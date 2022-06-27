pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '0'))
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
    image: danielrmartin/sko:1.2
    command: ['cat']
    tty: true
"""
    }
  }

  stages {
    stage('Run Maven') {
      steps {
        container('Maven Deploy') {
          configFileProvider([configFile(fileId: 'maven-nexus-settings', targetLocation: 'settings.xml')]) {
            sh 'mvn deploy -s settings.xml -f ./complete/pom.xml'
          }
        }
      }
    }
    stage('Run Sonarqube') {
      steps {
        container('maven') {
          configFileProvider([configFile(fileId: 'maven-nexus-settings', targetLocation: 'settings.xml')]) {
            sh 'mvn sonar:sonar -s settings.xml -f ./complete/pom.xml'
          }
        }
      }
    }
  }
}
