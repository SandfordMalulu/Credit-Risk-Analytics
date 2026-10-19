# KPI Definitions and Checks

| KPI | Intended definition | Important note |
|---|---|---|
| Total Snapshot Loans | Distinct loan IDs in delinquency snapshot | Check snapshot date and duplicates |
| Loans 30+ DPD | Distinct loans with days past due >= 30 | Define treatment of exactly 30 days |
| 30+ DPD Loan Rate | Loans 30+ DPD / Total Snapshot Loans | 544 / 1427 = 38.12%, not 38.28% |
| Loans 90+ DPD | Distinct loans with days past due >= 90 | Confirm whether 90 is inclusive |
| Critical Priority Loans | Loans meeting documented critical recovery rule | Current display: 525 |
| Critical Recovery Exposure | Overdue exposure on critical-priority loans | Current display: ZMW 580.28K |
| Total Overdue Exposure | Sum of overdue amounts for relevant snapshot | Current display: ZMW 629.91K |
| Collection Efficiency | Collected / Scheduled payments | ZMW 21,508,237.35 / 22,102,220.15 = 97.31% |
| Default Rate | Loans flagged default / eligible loans | Simulated indicator, not an observed market default rate |

## Required validation
Confirm identical reporting dates and filter contexts, payment-date versus schedule-date logic, totals versus distinct counts, and that all buckets sum to the snapshot population.
