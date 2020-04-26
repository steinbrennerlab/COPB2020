echo "/n"
echo "blast_genbanks: Adam's script takes all genbank .gb files in a directory, uses genbank_to_fasta3.py to convert to fa, and then runs blast comparisons for each comparison.  Does so in ABC order, so order the files using numbering"
echo "/n"

#Usage: 

#Converts all .gb to .fa.
#Extracts whole sequence using option -s whole
for i in *.gb; do
	echo $i
	python genbank_to_fasta3.py -i $i -m genbank -o ${i%%.*}.fa -s whole
done

#Makes blastn comparisons for each two .fa files in abc order, called 1.txt 2.txt 3.txt ...
a=0
for j in *.fa; do
	echo $a
	array+=($j)
	if [ $a = 0 ]
	then
		array=($j)
	else
		blastn -query ${array[a-1]} -subject ${array[a]} -gapopen 5 -gapextend 2 -reward 2 -penalty -3 -task blastn -evalue 10 -word_size 50 -outfmt 6 > $a.txt
	fi
	let "a += 1"
	echo $j
	#echo ${array[@]}
	echo ${array[a-1]}
	#	blastn -query j -subject seqB -gapopen 5 -gapextend 2 -reward 2 -penalty -3 -task blastn -outfmt 6 > seqA_seqB.txt
done

#Generates genoplotR graphic using all .gb and all .txt files in order
Rscript genoplot_custom.R -f none -o 190603test4
