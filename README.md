# PROJECT REQUIREMENTS
Click [here](https://drive.google.com/file/d/1tGGlStHzIt1oxkCvyJbIYO1gQV_MMDHF/view?usp=sharing) to read the project requirements

# TESTING GUIDE

# Initial Setup

1. Clone the repository and install dependencies
2. Run database migrations
3. Start the server

# Testing Steps

Here are the suggested testing steps per each feature requirement

## Imports new merchants and admins from CSV
- Update `lib/assets/users.csv` at your will
- Run `rake import:users` from project terminal
- Verify that data from file is saved in the database

## A background Job for deleting transactions older than an hour (cron job)
- Manually insert transactions that are older than an hour
- Update `config/schedule.rb` or be ready for wait every two hours for execution
- Run `whenever --update-crontab` from project terminal
- Verify that old transactions are deleted after the cronjob cycle

## Accepts payments using XML/ JSON API (single point POST request)
- Fetch token for user by following this example
```
Request

  POST /api/v1/sessions

  Headers
    Content-Type: application/json

  Body
    {
      "email": "msehovic92@gmail.com",
      "password": "asdfasdf"
    }

Response

  {
      "token": "3ssx78ddacR_VEmUYhSF"
  }
```
- Create new payment as active merchant by following this example
```
Request

  POST /api/v1/transactions

  Headers
    Content-Type: application/json
    X-User-Email: msehovic92@gmail.com
    X-User-Token: 3ssx78ddacR_VEmUYhSF

  Body
    {
      "uuid": "43a1e03d-b5cf-4849-a031-ff326628107c",
      "amount": 134,
      "customer_email": "foojohn@tadamail.com",
      "status": "approved",
      "type": "authorize"
    }

  Note: For referenced transactions you'll need to add "parent_id" parameter as well.

Response

  {
    "id": 16,
    "uuid": "43a1e03d-b5cf-4849-a031-ff326628121c",
    "amount": 134,
    "customer_email": "foojohn@tadamail.com",
    "status": "approved",
    "parent_id": null,
    "merchant_id": 2,
    "created_at": "2020-05-22T13:37:45.762Z",
    "updated_at": "2020-05-22T13:37:45.762Z"
  }
```
## Presentation
- Navigate in your browser to `/merchants`
- Interact with UI and verify if it meets presentation requirements


