#!/bin/bash

wp core download

wp config create \
  --dbhost=db \
  --dbname="$MYSQL_DATABASE" \
  --dbuser="$MYSQL_USER" \
  --dbpass="$MYSQL_PASSWORD"

wp config set WP_ENVIRONMENT_TYPE development
wp config set WP_DEVELOPMENT_MODE all
wp config set WP_DEBUG true --raw
wp config set WP_DEBUG_LOG true --raw
wp config set WP_DEBUG_DISPLAY false --raw
wp config set SCRIPT_DEBUG true --raw

wp core install \
  --url="https://$WP_DOMAIN" \
  --title="$WP_TITLE" \
  --admin_user="$WP_ADMIN_USER" \
  --admin_password="$WP_ADMIN_PASSWORD" \
  --admin_email="$WP_ADMIN_EMAIL"

wp plugin delete akismet hello
wp theme delete twentytwentythree twentytwentytwo
