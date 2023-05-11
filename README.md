# Note

This is a fork of https://github.com/martin-denizet/redmine_custom_css

# Redmine Custom CSS plugin

Allows to input CSS directly from Redmine to customize Redmine appearance.
There are global styles and isolated per user.

## Compatibility

Ruby 3.1+  
Redmine 5.x stable

## Installing

Clone the repo, install ruby dependencies and run database migrations:

```bash
# git clone https://github.com/dmakurin/redmine_custom_css.git plugins/redmine_custom_css
# bundle install
# bundle exec rails redmine:plugins:migrate RAILS_ENV=development NAME=redmine_custom_css
```

## Running tests

tldr:
```bash
# git clone https://github.com/dmakurin/redmine_custom_css.git plugins/redmine_custom_css
# bundle install
# bundle exec rails redmine:plugins:migrate RAILS_ENV=development NAME=redmine_custom_css
# bundle exec rails redmine:plugins:test RAILS_ENV=test NAME=redmine_custom_css
```

## Uninstalling

Clean up the database and remove a plugin directory:

```bash
# bundle exec rails redmine:plugins:migrate RAILS_ENV=development NAME=redmine_custom_css
# rm -rf plugins/redmine_custom_css
```

## Usage

To use global styles navigate to the plugin settings `Administration - Plugins - Redmine Custom Css - Settings` and put your css there. It will be applied globally for the whole redmine instance.  
A user can specify their own styles that will be loaded only for them. The menu available at `My account - Custom Css`. 

