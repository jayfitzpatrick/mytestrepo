pipeline {
   environment {
     VAR1 = "findme1"
     VAR2 = "findme2"
   }

   agent none

   stages {
       stage("first") {
         sh """
         logger "${VAR1}"
         logger "${env.VAR2}"
         """
         }
         }
       }
