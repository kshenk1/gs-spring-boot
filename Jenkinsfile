pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '0'))
  }

  environment {
    DOCKER_IMAGE = "danielrmartin/sko:1.2"
  }

  agent {
    kubernetes {
      //cloud 'kubernetes'
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: maven
    image: $DOCKER_IMAGE
    command: ['cat']
    tty: true
"""
    }
  }

  stages {
    stage('Run Maven') {
      steps {
        container('maven') {
          sh 'mvn deploy -f ./complete/pom.xml'
        }
      }
    }
    stage('Run Sonarqube') {
      steps {
        container('maven') {
          sh 'mvn sonar:sonar -f ./complete/pom.xml'
        }
      }
    }
  }
}
