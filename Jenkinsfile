pipeline {
    agent {
        label 'one'
    }

    stages {
      stage('code build') {
            steps {
            sh '/opt/maven/bin/mvn package '
            }
        }
     
     stage('ECR creation and docker build and push ') {
           steps {
              
               sh '''terraform init && terraform plan && terraform ${TFCOMMAND}  -auto-approve ''' 
               
               
          }
        }  
  
    }
    
}
