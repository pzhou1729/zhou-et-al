import gzip
import pandas as pd
import argparse
from collections import defaultdict
import os

# Setup argument parser
parser = argparse.ArgumentParser(description="Analyze reporter matches in paired-end FASTQ files.")
parser.add_argument("read1", help="Input FASTQ.gz file for Read 1 (R1)")
parser.add_argument("read2", help="Input FASTQ.gz file for Read 2 (R2)")
parser.add_argument("csvfile", help="Reference CSV file with reporter information")
parser.add_argument("output", help="Output CSV file for reporter counts")
parser.add_argument("summary", help="Final summary CSV file for total counts")  # New argument for summary

args = parser.parse_args()

# Load reporter reference from CSV file
df = pd.read_csv(args.csvfile)
df.columns = df.columns.str.strip()  # Ensure no extra spaces in column names
sequence_columns = ["Spacer_fw", "7-nt barcode rc orientation", "Unedited_reporter_seq_rc_orient", "Edited_reporter_seq_rc_orient"]
df[sequence_columns] = df[sequence_columns].apply(lambda x: x.str.upper())

# Create lookup dictionaries
barcode_to_spacer = dict(zip(df["7-nt barcode rc orientation"], df["Spacer_fw"]))
barcode_to_pegRNA = dict(zip(df["7-nt barcode rc orientation"], df["pegRNA_name"]))
barcode_to_unedited = dict(zip(df["7-nt barcode rc orientation"], df["Unedited_reporter_seq_rc_orient"]))
barcode_to_edited = dict(zip(df["7-nt barcode rc orientation"], df["Edited_reporter_seq_rc_orient"]))

# Dictionaries for counts
pegRNA_counts = defaultdict(int)
unedited_counts = defaultdict(int)
edited_counts = defaultdict(int)
neither_counts = defaultdict(int)

# Global counters for total numbers
total_unedited = 0
total_edited = 0
total_neither = 0
total_reads = 0
assigned = 0

# Function to process paired-end FASTQ files
def process_fastq(r1_file, r2_file):
    global total_unedited, total_edited, total_neither, total_reads, assigned

    with gzip.open(r1_file, "rt") as r1, gzip.open(r2_file, "rt") as r2:
        while True:
            r1_header = r1.readline().strip()
            r1_seq = r1.readline().strip()
            r1.readline()
            r1.readline()

            r2_header = r2.readline().strip()
            r2_seq = r2.readline().strip()
            r2.readline()
            r2.readline()
            total_reads += 1
            if not r1_seq or not r2_seq:
                break  # End of file

            barcode_seq = r2_seq[:7].upper()  # Extract first 7nt from R2

            if barcode_seq in barcode_to_spacer:
                expected_spacer = barcode_to_spacer[barcode_seq].upper()
                expected_spacer = "G"+expected_spacer
                spacer_length = len(expected_spacer)
                extracted_spacer = r1_seq[:spacer_length].upper()

                if extracted_spacer == expected_spacer:
                    pegRNA_counts[barcode_to_pegRNA[barcode_seq]] += 1
                    assigned += 1

                    # Extract the next 36nt from Read 2 (excluding barcode)
                    unedited_seq = barcode_to_unedited[barcode_seq]
                    edited_seq = barcode_to_edited[barcode_seq]

                    compare_length = len(unedited_seq)  # Length of unedited sequence (≤ 36)
                    extracted_36nt = r2_seq[7:7 + compare_length].upper()  # Aligning length

                    if extracted_36nt == unedited_seq:
                        unedited_counts[barcode_to_pegRNA[barcode_seq]] += 1
                        total_unedited += 1
                    elif extracted_36nt == edited_seq:
                        edited_counts[barcode_to_pegRNA[barcode_seq]] += 1
                        total_edited += 1
                    else:
                        neither_counts[barcode_to_pegRNA[barcode_seq]] += 1
                        total_neither += 1

    #print(f"📌 Total Unedited: {total_unedited}")
    #print(f"📌 Total Edited: {total_edited}")
    #print(f"📌 Total Neither: {total_neither}")
    print(total_reads,assigned)

# Run function with command-line inputs
process_fastq(args.read1, args.read2)

# Convert counts to DataFrame
pegRNA_df = pd.DataFrame(pegRNA_counts.items(), columns=["pegRNA_name", "match_both_count"])
unedited_df = pd.DataFrame(unedited_counts.items(), columns=["pegRNA_name", "Unedited"])
edited_df = pd.DataFrame(edited_counts.items(), columns=["pegRNA_name", "Edited"])
neither_df = pd.DataFrame(neither_counts.items(), columns=["pegRNA_name", "Neither"])

# Merge all data into final DataFrame
df_counts = df.merge(pegRNA_df, on="pegRNA_name", how="left") \
    .merge(unedited_df, on="pegRNA_name", how="left") \
    .merge(edited_df, on="pegRNA_name", how="left") \
    .merge(neither_df, on="pegRNA_name", how="left")

# Fill missing counts with 0
df_counts[["match_both_count", "Unedited", "Edited", "Neither"]] = df_counts[
    ["match_both_count", "Unedited", "Edited", "Neither"]
].fillna(0).astype(int)

# Save results
df_counts.to_csv(args.output, index=False)

#print(f"✅ Processing complete. Results saved in '{args.output}'.")

# Run function with command-line inputs
#process_fastq(args.read1, args.read2)

# Extract sample name from input file
sample_name = os.path.basename(args.read1).replace("_R1.fastq.gz", "")

# Save total counts into a summary CSV file
summary_file = args.summary

# Check if summary file exists; if not, create it with headers
if not os.path.exists(summary_file):
    with open(summary_file, "w") as f:
        f.write("Sample,Total_Unedited,Total_Edited,Total_Neither\n")

# Append results for this sample
with open(summary_file, "a") as f:
    f.write(f"{sample_name},{total_unedited},{total_edited},{total_neither}\n")
