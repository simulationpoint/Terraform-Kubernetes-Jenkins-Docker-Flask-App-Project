// Jesh Amera 
// Feb 22/2021

pipeline {
    agent any
    node {
        label "master"
    } 
    triggers {
        pollSCM 'H/4 * * * *'
    }
    environment {
        APP_NAME = "terraform-flask-app"
        APP_HOME = "~/Terraform-Kubernetes-Jenkins-Docker-Flask-App-Project/$APP_NAME"
        DOCKER_HUB_REPO = "211896/terraform-flask-app"
        CONTAINER_NAME = "terraform-flask-app"
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Clean WORKDIR') {
            steps {
                sh 'rm -rf $APP_HOME'
            }
        }
        // clone repository  
        stage('Clone Repository') {
            steps {
                sh 'git clone https://github.com/simulationpoint/Terraform-Kubernetes-Jenkins-Docker-Flask-App-Project.git/$APP_NAME'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker image build -t $DOCKER_HUB_REPO $APP_HOME/'
                sh 'docker image tag $DOCKER_HUB_REPO $DOCKER_HUB_REPO:$BUILD_NUMBER'
            }
        }
        stage('Run the Container') {
            steps {
                sh 'if (docker ps | grep $CONTAINER_NAME); then docker stop $CONTAINER_NAME;fi'
                sh 'if (docker image ls | grep $CONTAINER_NAME); then docker rm $CONTAINER_NAME;fi'
                sh 'docker run --name $CONTAINER_NAME -d -p 9090:9090 $DOCKER_HUB_REPO:$BUILD_NUMBER'
            }
        }
        stage('Test the Container') {
            steps {
                sh 'curl -s --head  --request GET  10.0.0.38:9090 | grep 200'
                sh 'if (docker ps | grep $CONTAINER_NAME); then docker stop $CONTAINER_NAME;fi'
            }
        }
        stage('Push Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER1', passwordVariable: 'PASS1')]) {
                sh 'docker login -u "$USER1" -p "$PASS1"'
             }
                sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
                sh 'docker push $DOCKER_HUB_REPO'
          }
        }
        stage('Deploy Kubernetes Cluster Using Terraform') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
                sh 'sudo -u grand kubectl set image deployment/scalable-flask-app flask=${DOCKER_HUB_REPO}:${BUILD_NUMBER}'
            }
        }
        stage('Get namespaces information') {
            steps {
                script {
                    sh '~/kubectl get all --all-namespaces'
                }
            }
        }
    }
}