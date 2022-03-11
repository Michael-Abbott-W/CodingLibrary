#!/bin/sh

#shebang "#!" only works when it's on the first line

#I could not get this file to work. it was meant to make a command line tool called
#lpssh where you would enter lpssh <name of ssh key> and it would log you into lastpass
#if you weren't already logged in and then look up the key's passphrase and use it to unlock
#the key (add it to the ssh agent)

lastpass_status=$((lpass status) | awk '{print $1}')

while [ "$lastpass_status" != "Logged" ] ; do
	echo "You are not logged into lastpass./nPlease enter your lastpass username:"
	read lastpass_username
	lpass login $lastpass_username
	lastpass_status=$((lpass status) | awk '{print $1}')
done

passphrase=$((lpass show -p "$1") | awk '{print $1 $2;}')

expect <<EOF >/dev/null
spawn ssh-add -t 30m ~/.ssh/"$1"
expect "Enter passphrase*"
send -- "$passphrase\n"
expect eof
EOF
#ssh-add -t 30m ~/.ssh/"$1"
#/usr/bin/expect -f 'expect "Enter*"'

#send -- "$passphrase"

###############



#read lastpass_status

#echo "$lastpass_status"

#if [ "$lastpass_status" = "Not logged in." ] ; then
#	echo "you are doing well" 
#fi

#$1