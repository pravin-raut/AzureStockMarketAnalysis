# Azure Stock Market Analysis Project

## Project Description

This project is aimed at analyzing stock market data using Python libraries and Azure technologies. The project leverages the NSePy and NSe libraries of Python to extract and analyze stock market data. Azure Functions are created on top of these libraries to enable data processing.


## Architecture Diagram


## Project Components
The project comprises the following components:

### Azure Functions
The Azure Functions are created using Python and are used to extract stock market data using the NSePy and NSe libraries. The functions are deployed to Azure using the Azure Functions service.

### Azure Data Factory
The Azure Data Factory (ADF) is used to load multiple files in ADLS Gen2. The pipeline is created using the For Each activity and reads parameters from Azure Synapse.

### Azure Synapse
Azure Synapse is used to create a table procedure to populate the staging core and business layer. The table procedure is used to perform data transformations and cleansing.

### Power BI Reports (In Progress)
Power BI reports are created on top of the business layer created in Azure Synapse. These reports provide visualizations and insights into the stock market data.



## Teaser (Comming Soon)




## Contact Information
https://www.linkedin.com/in/pravinraut16/

