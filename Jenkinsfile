#!/usr/bin/env groovy

// options { buildDiscarder(logRotator(numToKeepStr: '5')) }


node {
    stage('Init Stage'){
        env.APP_NAME = "spr-monolith"
        env.ACR_NAME = "testrigregistry"
        env.SUBSCRIPTION_ID = "57b13db8-88cf-4fe6-924b-ae10dc6fadee"
        env.AKS_NAME = "demo-aks"
        env.RESOURCE_GROUP = "demo-rg"
	    env.BRANCH_NAME = env.BRANCH_NAME.replaceAll('/','_')
    }

    stage('GitCheckout'){
        checkout scm
    }




    stage('SelfTests'){
             sh 'docker run --rm  -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven testrigregistry.azurecr.io/spr-monolith:seed mvn test'
    }


    stage('AzureBuild'){
    withCredentials([azureServicePrincipal('test-rig-demo-jenkins')]) {  
        sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
        sh 'az acr build --file Dockerfile --subscription  ${SUBSCRIPTION_ID}   --registry ${ACR_NAME} --image ${APP_NAME}:${BRANCH_NAME} .'
    }}



    // stage('DropdownPopulator'){
    //     withCredentials([azureServicePrincipal('test-rig-demo-jenkins')]) {
    //         sh '''
    //             set -e
    //             az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
    //             az aks get-credentials --resource-group ${RESOURCE_GROUP} --subscription ${SUBSCRIPTION_ID}   --name ${AKS_NAME}
    //             rm -rf ~/DROPDOWNS/
    
    //             for NAMESPACE in $(kubectl get namespaces -o json | jq -r '.items[].metadata | select(.name | startswith("self-")) | .name ')
    //             do
    //                 echo NAMESPACE is $NAMESPACE
    //                 mkdir -p ~/DROPDOWNS/namespaces/${NAMESPACE}
    //             done

    //             for REPOSITORY in $(az acr repository list --subscription ${SUBSCRIPTION_ID} --name ${ACR_NAME} | jq -r '.[]')
    //             do
    //                 echo REPO is $REPOSITORY
    //                 for TAG in $(az acr repository show-tags --subscription ${SUBSCRIPTION_ID} --name ${ACR_NAME} --repository $REPOSITORY | jq -r .[])
    //                 do
    //                     mkdir -p ~/DROPDOWNS/apps/$REPOSITORY/$TAG
    //                 done
    //             done
    //         '''
    //      }   
    // }
}


 
