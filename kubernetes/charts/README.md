## Installation
Since the chart installs its' subcharts, which in turn depend on the Common chart, a recursive dependency update strategy was required. A simple `helm dep up` command wouldn't do the job here. Hence, run the following script:
```
./segmentme-helm-dependencies-build.sh segmentme-chart
```

Next, simply install chart:
```
helm install segmentme-chart ./segmentme-chart
```

Next, simply install with debug chart:
```
helm install segmentme-chart --dry-run --debug ./segmentme-chart
```

Install single:
```
helm install management-service --dry-run --debug ./management-service
```