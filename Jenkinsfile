Pipeline {

node () {

    stage ('terraform-jenkins - Checkout') {
     checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/simulationpoint/Terraform-Kubernetes-Jenkins-Docker-Flask-App-Project.git']]]) 
    }
    stage ('terraform-jenkins - Build') {
            // Shell build step
sh """
# cd in the cloned repo and pulling changes
cd ~/Documents/devops/Jenkins_terraform
git pull https://github.com/simulationpoint/Terraform-Kubernetes-Jenkins-Docker-Flask-App-Project.git
# Starting terraform
ls
docker ps
terraform apply -auto-approve
 """ 
    }
}
}