*&---------------------------------------------------------------------*
*& Report Z_SALES_ORDER_OVERVIEW
*&---------------------------------------------------------------------*
*& Simple report demonstrating core ABAP concepts:
*& - Internal table declaration with a TYPE structure
*& - SELECT with WHERE condition
*& - LOOP AT with field processing
*& - Basic list output (WRITE)
*&---------------------------------------------------------------------*
REPORT z_sales_order_overview.

" Selection screen: let the user filter by sales organization
PARAMETERS: p_vkorg TYPE vbak-vkorg OBLIGATORY DEFAULT '1000'.

" Internal table to hold selected sales orders
DATA: gt_orders TYPE TABLE OF vbak,
      gs_order  TYPE vbak,
      gv_total  TYPE vbak-netwr.

START-OF-SELECTION.

  " Select sales orders for the chosen sales organization
  SELECT * FROM vbak
    INTO TABLE gt_orders
    WHERE vkorg = p_vkorg.

  IF sy-subrc <> 0.
    WRITE: / 'No sales orders found for sales organization', p_vkorg.
    RETURN.
  ENDIF.

  WRITE: / 'Sales Order Overview for Org', p_vkorg.
  WRITE: / '--------------------------------------'.

  " Loop through the internal table and display key fields
  LOOP AT gt_orders INTO gs_order.
    WRITE: / gs_order-vbeln,   " Sales document number
             gs_order-erdat,   " Creation date
             gs_order-netwr,   " Net value
             gs_order-waerk.   " Currency

    " Accumulate total order value
    gv_total = gv_total + gs_order-netwr.
  ENDLOOP.

  WRITE: / '--------------------------------------'.
  WRITE: / 'Total value:', gv_total.
