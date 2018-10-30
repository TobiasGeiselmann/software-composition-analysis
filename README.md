# SCA Docker image
This is a Docker image that combines multiple open source tools that can be used for software composition analysis. It consists of the following tools:
* dependency-check
* license_finder
* npm audit
* auditjs
* OSSIndex Maven Plugin
* Snyk

# Build Docker image
```
docker build -t sca .
```

# Run Docker image
To run the image, we need to mount a project directory into it, that we want to scan. Furthermore, you need to authenticate snyk with an API key. 
You can get the API key by registering on snyk.io. Create a file called snyk.json inside a directory snyk_config with the following content:
```
{
	"api": "<your_api_token>"
}
```
We will mount this file into our Docker container, so you can use snyk without ever having to run `snyk auth`.
Run the container with the following command:
```
docker run -it -v <path_to_project>:/scan -v <path_to_snyk_config>:/root/.config/configstore sca
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

