// Jesh Amera 
// Feb 22/2021
// Inspired by talha22081992@github
pipeline {
    agent any
    environment {        
	DOCKER_HUB_REPO = "211896/jesh_docker_image"
	REGISTRY_CREDENTIAL = "dockerhub"
        CONTAINER_NAME = "jesh-final"
        STUB_VALUE = "200"
    }
    stages {
        stage('Stubs-Replacement') {
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
				sh 'docker push 211896/jesh_docker_image:$BUILD_NUMBER'
				sh 'docker push 211896/jesh_docker_image:latest'
			}
      echo "Image built and pushed to repository"
       }
     }
   }
  // Prune unnecessary docker resources
      stage("Cleaning up") {
        steps {
          echo 'Cleaning up...'
          sh "docker system prune"
      }
    }
  }
}



                  

