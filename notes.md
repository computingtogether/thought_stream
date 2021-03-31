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

Running rails s in the command line and visiting http://localhost:3000/, you can see that the form for adding new thoughts is very small. Head to app/views/entries/_form.html.erb and give the text field a class name "text-field__thoughts", set a placeholder for the text area. Finally, let's set this text area to autofocus to create a a good user experience for this app. 
Now that we have a placeholder we can delete the default for label that rails gave us. 
Delete <%= form.label :thoughts %> from the entries _form.html.erb partial. 


>app/views/entries/_form.html.erb

```erb
  <div class="field">
    <%= form.text_field :thoughts, 
                       class: "text-field__thoughts", 
                       placeholder: "Write down what's on your mind seperated by commas...",                        
                       rows: 3, 
                       autofocus: true %>
  </div>
```

Set the width of the text area with scss
>app/assets/stylesheets/entries.scss
```scss
.text-field__thoughts{
  width: 99%;
}
```

To make a fluid onscreen creation of a new thoughts entry, in entries_controller.rb change:

```ruby
format.html { redirect_to @entry, notice: "Entry was successfully created." }
```

to 
```ruby
format.html { redirect_to entries_path, notice: "Entry was successfully created." }
```

in views/entries/edit change:

```ruby
<h1>Editing Entry</h1>

<%= render 'form', entry: @entry %>

<%= link_to 'Show', @entry %> |
<%= link_to 'Back', entries_path %>

```
to 

```ruby
<h1>Editing Entry</h1>

<%= render 'form', entry: @entry %>

<%= link_to 'Delete', @entry, method: :delete, data: { confirm: 'Are you sure?' } %>  |  
<%= link_to 'Back', entries_path %>
```

Now lets clean up views/entries/index.html.erb to look like:

```erb

<p id="notice"><%= notice %></p>

<%= render 'form', entry: @entry %>

<table>

  <tbody>
    <% @entries.each do |entry| %>
      <tr>
        <td><%= link_to "added " + time_ago_in_words(entry.created_at) +" ago", edit_entry_path(entry) %></td>
        <td><%= entry.thoughts %></td>
      </tr>
    <% end %>
  </tbody>
</table>

```
We got rid of the table header and added a column to the left to show when the entry was created. Instead of having the CRUD buttons I am opting for just clicking on the entry time stamp to be able to edit or delete it. 