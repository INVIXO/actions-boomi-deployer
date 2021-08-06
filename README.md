# Options
Command can be any of the following 
# GitHub Actions for Boomi CI/CD

Github action wrapper around the CLI tools from https://github.com/OfficialBoomi/boomicicd-cli, which wraps calls to [Boomi Atomsphere APIs](https://help.boomi.com/bundle/integration/page/r-atm-AtomSphere_API_6730e8e4-b2db-4e94-a653-82ae1d05c78e.html). Handles input and output JSON files and performance orchestration for deploying and managing Boomi runtimes, components and metadata required for CI/CD. 

## Set up

You can call it in a github workflow as shown below:

````
- name: Call Atomsphere API
  if: always() && github.ref == 'refs/heads/master'
  uses: INVIXO/boomi-deployer@master
  with:
    ACCOUNT_ID: ...
    AUTH_TOKEN: ${{ secrets.BOOMI_TOKEN }}
    COMMAND: Create_Deployed_Package
    ENVIRONMENT_ID: ...
    PACKAGE_ID: ...
    NOTES: "Installed via GitAction"
    LISTENER_STATUS: RUNNING
    COMPONENT_TYPE: ...
    PACKAGE_VERSION: ...
    COMPONENT_ID: ...
    COMPONENT_IDS: ...
    NAMES: ...
    COMPONENT_VERSION: ...
    CREATED_DATE: ...
````
Where

