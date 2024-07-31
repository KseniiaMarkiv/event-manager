require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

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

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.html.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  # Assign an ID for the attendee
  id = row[0]

  name = row[:first_name]
  phone_number = clean_phone_numbers(row[:home_phone])
  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

