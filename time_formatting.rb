# frozen_string_literal: true
require 'time'
require 'date'

time = Time.now

p time.zone.split(' ').map { |word| word[0] }.join('')
# 'EDT'

p Time.now.utc
#  2024-07-31 19:53:46.1478195 UTC

p time.strftime('%d/%m/%Y')        # '05/12/2015'
p time.strftime('%k:%M')           # '17:48'
p time.strftime('%I:%M %p')        # '11:04 PM'
p time.strftime('Today is %A')     # 'Today is Sunday'
p time.strftime('%d of %B, %Y')    # '21 of December, 2015'
p time.strftime('Unix time is %s') # 'Unix time is 1449336630'

# Add ten seconds
p Time.new + 10

# Then you can check if that time has passed yet.
target_time = Time.new(2024, 12, 31, 23, 59, 59) # Set your target time here
current_time = Time.now

formatted_target_time = target_time.strftime('%d of %B, %Y')
formatted_current_time = current_time.strftime('%d of %B, %Y')

if current_time > target_time
  puts "The target time (#{formatted_target_time}) has passed."
else
  puts "The target time (#{formatted_target_time}) has not passed yet."
end

puts "Current time is #{formatted_current_time}."

# seconds * minutes * hours
60 * 60 * 24 #=> 86400
p Time.now - 86400

p Date.today + 1  # Current date adds one day 
p Date.new   # Returns a negative date

# REVIEW ActiveSupport – Time & Date Methods

# If you are using RAILS then you can do this:
# Time.now - 1.day

# 1.hour.to_i  # 3600

# 1.day        # ActiveSupport::Duration
# 3.days.ago   # ActiveSupport::TimeWithZone

# Other RAILS-exclusive time methods:
# date = Time.current
# date.change(hour: 20)
# date.at_beginning_of_day

# date = Date.today
# date.to_formatted_s(:short) # "16 Jul"
# date.to_formatted_s(:long)  # "July 16, 2018"