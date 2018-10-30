#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "No project path supplied, using default path /scan"
    path="/scan"
  else
    path=$1
fi

# Create report directory if it doesn't already exist
if [ ! -d "$path/report" ]; then
    mkdir $path/report
fi

# Run dependency-check
echo "Running dependency-check..."
/dependency-check/bin/dependency-check.sh --project myproject --out $1/report/ --scan $1
echo "Finished running dependency-check. Report can be found under /scan/report."

# Run license_finder
echo "Running license_finder..."
license_finder report --save=$1/report/license_report --project-path=$1
echo "Finished running license_finder."

# Run snyk
echo "Running snyk..."
(cd $1 && snyk test >> report/snyk 2>&1)
echo "Finished running snyk."

# Run npm audit
echo "Running npm audit..."
(cd $1 && npm audit >> report/npm_audit 2>&1)
echo "Finished running npm audit."

# Run auditjs
echo "Running auditjs..."
(cd $1 && auditjs >> report/auditjs 2>&1)
echo "Finished running auditjs."
