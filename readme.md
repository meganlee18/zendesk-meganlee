# Ticket Viewer
This project uses Sinatra version (2.0.3).
View my app here - https://meganlee-zendesk-ticketviewer.herokuapp.com/

## About Ticket Viewer
- Connect to the Zendesk API
- Request all the tickets for your account
- Display them in a list
- Display individual ticket details
- Page through tickets when more than 25 are returned

## Installation process
- First, clone the repository:
```
$ git clone https://github.com/meganlee18/zendesk-meganlee.git
```
- You can install the required gems for the project by running bundle install:
```
$ bundle install
```

## Testing the app
- To run tests, run the following command:
```
$ rspec main_spec.rb
```

## Using the app
- To start the server, run the following command:
```
$ ruby main.rb
```
- The server will run on localhost: 4567

## Technologies used
- Built using the Sinatra framework
- CSS layout uses bootstrap library

## Ruby gems used in the project
- sinatra
- sintra-contrib
- pry
- httparty
- shotgun
- rack-test
- rspec

## Improvements to the app 
- Added search bar functionality to allow users to search tickets by ticket description
- Allow users to update individual ticket status. Applicable statuses include "Open", "Pending", "Closed", "Solved"