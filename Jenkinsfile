pipeline {
    agent {
        label 'one'
    }

    stages {
        stage('code clone') {
            steps {
           git  branch: 'master', changelog: false, poll: false, url: ''
            }
        }
      stage('code build') {
            steps {
            sh '/opt/maven/bin/mvn package '
            sh 'ls -al'
           }
        }
     
     
     stage('Docker Build and Tag') {
           steps {
              
                sh 'docker build -t samplewebapp:latest .' 
                //sh 'docker tag samplewebapp nikhilnidhi/samplewebapp:latest'
                //sh 'docker tag samplewebapp nikhilnidhi/samplewebapp:$BUILD_NUMBER'
               
          }
        }  
    }
    
}
