# README

## Setup
Application requires PostgreSQL and Redis to be installed and listening on default ports.

1. Install gems: `bundle install`
1. Create and migrate database: `rails db:create && rails db:migrate`

## Usage
To start application you need to:

1. Start rails server: `rails server`
1. Start sidekiq server: `sidekiq`

Application has 3 pages:
- Root page (where event form is): `/`
- Report page (where customer rewards information and event error logs are displayed): `/event`
- Sidekiq web page: `/sidekiq`

When you add events through event form on the root page, background tasks process events and save to database
So you can see results on the report page.

## !!!Warnings!!!
- Events are processed asynchroniously so report page reload may be required to see the actual information
- Customer validation does not allows creation of customers with same names due to orders association by this attribute
