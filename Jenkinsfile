pipeline {
    agent any
    tools {
        maven 'myMaven' 
    }
   
    stages {
        stage ('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

	    stage('Docker Build'){
            steps{
                withDockerRegistry(
                    [credentialsId:"dockerlogin", url: ""]
                )  {
                    script{
                    app = docker.build("testjava")
                    }
                }
            }
        }
		 stage('Push'){
             steps{
                 script{
                     docker.withRegistry("https://registry.hub.docker.com", "dockerlogin"){
                         app.push("latest")
                     }
                    

    }
   
             }
         }
        stage('Deploy'){
            steps {
                sh "docker stop testjava | true"
                sh "docker rm testjava | true"
                sh "docker run --name testjava -d -p 9004:8080 tech365/testjava:latest"
            }
        }
 

    }

}
