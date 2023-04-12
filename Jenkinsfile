pipeline{
     agent {
        label 'docker'
    }
environment {
		DOCKER_LOGIN_CREDENTIALS=credentials('dockerhostpush')
	}
    stages {
  stage('checkout') {
    steps {
      git credentialsId: 'junit-token', url: 'https://github.com/DivyaChilukuri/Jacoco-junit-java-maven.git'
    }
  }

  stage('build') {
    steps {
      sh 'mvn clean install'
       }
  }

 stage('sonarqube scanner') {
    steps {
      withSonarQubeEnv('sonarqube') {
            sh "mvn clean verify sonar:sonar -Dsonar.projectKey=sonar-test2"
       }
      }
 }

 stage('jacoco test unit') {
    steps {
      jacoco(execPattern: '**/target/jacoco.exec')
       }
  }

  stage('Snyk scanning code') {
            steps {
            	snykSecurity failOnError: false, failOnIssues: false, organisation: 'DivyaChilukuri', projectName: 'jacoco-junit', snykInstallation: 'synkinstall', snykTokenId: 'SNYK_TOKEN'
            }
        }
  stage('Build image') {
    steps {
      sh 'docker build -t divyachilukuri/divya1:$BUILD_NUMBER .' 
      sh 'echo $DOCKER_LOGIN_CREDENTIALS_PSW | docker login -u $DOCKER_LOGIN_CREDENTIALS_USR --password-stdin'
      sh 'docker push divyachilukuri/divya1:$BUILD_NUMBER'
    }
  }

  stage('deploy') {
    steps {
      sh "docker run -itd divyachilukuri/divya1:$BUILD_NUMBER"
    }
  }
  stage('Cleanup') {
            steps {
                sh 'rm -rf *'
            }
   }	    

}

}
