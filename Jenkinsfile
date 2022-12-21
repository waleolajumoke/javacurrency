pipeline {
    agent any
    tools {
        maven 'myMaven' 
	docker 'myDocker'
    }
    environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }
    stages {
        stage ('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.build("tech365/testjava:${TAG}")
                }
            }
        }
	    stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerlogin') {
                        docker.image("tech365/testjava:${TAG}").push()
                        docker.image("tech365/testjava:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy'){
            steps {
                sh "docker stop testjava | true"
                sh "docker rm testjava | true"
                sh "docker run --name testjava -d -p 9004:8080 tech365/testjava:${TAG}"
            }
        }
    }
}


// pipeline { 
//     environment { 
//         registry = "tech365/javatest" 
//         registryCredential = 'dockerid' 
//         dockerImage = '' 
//     }
//     agent any 
//     stages { 
//         stage('Cloning our Git') { 
//             steps { 
//                 git 'https://github.com/waleolajumoke/javacurrency.git' 
//             }
//         } 
//         stage('Building our image') { 
//             steps { 
//                 script { 
//                     dockerImage = docker.build registry + ":$BUILD_NUMBER" 
//                 }
//             } 
//         }
//         stage('Deploy our image') { 
//             steps { 
//                 script { 
//                     docker.withRegistry( '', registryCredential ) { 
//                         dockerImage.push() 
//                     }
//                 } 
//             }
//         } 
//         stage('Cleaning up') { 
//             steps { 
//                 sh "docker rmi $registry:$BUILD_NUMBER" 
//             }
//         } 
//     }
// }


