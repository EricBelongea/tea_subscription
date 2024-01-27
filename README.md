# README

## Getting Started

These instructions will give you a copy of the project up and running on your local machine for development and testing purposes. 

This project uses Ruby version 3.2.2.

## Database Setup

Fork and Clone this repo.

Change directories into the project:
`cd /tea_zaanti`

Install all gems:
`bundle install`

To initialize the database, run the following commands:

`rails db:{drop,create,migrate,seed}`

## Gems

- [rspec-rails](https://github.com/rspec/rspec-rails) gem that is backbone of our testing architecture
- [factory_bot](https://github.com/thoughtbot/factory_bot) gem to create models for testing data
- [Faker](https://github.com/faker-ruby/faker) gem to mock and stub test data
- [JSONAPI Serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) gem for formatting JSON responses
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem for code coverage tracking
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) gem for testing assertions
- [Pry](https://github.com/pry/pry) gem for debugging
- [Capybara](https://github.com/morris-lab/Capybara) gem for end to end testing 
- [Lanchy](https://github.com/copiousfreetime/launchy) gem for inspection and debugging
- [Postman](https://www.postman.com/) to check API endpoints



## Running the Test Suite

To run the test suite, execute the following command:

`bundle exec rspec`

To make use of SimpleCov to see test coverage run:

`open coverage/index.html`

## How to Consume
Launch Server: <br>
```rails s```

* The backend (This Repo/API) runs on 'http://localhost:3000/'

Important Notes

* When Creating or Updating a subscription the boolean must be passed from the front end to the back. 
  * When `Creating` a subscription you should pass a default value of `true` to the backend via the form.
  * When `Updating` or "cancelling" a subscription you should pass a default value of `false` to the backend via the form.


## Contributors

* Eric Belongea 
    * [Eric's LinkedIn](https://www.linkedin.com/in/eric-belongea/)
    * [Eric's Github](https://github.com/EricBelongea)
