import os
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://nguyentrong:password@localhost/paircolumbus')
data_dir = 'data'

def drop_table(name):
	with engine.connect() as conn:
		conn.execute('DROP TABLE IF EXISTS {}'.format(name))

def create_table_from_csv(name, conversions):
	df = pd.read_csv(os.path.join(data_dir,'{}.csv'.format(name)))
	for k, convert in conversions.items():
		df[k] = convert(df[k])

	drop_table(name)
	df.to_sql(name, engine)

def jeopardy(name='jeopardy'):
	create_table_from_csv(name, {
		'air_date': pd.to_datetime,
		'value': lambda v: pd.to_numeric(v.replace('[\$,]', '', regex=True)), # convert currency / money to numeric type, might not be neccessary
		})

def talkpay(name='talkpay'):
	create_table_from_csv(name, {
		'created_at': pd.to_datetime,
		})


	
		
