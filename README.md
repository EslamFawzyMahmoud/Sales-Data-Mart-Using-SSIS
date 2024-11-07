# Sales Data Mart Project
This project focuses on building a Sales Data Mart using SQL Server Integration Services (SSIS) to extract, transform, and load (ETL) data from an existing data warehouse (AdventureWorksDW) into a newly created data mart. The objective is to support optimized reporting and analytics by organizing sales data into a star schema structure, centralizing critical sales-related information.

## Project Components:
### 1- Destination Database Creation

A destination database is established to house the data mart. This database is specifically designed to receive data extracted from the source database, AdventureWorksDW, ensuring a separation between the source and the data mart environments.

### 2- Data Mart Structure and Schema Design

The data mart is structured using a star schema, comprising:
A central Fact_Sales table that aggregates and stores core sales metrics.
Four supporting dimension tables — Dim_Product, Dim_Customer, Dim_Territory, and Dim_Date — which categorize and describe the facts in Fact_Sales, making it easier to analyze and report sales data based on product, customer, territory, and date attributes.
Each dimension table is populated with data sourced from relevant tables in the AdventureWorksDW database, allowing for a rich analytical layer.

### 3- ETL Process with SSIS Packages

SSIS packages are created to automate the ETL process, moving data from the source (AdventureWorksDW) to the destination (data mart) database.
Custom SQL queries are used within each SSIS package to extract and load data from the source tables to the appropriate tables in the data mart.
SSIS packages are configured for each table (Fact_Sales and each dimension table) to ensure data is accurately loaded, transformed if necessary, and ready for reporting.

## Key Objectives

1- To enable faster and more efficient reporting on sales data.
2- To centralize and organize sales data into a scalable and easy-to-query structure.
3- To maintain separation between the source operational database and the analytics-focused data mart for optimized performance.

Note: This project provides a foundational approach to building a data mart using SSIS, with a focus on ETL process automation, schema design, and efficient data transfer between databases.
