#!/bin/bash

# This script will generate a list of random pages

# A random number as a password.
PASSWORD=${RANDOM}
echo "${PASSWORD}"

# Three random numbers together.
PASSWORD=${RANDOM}${RANDOM}${RANDOM}
echo "${PASSWORD}"

# Use EPOCH (current date/time) time as a password.
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# Use EPOCH (current date/time) time with nanoseconds as a password.
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# Create better password.
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# Even better password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo ${PASSWORD}

# Append a special character to the password.
# fold: transform single to multiple lines
# shuf: Randomly select a line from
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"
