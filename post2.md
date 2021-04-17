In part 2, we will write the methods for color coding each "thought" (seperated by commas) of our thought streams based on frequency in the database. We will adhere to industry best practices by following TDD (test driven development). Furthermore, we will practice "red, green, refactor" and will use RSpec as a testing framework. We will write tests that come up red (fail), then write the methods that our tests test so that they pass the tests (green), then we will refactor if we can.

# Setting up RSpec

Head to rubygems.org, and search for "rspec-rails". Select "rspec-rails" and it should have at least 111 million downloads. On the right copy the GEMFILE to clipboard. Go to **Gemfile** and paste it in the development, test group.

Also on rubygems.org, search for "factory bot rails". Select "factory_bot_rails" and it should have at least 52 million downloads. On the right copy the GEMFILE to clipboard. 

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'factory_bot_rails', '~> 6.1'
end
```

Run

```
$ bundle install
```
Run

```
$ rails generate rspec:install
```

We are ready to write some tests, but first read up on [file structure](https://relishapp.com/rspec/rspec-rails/docs/directory-structure) with RSpec. If you use Minitest, it comes with an already established file folder tree, but RSpec is a build your own kind of thing.

In the **spec** directory, create a new folder called "helpers". We wish to test the helper methods that we will write in **app/helpers/entries_helper.rb**. You can read up about writing [helper tests here](https://relishapp.com/rspec/rspec-rails/docs/helper-specs/helper-spec). 

In **spec/helpers** create a new file called "entries_helper_spec.rb".

Instead of manually creating the helpers folder and the spec ruby file, you could have run **$ rails g rspec:helpers entries_helper**

In **spec** create a folder called "factories". In factories create a file called "entry.rb". Now add the following to 

```ruby
FactoryBot.define do
  factory :entry do
  end
end
```