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

>app/controllers/entries_controller.rb
```ruby
class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]

  # GET /entries or /entries.json
  def index
    @entry = Entry.new
    @entries = Entry.all
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  ...
```
Render the partial _form.html.erb that comes free with generating a scaffold to the top of the index page of entries.

>app/views/entries/index.html.erb
```erb
<p id="notice"><%= notice %></p>

<%= render 'form', entry: @entry %>  // add this line

<h1>Entries</h1>
...
```

# Adding Style

rename app/assets/stylesheets/application.css to  app/assets/stylesheets/application.scss

Running rails s in the command line and visiting http://localhost:3000/, you can see that the form for adding new thoughts is very small. Head to app/views/entries/_form.html.erb and give the text field a class name "text-area__thoughts" (it's BEMy), change text_field to text_area to give more space, set a placeholder for the text area, and let's make  it 3 rows high. Finally, let's set this text area to autofocus to create a a good user experience for this app. 
Now that we have a placeholder we can delete the default for label that rails gave us. 
Delete <%= form.label :thoughts %> from the entries _form.html.erb partial. 


>app/views/entries/_form.html.erb

```erb
  <div class="field">
    <%= form.text_area :thoughts, 
                       class: "text-area__thoughts", 
                       placeholder: "Write down what's on your mind...",                        
                       rows: 3, 
                       autofocus: true %>
  </div>

```

Set the width of the text area with scss
>app/assets/stylesheets/entries.scss
```scss
.text-area__thoughts{
  width: 99%;
}
```

