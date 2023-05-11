import logging
import requests

import azure.functions as func
from ..StockMarketFunctions import StockFunctions as sf


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    day = req.params.get('day')
    month = req.params.get('month')
    year = req.params.get('year')

    if day and month and year :
            try:
                OutputFile="sec_bhavdata_full_"+day+month+year+".csv"
                url = 'https://archives.nseindia.com/products/content/'+OutputFile
                r = requests.get(url, allow_redirects=True)
                data=r.content

                sm=sf.stockMarket(int(year),int(month),int(day))
                if sm.IsHoliday=="Y":
                    return func.HttpResponse(f"Input day={day},month={month},year={year} is Holiday so No File is available",status_code=400)
    
                else:

                    return func.HttpResponse(data,headers={'Content-Disposition':'attachment; filename='+OutputFile} ,mimetype='application/csv')
            except Exception as e:
                return func.HttpResponse(f"An error occured while generating the file {OutputFile},check parameter passed day={day},month={month},year={year},error=",status_code=400)
    
    else:
            return func.HttpResponse(
                "This HTTP triggered function executed successfully Pass parameters like ?day=13&month=10&year=2022",
                status_code=200
            )
  

