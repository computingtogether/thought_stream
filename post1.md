The goal of this web app is for a user to be able to create an account and sign in. On the main page of the app there will be a "thought stream" input text area. When the user inputs text representing things on their mind, that entry is stored in the database and we will display a chronological list of entries on the main page. The color of the text of each word from the line of entries will depend upon its frequency in the database of past entries.

If you do not have Ruby on Rails set up, I suggest you utilize  [The Odin Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/your-first-rails-application-ruby-on-rails). You do not need any Rails experience to do this tutorial. This is meant as exposure to the concepts and flows of writing rails apps. Hopefully this series will spark questions and ideas that you can act upon. Please leave comments with any questions, suggestions, corrections etc. Learning web development is a team sport and you cannot learn it by sitting on the side lines so let's dive in!

For this app, I am using ruby version 3.0.0, and rails version 6.1.3. 
Terminal commands will be denoted with a $ sign. 

In the terminal run the following. Start by created a new rails app called "thought_stream". 

```bash
$ rails new thought_stream
```
Generate (g for short) a scaffold called **entry** and create a column in the entries database called **thoughts** which will be a string (you can also write thoughts:string but leaving off the data type defaults to string).

```bash
$ rails g scaffold entry thoughts
$ rails db:migrate
```
Set the root route in **config/routes.rb** to be the index page for entries. You can check which routes are available by running **$ rails routes** in the terminal. 

```ruby
Rails.application.routes.draw do
  resources :entries

  root 'entries#index'

end
```

I want the input form for new entries to be on the same page as the color coded and chronological display of the thought streams. Modify **app/controllers/entries_controller.rb**

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

In **app/views/entries/index.html.erb** render the entries _form partial so that the thought stream input box will appear on the same page as our root index.

```erb
<p id="notice"><%= notice %></p>

<%= render 'form', entry: @entry %>

<h1>Entries</h1>
...
```
Adding **@entry = Entry.new** to the index method of the entries controller gives us access to **@entry** in **entries/index.html.erb**. This made it possible to render the new entry form on our main index page. 

# Resizing and User Experience

Run **$ rails s** in the command line and visit http://localhost:3000/. You should see a text field at the top but it is small. Head to **app/views/entries/_form.html.erb** and give the text field a class name **text-field__thoughts**, set a placeholder for the text area. Set the text area to autofocus for a more fluid user experience on the app. 


Now that we have a placeholder we can delete the default for label that rails gave us. 
Delete **<%= form.label :thoughts %>** from the entries _form.html.erb partial. In **app/views/entries/_form.html.erb** you should have:

```erb
  <div class="field">
    <%= form.text_field :thoughts, 
                       class: "text-field__thoughts", 
                       placeholder: "Write down what's on your mind separated by commas...",                        
                       rows: 3, 
                       autofocus: true %>
  </div>
```
Rename **app/assets/stylesheets/application.css** to  **app/assets/stylesheets/application.scss**

Set the width of the text area in **app/assets/stylesheets/entries.scss**


```scss
.text-field__thoughts{
  width: 99%;
}
```

After we create a new entry, rails sends us to the show page by default. For a smoother user experience we would like to stay on the same page to see the new entry added and color coded in real time. Redirect to the **entries_path** instead of **@entry** in **entries_controller.rb**.

Change

```ruby
format.html { redirect_to @entry, notice: "Entry was successfully created." }
```

to 

```ruby
format.html { redirect_to entries_path, notice: "Entry was successfully created." }
```

In **app/views/entries/edit.html.erb** change:

```erb
<h1>Editing Entry</h1>

<%= render 'form', entry: @entry %>

<%= link_to 'Show', @entry %> |
<%= link_to 'Back', entries_path %>

```
to 

```erb
<h1>Editing Entry</h1>

<%= render 'form', entry: @entry %>

<%= link_to 'Delete', @entry, method: :delete, data: { confirm: 'Are you sure?' } %>  |  
<%= link_to 'Back', entries_path %>
```

This consolidates the UD actions of CRUD (create, read, **update, destroy**) to the edit page for entries. I think this makes the main page look cleaner. 

Speaking of which, clean up **views/entries/index.html.erb** to look like:

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
We got rid of the table header and added a column to the left to show when the entry was created. Now the user can click on the entry time link to be able to edit or delete the entry. Later we will create a "delete all" button for this page. 

Thanks for sticking with me all the way to the end of part one of building the Thought Stream App! 