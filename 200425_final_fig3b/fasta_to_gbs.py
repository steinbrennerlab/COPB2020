
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
import argparse
import io
import os
import re
from Bio import SeqFeature
from Bio.SeqFeature import FeatureLocation
from Bio.SeqFeature import SeqFeature

from Bio.Alphabet import generic_dna

handle = "syntenic_region.fa"
output = 'output.gb'

for seqRecord in SeqIO.parse(handle, "fasta", alphabet=generic_dna):

	length=len(seqRecord)
	my_feature_location = FeatureLocation(1,length)
	my_feature_type = "CDS"
	my_feature = SeqFeature(my_feature_location,type=my_feature_type)
	seqRecord.features.append(my_feature)
	print(seqRecord.features[0])
	outputHandle = seqRecord.id+".gb"
	SeqIO.write(seqRecord,outputHandle,"gb")


