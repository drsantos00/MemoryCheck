#!/bin/bash

while getopts c:w:e flag

  do

    case ${flag} in

      c)
      critical=${OPTARG};;
      w)
      warning=${OPTARG};;
	  e)
      email=${OPTARG};;


      esac

   done



    if [[ $critical = "" || $warning = "" || $email = "" ]]

   then

   echo "No complete argument."

   exit 1

   fi


   if (( $(( warning )) >= $(( critical)) ))

   then

   echo "Error: Critical threshold should be greater than warning threshold."

   exit 1

    else

    echo "ALL GOOD"

    fi
	
	#free -h
	
	ramusage=$(free | awk '/Mem/{printf("Ram Usage: %.0f\n"), $3/$2*100}'|awk '{print $3}')
   
   if (( $ramusage >= $(( critical )) ))
   then
    subj="$(date + "%Y%m%d %HH:%MM") Critical"
    mail -s "$subj" "$email"
    exit 2
    
    elif (( $ramusage >= $(( warning )) ))
    then
    exit 1
    
    else
    exit 0
    
    fi
	
	echo "Memory usage is $ramusage"