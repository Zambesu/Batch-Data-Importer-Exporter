# Batch Data Importer/Exporter

## Description
This project contains a Cobol-based batch program designed to import and export data between a flat file (CSV or fixed-width) and a DB2 database.

## Features

- **Import Data**: Load data from a CSV or fixed-width flat file into a DB2 table.
- **Export Data**: Export data from a DB2 table into a CSV or fixed-width flat file.
- **Error Handling**: Logs any errors encountered during the import/export process.
- **Data Validation**: Ensures data conforms to the required format before importing it into DB2.

## Requirements

- **Mainframe Environment**: COBOL, DB2, and JCL support.
- **Database**: DB2 (can be adapted to other databases with minor modifications).
- **File Format**: Supports CSV and fixed-width formats.
- **Tools**: JCL for job control.

## Installation

1. Clone this repository to your local machine or mainframe environment. ```bash git clone https://github.com/yZambesu/batch-data-importer-exporter.git ```
2. Change the EXEC SQL instructions and the file structure in the program to match your input file and database table .
3. Chanege the INPUTLIB symbolic in the COMPILE.JCL job to the dataset where the Cobol program is saved
4. Compile the program using the COMPILE.JCL job

## Usage

1. **To Import Data**:
   - Load the input file to the mainframe before execution.
   - Change the IMPORT.JCL job to match your filename, UserID, current date and the propper LRECL and space alocations, according to your Input file and database table
   - Use the IMPORT.JCL job to execute the Cobol program with the propper parameters to insert the data into the database table.

3. **To Export Data**:
   - Change the EXPORT.JCL job to set the current date and your UserID
   - Run the EXPORT.JCL job to export the data from the database table.

## License
This project is licensed under the GNU GENERAL PUBLIC LICENSE License - see the [LICENSE](LICENSE) file for details.
