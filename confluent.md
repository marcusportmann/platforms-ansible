# Confluent

## Deployment and Management
This project enables the deployment, configuration, and management of one or more Confluent clusters using the Confluent Community License; along with the required monitoring capabilities to effectively manage the clusters. 


### Ansible Roles
The following Ansible roles are responsible for the deployment, configuration and management of the Confluent platform and the associated monitoring capabilities.
These roles are assigned to Ansible hosts using an inventory file. The roles are compatible and can all be assigned to a single host or to different hosts.

These Ansible roles are compatible with AWX (https://github.com/ansible/awx).

- **burrow**<br/>
  Deploys and configures the Burrow component (https://github.com/linkedin/Burrow), which is responsible for monitoring consumer lag for one or more Confluent clusters.
- **common**<br/>
  This is the base role that all other roles inherit from, which ensures that the standard configuration is applied to all hosts. It is also responsible for initializing the application storage attached to a host. 
- **confluent_common**<br/>
  The base role responsible for downloading and installing the Confluent package. This role is inherited by all other Confluent roles.
- **confluent_kafka_mirrormaker**<br/>
  Deploys and configures the Confluent Kafka MirrorMaker component.
- **confluent_kafka_server**<br/>
  Deploys and configures the Confluent Kafka Server component.
- **confluent_schema_registry**<br/>
  Deploys and configures the Confluent Schema Registry component.
- **confluent_zookeeper**<br/>
  Deploys and configures the Confluent ZooKeeper component.
- **grafana**<br/>
  Deploys and configures the Grafana component (https://grafana.com), which provides advanced analytics and interactive visualization capabilities.
- **monitored**<br/>
  Deploys and configures the Prometheus Node Exporter component (https://github.com/prometheus/node_exporter), which is responsible for exposing host-level metrics including CPU usage, RAM usage, disk usage, etc.
- **prometheus_server**<br/>
  Deploys and configures the Prometheus Server component (https://prometheus.io), which records real-time metrics in a time series database.

### Ansible Variables
The behavior of the Ansible roles is controlled through hierarchical configuration data, which should be specified in an Ansible inventory file.
Default values for the configuration options, excluding the cluster configuration which must always be specified, are included in the *ROLE_NAME_/defaults/main.yaml* files.

An example of the configuration data is shown below.

```
credentials_root: /var/lib/awx/credentials
packages_root: /var/lib/awx/packages
# pki_root: /var/lib/awx/pki

burrow:  
  log_directory: /data/burrow/log
  run_directory: /data/burrow/data
  clusters:
    local:
      hosts:
      - monitoring.local
      zookeeper_cluster_type: confluent
      zookeeper_cluster_name: local

confluent:
  data_directory: /data/confluent
  kafka_mirrormaker:
    log_directory: /data/confluent/kafka-mirrormaker/log
  kafka_server:
    log_directory: /data/confluent/kafka-server/log
    data_directory: /data/confluent/kafka-server/data
  schema_registry:
    log_directory: /data/confluent/schema-registry/log
  zookeeper:
    log_directory: /data/confluent/zookeeper/data
    data_directory: /data/confluent/zookeeper/log
    data_log_directory: /data/confluent/zookeeper/data-log
  clusters:
    local:
      kafka_server_hosts:
      - confluent-ks-local-01.local
      - confluent-ks-local-02.local
      - confluent-ks-local-03.local                
      schema_registry_hosts:
      - confluent-sr-local-01.local
      - confluent-sr-local-02.local
      - confluent-sr-local-03.local
      zookeeper_hosts:
      - confluent-zk-local-01.local
      - confluent-zk-local-02.local
      - confluent-zk-local-03.local

grafana:
  data_directory: /data/grafana/data
  log_directory: /data/grafana/log

prometheus_server:
  data_directory: /data/prometheus
```

**NOTE:** The *credentials_root*, *packages_root*, and *pki_root* configuration options allow credentials, cached packages and private keys/certificates to be stored outside of the job isolation imposed by AWX.

### Deployment Steps
#### Ansible
Complete the following steps to deploy the Confluent Platform along with the associated monitoring capabilities using Ansible:

1. Provision the required hosts and confirm which Ansible role(s) will be applied to each host.

2. Assign an additional data disk, e.g. a VMDK on VMware, to the appropriate hosts. These disks will be automatically formatted and mounted under the */data* directory by the Ansible **common** role.

3. Ensure that Ansible is able to connect to the hosts with privilege escalation.

4. Obtain the private keys and certificates for the hosts and place them under the PKI directory hierarchy that forms part of the *platforms-ansible* project, or under a similar directory hierarchy that will be referenced through the **pki_root** configuration value.
   ```
   ../pki/confluent_zookeeper
   ../pki/confluent_zookeeper/CONFLUENT_CLUSTER_NAME
   ../pki/confluent_kafka_mirrormaker
   ../pki/confluent_kafka_mirrormaker/CONFLUENT_CLUSTER_NAME
   ../pki/burrow
   ../pki/burrow/BURROW_CLUSTER_NAME
   ../pki/confluent_kafka_server
   ../pki/confluent_kafka_server/CONFLUENT_CLUSTER_NAME
   ../pki/confluent_schema_registry
   ../pki/confluent_schema_registry/CONFLUENT_CLUSTER_NAME
   
   
   E.g.
   
   ../pki/confluent_zookeeper
   ../pki/confluent_zookeeper/local
   ../pki/confluent_kafka_mirrormaker
   ../pki/confluent_kafka_mirrormaker/local
   ../pki/burrow
   ../pki/burrow/dev
   ../pki/confluent_kafka_server
   ../pki/confluent_kafka_server/local
   ../pki/confluent_schema_registry
   ../pki/confluent_schema_registry/local   
   ```
5. Create an Ansible inventory file that contains the following:
   - The required configuration data.
   - The host details.
   - The host to group mappings.
   
6. Execute the **platforms.yaml** playbook using the inventory file.

#### AWX

1. Provision the required hosts and confirm which Ansible role(s) will be applied to each host.

2. Assign an additional data disk, e.g. a VMDK on VMware, to the appropriate hosts. These disks will be automatically formatted and mounted under the */data* directory by the Ansible **common** role.

3. Ensure that AWX is able to connect to the hosts with privilege escalation.

4. Obtain the private keys and certificates for the hosts and place them under the PKI directory hierarchy that forms part of the *platforms-ansible* project, or under a similar directory hierarchy that will be referenced through the **pki_root** configuration value.
   ```
   ../pki/confluent_zookeeper
   ../pki/confluent_zookeeper/CONFLUENT_CLUSTER_NAME
   ../pki/confluent_kafka_mirrormaker
   ../pki/confluent_kafka_mirrormaker/CONFLUENT_CLUSTER_NAME
   ../pki/burrow
   ../pki/burrow/BURROW_CLUSTER_NAME
   ../pki/confluent_kafka_server
   ../pki/confluent_kafka_server/CONFLUENT_CLUSTER_NAME
   ../pki/confluent_schema_registry
   ../pki/confluent_schema_registry/CONFLUENT_CLUSTER_NAME
   
   
   E.g.
   
   ../pki/confluent_zookeeper
   ../pki/confluent_zookeeper/local
   ../pki/confluent_kafka_mirrormaker
   ../pki/confluent_kafka_mirrormaker/local
   ../pki/burrow
   ../pki/burrow/dev
   ../pki/confluent_kafka_server
   ../pki/confluent_kafka_server/local
   ../pki/confluent_schema_registry
   ../pki/confluent_schema_registry/local   
   ```
   
5. Create the AWX credential, e.g. Platforms - LOCAL, Platforms - Digital - DEV, etc.

6. Create the AWX project that references the **platforms-ansible** Git project, e.g. Platforms - LOCAL, Platforms - Digital - DEV, etc.

7. Create the AWX inventory with the required configuration data, groups, hosts, and host to group mappings.

   The following groups need to be created that map to the Ansible roles that form part of the *platforms-ansible* project:
   - burrow
   - confluent_kafka_mirrormaker
   - confluent_kafka_server
   - confluent_schema_registry
   - confluent_zookeeper
   - grafana
   - monitored
   - prometheus_server

8. Create the AWX template as a **Run** job type that references the AWX inventory, AWX project, playbook and AWX credentials.

9. Start the AWX job.

**NOTE:** OpenSSL can be used to confirm that a private key and certificate match by executing commands similar to the following:
```
openssl x509 -modulus -noout -in /var/tmp/ansible/confluent/HOSTNAME.crt | openssl md5
openssl rsa -modulus -noout -in  /var/tmp/ansible/confluent/HOSTNAME.key | openssl md5
 
```


## Security Model
The following Confluent security model is implemented as part of this project:

- Mutual-TLS with hostname verification and SASL authentication (username and password) is enabled for all connections to ZooKeeper. Firewall rules ensure that only the Kafka server nodes are able to connect to ZooKeeper.
- Mutual-TLS and SASL authentication (username and password) is enabled for all connections to Kafka. This includes client connections and inter-broker connections.
- Mutual-TLS is enabled for connections to the schema registry.
- Kafka ACLs control which principals can perform which operations on Kafka resources. Kafka ACLs are defined in the general format of “Principal P is [ Allowed / Denied ] Operation O from Host H on Resource R”.
- The default Kafka authorizer implementation (AclAuthorizer) is enabled, which stores Kafka ACL information in ZooKeeper.
- When a client connects to Kafka, the principal name is the username provided by the client during SASL authentication.
- ACLs are used to control which producers can write to topics and which consumers can read from topics.


## User Management
All user management commands must be executed as the **root** user or by a user who is a member of the **cp-kafka** group.

### Create a user
All Confluent users, for producers and consumers, are created in ZooKeeper by executing a command similar to the one below on a Kafka Server node; replacing the username and password placeholders (REPLACE_WITH_USERNAME and REPLACE_WITH_PASSWORD) as appropriate:

```
KAFKA_OPTS="-Djava.security.auth.login.config=/etc/kafka/conf/server-jaas.conf" /opt/confluent/bin/kafka-configs \
  --zk-tls-config-file /etc/kafka/conf/server.properties --zookeeper `hostname`:2182  \
  --alter --entity-type users \
  --entity-name 'REPLACE_WITH_USERNAME' \
  --add-config 'SCRAM-SHA-256=[iterations=8192,password=REPLACE_WITH_PASSWORD],SCRAM-SHA-512=[password=REPLACE_WITH_PASSWORD]'
```

### Grant a user access to a consumer group.
Execute a command similar to the one below on a Kafka server node to grant a user access to a consumer group:

```
kafka-acls --add --allow-principal User:REPLACE_WITH_USERNAME --operation read --group REPLACE_WITH_CONSUMER_GROUP_NAME

E.g

kafka-acls --add --allow-principal User:demo-consumer --operation read --group demo-consumer

```


## Topic management
All topic management commands must be executed as the **root** user or by a user who is a member of the **cp-kafka** group.

### Create a topic
Execute a command similar to the one below on a Kafka Server node to create a new topic:

```
kafka-topics --create --replication-factor 1 --partitions 1 --topic test 
```


### Delete a topic
Execute a command similar to the one below on a Kafka Server node to delete an existing topic:

```
kafka-topics --delete --topic test
```

### List ACLs for a topic
Execute a command similar to the one below on a Kafka server node to list the existing ACLs for a topic:

```
kafka-acls --list --topic test
```

### Grant a user access to a topic
Execute a command similar to the one below on a Kafka server node to grant a user access to a topic:

```
kafka-acls --add --allow-principal User:REPLACE_WITH_USERNAME --operation REPLACE_WITH_OPERATION_TYPE --topic REPLACE_WITH_TOPIC_NAME

E.g.

kafka-acls --add --allow-principal User:demo-producer --operation write --topic test

or 

kafka-acls --add --allow-principal User:demo-consumer --operation read --topic test

```







