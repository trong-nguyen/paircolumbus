# PairColumbus Personal Repo
Challenges from PairColumbus

Each folder present focus section (SQL, DataAnalytics, Testing, Algorithm, Ruby, Python)

### Workflow for SQL:
- Database of choice: PostgreSQL ([tutorials](https://launchschool.com/books/sql/read/alter_table#renametables)) and/or SQLite. SQLite has minimal support for RE hence PostgreSQL is recommended.
- Pandas for importing, pre-processing -> using [SQLAlchemy](http://pythoncentral.io/sqlalchemy-faqs/) to [update/create] [tables]. The rationale is to save tedious URL parsing (.csv files not [well-supported](https://www.calazan.com/how-to-import-data-from-a-csv-file-to-a-postgresql-database/) in PostgreSQL, you have to manually CREATE TABLE / DROP TABLE IF EXISTS and feed columns and column data type into psql) and to automate works.
- CLI: `=#psql` for monitoring databases and `ipython` for running scripts.

- Editor of choice for SQL queries: [Sublime Text](http://sublimetext.com) with [SQLTools](https://packagecontrol.io/packages/SQLTools) plugin. On MacOS, you should install the sublime package [FixMacPath](https://github.com/int3h/SublimeFixMacPath) to address the [path issue](https://github.com/mtxr/SQLTools/issues/51) when connecting to [PostgreSQL] databases
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
fy16_school() # built-in
marvel() # built-in
```
Tables `filmdeathcounts`, `jeopardy`, `talkpay`, `marvel-wikia-data`, `fy16_school.*` and others should now be ready for queries


### Learning

| Tool | What |
| ---- | ----------------- |
| SQL | Different flavors (MySQL, PostgreSQL, SQLite, SQL Server) have very different supports and syntaxes for eg. regex, comparison, data types, etc. which make ORM tools like [SQLAlchemy](http://www.sqlalchemy.org) the more compelling. |
| SQL | Relative popularity according to [Google Trends](https://www.google.com/trends/explore?geo=US&q=%2Fm%2F05ynw,%2Fm%2F0120vr,%2Fm%2F04y3k,%2Fm%2F01kgq9) |
| SQL Server | 70 |
| MySQL | 50 |
| PostgreSQL | 20 |
| SQLite | 8 |
| PostgreSQL | Open Source, ANSI-standard, stability, scalibility. |
| PostgreSQL | Newline / Linebreak: `chr(10)` |
| PostgreSQL | Column names should be taken seriously. "Spaces, non-word characters like $ % etc." all make selections very cubersome. I wrote a `rename_to_conform_postgre` routine to standardize column names (remove all non-word characters and lower case) when using PostgreSQL |
| PostgreSQL | Regular expression: `regexp_matches()` for `SELECT` or `~` for `WHERE` |
| PostgreSQL | Remove curly braces (result from regexp_matches, for ex.): `unnest(text)` |
| PostgreSQL | `regexp_matches(text, pattern, 'g')` with `g` flag might return multiple rows, don't put another `regexp_matches` in the same `SELECT`, use `JOIN` instead |
| PostgreSQL | Single `''` and double `""` quotes mean differently: ie. `'string_values'` whislt `"table/column_names"`, [more on this](https://wiki.postgresql.org/wiki/Things_to_find_out_about_when_moving_from_MySQL_to_PostgreSQL) |

### Extra Credits

`#trump` Trump is not a person's name. It is the name of an Empire with hundreds of states (companies).

`#paytalk` It pays really well in the Tech industry, quite encouraging.

`#marvel` The number of Marvel characters is simply marvelous. More than 16 thousands (What!).