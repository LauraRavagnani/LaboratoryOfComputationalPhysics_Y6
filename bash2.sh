# Make a copy of the file `data.csv` removing the metadata
# and the commas between numbers; call it `data.txt`
grep -v "^#" data.csv | tr ',' ' ' > data.txt

# Count even numbers
count=0

while IFS= read -r line; do
    for d in $line; do
    	if (( $d%2==0 )); then count=$((count+1)); fi
    done
done < data.txt

echo "The number of even numbers is $count"

# Distinguish the entries on the basis of `sqrt(X^2 + Y^2 + Z^2)` is greater or smaller than `100*sqrt(3)/2`.
# Count the entries of each of the two groups 

threshold=$(echo "100 * sqrt(3) / 2" | bc -l)
greater=0
smaller=0

while IFS= read -r line; do
    # Extracting the first three values from the line
    read -r x y z _ _ _ <<< "$line"

    # Using bc for floating-point arithmetic
    s=$(echo "sqrt($x^2 + $y^2 + $z^2)" | bc -l)

    if (( $(echo "$s > $threshold" | bc -l) )); then
        greater=$((greater + 1))
    else
        smaller=$((smaller + 1))
    fi
done < data.txt

echo "The entries with the value greater are $greater"
echo "The entries with the value smaller are $smaller"

# Make `n` copies of data.txt (with `n` an input parameter of the script),
# where the i-th copy has all the numbers divided by i (with `1<=i<=n`).
n="$1"

for i in $(seq 1 "$n"); do
	output_file="data_copy_$i.txt"
	awk -v c="$i" '{ for (j = 1; j <= NF; j++) $j = $j / c }1' data.txt > "$output_file"
done





