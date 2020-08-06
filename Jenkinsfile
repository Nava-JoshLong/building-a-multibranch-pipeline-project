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
    string(name: 'tagSearchingFor', defaultValue: '', description: 'Tag to search for')
  }

  stages
  {
    stage('Scan')
    {
      steps
      {
        echo "=========== Scan Stage ==========="
        try
        {
          //Use string from user to search for tags
          //#log shows just the commit logs
          //#--pretty is the format of the output
          //#-1 only displays 1 commit
          //#https://stackoverflow.com/a/38783622
          TAG_FOUND = sh (
          script: "git log -1 --pretty=%B | grep '${tagSearchingFor}'",
          returnStatus: true
          ) == 0
          echo "Tag Found: ${TAG_FOUND}"
        }
        //#If the release tag is not found
        catch(error)
        {
          echo "Release tag not found"
          //#Attempts 3 times before failing out
          retry(3)
          {
            script
            {
              //#If not found, notify user and prompt for new string
              //#https://issues.jenkins-ci.org/browse/JENKINS-34521
              def userInput = input(id: 'tagSearch', message: 'Tag not found',
              parameters: [
              $class: 'StringParameterDefinition',
              defaultValue: 'Release Tag',
              description: 'Tag to search for',
              name: 'Release'
              ])
              //#if the userInput is found, exit loop
              TAG_FOUND = sh (
              script: "git log -1 --pretty=%B | grep '${userInput}'",
              returnStatus: true
              ) == 0
              echo "Tag Found: ${TAG_FOUND}"
              //#Otherwise, it will run again
            }
          }
        }
      }
    }
  }
  post
  {
    always
    {
      //#This will always run
    }
    success
    {
      //#This will only run if the pipeline runs successfully
    }
    failure
    {
      //#This will only run if the pipeline fails running
    }
    unstable
    {
      //#This will only run if the pipeline is marked unstable
    }
    changed
    {
      //#This will only run if the state changes
      //#Like if it was failing before but now is successful
    }
  }
}
