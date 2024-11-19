# README

## Table of contents

* Dependencies
* Set up

## Dependencies

* Ruby '3.1.0'

* We are using Rails 7 as it is stable, although Rails 8 is available.
```
    Rails '~>7.2.2'
```

* Postgres Database:

## Set up

* Install PostgreSQL on your machine to set up the database.


* Install required gems and dependencies by running:
```
    bundle install
```

* Update the `config/database.yml` file with your PostgreSQL credentials (username, password, and database details).

* Create database
```
    rails db:create
```

* Apply database migrations to set up the schema:
```
    rails db:migrate
```

* You can create dummy student data through the seed file `db/seeds.rb`, or alternatively, you can create students individually through the UI.
```
    rails db:seed
```

* Precompile static assets for app:
```
    rails assets:precompile
```

* Start the Rails server:
```
    rails s
```

## Current Functionalities

* Student Management:
  - Create, update, and delete student records.

* Race Management:
  - Create and read race records.
  - Update race results.

* Listing Records:
  - List all students and races in the system.

* Validation:
  - Ensure the uniqueness of student names within unique lanes.
  - Validate gaps and ties for places in race results, with a minimum of two students per race.

* Error Handling:
  - Handle errors gracefully using inline flash messages.

* Advanced Functionality:
  - Support nested lanes and race results for enhanced features.
  - Utilize Turbo for faster page updates and improved user experience without full page reloads.

## Possible Improvements

* Client-Side Validation
  - While validations are already implemented at both the database and model levels but we can Enhance the user experience by adding field-level validations with JavaScript, providing instant feedback on form inputs before submission.

* Testing
  - Use Capybara for simulating user interactions and Cucumber for Behavior-Driven Development (BDD) to write clear, comprehensive test cases, ensuring robust test coverage.
