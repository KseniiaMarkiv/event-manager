require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

# common methods
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_numbers(number)
  
  # If the phone number is less than 10 digits, assume that it is a bad number
  # If the phone number is 10 digits, assume that it is good
  # If the phone number is 11 digits and the first number is 1, trim the 1 and use the remaining 10 digits
  # If the phone number is 11 digits and the first number is not 1, then it is a bad number
  # If the phone number is more than 11 digits, assume that it is a bad number

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

