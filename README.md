# digitalocean-kubernetes-terraform
A basic Terraform script, for deploying my personal k8s cluster under DO.
Running instructions:
```
terraform plan -var do_token="${do_token}"
```
When you do a:
´export do_token=123123123213123 ´

Finally, when the cluster is created, you should do a:

´´´
doctl kubernetes cluster kubeconfig save $(terraform output --raw cluster-id) 
´´´


