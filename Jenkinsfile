// Jesh Amera Feb 21/2020

Pipeline {
node() {
    stage ('Checkout SCM') {
     checkout([$class: 'GitSCM', 
     	branches: [[name: '*/master']], 
     	doGenerateSubmoduleConfigurations: false, 
     	extensions: [], 
     	submoduleCfg: [], 
     	userRemoteConfigs: [[credentialsId: '', 
     	url: 'https://github.com/simulationpoint/Terraform-Kubernetes-Jenkins-Docker-Flask-App-Project.git']]]) 
    	 }
   	stage ('TF init & TF apply') {
	sh """
	# cd to cloned repo and check pull SCM
	cd ~/Desktop/Terraform-Kubernetes-Jenkins-Docker-Flask-App-Project
	git pull https://github.com/simulationpoint/Terraform-Kubernetes-Jenkins-Docker-Flask-App-Project.git

	# apply terraform
	
	terraform apply -auto-approve
	""" 
      }
   }
}
