# Event Manager 

## What we’re doing in this tutorial

*Imagine that a friend of yours runs a non-profit organization around political activism. A number of people have registered for an upcoming event. She has asked for your help in engaging these future attendees. For the first task, she wants you to find the government representatives for each attendee based on their zip code.*



This section contains a general overview of topics that you will learn while performing this project.

- Manipulate file input and output.
- Read content from a CSV (Comma Separated Value) file.
- Transform it into a standardized format.
- Utilize the data to contact a remote service.
- Populate a template with user data.
- Manipulate strings.
- Access Google’s Civic Information API through the Google API Client Gem.
- Use ERB (Embedded Ruby) for templating.



## Table of Contents

- [Getting Started](#getting-started)
- [Installation](#installation)
- [Important things from lesson](#important-things-from-lesson)
- [Usage](#usage)
- [Directory Structure](#directory-structure)
- [Features](#features)
- [Contributing](#contributing)

## Getting Started
These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes.

## Installation
1. Clone the repository to your local machine:
  ```
    git clone https://github.com/KseniiaMarkiv/event-manager.git
  ```
2. Navigate to the project directory:
  ```
    cd event-manager
  ```

## Important things from lesson

- The entire lesson you can find by link [Odin course](https://www.theodinproject.com/lessons/ruby-event-manager)
- To create new file:

**for Windows CMD**
  ```
    mkdir lib
  ```
  ```
    type nul > lib\event_manager.rb
  ```
**for Windows Linux**
  ```
    mkdir lib
  ```
  ```
    touch lib\event_manager.rb
  ```

- to read file:
    - go to file
  ```
    cd event_manager
  ```
    - run command to read csv file
  ```
    ruby lib\event_manager.rb
  ```
- to confirm that you are in the right directory and enter the following command:
  ```
    curl -o event_attendees.csv https://raw.githubusercontent.com/TheOdinProject/curriculum/main/ruby/files_and_serialization/event_attendees.csv
  ```
- so as not to disclose the secret key:
    - create file `secret.key`;
    - write API key inside `secret.key`;
    - create `.gitignore` file and write inside 

  ```
    secret.key
  ```
    to hide your key safely and don't pass to GitHub repo;

    - save the value in variable `civic_info.key`

  ```
    civic_info.key = File.read('secret.key').strip
  ```

## Usage
1. To run the event manager, execute the following command in your terminal:
  ```
    ruby lib/event_manager.rb
  ```
2. The application reads from a CSV file named `event_attendees.csv` located in the project directory. Ensure that the file exists and is properly formatted.

3. The application will process the data, generate personalized thank-you notes for each attendee, and save them in the `output` directory. It will also create an HTML report of registration data.

## Directory Structure

  ```
    .
    ├── .gitignore
    ├── data_report.html.erb
    ├── event_attendees.csv
    ├── example_erb.rb
    ├── form_letter.html.erb
    ├── lib
    │   └── event_manager.rb
    ├── output
    │   └── thanks_*.html
    ├── README.md
    ├── secret.key
    └── time_formatting.rb
  ```


- `.gitignore`: File to specify untracked files to ignore
- `data_report.html.erb`: ERB template for generating the data report
- `event_attendees.csv`: CSV file containing the event attendees' data
- `example_erb.rb`: Example file demonstrating the usage of ERB
- `form_letter.html.erb`: ERB template for generating thank-you letters
- `lib`: Directory containing the main application script
- `event_manager.rb`: Main script for the Event Manager application
- `output`: Directory where generated output files will be saved
- `README.md`: This README file
- `secret.key`: File containing the API key for Google Civic Information API
- `time_formatting.rb`: Helper file for time formatting

## Features

- Reads attendee data from a CSV file
- Cleans and formats phone numbers and zip codes
- Generates personalized thank-you notes
- Logs the most popular registration hours and days
- Generates an HTML report of registration data

## CSV Parsing

  ```ruby
    contents = CSV.open(
      'event_attendees.csv',
      headers: true,
      header_converters: :symbol
    )
  ```

## Contributing

Contributions are welcome! Please follow these steps to contribute:

- Fork the repository
- Create a new branch
  ```
    git checkout -b feature-branch
  ```
- Commit your changes
  ```
    git commit -m 'Add new feature
  ```
- Push to the branch
  ```
    git push origin feature-branch
  ```
- Create a new Pull Request