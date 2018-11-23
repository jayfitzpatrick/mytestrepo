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
                  echo ${VAR1}
                    sh """
                    logger ${VAR1}
                    """

                }
                echo ${VAR1}

            }
        }
    }
}
