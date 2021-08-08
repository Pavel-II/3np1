#!/bin/bash

FROMNUM=$1
TONUM=$2
SHOWMORE=$3

if [[ $FROMNUM -eq "" ]]; then
	echo "How to use: run $0 [FROMNUM] [TONUM] [Y]"
	echo "for print from FROMNUM to TONUM and print visual calculations if Y specified"
	echo "Without specified TONUM or by default FROMNUM=1 TONUM = 42"
	echo "FROMNUM and TONUM only positive numbers"
	FROMNUM=1
	TONUM=42
fi
seq=''

#
function seq_print(){
	steps_count=`echo $seq| wc -w`
	echo "("$(($steps_count+1))")" $seq""$next
}

#
function get_seq(){
	#	
	seq=$seq" "$1" "
	#
	if [[ $(($1 % 2)) -eq 0 ]] ; then
		next=$(($1/2))
		#
		if ! [[ $next -eq 1 ]]; then
			get_seq $next
		else
			seq_print
		fi
	else
		next=$(($1*3+1))
		# 
		if ! [[ $next -eq 1 ]]; then
			get_seq $next
		else
			seq_print
		fi
	fi
}
#
for i in `seq $FROMNUM $TONUM`; do
	echo -n $i:" "
	seq=""
	get_seq $i;
done
#
if [[ "$SHOWMORE" = "Y"  ]]; then
	echo ""
	echo "Visual calculations:"
	#SEP=''
	SEP=';' # for export as csv for example
	#	
	for i in `seq 1 $TONUM`; do
		echo -n $i:"$SEP"
		if [[ $(($i % 2)) -eq 0 ]] ; then
			res=$(($i/2))
			#
			echo "$i/2$SEP=$SEP"$res
		else
			res=$(($i*3+1))
			#
			echo "$i*3$SEP+$SEP$SEP"1"$SEP=$SEP"$res
		fi
	done
fi
