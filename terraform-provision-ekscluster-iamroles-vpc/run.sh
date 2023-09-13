aws eks --region us-east-1 update-kubeconfig --name demo

# result 
# Added new context arn:aws:eks:us-east-1:604020082473:cluster/demo to C:\Users\joelwembo\.kube\config
kubectl get svc

kubectl apply -f k8s/aws-test.yaml

kubectl exec aws-cli -- aws s3api list-buckets
kubectl get pods

kubectl apply -f k8s/deployment.yaml 

kubectl apply -f k8s/public-lb.yaml
kubectl apply -f k8s/private-lb.yaml 

kubectl get pods
kubectl get services


kubectl apply -f k8s/cluster-autoscaler.yaml
# serviceaccount/cluster-autoscaler created
# clusterrole.rbac.authorization.k8s.io/cluster-autoscaler created
# role.rbac.authorization.k8s.io/cluster-autoscaler created
# clusterrolebinding.rbac.authorization.k8s.io/cluster-autoscaler created
# rolebinding.rbac.authorization.k8s.io/cluster-autoscaler created
# deployment.apps/cluster-autoscaler created
# You can verify that the autoscaler pod is up and running with the following command.
kubectl get pods -n kube-system
