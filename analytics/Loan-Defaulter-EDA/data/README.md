# Data

The raw files are not stored in this repo. They come from the Kaggle dataset
**Loan Defaulter** by Gaurav Dutta:
https://www.kaggle.com/datasets/gauravduttakiit/loan-defaulter

## Files used

| File | Description |
|------|-------------|
| `application_data.csv` | One row per loan application: 307,511 records, 122 features, `TARGET` column (1 = defaulted, 0 = repaid) |
| `previous_application.csv` | Each applicant's earlier applications with the bank |

## How to get them

1. Download the dataset from the Kaggle link above (manual download, or via `opendatasets` as the notebook does).
2. Unzip it into `data/loan-defaulter/` so you end up with:

```
data/loan-defaulter/application_data.csv
data/loan-defaulter/previous_application.csv
```

The notebook reads from `./loan-defaulter/...`, so either run it from a folder
containing `loan-defaulter/`, or change the two `pd.read_csv` paths to
`../data/loan-defaulter/...`.
