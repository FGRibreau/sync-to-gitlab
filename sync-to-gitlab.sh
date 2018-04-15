#!/usr/bin/env zsh

# see: https://gitlab.com/profile
USER_ID=PLEASE_SET_ME
USER_NAME=PLEASE_SET_ME

# see: https://gitlab.com/profile/personal_access_tokens
PRIVATE_TOKEN=PLEASE_SET_ME

# find user namespace id
ALL_NAMESPACE=$(curl -k --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" "https://gitlab.com/api/v3/namespaces")
NAMESPACE_ID=$(echo $ALL_NAMESPACE | jqn --color=false "find({kind:'user', name: '$USER_NAME'}) | get('id')")

for directory in * ; do
  if [ -d "$directory" ]; then
    echo $directory;
    (
      # /user/$USER_ID
      cd $directory;
      git init . -q;
      git add *;
      git commit -m 'init';
      RESPONSE=$(curl -v -H "Content-Type: application/json" \
        --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" \
        "https://gitlab.com/api/v4/projects" \
         -d "{ \"name\": \"$directory\", \"visibility\": \"private\", \"path\": \"$directory\", \"public\": \"false\", \"namespace_id\": \"$NAMESPACE_ID\" }");
      REPO_URL=$(echo $RESPONSE | jqn 'get("ssh_url_to_repo")')
      git remote remove gitlab-backup
      git remote add gitlab-backup $REPO_URL
      git push -all gitlab-backup
    )
  fi
done
