#!/bin/bash
#SBATCH --partition=debug --time=00:10:00 --output=output.log --mem=4G
#SBATCH -c 2

#Author: Michael Abbott
#Project: BlueHiveTips
#Date Last Updated: September 9, 2021
#Description:	This is a template shell script for submitting a job to bluehive
#				This file will be customized to perform the tasks you want, and 
#				these tasks will be executed on a new bluehive session that you don't
#				have to wait around for. In any bluehive session, go to the terminal
#				and type command "sbatch ThisScript'sFileName.sh"

#Note:	The "#" symbol is a comment in shell scripts. HOWEVER, the first several lines
#		are treated different, and must begin with the shebang (#!) line, followed by
#		the options (lines starting with #SBATCH) for specifying the bluehive session
#		you want to run your job.
#		See "info.circ.rochester.edu/#BlueHibe/Running_Jobs/index.html" for more info.


#Everything that follows should be customized to your needs

#navigate to your project folder
cd [insert filepath to project folder]

#load stata or other programs you need
module load stata

#execute stata do file in "batch mode" (runs in background without user interface)
stata -b do YourDoFile.do
#note that other programs (besides stata) have different commands for running their respecitve script files

#Make sure that YourDoFile.do and any other files it refers to are in your project folder. The session you are launching to carry out your job can "see" the same directories as the one you launched it from.






