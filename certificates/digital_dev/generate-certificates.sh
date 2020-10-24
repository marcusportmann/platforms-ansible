#!/bin/sh


# Copy the CA certificate
cp ca.crt ../../pki/burrow/dev/
cp ca.crt ../../pki/confluent_kafka_mirrormaker/digital_dev 
cp ca.crt ../../pki/confluent_kafka_server/digital_dev 
cp ca.crt ../../pki/confluent_schema_registry/digital_dev 
cp ca.crt ../../pki/confluent_zookeeper/digital_dev 



mkdir -p ../../pki/confluent_kafka_mirrormaker/digital_dev
touch ../../pki/confluent_kafka_mirrormaker/digital_dev/.gitkeep
mkdir -p ../../pki/confluent_kafka_server/digital_dev
touch ../../pki/confluent_kafka_server/digital_dev/.gitkeep
mkdir -p ../../pki/confluent_schema_registry/digital_dev
touch ../../pki/confluent_schema_registry/digital_dev/.gitkeep
mkdir -p ../../pki/confluent_zookeeper/digital_dev
touch ../../pki/confluent_zookeeper/digital_dev/.gitkeep






# Generate the Confluent hosts private keys and certificates
cfssl genkey zadsdcrapp0599-csr.json | cfssljson -bare zadsdcrapp0599
mv -f zadsdcrapp0599-key.pem zadsdcrapp0599.key


cp zadsdcrapp0599.key ../../pki/burrow/dev/
cp zadsdcrapp0599.key ../../pki/confluent_kafka_mirrormaker/digital_dev 
cp zadsdcrapp0599.key ../../pki/confluent_kafka_server/digital_dev 
cp zadsdcrapp0599.key ../../pki/confluent_schema_registry/digital_dev 
cp zadsdcrapp0599.key ../../pki/confluent_zookeeper/digital_dev 

cp zadsdcrapp0599.crt ../../pki/burrow/dev/
cp zadsdcrapp0599.crt ../../pki/confluent_kafka_mirrormaker/digital_dev 
cp zadsdcrapp0599.crt ../../pki/confluent_kafka_server/digital_dev 
cp zadsdcrapp0599.crt ../../pki/confluent_schema_registry/digital_dev 
cp zadsdcrapp0599.crt ../../pki/confluent_zookeeper/digital_dev 





cfssl genkey zadsdcrapp0600-csr.json | cfssljson -bare zadsdcrapp0600
mv -f zadsdcrapp0600-key.pem zadsdcrapp0600.key


cp zadsdcrapp0600.key ../../pki/burrow/dev/
cp zadsdcrapp0600.key ../../pki/confluent_kafka_mirrormaker/digital_dev 
cp zadsdcrapp0600.key ../../pki/confluent_kafka_server/digital_dev 
cp zadsdcrapp0600.key ../../pki/confluent_schema_registry/digital_dev 
cp zadsdcrapp0600.key ../../pki/confluent_zookeeper/digital_dev 

# cp zadsdcrapp0600.crt ../../pki/burrow/dev/
# cp zadsdcrapp0600.crt ../../pki/confluent_kafka_mirrormaker/digital_dev 
# cp zadsdcrapp0600.crt ../../pki/confluent_kafka_server/digital_dev 
# cp zadsdcrapp0600.crt ../../pki/confluent_schema_registry/digital_dev 
# cp zadsdcrapp0600.crt ../../pki/confluent_zookeeper/digital_dev 


