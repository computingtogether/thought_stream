The goal of this web app is for a use to be able to create an accout and sign in, and on the main page of the app there is a "brain dump" input text box. When the user inputs text representing things on their mind, that entry is stored in the database and we will display a chronological list of brain dump entries on the main page. The color of the text of each word from the dump will depend upon its frequency in the past dumps. There will be another page to see a numeric table of dump words. 

If you are following along, I am using ruby version 3.0.0, and rails version 6.1.3.

```
$ rails new thought_stream
```

```
$ rails g scaffold entry thoughts
$ rails db:migrate
```

Set the root route
>config/routes.rb
```ruby
Rails.application.routes.draw do
  resources :entries

  root 'entries#index'

end
```

I want this site to be nice and streamlined, so the input form for new brain dumps will be on the same page as the color coded chronological display of brain dumps. To accomplish this add the code from the new method in app/controllers/dump_entries_controller.rb to the index method.

>app/controllers/dump_entries_controller.rb
```ruby
class DumpEntriesController < ApplicationController
  before_action :set_dump_entry, only: %i[ show edit update destroy ]

  # GET /dump_entries or /dump_entries.json
  def index
    @dump_entry = DumpEntry.new
    @dump_entries = DumpEntry.all
  end

  # GET /dump_entries/1 or /dump_entries/1.json
  def show
  end

  # GET /dump_entries/new
  def new
    @dump_entry = DumpEntry.new
  end
```

# Adding Style

rename app/assets/stylesheets/application.css to  app/assets/stylesheets/application.scss