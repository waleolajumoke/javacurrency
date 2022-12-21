node {   
    stage('Clone repository') {
        git credentialsId: 'git', url: 'https://github.com/waleolajumoke/javacurrency'
    }
    
    stage('Build image') {
       dockerImage = docker.build("tech365/javacurrency:latest")
    }
    
 stage('Push image') {
        withDockerRegistry([ credentialsId: "dockerid", url: "" ]) {
        dockerImage.push()
        }
    }    
}