# PairColumbus Personal Repo
Challenges from PairColumbus

Each folder present focus section (SQL, DataAnalytics, Testing, Algorithm, Ruby, Python)

### Workflow for SQL:
- Database of choice: PostgreSQL ([tutorials](https://launchschool.com/books/sql/read/alter_table#renametables)) and/or SQLite. SQLite has minimal support for RE hence PostgreSQL is recommended.
- Pandas for importing, pre-processing -> using [Alchemy](http://pythoncentral.io/sqlalchemy-faqs/) to [update/create] [tables]. The rationale is to save tedious URL parsing (.csv files not [well-supported](https://www.calazan.com/how-to-import-data-from-a-csv-file-to-a-postgresql-database/) in PostgreSQL, you have to manually CREATE TABLE / DROP TABLE IF EXISTS and feed columns and column data type into psql) and to automate works.
- [SQLTools] (https://packagecontrol.io/packages/SQLTools) plugin for sublime, on MacOS install the sublime package [FixMacPath](https://github.com/int3h/SublimeFixMacPath) to address the [path issue](https://github.com/mtxr/SQLTools/issues/51) when connecting to [PostgreSQL] databases
```shell
createdb [dbname] #PostgreSQL cli to create database
cd [sql directory]
```

Open python (Ipython, Jupyter) to run helper scripts

```python
from utils import *
create_table_from_csv('filmdeathcounts')
jeopardy() # built-in loadder for jeopardy dataset
talkpay() # built-in
```
Tables `filmdeathcounts`, `jeopardy`, and others should now be ready for queries


### Learning

| Tool | What |
| ---- | ----------------- |
| PostgreSQL | Newline / Linebreak: `chr(10)` |
| PostgreSQL | Regular expression: `regexp_matches()` for `SELECT` or `~` for `WHERE` |
| PostgreSQL | Remove curly braces (result from regexp_matches, for ex.): `unnest(text)` |
| PostgreSQL | `regexp_matches(text, pattern, 'g')` with `g` flag might return multiple rows, don't put another `regexp_matches` in the same `SELECT`, use `JOIN` instead |