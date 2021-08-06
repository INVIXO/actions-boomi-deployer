#!/bin/bash

#Check if COMMAND is defined
if [ -z "$COMMAND" ]
then
   return 255;
fi

case $COMMAND in
    Create_Deployed_Package) 
        if [ -z "$ENVIRONMENT_ID" -o -z "$PACKAGE_ID" -o -z "$NOTES" -o -z "$LISTENER_STATUS" ]
        then
            return 255;
        fi
        source bin/createDeployedPackage.sh $ENVIRONMENT_ID $PACKAGE_ID $NOTES $LISTENER_STATUS
        ;;
    *)
        #Error if command not defined
        return 255;
esac