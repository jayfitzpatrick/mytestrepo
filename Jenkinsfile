timestamps {

VAR1='findme1'
VAR2='findme2'
node () {
env.myVar1=${VAR1}
stage ('Variables') {
  env.myVar1=${VAR2}
sh """
logger "${env.myVar1}"
logger "${env.myVar2}"
"""
}
}
}
