# README

This README documents a few instructions and steps that are necessary to get the
application up and running.

Best Available Seat
Write a solution to return the best seat (closest to the front & middle) given a list of open seats. Rows follow alphabetical order with "a" being the first row. Columns follow numerical order from left to right.

The list of open seats, number of rows and columns (seats) is based on a JSON input.

{
    "venue": {
        "layout": {
            "rows": 10,
            "columns": 50
        }
    },
    "seats": {
        "a1": {
            "id": "a1",
            "row": "a",
            "column": 1,
            "status": "AVAILABLE"
        },
        "b5": {
            "id": "b5",
            "row": "b",
            "column": 5,
            "status": "AVAILABLE"
        },
        "h7": {
            "id": "h7",
            "row": "h",
            "column": 7,
            "status": "AVAILABLE"
        }
    }
}
The solution should find the best open seat (closest to the front & middle) given the input JSON and number of requested seats. Imagine a concert, people want to be as close as possible to the stage.

For example, for a venue with 10 rows and 12 columns with all seats open, the best seat would be A6.

If a group of seats is requested, the algorithm needs to find the best open group of seats together. In the example above, for 3 seats, it would be A5, A6, and A7.

For 5 columns and 2 requested seats the best open seats - assuming the first row A is fully occupied and the second row B is fully open, would be B2 and B3.

Start by a single seat request (not a group of seats together)
The app should have automated tests
The app needs a README.md explaining the app and steps to run it locally
Script or Rails app (see Bonus) for manual testing the implementation

Bonus
Rails app for testing out the solution
React for the interface

Things you may want to cover:

* Ruby version

=> ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]
=> Rails 5.2.4.2

* System dependencies

* Configuration
 
* Database creation

type 'rails db:create db:migrate'
  
* Database initialization
N/A
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Run instructions

type 'bundle install'
type 'rails db:create db:migrate'
'rails s -b 0.0.0.0'

* ...

## Some further notes

The best seat will be provided follow the instruction, which is closest to the front & middle.

If performing group of seats close of each other:
-A "number_of_seats" key must be provided and its value with numbers of seats desired;
-In absense of this parameter, a single seat is provided.

For Run the Automated test, you must exec:

'rspec ./spec/controllers/v1/best_seat_controller_spec.rb' 

Bonus

if Closest to corridor is considered better than rows more in the front but away from middle position, then:
-A "priority" key must be provided with the value '1' as number;
-In absense of this parameter, the default priority is the best open group of seats together. 