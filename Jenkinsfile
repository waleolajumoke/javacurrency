pipeline { 
2
    environment { 
3
        registry = "tech365/javatest" 
4
        registryCredential = 'dockerid' 
5
        dockerImage = '' 
6
    }
7
    agent any 
8
    stages { 
9
        stage('Cloning our Git') { 
10
            steps { 
11
                git 'https://github.com/waleolajumoke/javacurrency.git' 
12
            }
13
        } 
14
        stage('Building our image') { 
15
            steps { 
16
                script { 
17
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
18
                }
19
            } 
20
        }
21
        stage('Deploy our image') { 
22
            steps { 
23
                script { 
24
                    docker.withRegistry( '', registryCredential ) { 
25
                        dockerImage.push() 
26
                    }
27
                } 
28
            }
29
        } 
30
        stage('Cleaning up') { 
31
            steps { 
32
                sh "docker rmi $registry:$BUILD_NUMBER" 
33
            }
34
        } 
35
    }
36
}


