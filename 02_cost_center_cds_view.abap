// ---------------------------------------------------------------------
// CDS View: ZI_CostCenterBalance
// ---------------------------------------------------------------------
// Purpose:
//   Exposes cost center actual balances by combining the cost center
//   master data (CSKS) with the cost totals table (COSP), aggregated
//   by controlling area, cost center, and fiscal year.
//
// Demonstrates:
//   - Basic CDS view definition
//   - JOIN between master data and transactional data
//   - Aggregation with SUM
//   - Association-style annotations for Fiori consumption
// ---------------------------------------------------------------------
@AbapCatalog.sqlViewName: 'ZCOSTCENTERBAL'
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Cost Center Actual Balance'
define view ZI_CostCenterBalance as select from cosp as cost_totals

  inner join csks as cost_center
    on cost_totals.kostl = cost_center.kostl
   and cost_totals.kokrs = cost_center.kokrs

{
      key cost_totals.kokrs      as ControllingArea,
      key cost_totals.kostl      as CostCenter,
      key cost_totals.gjahr      as FiscalYear,
          cost_center.ktext      as CostCenterName,
          sum( cost_totals.wtg001 +
               cost_totals.wtg002 +
               cost_totals.wtg003 +
               cost_totals.wtg004 ) as ActualBalanceQ1

}
group by
  cost_totals.kokrs,
  cost_totals.kostl,
  cost_totals.gjahr,
  cost_center.ktext
