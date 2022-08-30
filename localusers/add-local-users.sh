#!/bin/bash
# shellcheck shell=bash

# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then
  echo "You are not the root user.  Please log in as root user to continue."
  exit 1
fi

# Get the username (login).
read -p 'Enter the username to create: ' USERNAME

# Get the real name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this account: ' COMMENT

# Get the password.
read -p 'Enter the password to use for this account: ' PASSWORD

# Create the account.
useradd -c "${COMMENT}" -m ${USERNAME}

# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.
if [[ ${?} -ne 0 ]]
then
  echo "The account could not be created."
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USERNAME}

# Check to see if the passwd command succeeded.
if [[ ${?} -ne 0 ]]
then
  echo "The password for this account could not be set."
  exit 1
fi

# Force password change on first login.
passwd -e ${USERNAME}

# Display the username, password, and the host where the user was created.
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"

exit 0