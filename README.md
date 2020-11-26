# Monitoring

New Relic scripts for custom metrics & alerts

flex-warsmonitor:
Monitors JBoss files in C:/JBossEAP6.4/standalone/deployments/EWMS and forwards the file information to New Relic. Use the below query on the new metric to find .failed files. From here, alerts can be created on New relic.

SELECT count(*) FROM  IsWarsDeplyedSample where Name Like '%failed' OR  Name NOT LIKE '%deployed' and Name NOT LIKE '%war' and Name NOT LIKE '%txt'  and Name NOT LIKE '%ear' and hostname = '_____'

services-lookup:
Monitor certain Windows services status and forward the infomation to New Relic.
