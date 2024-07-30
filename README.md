# Event Manager 

This section contains a general overview of topics that you will learn while performing this project.

- Manipulate file input and output.
- Read content from a CSV (Comma Separated Value) file.
- Transform it into a standardized format.
- Utilize the data to contact a remote service.
- Populate a template with user data.
- Manipulate strings.
- Access Google’s Civic Information API through the Google API Client Gem.
- Use ERB (Embedded Ruby) for templating.

## Important things from lesson

- The entire lesson you can find by link [Odin course](https://www.theodinproject.com/lessons/ruby-event-manager)
- To create new file:

`for Windows CMD`
  ```
    mkdir lib
    type nul > lib\event_manager.rb
  ```
`for Windows Linux`
  ```
    mkdir lib
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
