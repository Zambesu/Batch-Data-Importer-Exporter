<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Data Importer/Exporter</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            color: #333;
        }
        h1, h2, h3 {
            color: #0056b3;
        }
        code {
            background-color: #f4f4f4;
            padding: 2px 4px;
            border-radius: 4px;
            font-family: Consolas, "Courier New", monospace;
        }
        pre {
            background-color: #f4f4f4;
            padding: 10px;
            border-left: 4px solid #ccc;
            overflow-x: auto;
        }
        ul {
            margin-left: 20px;
        }
        a {
            color: #0056b3;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Batch Data Importer/Exporter</h1>

    <h2>Description</h2>
    <p>
        This project contains a Cobol-based batch program designed to import and export data 
        between a flat file (CSV or fixed-width) and a DB2 database. The program includes 
        error handling, logging, and basic validation to ensure data integrity during the 
        import/export process.
    </p>

    <h2>Features</h2>
    <ul>
        <li><strong>Import Data:</strong> Load data from a CSV or fixed-width flat file into a DB2 table.</li>
        <li><strong>Export Data:</strong> Export data from a DB2 table into a CSV or fixed-width flat file.</li>
        <li><strong>Error Handling:</strong> Logs any errors encountered during the import/export process.</li>
        <li><strong>Data Validation:</strong> Ensures data conforms to the required format before importing into DB2.</li>
        <li><strong>Logging:</strong> Generates logs for each import/export session, tracking successful records and errors.</li>
    </ul>

    <h2>Requirements</h2>
    <ul>
        <li><strong>Mainframe Environment:</strong> COBOL, DB2, and JCL support.</li>
        <li><strong>Database:</strong> DB2 (can be adapted to other databases with minor modifications).</li>
        <li><strong>File Format:</strong> Supports CSV and fixed-width formats.</li>
        <li><strong>Tools:</strong> JCL for job control, and a text editor for CSV or fixed-width files.</li>
    </ul>

    <h2>Installation</h2>
    <ol>
        <li>Clone this repository to your local machine or mainframe environment:
            <pre><code>git clone https://github.com/yourusername/batch-data-importer-exporter.git</code></pre>
        </li>
        <li>Modify the DB2 connection settings in the <code>config</code> section of the Cobol program.</li>
        <li>Prepare your input CSV or fixed-width file to match the expected format.</li>
        <li>Set up the appropriate JCL scripts to run the batch job.</li>
    </ol>

    <h2>Usage</h2>
    <p><strong>To Import Data:</strong></p>
    <ol>
        <li>Place the input file in the appropriate directory.</li>
        <li>Execute the batch job using the JCL script.</li>
    </ol>
    <p><strong>To Export Data:</strong></p>
    <ol>
        <li>Set up the output file location.</li>
        <li>Run the batch job to export the data.</li>
    </ol>

    <h2>Example CSV Format</h2>
    <p><strong>Input File (CSV):</strong></p>
    <pre><code>ID,Name,Amount
1,John Doe,1000
2,Jane Smith,1500</code></pre>
    <p><strong>Output File (CSV):</strong></p>
    <pre><code>ID,Name,Amount
1,John Doe,1000
2,Jane Smith,1500</code></pre>

    <h2>Configuration</h2>
    <p>
        The Cobol program uses configuration settings to connect to DB2 and specify file paths.
    </p>
    <ul>
        <li><strong>DB2 Connection String:</strong> Modify the connection string in the Cobol code for your DB2 instance.</li>
        <li><strong>File Paths:</strong> Update the input/output file paths in the program.</li>
    </ul>

    <h2>License</h2>
    <p>
        This project is licensed under the MIT License - see the 
        <a href="LICENSE">LICENSE</a> file for details.
    </p>
</body>
</html>
