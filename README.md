# Statcounter

[![Build Status](https://secure.travis-ci.org/ksarunas/statcounter.png)](http://travis-ci.org/ksarunas/statcounter)
[![Gem Version](https://badge.fury.io/rb/statcounter.png)](http://badge.fury.io/rb/statcounter)

Ruby Statcounter API wrapper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'statcounter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install statcounter

## Initialization

```ruby
# config/initializers/statcounter.rb

Statcounter.configure do |config|
  config.username = 'STATCOUNTER_USERNAME_HERE'
  config.secret = 'STATCOUNTER_API_PASSWORD_HERE'
  config.timeout = 60 # default is 60
  config.timezone = 'America/New_York' #default is America/New_York
end
```

In case your app has to handle multiple Statcounter accounts you can pass credentials to each endpoint wrapper method like this:

```ruby
Statcounter::Projects.all(username: 'STATCOUNTER_USERNAME_HERE', secret: 'STATCOUNTER_API_PASSWORD_HERE')
```

## Examples

### Projects

#### Get all your projects
```ruby
Statcounter::Projects.all

# returns array of project hashes
[
  {
    project_id: '1000000',
    project_name: 'mywebsite1.com',
    url: 'https://www.mywebsite1.com',
    project_group_id: '1',
    project_group_name: 'Websites',
    hidden_group: '0',
  },
]
```

#### Find projects

When selecting one projects:

```ruby
Statcounter::Projects.find(1000000)

# returns project hash
{
  project_name: 'mywebsite1.com',
  log_size:  '500',
  timezone:  'America/New_York',
  url: 'https://www.mywebsite1.com',
  log_oldest_entry: 'LOG_OLDEST_ENTRY',
  log_latest_entry: 'LOG_LATEST_ENTRY',
  created_at: 'CREATED_AT'
}
```

When selecting multiple projects:

```ruby
Statcounter::Projects.find([1000000, 1000001])

# returns array of project hashes
[
  {
    project_name: 'mywebsite1.com',
    log_size:  '500',
    timezone:  'America/New_York',
    url: 'https://www.mywebsite1.com',
    log_oldest_entry: 'LOG_OLDEST_ENTRY',
    log_latest_entry: 'LOG_LATEST_ENTRY',
    created_at: 'CREATED_AT'
  },
  {
    project_name: 'mywebsite2.com',
    log_size:  '500',
    timezone:  'America/New_York',
    url: 'https://www.mywebsite2.com',
    log_oldest_entry: 'LOG_OLDEST_ENTRY',
    log_latest_entry: 'LOG_LATEST_ENTRY',
    created_at: 'CREATED_AT'
  }
]
```

#### Create project

```ruby
Statcounter::Projects.create(
  project_name: 'mywebsite1.com',
  url: 'https://www.mywebsite2.com',
  public_stats: true, # default false
)

# returns hash with id and security code
{
  project_id: '1000000',
  security_code: 'hjk89077hh',
}
```

#### Delete project
```ruby
Statcounter::Projects.delete(
  project_id: '123123',
  admin_username: 'admin',
  admin_password: 'password',
)

# return string 'ok'
'ok'
```

### Summary stats

#### Get daily

When one project:

```ruby
Statcounter::SummaryStats.daily(
  project_ids: 1000,
  date_from: Date.yesterday,
  date_to: Date.yesterday,
)

# Returns array of summary stats by date

[
  {
    date: '2016-07-04',
    page_views: '876',
    unique_visits: '609',
    returning_visits: '57',
    first_time_visits: '552',
  }
]
```

When multiple projects:

```ruby
Statcounter::SummaryStats.daily(
  project_ids: [1000, 1001],
  date_from: Date.yesterday,
  date_to: Date.yesterday,
)

# Returns hash where key is project id and value is array of summery stats by date

{
  1000 => [
    {
      date: '2016-07-04',
      page_views: '876',
      unique_visits: '609',
      returning_visits: '57',
      first_time_visits: '552',
    }
  ],
  1001 => [
    {
      date: '2016-07-04',
      page_views: '876',
      unique_visits: '609',
      returning_visits: '57',
      first_time_visits: '552',
    }
  ],
}
```
