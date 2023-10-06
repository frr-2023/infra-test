# Deploy a HelmRealease levaring Flux

After bootstraping a cluster, I add the required manifests for creating the HelmRealease. You can find it [here](https://github.com/frr-2023/infra-test-cluster/blob/main/clusters/Artemis/harbor/resources.yaml)

HelmRepository.
```yaml
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: harbor
  namespace: cowbell
spec:
  interval: 1m0s
  url: https://helm.goharbor.io
```

HelmRelease, we also defined the replicas of the portal to 5 to check the syncronization.
```yaml

apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: scoobydoo
  namespace: cowbell
spec:
  chart:
    spec:
      chart: harbor
      sourceRef:
        kind: HelmRepository
        name: harbor
      version: 1.13.0
  interval: 1m0s
  values:
    portal:
      replicas: 5

```

Then We checked that everything was working
```shell script
$ kga -n cowbell
NAME                                               READY   STATUS    RESTARTS        AGE
pod/scoobydoo-harbor-core-b7cdbb7c6-p8vm4          1/1     Running   0               2m43s
pod/scoobydoo-harbor-database-0                    1/1     Running   0               2m43s
pod/scoobydoo-harbor-jobservice-6d646bd49d-c7x85   1/1     Running   2 (2m36s ago)   2m43s
pod/scoobydoo-harbor-portal-7b8c7f6577-5vk6d       1/1     Running   0               2m43s
pod/scoobydoo-harbor-portal-7b8c7f6577-9l5gn       1/1     Running   0               2m43s
pod/scoobydoo-harbor-portal-7b8c7f6577-9xx5w       1/1     Running   0               2m43s
pod/scoobydoo-harbor-portal-7b8c7f6577-nh69r       1/1     Running   0               2m43s
pod/scoobydoo-harbor-portal-7b8c7f6577-zlcgl       1/1     Running   0               2m43s
pod/scoobydoo-harbor-redis-0                       1/1     Running   0               2m43s
pod/scoobydoo-harbor-registry-849c85c59c-krzq8     2/2     Running   0               2m43s
pod/scoobydoo-harbor-trivy-0                       1/1     Running   0               2m43s

NAME                                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/scoobydoo-harbor-core         ClusterIP   10.107.156.208   <none>        80/TCP              2m44s
service/scoobydoo-harbor-database     ClusterIP   10.111.140.78    <none>        5432/TCP            2m44s
service/scoobydoo-harbor-jobservice   ClusterIP   10.97.222.195    <none>        80/TCP              2m44s
service/scoobydoo-harbor-portal       ClusterIP   10.96.253.227    <none>        80/TCP              2m44s
service/scoobydoo-harbor-redis        ClusterIP   10.101.168.251   <none>        6379/TCP            2m44s
service/scoobydoo-harbor-registry     ClusterIP   10.102.90.81     <none>        5000/TCP,8080/TCP   2m44s
service/scoobydoo-harbor-trivy        ClusterIP   10.108.7.178     <none>        8080/TCP            2m44s

NAME                                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/scoobydoo-harbor-core         1/1     1            1           2m43s
deployment.apps/scoobydoo-harbor-jobservice   1/1     1            1           2m43s
deployment.apps/scoobydoo-harbor-portal       5/5     5            5           2m43s
deployment.apps/scoobydoo-harbor-registry     1/1     1            1           2m43s

NAME                                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/scoobydoo-harbor-core-b7cdbb7c6          1         1         1       2m43s
replicaset.apps/scoobydoo-harbor-jobservice-6d646bd49d   1         1         1       2m43s
replicaset.apps/scoobydoo-harbor-portal-7b8c7f6577       5         5         5       2m43s
replicaset.apps/scoobydoo-harbor-registry-849c85c59c     1         1         1       2m43s

NAME                                         READY   AGE
statefulset.apps/scoobydoo-harbor-database   1/1     2m43s
statefulset.apps/scoobydoo-harbor-redis      1/1     2m43s
statefulset.apps/scoobydoo-harbor-trivy      1/1     2m43s

```