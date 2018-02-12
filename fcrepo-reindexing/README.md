# config.json

```
{
    "identifier": "/prod",
    "recipients": "activemq:queue:triplestore.reindex,activemq:queue:solr.reindex,activemq:queue:fixity",
    "action": "update.triple"
}
```
- identifier: container path to reindex Ex. ```/prod```
- recipients: queues to reindex(comma seperated), will not process if it is empty. 
  Ex. ```activemq:queue:triplestore.reindex,activemq:queue:fixity``` (fcrepo-triplestore)
  or  ```broker:queue:triplestore.reindex,broker:queue:solr.reindex,broker:queue:fixity``` (fcrepo-reindexing-4.7.2)
- action: action to preform ```[update.triple|delete.object]```