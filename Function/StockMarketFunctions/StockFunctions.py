import nsepy as np
from datetime import date
import nsepython as nsepy

class stockMarket:
    IsHoliday="N"
    def __init__(self,year,month ,day) -> None:
        self.year=year
        self.month=month
        self.day=day

    
    def checkHoliday(self):
        try:
            holiday = nsepy.nse_holidays()['CM']
            holidaySet = set()
            for days in holiday:
                holidaySet.add(days['tradingDate'])
            if date(self.year, self.month, self.day).strftime("%A") not in ["Saturday", "Sunday"] and date(self.year, self.month, self.day).strftime("%d-%b-%Y") not in holidaySet:
                return True
                
            else:
                return False
        except Exception as e:
            return e

    def generatePriceList(self):
        try:
            if self.checkHoliday():
                print("Its Working Day")
                return np.history.get_price_list(date(int(self.year), int(self.month), int(self.day))).to_csv(index=False)
            else:
                self.IsHoliday="Y"
                return self.IsHoliday
        except Exception as e:
            return e

    def generatebhavcopy(self):
        try:
            if self.checkHoliday():
                print("Its Working Day")
                return nsepy.get_bhavcopy(str(self.day)+str(self.month)+str(self.year)).to_csv(index=False)
            else:
                self.IsHoliday="Y"
                return self.IsHoliday
        except Exception as e:
            return e
           

