# #!/bin/bash

# # Path to the directory containing .robot files
# robot_files_directory="./deployment/e2etestcases/p1"

# # Declare an array to store non-blank lines
# declare -a non_blank_lines

# # Loop through each .robot file
# for robot_file in "$robot_files_directory"/*.robot; do
#     # echo "Test Cases in $robot_file"

#     # Use awk to extract lines after *** Test Cases *** where there are no spaces or tabs and exclude blank lines
#     lines=$(awk '/^\*\*\* Test Cases \*\*\*/{flag=1; next} flag && !/^[[:space:]]/ && NF {print}' "$robot_file")

#     # Add non-blank lines to the array
#     non_blank_lines+=("$lines")
# done

# # Print the non-blank lines stored in the array
# for line in "${non_blank_lines[@]}"; do
#     echo "$line"
# done




#!/bin/bash

# Path to the directory containing .robot files
robot_files_directory="./deployment/e2etestcases/p1"

# Path to the poc.xml file
xml_file="./poc.xml"

# Declare an array to store non-blank lines
declare -a non_blank_lines

# Loop through each .robot file
for robot_file in "$robot_files_directory"/*.robot; do
    # echo "Checking test cases in $robot_file"

    # Use awk to extract lines after *** Test Cases *** where there are no spaces or tabs and exclude blank lines
    lines=$(awk '/^\*\*\* Test Cases \*\*\*/{flag=1; next} flag && !/^[[:space:]]/ && NF {print}' "$robot_file")

    # Add non-blank lines to the array
    non_blank_lines+=("$lines")
done

# Loop through the non-blank lines array
# for line in "${non_blank_lines[@]}"; do
#     # echo "$line"

#     # Check if the test case name is present in the xml file
#     if grep -q "name=\"$line\"" "$xml_file"; then
#         # Check for duplicate entries in the xml file
#         if grep -c "name=\"$line\"" "$xml_file" | grep -qv ':1$'; then
#             echo "Test case $line: Duplicate entries in XML"
#         else
#             # Check if the tags property has no value
#             if grep -q "name=\"$line\".*tags=\"\"" "$xml_file"; then
#                 echo "Test case $line: No tags associated"
#             fi
#         fi
#     else
#         echo "Test case $line: Not found in XML"
#     fi
# done

for line in "${non_blank_lines[@]}"; do
    echo "$line"
    # Check if the test case is present in the XML
    if grep -q "name=\"$line\"" "$xml_file"; then
        echo "Present in XML"
        # # Check for duplicate entries in the XML file
        # if grep -c "name=\"$line\"" "$xml_file" | grep -qv ':1$'; then
        #     echo "Duplicate entries: $line"
        # else
        #     # Check if the tags property has values
        #     if grep -q "name=\"$line\".*tags=\"[^\"]+\"" "$xml_file"; then
        #         echo "Properly present: $line"
        #     else
        #         echo "No Tags associated: $line"
        #     fi
        # fi
    else
        echo "Not found"
    fi
done

