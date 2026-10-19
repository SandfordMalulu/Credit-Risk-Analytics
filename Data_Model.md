# Data Model Overview

Observed report tables include `FactLoans`, `FactDelinquencySnapshot`, `FactPaymentSchedule`, `FactPayments`, `DimCustomer`, `DimDate`, `DimBranch`, `DimDPDBucket`, and `DimRecoveryPriority`.

## Validation guidance
- Verify one unique row per loan in `FactLoans`, and document the grain of the delinquency snapshot.
- Validate one-to-many relationships, filter directions, and inactive date relationships.
- Use payment dates for cash receipts and due dates for scheduled repayments when reporting monthly trends; ensure intended date filters are explicitly applied.
- Avoid ambiguous bidirectional filtering unless tested and documented.
- Confirm recovery priority and DPD bucket sorting are based on explicit business order.
- Check whether loan product slicers propagate consistently through related fact tables.

This is a model summary from report screenshots, not an exported schema or exhaustive relationship audit.