- ACCOUNT_ID: (Required) the Boomi Account ID (See accountID= in the URL)
- AUTH_TOKEN: (Required) BOOMI_TOKEN.{user email}:{API Token} (Ex. BOOMI_TOKEN.example@invixo.com:11111-1111-1111-1111-1111111111). Should be saved as a github secret
- COMMAND: (Required) taken from the table below
- ENVIRONMENT_ID: The environment to query/deploy to
- PACKAGE_ID: The package GUID to deploy/query
- NOTES: Any notes to add to the action
- LISTENER_STATUS: If the listener should start RUNNING or PAUSED
- COMPONENT_TYPE: (Optional) A valid (component type)[https://help.boomi.com/bundle/developer_apis/page/int-Component_object.html]
- PACKAGE_VERSION: The text that should show up in the package's version section.
- COMPONENT_ID: A Boomi component id. 
- COMPONENT_IDS: A comma-delimited list of component ids. Either COMPONENT_IDS or NAMES are required when deploying or querying multiple components
- NAMES: A comma-delimited list of component names. Either COMPONENT_IDS or NAMES are required when deploying or querying multiple components
- COMPONENT_VERSION:
- CREATED_DATE:

See the below list for which variables are required for which command

## List of Available Interfaces
The following scripts are available via the action

| **COMMAND** | **REQUIRED VARIABLES** | **OPTIONAL VARIABLES** | **API/Action**| **Notes** |
|---|---|---|---|---|
| Create_Deployed_Package | ENVIRONMENT_ID, PACKAGE_ID, NOTES, LISTENER_STATUS | | DeployedPackage /create|Deploy a Packaged Component in an Env|


## List of Planned Interfaces
| Create_Packaged_Component | COMPONENT_ID, COMPONENT_TYPE, PACKAGE_VERSION, NOTES, COMPONENT_VERSION, CREATED_DATE|createPackagedComponent.json|PackagedComponent/create|Create a Packaged Component| 
| Create_Packages | PACKAGE_VERSION, NOTES, COMPONENT_TYPE, COMPONENT_IDS or NAMES, GIT_PATH | | Multiple | Creates multiple PackagedComponents using the currentVersion processName or id. If the extractComponentXmlFolder if passed all the component XML and package manifest files are extracted into the folder|Note - need to split out sonar and prevent from pushing directly to master in handleXMLComponents

|createPackage.sh|packageVersion, notes, componentType, componentVersion, componentId or processName, extractComponentXmlFolder,tag|Muliple|Multiple|Creates a PackagedComponent by processName or componentid. If the extractComponentXmlFolder if passed all the component XML and package manifest files are extracted into the folder|
|deployPackage.sh|env, packageVersion, notes, listenerStatus, componentType, componentVersion, componentId or processName, extractComponentXmlFolder,tag|Muliple|Multiple|Creates and deploys a PackagedComponent by processName or componentid in a given Env. If the extractComponentXmlFolder if passed all the component XML and package manifest files are extracted into the folder|
|deployPackages.sh|env, packageVersion, notes, listenerStatus, componentType, componentIds or processNames, extractComponentXmlFolder, tag|Muliple|Multiple|Creates and deploys multiple packaged component using the currentVersion processName or id to an env. If the extractComponentXmlFolder if passed all the component XML and package manifest files are extracted into the folder|
|executeProcess.sh|	atomName, atomType, componentId or *processName*| executeProcess.json|executeProcess| Executes a process on a named Boomi runtime|
|queryExecutionRecord.sh|from, to, atomName|queryExecutionRecord.json|ExecutionRecord /query|Queries Process Execution records within a given time span|
|queryPackagedComponent.sh|componentId, componentType, packageVersion|queryPackagedComponent.json|PackagedComponent /query|Queries a Packaged Component by version and Process Name|
|queryProcess.sh|processName|queryProcess.json|Process/query|Queuries a process to get ComponentId|
|queryProcessScheduleStatus.sh|atomName, atomType, processName|queryProcessScheduleStatus.json|ProcessScheduleStatus /query|Queries Process Schedule Status in a runtime|
|queryProcessSchedules.sh|atomName, atomType, processName|queryProcessSchedules.json|ProcessSchedules /query|Queries Process Schedules in a runtime|
|updateProcessScheduleStatus.sh|atomName, atomType, processName, status|updateProcessScheduleStatus.json|ProcessScheduleStatus /$scheduleId /update|Updates Process Schedule Status|
|updateExtensions.sh|extensionJson, envId or env|User supplied JSON file|EnvironmentExtensions $envId/update|Updates the environment extension. The extension values can be passed as strings value="string" or as valueFrom="lookup_value"|
|updateProcessScheduleStatus.sh|atomName, atomType, processName, status|updateProcessScheduleStatus.json|ProcessScheduleStatus /$scheduleId /update|Updates Process Schedule Status|
|updateProcessSchedules.sh|atomName, atomType, processName, years, months, daysOfMonth, daysOfWeek, hours, minutes|updateProcessSchedules.json|ProcessSchedules /$scheduleId /update|Updates Single Process Schedule (For advance options use the UI)|
|updateSharedServer.sh|atomName, overrideUrl, apiType, auth, url|updateSharedServer.json|SharedServerInformation /$atomId /update|Updates Shared Web Server URL and APIType|

## List of Not Planned Interfaces
The following scripts are developed by Boomi, but not yet available via the action

| **SCRIPT_NAME** | **ARGUMENTS** | **JSON FILE** |**API/Action**| **Notes**|
| ------ | ------ | ------ | ------ | ------ |
|changeAllListenersStatus.sh|atomName, atomType, action|changeAllListenersStatus.json|changeListenerStatus|Change Listener Status for all listeners in an atom|
|changeListenerStatus.sh|atomName, atomType, processName, , action|changeListenerStatus.json|changeListenerStatus|Change Listener Status for a single processName in an atom|
|createAtom.sh|atomName, cloudId|createAtom.json|Atom/create|Create Cloud Atom in $cloudId|
|createAtomAttachment.sh|atomId, envId|createAtomAttachment.json|EnvironmentAtomAttachment /create|Attach Atom to Environment|
|createEnvironment.sh|env, classification|createEnvironment.json|Environment/create|Create Env (only if does not exist)|
|createEnvironmentRole.sh|roleName, env|createEnvironmentRole.json|EnvironmentRole /create|Attach a Role to an Env|
|createProcessAttachment.sh|processId, envId, componentType|createProcessAttachment.json|ProcessEnvironmentAttachment /create|Attach Process to Environment (Legacy deployment)|
|dynamicJenkinsGitJobBuilder.sh|GIT_COMMIT_ID|Muliple|Multiple|Reads a JSON configuration file (*\*.conf* extension) that was added/updated as part of the GIT COMMIT and calls Jenkins jobs based the pipeline template. The templates are defined in the templates/configurations folder|
|dynamicScripGitJobBuilder.sh|GIT_COMMIT_ID|Muliple|Multiple|Sames as above reads a JSON configuration file (*\*.conf* extension) that was added/updated as part of the GIT COMMIT and calls cli scripts based the pipeline template. The templates are defined in the templates/configurations folder|
|dynamicScriptJobBuilder.sh|file|Muliple|Multiple|Sames as above directly reads a JSON configuration file (*\*.conf* extension) and calls cli scripts based the pipeline template. The templates are defined in the templates/configurations folder|
|deployProcess.sh|processId, envId, componentType, notes|deployProcess.json|Deployment/|Deploys a process to an env (Legacy Deployment)|
|installerToken.sh|atomType, *cloudId*|installerToken.json|InstallerToken|Gets an installer token atomType must be one-of **ATOM**, **MOLECULE** or **CLOUD**. If atomType=CLOUD then the cloudId must be specified|
|promoteProcess.sh|from, to, processName, current, version, listenerStatus|Muliple|Multiple|Promotes a process of a given version from an Env to another Env (Legacy deployment)|
|queryAtom.sh|atomName, atomType, atomStatus|queryAtom.json|Atom/query|Queries Atom use atomType and atomStatus =* for wild card|
|queryAtomAttachment.sh|atomId, envId|queryAtomAttachment.json|EnvironmentAtomAttachment /query|Queries an Atom/Env Attachment|
|queryDeployedPackage.sh|envId, packageId|queryDeployedPackage.json|DeployedPackage /query|Queries a deployed Packaged Component in an Env|
|queryDeployment.sh|processId, envId, current, version|queryDeployment.json|Deployment/query|Queries a deployment in an Env (Legacy deployment)|
|queryEnvironment.sh|env, classification|queryEnvironment.json|Environment/query|Queries an Env in an Account. Use classification=* for wildcard.|
|queryProcessAttachment.sh|processId, envId, componentType|queryProcessAttachment.json|ProcessEnvironmentAttachment /query|Queries a Process Deployment in an Env (Legacy deployment)|
|queryRole.sh|roleName|queryRole.json|Role/query|Queries a role exists|
|updateAtom.sh|atomId, purgeHistoryDays|updateAtom.json|Atom/$atomId/update|Update atom properties (purgeHistory)|

## Folder Organization
- **bin** has the bash scripts for CLI
- **conf** has configuration files for Molecule installation 
- **json** has json templates used in the Atomsphere API calls.
    



