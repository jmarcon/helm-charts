# helm-charts

It will hold all my helm charts examples

## Test the template

```bash
helm template charts/microservice --values .examples/microservice.yaml --debug --dry-run
```

or

```bash
helm template charts/microservice \
    --set name="example" \
    --set version="0.0.1-beta" \
    --set image.repository="jmarcon/example" \
    --set image.tag="0.0.1" \
    --set git.commit="$(git rev-parse HEAD)" \
    --set git.branch="$(git rev-parse --abbrev-ref HEAD)" \
    --set git.url="$(git config --get remote.origin.url)" \
    --dry-run
```

