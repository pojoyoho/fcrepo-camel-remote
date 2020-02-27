# config.json
Fedora camel component: fcrepo-reindexing-4.7.2
```
{
    "identifier": "/prod/48/79/6c/36/48796c36-a119-4551-b6b0-7d71f840b84d",
    "recipients": "broker:queue:triplestore.reindex,broker:queue:solr.reindex,broker:queue:fixity",
    "action": "update.object"
}
```
- identifier: container path to reindex Ex. ```/prod/48/79/6c/36/48796c36-a119-4551-b6b0-7d71f840b84d```
- recipients: queues to reindex(comma seperated), will not run reindexing if it is empty. 
  Ex. ```broker:queue:triplestore.reindex,broker:queue:solr.reindex,broker:queue:fixity```
- action: action to preform ```[update.object|delete.object]```
  - update.object: set identifier: "/prod/.." and recipients: (one of the list or "": will do nothing)
  - delete.object: set identifier: "/prod/.." and recipients = ""

# Configure git account in the project
- Update git config in /workspace/fcrepo-camel-remote/.get/config
```
[user]
        name = pojoyoho
        email = pojoyoho@gmail.com
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
        precomposeunicode = true
[remote "origin"]
        url = git@pojoyoho.github.com:pojoyoho/fcrepo-camel-remote.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
        rebase = false
```