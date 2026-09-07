# SAP ABAP Practice

A collection of small, self-contained ABAP examples I've written while studying SAP development. These are learning exercises rather than production code, written to demonstrate specific concepts clearly.

## 📂 Contents

| File | Concept | What it shows |
|---|---|---|
| `01_sales_report.abap` | Classic ABAP report | Internal tables, `SELECT`, `LOOP AT`, selection screen parameters |
| `02_cost_center_cds_view.abap` | CDS view | Joins, aggregation (`SUM`), annotations for controlling/FI-CO data |
| `03_rap_travel_behavior.abap` | RAP (RESTful ABAP Programming) | Managed behavior definition, validations, determinations |

## 🎯 Why these three

I picked examples that span the range I'm building toward as a future SAP FI/CO consultant with ABAP skills:

- **Report** — the traditional entry point into ABAP, still widely used for custom reporting
- **CDS View** — the modern way to expose and aggregate data, especially relevant for FI/CO reporting scenarios
- **RAP** — SAP's current framework for building business objects and Fiori apps on S/4HANA

## 📌 Note

These snippets are written to compile conceptually against standard SAP tables (`VBAK`, `CSKS`, `COSP`) and a simplified custom `ZTRAVEL` table, following SAP's own teaching examples. They're meant to demonstrate syntax and structure, not to be run as-is without an SAP system and the corresponding data dictionary objects.
