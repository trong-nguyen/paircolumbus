import os
import re
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://nguyentrong:password@localhost/paircolumbus')
data_dir = 'data'

def drop_table(name):
	with engine.connect() as conn:
		conn.execute('DROP TABLE IF EXISTS "{}"'.format(name))

def create_table_from_csv(name, parse_dates=[], treatments=[], conversions={}):
	df = pd.read_csv(os.path.join(data_dir,'{}.csv'.format(name)), parse_dates=parse_dates)
	for k, convert in conversions.items():
		df[k] = convert(df[k])
	for treat in treatments:
		treat(df)

	drop_table(name)
	df.to_sql(name, engine)

	return df


def convert_currency(v):
	return pd.to_numeric(v.replace('[\$,-]', '', regex=True)) # convert currency / money to numeric type, might not be neccessary

def rename_to_conform_postgre(v):
	v.rename(columns=lambda x: 
		re.sub('\W', '_', x)
		.lower(), inplace=True)

def jeopardy(name='jeopardy'):
	return create_table_from_csv(name, {
		'air_date': pd.to_datetime,
		'value': convert_currency
		})

def talkpay(name='talkpay'):
	return create_table_from_csv(name, {
		'created_at': pd.to_datetime,
		})

def fy16_school():
	create_table_from_csv('fy16_school.districts',
		treatments=[rename_to_conform_postgre],
		conversions={'FY16 Expenditures': convert_currency
		})
	create_table_from_csv('fy16_school.counties',
		treatments=[rename_to_conform_postgre]
		) 
	create_table_from_csv('fy16_school.jvsd',
		treatments=[rename_to_conform_postgre]
		) 
	create_table_from_csv('fy16_school.trends',
		treatments=[rename_to_conform_postgre]
		) 
	create_table_from_csv('fy16_school.typologies',
		treatments=[rename_to_conform_postgre]
		) 

def marvel(name='marvel-wikia-data'):
	return create_table_from_csv(
		name,
		parse_dates = [12],
		treatments=[rename_to_conform_postgre]
		)	

	
		
