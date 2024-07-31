require 'csv'
require 'google/apis/civicinfo_v2'

template_letter = File.read('form_letter.html')

# common methods
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('secret.key').strip

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(", ")
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

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  # making a copy that 
  personal_letter = template_letter.gsub('FIRST_NAME', name)

  # then changing the copy, we’re sure everyone’s name is UNIQUE.
  personal_letter.gsub!('LEGISLATORS', legislators)

  puts personal_letter
end

