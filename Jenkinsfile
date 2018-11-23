timestamps {

node () {
def env.myVar1='findme1'
stage ('Variables') {
  env.myVar1='findme2'
sh """
logger "${env.myVar1}"
logger "${env.myVar2}"
"""
}
}
}
