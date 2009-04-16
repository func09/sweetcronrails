# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sweetcron_session',
  :secret      => 'da5b13ca84ebaae4febea81bb0330aea5e945a495914f19481e390e08a9e8cea07b3ceedb8e4bdbc433ee40d1114236c1f69bcb6f8c9c2e1b87eee6c600e6a9c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
