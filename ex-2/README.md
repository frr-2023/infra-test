# Helm Chart

`helm create` was used for creating the basic structure, and then delete unnecessary files
````shell script
$ helm create ex-2
Creating ex-2
$ rm -rf ex-2/templates
$ touch ex-2/templates/_helpers.tpl
````

We create the _helpers.tpl file in order to define out function `bussinessLabels` that we are using 
in our statefulset. 
```
{{/*
Mandatory labels
*/}}
{{- define "businessLabels" -}}
app: {{ .Chart.Name }}
env: {{ default "local" .Values.statefulset.env }}
{{- end }}
```


For checking the render of the template we execute (assuming that we are in the directory of the chart)
```shell script
$ helm template . -f values.yaml          
---
# Source: infra-test/templates/statefulset.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
  labels:
    app: infra-test
    env: LIVE
spec:
  selector:
    matchLabels:
      app: infra-test
      env: LIVE
  serviceName: "nginx"
  replicas: 1
  minReadySeconds: 10
  template:
    metadata:
      labels:
        app: infra-test
        env: LIVE
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: infra-test
        image: "dockerhub.com/webada:0.0.1"
        resources:
          limits:
            cpu: 1
            memory: 128Mi
          requests:
            cpu: 500m
            memory: 64Mi
  volumeClaimTemplates:
    tolerations:
      - metadata:
          name: www
        spec:
          accessModes:
          - ReadWriteOnce
          resources:
            requests:
              storage: 1Gi
          storageClassName: standard

```