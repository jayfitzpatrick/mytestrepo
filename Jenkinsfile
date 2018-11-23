pipeline {
    agent any
    environment {
        VAR1 = "findme1"
    }

    // ----------------

    stages {
        stage('Starting Work') {
            steps {
                echo 'Still Trying.'

                script {
                    sh """
                    logger "${VAR1}"
                    logger "${env.myVar}"
                    """

                }
            }
        }
    }
}
