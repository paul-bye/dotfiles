#!/bin/sh
#
# SDKMAN
#

# Check for sdkman
if test ! $(which sdk)
then
  echo "  Installing SDKMAN."
  curl -s "https://get.sdkman.io" | bash
fi

exit 0
