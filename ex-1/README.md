# k8s FTW

References:
- For creating the [statefulset Kubernetes Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)


In order to check the created resources:

```shell script
$ k get pods
NAME    READY   STATUS    RESTARTS   AGE
web-0   1/1     Running   0          21s

$ k get pvc
NAME        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
www-web-0   Bound    pvc-d2e42776-e318-4672-a3e4-f40a24f9f575   1Gi        RWO            standard       44m

```