# SCA Docker image
This is a Docker image that combines multiple open source tools that can be used for software composition analysis. It consists of the following tools:
* dependency-check
* license_finder
* npm audit
* auditjs
* OSSIndex Maven Plugin
* Snyk

# Build Docker image
In order to use Snyk, you need to authenticate with the server during the build. Set an environment variable with you Snyk API token, so we can use it during the build:
```
read api_token
```
Input the API token that you can find on the settings page on skyk.io. Now build the image.
```
docker build -t sca --build-arg snyk_auth=$api_token .
```

# Run Docker image
To run the image, we need to mount a project directory into it, that we want to scan.
```
docker run -it -v <path_to_project>:/scan sca
```

# Tools for node.js and maven projects 

## Run dependency-check
```
dependency-check/bin/dependency-check.sh --project myproject --out /scan/report/ --scan scan/
```

## Run license_finder
The license_finder is based on package managers and therefore needs the sources of the project. You can run it like this:
```
license_finder report --save=/scan/report/license_report --project-path=/scan
```

# For node.js projects

## Run npm audit
In order to run npm audit, you need to switch into your project folder.
```
cd scan
npm audit
```

## Run auditjs (OSSIndex for node.js)
```
cd scan
auditjs
```

## Run snyk
```
cd scan
snyk test
```

# For maven projects

## Run OSS Index 
```
mvn org.sonatype.ossindex.maven:ossindex-maven-plugin:audit -Dossindex.reportFile=/report/ossindex_report.txt -f scan/pom.xml
```

