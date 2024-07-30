puts 'EventManager initialized.'

lines = File.readlines('event_attendees.csv')

# REVIEW display the first names of all the attendees without first row

p '---------- first way ------------'
lines.each do |line|
  next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
  columns = line.split(',')
  name = columns[2]
  puts name
end
p '---------- second way ------------'
row_index = 0
lines.each do |line|
  row_index = row_index + 1
  next if row_index == 1
  columns = line.split(',')
  name = columns[2]
  puts name
end
p '---------- third way ------------'
lines.each_with_index do |line, index|
  next if index == 0
  columns = line.split(',')
  name = columns[2]
  puts name
end