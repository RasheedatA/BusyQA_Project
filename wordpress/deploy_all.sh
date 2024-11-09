#!/bin/bash
kubectl apply -f namespace.yaml
kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql.cm.yaml
kubectl apply -f mysql-svc.yaml
kubectl apply -f pvc-mysql.yaml
kubectl apply -f storageclass.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f wordpress-pvc.yaml
kubectl apply -f wordpress-svc.yaml
kubectl apply -f wordpress-deployment.yaml
kubectl apply -f wordpress-hpa.yaml
