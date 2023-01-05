#!/bin/sh
#
# Starship
#

# Check for sdkman
if test ! $(which starship)
then
  echo "  Installing Starship."
  curl -sS https://starship.rs/install.sh | sh
fi

exit 0
