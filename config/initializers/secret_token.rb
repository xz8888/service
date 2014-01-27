# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Service::Application.config.secret_key_base = '74106a2c4722f1826b06f1602b2cfe043364d24447b1516ba15cb86ac0c7c17d3e0616b57c9119618e8739a62a62b17669b9d17dcf811e73d96b0a14dc1e1895'
