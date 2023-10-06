```shell script
 export GITHUB_TOKEN=""
flux bootstrap github \
  --token-auth \
  --owner=fr-2023 \
  --repository=infra-test-cluster \
  --branch=main \
  --path=clusters/Artemis \
  --personal
```
