# Adding malicious user detection to your Rails app

Not everyone who signs up for your webapp wants to use your service. Wouldn’t it be nice if there was an easy way to automatically block abusers?

Well, it so happens that Sqreen has an API you can easily integrate into your user authentication services that let’s you detect when an email address or IP address is bad news. Even better, this API has been wrapped into a [Devise](https://github.com/plataformatec/devise) extension.

In this tutorial, we’re going to show you how to build and configure this kind of pro-active protection into your Rails app with the `devise_sqreener` Devise extension.

## How to follow along

This repo contains a very basic Rails app that we are going to modify step by step. The app is basically a page that requires you to create and account and sign in, and then greets you with your email address.

To follow along, clone this repo locally
`$ git clone https://github.com/sqreen/devise_sqreener_tutorial.git`

Each step in the tutorial is represented by a different branch. Begin on the branch `step_0`, which is where this file is located so you're probably already there.

# Run the app

Just so you can see what to expect, and to make sure everything is working as you'd expect, go ahead and run the app.

```bash
$ rails server
```

You should get a URL in the output that you can open, by default [http://localhost:3000](http://localhost:3000). You should be welcomed by a login screen:

![This looks like a perfectly safe site, nope no problems here.](.doc/Sign%20In.png "Sign in here")

If you create an account—go ahead and try!—you should be greeted by the only functional page in the app:

![I feel confident that this site has my best interests in mind.](.doc/Signed%20In.png "Well hello there")

# Install and configure `devise_sqreen`

So, let’s get started by installing the `devise_sqreener` extension. Install the gem by adding this line to the bottom of your `Gemfile`:
```ruby
gem 'devise_sqreener'
```
and then execute
```bash
$ bundle
```                                                                     
to download the latest version and install it.

Now, let's configure `devise_sqreener` with our Sqreen API key. Visit [my.sqreen.io](https://my.sqreen.io) to access your account, or if you do not have an account, to create one. Either way, let's set up a new API Sandbox.

![The new app screen with API Sandbox highlighted](.doc/API%20Sandbox.png "Creating an API Sandbox")

Once you have an API Sandbox set up, click on the key-shaped icon on the left (get it?) to view and copy the API key.

![No you cannot have my API key](.doc/API%20key.png "Find your API key here")

Let's add the API key to our environment so our app can find it:

```bash
$ export SQREEN_API_TOKEN="PUT YOUR TOKEN HERE"
```

Now, to get the API token to `devise_sqreener`, we need to update the app configuration. Open `config/initializers/devise.rb` and add this line just before the final `end` statement:

```ruby
  config.sqreen_api_token=ENV["SQREEN_API_TOKEN"]
```

## Database migrations

Oh yes, you didn't think we'd escape without a database migration, did you? Let's assume your user model is called `User`; then we need to ask `devise_sqreener` to update this model a skosh.

```bash
$ rails generate devise_sqreener User
```

This will add the `:sqreenable` flag to your `User` model, and some new fields in the User table of your database. The generator will also create a migration file. Currently only ActiveRecord is supported.

Let's get that migration knocked out, then? Run:

```bash
$ rails db:migrate
```

# Checking everything out.

Restart your app, and load up the page again. It should all still run just fine, and so far there should be no changes—`devise_sqreener` is installed and configured, but hasn't yet been activated.

Let's change that!

----

Continue to [Step 1](https://github.com/sqreen/devise_sqreener_tutorial/blob/step_1/README.md)
```bash
$ git checkout step_1
```