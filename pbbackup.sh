#!/bin/bash
# bash backup script 
# Arguments:
# inputfile      filename in cwd
# --ver          use "ver" instead of "BU"
# -t             include time in date-time stamp (otherwise just date)
# --dir path     save backup to path instead of cwd

USAGE="pbbackup.sh  infile  [-h] [-t]  [-v]  [--tag mytag] [--dir path]"
HELPTXT="${USAGE}\n -h This help text\n -t  Include timestamp with date\n -v  Same as --tag ver\n --tag mytag    Use mytag before the datestamp\n --dir path    Save file to path\n"

if [ "$#" == "0" ]; then
	echo "$USAGE"
	exit 1
fi

DTFMT='+%Y-%m-%d'   # default: YYYY-MM-DD
TAG="BU"
TARGETDIR="."
infile=$1
shift 

options=$(getopt -o htv --long tag --long dir: -- "$@")
eval set -- "$options"
while true; do
    case "$1" in
    -h)
        echo -e ${HELPTXT}
        exit
        ;;
    -t)
        DTFMT='+%Y-%m-%d-%H%M'  # YYYY-MM-DD-hhmm
        ;;
    --v)
        TAG="ver"
        ;;
    --tag)
        shift;   # The arg is next in position args
        TAG=$1
        ;;
    --dir)
        shift;  # The arg is next in position args
        TARGETDIR=$1
        ;;
    --)
        shift
        break
        ;;
    esac
    shift
done


# echo $infile
# echo $DTFMT
# echo $TAG
# echo $TARGETDIR
DATESTAMP=`date $DTFMT`
# echo $DATESTAMP
NEWTAG="_$TAG$DATESTAMP"
# echo $NEWTAG

filenopath=$(basename -- "$infile")
filestem="${filenopath%.*}"
extn="${filenopath##*.}"
outfile="${TARGETDIR}/${filestem}${NEWTAG}.${extn}"
echo $infile
echo $outfile
#cp ${infile} ${outfile}
