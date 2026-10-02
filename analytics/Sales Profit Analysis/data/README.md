# Data

`db_dump.sql` is a MySQL 8.0 dump of the `sales` database (about 11 MB). It creates the schema and loads all the data.

## Import

```bash
mysql -u <user> -p < db_dump.sql
```

Or use MySQL Workbench: Server → Data Import → Import from Self-Contained File.

## Tables

| Table | Rows | Key columns |
|---|---|---|
| `transactions` | 148,395 | product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency, profit_margin_percentage, profit_margin, cost_price |
| `customers` | 38 | customer_code, custmer_name (sic), customer_type (Brick & Mortar / E-Commerce) |
| `products` | 279 (338 distinct codes appear in transactions) | product_code, product_type (Own Brand / Distribution) |
| `markets` | 17 | markets_code, markets_name, zone |
| `date` | 1,126 | date, cy_date, year, month_name, date_yy_mmm |

Coverage: 4 Oct 2017 to 26 Jun 2020 (2020 is a partial year, roughly H1).

## Known data quirks

- Some text columns carry a trailing carriage return (`\r`) from the original CSV import, for example `currency` is stored as `'INR\r'` and `date_yy_mmm` as `'17-Jun\r'`. That is why the queries use `TRIM(currency)`.
- Only 2 of 148,395 transactions are in USD (both Delhi NCR, Nov 2017). Everything else is INR, so summing `sales_amount` across currencies is harmless here but not safe in general.
- The column `custmer_name` is misspelled in the schema; the queries use it as-is.
- 59 of the 338 product codes that appear in `transactions` are missing from `products` (about ₹469M of revenue), so joins to `products` drop rows unless you use a LEFT JOIN.
- `markets` includes two rows (New York, Paris) with no zone and no transactions in the data.
- Source: tutorial playlist linked in the main README.
