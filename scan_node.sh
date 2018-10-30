# Run dependency-check
echo "Running dependency-check..."
dependency-check/bin/dependency-check.sh --project myproject --out /scan/report/ --scan scan/
echo "Finished running dependency-check. Report can be found under /scan/report."

# Run license_finder
echo "Running license_finder..."
license_finder report --save=/scan/report/license_report --project-path=/scan
echo "Finished running license_finder."

# Run snyk
echo "Running snyk..."
(cd scan && snyk test >> /scan/report/snyk 2>&1)
echo "Finished running snyk."

# Run npm audit
echo "Running npm audit..."
(cd scan && npm audit >> /scan/report/npm_audit 2>&1)
echo "Finished running npm audit."

# Run auditjs
echo "Running auditjs..."
(cd scan && auditjs >> /scan/report/auditjs 2>&1)
echo "Finished running auditjs."
