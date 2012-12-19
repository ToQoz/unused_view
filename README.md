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
# Loading code in search of controllers
# Unused Views
/Users/toqoz/Projects/ppp/app/views/articles/edit.html.erb
/Users/toqoz/Projects/ppp/app/views/articles/new.html.erb
/Users/toqoz/Projects/ppp/app/views/users/create.html.erb
/Users/toqoz/Projects/ppp/app/views/users/edit.html.erb

```

then see list of unused views.

Now this is not support partial view.
