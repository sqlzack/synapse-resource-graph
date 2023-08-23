## Pulling Resource Graph Data in Azure Synapse

### Description
This repository is a demonstration of a path to creating custom reporting from the Azure Resource Graph.

### Disclaimer
This repository is for __EDUCATION PURPOSES ONLY__. It is __not endorsed__ by Microsoft. It is __only a Proof of Concept__ and __not best practice prescription__.

### Tools Used
- __Azure Resource Graph REST API__ - Allows for sending a query to the Resource Graph and receiving a paged response back for consumption in downstream processing.
- __Azure Synapse Analytics__ - Synapse is a comprehensive analytics platform supporting a wide array of use cases with a diverse set of analytics engines. For this example, we'll be using two of those engines to balance both simplicity and cost.
    - __Pipelines__ - Orchestration for data movement. In this case, call the API, if there are additional pages then repeat the call, and drop the data to a storage destination in JSON format. 
    - __Serverless SQL__ - Pick up data from the Storage Location defined in the Pipelines and transform it to a meaningful structure for reporting.
- __Azure Data Lake Storage Gen 2__ - Data transferred from the Synapse Pipelines will land in Data Lake Storage to be used with Synapse Serverless SQL. 
- __Power BI__ - Used to visualize and share data from the Serverless SQL queries.

### Pre-Requisites
1) Owner access to an Azure Resource Group.
2) Access to a user that can grant Role-based permissions at the Azure Subscription level
3) Ensure the below Resource Providers are [Registered](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types#azure-portal)
    - Microsoft.Synapse
    - Microsoft.Sql

### Steps

1) Deploy Synapse to your Resource Group by clicking the button below.

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsqlzack%2Fzm-deployment-repo%2Fmain%2Farm%2Fsynapse%2FsynapseBase.json)

2) Grant Synapse's Managed Identity access to the Storage Account that deployed with it by following the steps in this [link](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions#grant-permissions-to-managed-identity-after-workspace-creation).
3) Grant Synapse the "Reader" [role](https://learn.microsoft.com/en-us/azure/role-based-access-control/rbac-and-directory-admin-roles#azure-roles) for the Subscriptions you want to build reporting against.
3) [Set Up Linked Services in Synapse](./docs/linkedServices.md)
4) [Import pipeline from template and Publish](./docs/pipeline.md)
5) [Set Variables and Run Pipeline](./docs/runPipeline.md) 
6) Debug SQL
7) Optional: Try the notebook way
    - Deploy spark pool 
    - change variables in notebook
