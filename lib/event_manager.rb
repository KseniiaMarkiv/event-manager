require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

# common methods
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
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
  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  # Create an output folder
  Dir.mkdir('output') unless Dir.exist?('output') # If the file already exists it will be DESTROYED.

  # Save each form letter to a file based on the id of the attendee
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

