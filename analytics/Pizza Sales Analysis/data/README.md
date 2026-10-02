# Data

Source: Kaggle, "Pizza Sales Case Study" — https://www.kaggle.com/datasets/miniyadav/pizza-sales-case-study

The four CSVs are included here (about 1.9 MB in total). Coverage: 1 Jan 2015 to 31 Dec 2015.

| File | Rows | Columns |
|---|---|---|
| `orders.csv` | 21,350 | order_id, date, time |
| `order_details.csv` | 48,620 | order_details_id, order_id, pizza_id, quantity |
| `pizza_types.csv` | 32 | pizza_type_id, name, category, ingredients |
| `pizzas.csv` | 96 | pizza_id, pizza_type_id, size, price |

## Loading into MySQL

Create a schema, then import each CSV with the Table Data Import Wizard in MySQL Workbench.
The queries assume `date` and `time` in `orders` were renamed to `order_date` and `order_time`.

Relationships:
- `order_details.order_id` → `orders.order_id`
- `order_details.pizza_id` → `pizzas.pizza_id`
- `pizzas.pizza_type_id` → `pizza_types.pizza_type_id`

If a tool complains about encoding on `pizza_types.csv`, read it as latin-1.
