require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

# common methods
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_numbers(number)
  number = number.to_s.gsub(/[^0-9]/, '')

  if number.length == 10
    number.insert(6, '-').insert(3, '-')
  elsif number.length == 11 && number.start_with?('1')
    number = number[1..10]
    number.insert(6, '-').insert(3, '-')
  else
    'Invalid phone number'
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('secret.key').strip

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    puts
    p 'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
    puts
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def parse_date_time(date_time_str)
  DateTime.strptime(date_time_str, '%m/%d/%y %H:%M')
rescue ArgumentError
  nil
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.html.erb')
erb_template = ERB.new template_letter

hourly_registrations = Hash.new(0)

contents.each do |row|
  id = row[0]

  name = row[:first_name]
  phone_number = clean_phone_numbers(row[:home_phone])
  zipcode = clean_zipcode(row[:zipcode])

  registration_date_time = parse_date_time(row[:regdate])
  if registration_date_time
    hour = registration_date_time.hour
    hourly_registrations[hour] += 1
  end

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

peak_hours = hourly_registrations.sort_by { |hour, count| -count }.to_h

# Output peak hours and counts
puts "Hourly registration counts: #{hourly_registrations}"
puts "Peak registration hours: #{peak_hours.keys.take(3)}"

# Save hourly registration data and peak hours in an HTML file
erb_data_template = File.read('data_report.html.erb')
erb_data = ERB.new erb_data_template
File.open('output/data_report.html', 'w') do |file|
  file.puts erb_data.result(binding)
end