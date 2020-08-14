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
				checkout scm
      }
    }
    stage("Changed File List")
    {
      steps
      {
        sh '''
          git diff --name-only origin/master > changedFiles.lst
          cat changedFiles.lst
        '''
      }
    }
  }
}
