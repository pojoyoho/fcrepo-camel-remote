# config.json

```
{
    "identifier": "/prod/48/79/6c/36/48796c36-a119-4551-b6b0-7d71f840b84d",
    "recipients": "broker:queue:triplestore.reindex,broker:queue:solr.reindex,broker:queue:fixity",
    "action": "update.triple"
}
```
- identifier: container path to reindex Ex. ```/prod/48/79/6c/36/48796c36-a119-4551-b6b0-7d71f840b84d```
- recipients: queues to reindex(comma seperated), will not process if it is empty. 
  Ex. ```activemq:queue:triplestore.reindex,activemq:queue:fixity``` (fcrepo-triplestore)
  or  ```broker:queue:triplestore.reindex,broker:queue:solr.reindex,broker:queue:fixity``` (fcrepo-reindexing-4.7.2)
- action: action to preform ```[update.triple|delete.object]```