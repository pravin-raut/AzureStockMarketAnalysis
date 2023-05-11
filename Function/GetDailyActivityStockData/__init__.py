import logging

import azure.functions as func
import StockMarketFunctions.StockFunctions as sf

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    day = req.params.get('day')
    month = req.params.get('month')
    year = req.params.get('year')
    if not day and not month and not year:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            day = req.params.get('day')
            month = req.params.get('month')
            year = req.params.get('year')
    sm=sf.stockMarket(year,month,day)
    
    if day and month and year :
        
        OutputFile="DailyActivityStockData"+"_"+str(year)+"_"+str(month)+"_"+str(day)+".csv"
        return func.HttpResponse(sm.generatebhavcopy(),headers={'Content-Disposition':'attachment; filename='+OutputFile} ,mimetype='application/csv')
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully Pass parameters like ?env=dev&day=13&month=10&year=2022",
             status_code=200
        )
