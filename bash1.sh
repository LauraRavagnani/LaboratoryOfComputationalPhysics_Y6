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
n_max=0
letter_max=0

for letter in {A..Z}; do 
    n=$(grep -c "^$letter" LCP_22-23_students.csv)
    echo "number of students whose surname start with letter $letter is: $n"

    if [[ $n>$n_max ]]; then
    	n_max=$n
    	letter_max=$letter
    fi
done
echo "the letter that has more counts is $letter_max"

# find which letter has more counts







