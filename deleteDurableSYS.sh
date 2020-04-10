#!/bin/bash
#
# Assumptions:
# 1) everything is driven from this working directory 
# 2) Durable %SYS are in ./iris.sys.d1, ./iris.sys.d2, etc.
#

WDIR=$(pwd)
printf "pwd=%s" $WDIR 

# delete all Durable %SYS dirs
function deleteDurableSYSs()
{
  cd $IDIR
  printf "Deleting files and sub-dirs in \"%s\"... \n" $IDIR
  sudo rm -r -f *

  if [ $? -eq 0 ]
  then
    printf "Done.\n"
  else
    printf "There are issues...\n"
    exit 1
  fi

  # back home & delete the directory
  cd $WDIR 
  printf "Deleting directory \"%s\"... " $IDIR
  sudo rmdir $IDIR
  
  if [ $? -eq 0 ]
  then
    printf "Done.\n"
  else
    printf "There are issues...\n"
    exit 1
  fi
}

# work out the directories to delete
#
# directory name format
# single iris instance (via run.sh)  = ./iris.sys.d
# multiple iris with docker-compose  = ./iris.sys.d1, iris.sys.d2, etc.
# 
function workoutDirs()
{
  for IDIR in $(ls -d iris.sys*)
  do

    if [ -d $IDIR ]
    then

      printf "\nDeleting EVERYTHING in directory \"%s\"\n" $IDIR
      read -p "OK? (Y/N) " YNans
      case $YNans in
      [Yy]* ) deleteDurableSYSs 
	    ;;
      [Nn]* ) printf "OK, everything left untouched.\n"
	    ;;
          * ) printf "\nUnclear answer. Leaving all as is.\n"
   	    ;;
      esac

    else
      printf "\nDirectory \"%s\" does not exist." $IDIR
      printf "\nNothing to delete or check the value of \$IDIR.\n"
    fi

  done
}

function main()
{
  # work out the possible Durable %SYS directories and delete them
  workoutDirs
}

# starting
main
## end
