#!/usr/bin/env python

import argparse
import parasail

def main(args):
    ref_seqs = parasail.sequences_from_file(args.ref)
    ref_seq = ref_seqs[0]

    alt_seqs = parasail.sequences_from_file(args.alt)
    alt_seq = alt_seqs[0]
    
    alignment = parasail.nw(ref_seq.seq, alt_seq.seq, 1, 1, parasail.dnafull)

    print(alignment)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--ref')
    parser.add_argument('--alt')
    args = parser.parse_args()
    main(args)
