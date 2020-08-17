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
        //attempting to save SCM variables since it does not save the branch name
        //it is on during the checkout. Getting an error here when trying to save it
          echo "Saving SCM variables"
          scmVars = checkout scm
        }
      }
    }
    stage("Changed File List")
    {
      steps
      {
        echo scmVars.GIT_BRANCH
        script{
        FILES_FOUND = sh (
          returnStdout: true,
          script: "git diff --name-only ${scmVARS.GIT_BRANCH}/master"
        ).trim()
        }
        sh '''
          git diff --name-only ${scmVars.GIT_BRANCH}/master > changedFiles.lst
          cat changedFiles.lst
        '''
      }
    }
  }
}
