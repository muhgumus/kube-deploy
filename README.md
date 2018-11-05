# kube-deploy
You deploy services on kubernetes cluster with curl + jq also you can delete docker images your private repository
    kubernetes deploy - kubectl + curl + jq + delete_image.sh

# Usage (Delete image)
   You will typically use this image in your .gitlab-ci.yml file.

.gitlab-ci.yml
```
delete_image:
  stage: cleanup
  image: thecodingmachine/gitlab-registry-cleaner:latest
  script:
    - /delete_image.sh registry.gitlab.mycompany.com/path/to/image:$CI_COMMIT_REF_NAME
  when: manual
  environment:
    name: review/$CI_COMMIT_REF_NAME
    action: stop
  only:
  - branches
  except:
  - master
 ```
The /delete_image.sh script takes one single argument: the full path to the image to be deleted (including the tag).

Important: for the script to work, you must add a "Secret variable" in Gitlab CI named CI_ACCOUNT. This variable must be in the form "user:password" where [user] is a Gitlab user that has access to the registry and [password] is the Gitlab password of the user. This can be regarded obviously as a security issue if you don't trust all developers who have access to the CI environment (as they will be able to "echo" this secret variable).
