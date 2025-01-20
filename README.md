# Batch Data Importer/Exporter

## Description
This project contains a Cobol-based batch program designed to import and export data between a flat file (CSV or fixed-width) and a DB2 database. The program includes error handling, logging, and basic validation to ensure data integrity during the import/export process.

## Features
- **Import Data**: Load data from a CSV or fixed-width flat file into a DB2 table.
- **Export Data**: Export data from a DB2 table into a CSV or fixed-width flat file.
- **Error Handling**: Logs any errors encountered during the import/export process.
- **Data Validation**: Ensures data conforms to the required format before importing it into DB2.
- **Logging**: Generates logs for each import/export session, tracking successful records and errors.

## Requirements
- **Mainframe Environment**: COBOL, DB2, and JCL support.
- **Database**: DB2 (can be adapted to other databases with minor modifications).
- **File Format**: Supports CSV and fixed-width formats.
- **Tools**: JCL for job control, and a text editor for CSV or fixed-width files.

## Installation 1. Clone this repository to your local machine or mainframe environment. ```bash git clone https://github.com/yourusername/batch-data-importer-exporter.git ``` 2. Modify the DB2 connection settings in the `config` section of the Cobol program. 3. Prepare your input CSV or fixed-width file to match the expected format. 4. Set up the appropriate JCL scripts to run the batch job.

## Usage 1. **To Import Data**: Use the following JCL to execute the Cobol program that imports data from the flat file into DB2. - Place the input file in the appropriate directory. - Execute the batch job. 2. **To Export Data**: Use a separate JCL script to export data from DB2 to a flat file. - Set up the output file location. - Run the batch job to export the data.

## Example CSV Format - **Input File (CSV)**: ```csv ID,Name,Amount 1,John Doe,1000 2,Jane Smith,1500 ``` - **Output File (CSV)**: ```csv ID,Name,Amount 1,John Doe,1000 2,Jane Smith,1500 ```

## Configuration The Cobol program uses configuration settings to connect to DB2 and specify file paths. - **DB2 Connection String**: Modify the connection string in the Cobol code for your DB2 instance. - **File Paths**: Update the input/output file paths in the program.

## License This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
