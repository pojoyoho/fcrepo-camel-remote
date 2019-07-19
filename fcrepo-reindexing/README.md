# config.json
Fedora camel component: fcrepo-reindexing-4.7.2
```
{
    "identifier": "/prod/48/79/6c/36/48796c36-a119-4551-b6b0-7d71f840b84d",
    "recipients": "broker:queue:triplestore.reindex,broker:queue:solr.reindex,broker:queue:fixity",
    "action": "update.triple"
}
```
- identifier: container path to reindex Ex. ```/prod/48/79/6c/36/48796c36-a119-4551-b6b0-7d71f840b84d```
- recipients: queues to reindex(comma seperated), will not process if it is empty. 
  Ex. ```broker:queue:triplestore.reindex,broker:queue:solr.reindex,broker:queue:fixity```
- action: action to preform ```[update.triple|delete.object]```
  - update.object: set identifier: "/prod/.." and recipients: (one of the list or "": will do nothing)
  - delete.object: set identifier: "/prod/.." and recipients = ""