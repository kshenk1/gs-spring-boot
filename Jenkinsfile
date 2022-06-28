pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '0'))
  }

  agent {
    kubernetes {
      yamlFile 'k8s-pod.yaml'
    }
  }

  stages {
    stage('Run Maven') {
      steps {
        configFileProvider([configFile(fileId: 'maven-nexus-settings', targetLocation: './complete/settings.xml')]) {
          container('Maven Deploy') {
            sh 'mvn deploy -s ./complete/settings.xml -f ./complete/pom.xml'
          }
        }
      }
    }
    stage('Run Sonarqube') {
      steps {
        configFileProvider([configFile(fileId: 'maven-nexus-settings', targetLocation: './complete/settings.xml')]) {
          container('maven') {
            sh 'mvn sonar:sonar -s ./complete/settings.xml -f ./complete/pom.xml'
          }
        }
      }
    }
  }
}
