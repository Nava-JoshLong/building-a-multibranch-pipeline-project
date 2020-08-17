//Variables to be used in script
def scmVars = 'UNKNOWN'

pipeline
{
  //https://www.jenkins.io/doc/book/pipeline/syntax/
  agent any
  options
  {
    skipDefaultCheckout()
  }

  parameters
  {
    choice(name: 'environment', choices: ['dev', 'test', 'impl', 'prod'], description: 'Environment to run on')
    string(name: 'install_dir', defaultValue: '', description: 'Directory to install in')
    string(name: 'log_dir', defaultValue: '', description: 'Directory to store logs')
  }

  stages
  {
    stage('Cleanup Workspace')
    {
      steps
      {
        sh 'rm -rf *'
      }
    }
    stage("Parameter Checking")
    {
      steps
      {
        script
        {
          if (params.log_dir == '' || params.install_dir == '')
          {
            currentBuild.result = 'ABORTED'
            error('Parameters are not set')
          }
        }
      }
    }
    stage('Checkout SCM')
    {
      steps
      {
        script
        {
          echo "Saving SCM variables"
          scmVars = checkout scm
        }
      }
    }
    stage("Get Changed Files")
    {
      steps
      {
        echo scmVars.GIT_BRANCH
        script
        {
          curBranch = 'remotes/origin/'
          curBranch += scmVars.GIT_BRANCH
          FILES_FOUND = sh (
            returnStdout: true,
            script: "git diff --name-only ${curBranch}..remotes/origin/master"
          ).trim()
        }
      }
    }
    stage("Parse Changed Files")
    {
      steps
      {
        echo FILES_FOUND
      }
    }
  }
}
