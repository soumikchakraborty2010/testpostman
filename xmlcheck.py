import os
import xml.etree.ElementTree as ET

def extract_test_cases(robot_directory):
    test_cases_dict = {}

    for filename in os.listdir(robot_directory):
        if filename.endswith(".robot"):
            robot_file = os.path.join(robot_directory, filename)
            with open(robot_file, "r") as file:
                lines = file.readlines()

            test_cases = [line.strip() for line in lines if line.strip() and not line.startswith(" ")]
            test_cases_dict[filename] = test_cases

            # Print each test case name
            print(f"Tests in {filename}:")
            for test_case in test_cases:
                print(test_case)

    return test_cases_dict

def check_xml(xml_file, test_case_name):
    tree = ET.parse(xml_file)
    root = tree.getroot()

    found_count = 0
    for testCase in root.findall(".//testCase[@name='{}']".format(test_case_name)):
        found_count += 1
        tags = testCase.get("tags", "").strip()

        if not tags:
            print(f"{test_case_name}: No tags associated")
    
    if found_count == 0:
        print(f"{test_case_name}: Not found in XML")
    elif found_count > 1:
        print(f"{test_case_name}: Duplicate test cases")

# Example usage:
robot_directory = "deployment/e2etestcases/p1/"
xml_file = "./poc.xml"

# Extracting test cases from .robot files
test_cases_dict = extract_test_cases(robot_directory)

# Checking XML for each test case
for filename, test_cases in test_cases_dict.items():
    print(f"Checking {filename}...")
    for test_case_name in test_cases:
        check_xml(xml_file, test_case_name)
