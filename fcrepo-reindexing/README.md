# fcrepo-reindexing
This configuration is for fcrepo-camel-reindexing component to update the Fedora4 repository. There are 3 steps to complete the process.
- Use GraphDB workbrench to query data from fedora triplestore. The query result has only subject column.
```sql
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX fedora: <http://fedora.info/definitions/v4/repository#>
PREFIX model: <info:fedora/fedora-system:def/model#>
select ?s 
where {
  ?s fedora:lastModified ?date .
  ?s model:hasModel "IRItem" .
}
offset 15000
limit 3
```
- Run csv2path.sh to create object_path.txt for objects to be updated
- Run update_config.sh to update object ids in config.json. The script loops through the object list in object_path.txt with waiting interval.

## query-result.csv
The csv file is a result from GraphDB SPARQL query that has only subject column. 

## csv2path.sh
This script transforms query-result.csv from GraphDB SPARQL query to object_paths.txt. The script needs the query-result.csv directory as a parameter.
```shell
./csv2path.sh ~/Downloads > object_paths.txt
```

### object_paths.txt
```shell
/prod/b2/78/85/f5/b27885f5-bfca-4c3c-90c7-f1ea16447523
/prod/78/7b/a0/35/787ba035-be59-4828-94bc-45e6c5538aff
/prod/49/42/d3/5e/4942d35e-d98b-4b61-b017-10d085fc0d02
```

## config.json
Fedora camel component: fcrepo-reindexing-4.7.2
```json
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

## update_config.sh

The script reads object_paths.txt and uses the path to update object identifier in config.json. 
Then, commits to github repository and waits for random minutes from 20 to 60 minutes. To run the script
in background job using the following command. The outputs are in update_config.log file.

```shell
./update_config.sh >> update_config.log &
```

## Notes

### Configure git account in the project
- Update git config in /workspace/fcrepo-camel-remote/.get/config

```yml
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