# go in home and make directory
cd $HOME
mkdir students

# download file in home
if [ ! -f "./LCP_22-23_students.csv" ]
then
    wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv
#else
    #file=./LCP_22-23_students.csv
fi   

# check if file is already in students

if [ ! -f "./LCP_22-23_students.csv" ]
then
    echo "the file ./LCP_22-23_students.csv does not exist! "
else
    file=./LCP_22-23_students.csv
fi

# copy the file to students
cp LCP_22-23_students.csv students

# make two files containing different students
grep "PoD" LCP_22-23_students.csv > pod.csv
grep "Physics" LCP_22-23_students.csv > physics.csv

# counts how many students' surname begins with each letter of the alphabet
# find which letter has more counts
n_max=0
letter_max=0

for letter in {A..Z}; do 
    n=$(grep -c "^$letter" LCP_22-23_students.csv)
    echo "number of students whose surname start with letter $letter is: $n"

    if [ $n -gt $n_max ]; then
    	n_max=$n
    	letter_max=$letter
    fi
done
echo "the letter that has more counts is $letter_max"

# group students "modulo 18", i.e. 1,19,37,.. 2,20,38,.. etc. and put each group in a separate file 
#n_students=$(wc -l < LCP_22-23_students.csv)    # number of students

#awk 'NR > 1 && (NR-1) % 18 == 1 {print $0 > }' LCP_22-23_students.csv

# Create a directory to store the output files
output_dir="students"
mkdir -p "$output_dir"

# Use awk to group rows modulo 18, skipping the header and redirecting to files
awk -v output_dir="$output_dir" '
{
    if ((NR-1) % 18 == 0) {
        close(output_file)
        output_file = output_dir "/Group" ++i ".csv"
    }
    print $0 > output_file
}' LCP_22-23_students.csv

