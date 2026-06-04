#!/usr/bin/env python3
import csv, sys
fields = ["risk_level", "risk_item", "source_location", "description", "suggestion", "owner"]
writer = csv.DictWriter(sys.stdout, fieldnames=fields)
writer.writeheader()
writer.writerow({
    "risk_level":"高",
    "risk_item":"违约责任无上限",
    "source_location":"第6页第9条",
    "description":"赔偿范围没有上限，可能导致不可控责任。",
    "suggestion":"建议设置不超过合同总金额或已付款金额的赔偿上限。",
    "owner":"法务确认"
})
