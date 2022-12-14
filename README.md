# Eras
Error reporting services such as Bugsnag, Honeybadger, and Sentry are great, but they oftentimes leave us scratching our heads while developing locally. You're most likely not sending the errors in development environment, but the notifier caught it anyways, and now it's gone, *poof*, missing. Eras takes advantage of Rails 7.0's [`ActiveSupport::ErrorReporter`](https://api.rubyonrails.org/classes/ActiveSupport/ErrorReporter.html), and adds an additional subscriber to `Rails.error`. 

Because this hooks into ErrorReporter, you must be using [the reporter API](https://edgeguides.rubyonrails.org/error_reporting.html) for tracking your errors. This may be a change to how you report errors, but both [Sentry's](https://github.com/getsentry/sentry-ruby/blob/e18ce4b6dcce2ebd37778c1e96164684a1e9ebfc/sentry-rails/lib/sentry/rails/error_subscriber.rb) and [Honeybadger's](https://docs.honeybadger.io/lib/ruby/integration-guides/rails-exception-tracking/) libraries provide native subscribers that you can use, and writing a custom subscriber for other providers isn't too hard.   

### Index
![Index](./readme_assets/index.png)

### Show
![Show](./readme_assets/show.png)

## Installation
Add this line to your application's Gemfile:

```ruby
gem "eras", group: :development
```

And then execute:
```bash
$ bundle
```

mount the engine wherever you like (I prefer /eras)
```ruby
# config/routes.rb
mount Eras::Engine => "/eras" if defined?(Eras::Engine) # We only require this in development
```

## Disclaimer

This gem is in active development, and delivered as-is. 

## Contributing
You must run the tailwindcss server while developing, and commit any changes to `app/assets/builds`
```
rake app:tailwind_engine_watch
```

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
