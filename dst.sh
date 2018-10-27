#!/bin/bash
# ----------------------------------------------------------------------- debug tools (undo = set +)

set -u #or
#set -o nounset #more verbose
set -e #or
#set -o errexit #more verbose
#set -x #: Display commands and their arguments as they are executed.
#set -v #: Display shell input lines as they are read.
#set -n #: Read commands but do not execute them. This may be used to check a shell script for syntax errors.
#trap "echo hit return;read x" DEBUG #: Execute line by line
#echo "Safety exit, comment line 11." && exit 1
#umask 022

# ----------------------------------------------------------------------------------- User variables
# --------------------------------------------------------------------------------- script variables

VERSION=v0.1  							#template v.003
trap "exit" INT TERM

# -------------------------------------------------------------------------------------- dependecies
# --------------------------------------------------------------------------------- script functions
function usage
{
cat <<_EOM_
	Determining of start and end of "Daylight Saving Time."
	Usage:	`basename $0` [-h | --help] [$(date +"%Y")]
	${VERSION}	
_EOM_

exit 1

}
# ------------------------------------------------------------------------------------------ argtest
[[ "$#" -ge 2 ]] && usage 
if [[ "$#" -eq 0  ]];then ev=$(date +"%Y")
elif [[ $1 =~ ^-?[0-9]+$ ]];then ev=$1
else 
usage
fi

# ------------------------------------------------------------------------------------------- script

ev=${1:-$(date +"%Y")}
k=$(echo "scale=0; ($ev * 5) / 4" | bc -l);
marc_nap=$(echo "scale=0; ((32762 - $k) % 7) + 25" | bc -l);
okt_nap=$(echo "scale=0; ((32765 - $k) % 7) + 25" | bc -l);
echo "$ev"-03-"$marc_nap 02:00 -> 03:00";
echo "$ev"-10-"$okt_nap 03:00 -> 02:00"; 

exit 0

