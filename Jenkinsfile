// Jesh Amera 
// Feb 22/2021

pipeline {
    agent any
    environment {        
    DOCKER_HUB_REPO = "211896/terraform-flask-app"
    REGISTRY_CREDENTIAL = "dockerhub"
    CONTAINER_NAME = "loving_colden"
    STUB_VALUE = "200"
    }
    stages {
        stage('Stubs-Replacement'){
            steps {
                // 'STUB_VALUE' Environment Variable declared in Jenkins Configuration 
                echo "STUB_VALUE = ${STUB_VALUE}"
                sh "sed -i 's/<STUB_VALUE>/$STUB_VALUE/g' config.py"
                sh 'cat config.py'
            }
        }
        stage('Build') {
            steps {
            script {
            //  Building new image
            sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
            sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'

            //  Pushing Image to Repository
            docker.withRegistry( '', REGISTRY_CREDENTIAL ) {
                sh 'docker push 211896/terraform-flask-app:$BUILD_NUMBER'
                sh 'docker push 211896/terraform-flask-app:latest'
            }
                
                    echo "Image built and pushed to repository"
            }
        }
        }
        stage('Deploy') {
            steps {
                script{
                    // sh 'BUILD_NUMBER = ${BUILD_NUMBER}'
                    if (BUILD_NUMBER == "1") {
                        sh 'docker run --name $CONTAINER_NAME -d -p 5000:5000 $DOCKER_HUB_REPO'
                    }
                    else {
                        sh 'docker stop $CONTAINER_NAME'
                        sh 'docker rm $CONTAINER_NAME'
                        sh 'docker run --name $CONTAINER_NAME -d -p 5000:5000 $DOCKER_HUB_REPO'
                    }
                    // sh 'echo "Latest image/code deployed"'
                }
            }
        }
    }
}




                  

