FROM maven:3.5.4-jdk-8

# Install node
RUN apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs \
  && curl -L https://www.npmjs.com/install.sh | sh

# Install auditjs (OSS Index for npm)
RUN npm install auditjs -g

# Install snyk
RUN npm install -g snyk
ARG snyk_auth
RUN snyk auth ${snyk_auth}

# Install patch as snyk needs it to apply patches for vulnerabilities
RUN apt-get update && apt-get install -y patch

# install license finder
RUN apt-get update && apt-get install -y ruby && gem install license_finder

# install OWASP Dependency Check
RUN curl -L http://dl.bintray.com/jeremy-long/owasp/dependency-check-3.3.2-release.zip -o dc.zip && unzip -x dc.zip

# download CVEs etc
RUN dependency-check/bin/dependency-check.sh --project tmp -s /tmp && rm dependency-check-report.html

ADD scan_maven.sh /
ADD scan_node.sh /

ENTRYPOINT [ "/bin/bash" ]

