# UnusedView
This is a Rails plugin to see unused views in you controllers

## Usage
In your Gemfile.

```ruby
group :development do
  gem "unused_view"
end
```

and execute rake task `unused_views`.

```sh
# if you want to search unused views in path-to-rails-root/app/views
$ bundle exec rake unused_views
# if you want to search unused specific directory. e.g. path-to-rails-root/app/views/users
$ bundle exec rake 'unused_views[users]'
```

then see list of unused views.

Now this is not support partial view.
