# Notice: Repository Deprecation
This repository is deprecated and no longer actively maintained. It contains outdated code examples or practices that do not align with current MongoDB best practices. While the repository remains accessible for reference purposes, we strongly discourage its use in production environments.
Users should be aware that this repository will not receive any further updates, bug fixes, or security patches. This code may expose you to security vulnerabilities, compatibility issues with current MongoDB versions, and potential performance problems. Any implementation based on this repository is at the user's own risk.
For up-to-date resources, please refer to the [MongoDB Developer Center](https://mongodb.com/developer).


# Get-Started Realm Web

Repository to help getting started with MongoDB Realm Web connecting to MongoDB Atlas.

## Information

This Get-Started project uses [MongoDB Realm Web](https://docs.mongodb.com/realm/get-started/introduction-web). 

## Pre-requisites 

### Docker 

Have Docker running on your machine. You can download and install from: https://docs.docker.com/install/

### MongoDB Atlas

In order to execute the code example, you need to have: 

* [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) cluster
* Create a [MongoDB Atlas Programmatic API](https://docs.atlas.mongodb.com/configure-api-access#programmatic-api-keys). You would create a `Project Owner` permission, see also [Add an API key to your Atlas Project](https://docs.mongodb.com/realm/tutorial/realm-app#d.-add-an-api-key-to-your-atlas-project---log-into-the-realm-cli) for steps on how to get Public and Private keys. 

If you don't have an existing cluster, you can create one by signing up [MongoDB Atlas Free-tier M0](https://docs.atlas.mongodb.com/getting-started/). 

##  Execution Steps 

1. Execute the helper shell setup script by providing the PUBLIC and PRIVATE programmatic API keys: 
  ```
  ./get-setup.sh <PUBLIC_KEY> <PRIVATE_KEY>
  ```
2. Execute the helper shell starter script by providing the Realm application ID. The output from `get-setup.sh` helper script should inform you the name of the newly created Realm application. 
  ```
  ./get-started.sh <REALM_APP_ID>
  ```
Once successful, you should be able to access the web application from a browser via `localhost:3000`

## Tutorials

* [Realm Tutorial: Backend](https://docs.mongodb.com/realm/tutorial/realm-app)
* [Realm Tutorial: Web Client](https://docs.mongodb.com/realm/tutorial/web-graphql)


## About 

This project is part of the MongoDB Get-Started code examples. Please see [get-started-readme](https://github.com/mongodb-developer/get-started-readme) for more information. 

## Disclaimer

This software is not supported by [MongoDB, Inc](https://www.mongodb.com)
under any of their commercial support subscriptions or otherwise. Any usage is at your own risk.
