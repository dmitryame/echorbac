# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rbac-rest_session',
  :secret      => '269975bc68240eb1066cea75bb256b0c10d6403684445c134cdcc4b8beded9fc02d65694ab88ff12b4c32bceec1d06069d7fda44acd9b9497125438181c0d5de'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
