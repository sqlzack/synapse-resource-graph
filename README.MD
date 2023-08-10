## Pulling Resource Graph Data in Azure Synapse

### Description
This repository is a demonstration of a path to creating custom reporting from the Azure Resource Graph.

### Tools Used
- __Azure Resource Graph REST API__ - Allows for sending a query to the Resource Graph and receiving a paged response back for consumption in downstream processing.
- __Azure Synapse Analytics__ - Synapse is a comprehensive analytics platform supporting a wide array of use cases with a diverse set of analytics engines. For this example, we'll be using two of those engines to balance both simplicity and cost.
    - __Pipelines__ - Orchestration for data movement. In this case, call the API, if there are additional pages then repeat the call, and drop the data to a storage destination in JSON format. 
    - __Serverless SQL__ - Pick up data from the Storage Location defined in the Pipelines and transform it to a meaningful structure for reporting.
- __Azure Data Lake Storage Gen 2__ - Data transferred from the Synapse Pipelins will land in Data Lake Storage to be used with Synapse Serverless SQL. 
- __Power BI__ - Used to visualize and share data from the Serverless SQL queries.

### Pre-Requisites
1) Owner access to an empty RG.
2) Someone who can give the Synapse MSI "Read" access on relevant Subscriptions. 

### Steps

1) Deploy Synapse via the Deployments Repo
2) Give Synapse MSI Data Contributor on Storage Account
3) Detail RBAC needed to pull from Resource Grid
3) Go into Synapse and set up Linked Services and Publish
4) Import pipelin from template and Publish (Ensure Template has no sensitive info!)
5) Debug Pipeline  
    - Show setting parameters
        - https://management.azure.com/providers/Microsoft.ResourceGraph/resources?api-version=2020-04-01-preview
        - https://management.azure.com
6) Debug SQL
    - Show how to add in ABFS path
7) Optional: Try the notebook way
    - Deploy spark pool 
    - change variables in notebook
