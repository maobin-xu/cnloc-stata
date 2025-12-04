# cnloc (China Location)

Last updated on 2025-12-05

`cnloc` is an Stata interface for the Python cnloc package, which parses Chinese addresses to get province, city, and county names (_name), administrative division codes (_adcode), and unique IDs (_id) from addresses.

This command requires Python package [cnloc](https://github.com/maobin-xu/cnloc-stata).

```bash
pip install cnloc
```

## Usage 

Installation:
```stata
net install cnloc, from("https://raw.githubusercontent.com/maobin-xu/cnloc-stata/main/") replace
```

Command syntax:
```stata
cnloc address_var [ year_var , year(str) mode(str) drop(str) prefix(str) suffix(str) ]
```
- `address_var`: variable name for address strings
- `year_var`: variable name for year
- `year(str)`: year for matching. An interger or variable name. Default is `year(2024)`. Valid range is from 1980 to 2024, and invalid years will be clipped to the default year 2024. Alternative method is to use `year_var`
- `mode(str)`: matching mode. Default is `mode(1)`. `mode(1)` is left to right (high to low, province to county), following string order. `mode(2)` is low to high (county to province), ignoring string order; not recommended for basic use 
- `drop(str)`: variable list to drop in the final output. Default is None. `drop(year)` drops the year variable. `drop(name)}` drops full-name variables of province_name, city_name, and county_name. `drop(adcode)` drops administrative-division-code variables of province_adcode, city_adcode, and county_adcode. `drop(id)` drops unique IDs of province_id, city_id, and county_id variables 
- `prefix(str)`: prefix to add to variable names 
- `suffix(str)`: suffix to add to variable names 

Currently, the `county_id` is unreliable! Only province- and city-level IDs are manually verified. 

## Examples

Prepare sample address data
```stata
clear
set obs 34
gen address1 = ""
local address_list `" "朝阳" "朝阳市" "朝阳县" "朝阳区" "朝阳市朝阳" "朝阳朝阳" "北京朝阳" "辽宁朝阳" "荆州" "荆州市" "荆州区" "荆州市荆州区" "荆州市荆州" "荆州荆州" "荆州荆州区" "湖北荆州" "湖北荆州沙市" "鼓楼区" "江苏鼓楼区" "南京鼓楼区" "江苏徐州鼓楼区" "南山" "广东省深圳市南山区深南大道" "深圳南山" "广东南山" "深圳市华侨城东部工业区" "深圳东门南路2006号宝丰大厦五楼" "中国深圳市深南大道" "海淀" "北京市海淀区中关村大街1号" "海淀中关村大街1号" "中关村大街1号" "马鞍山市经济技术开发区红旗南路51号" "银川市西夏区北京西路630号" "'

* address
local i = 1
foreach addr in `address_list' {
    replace address1 = "`addr'" if _n == `i'
    local i = `i' + 1
}

* parse year
gen year1 = 2024
```


Example 1: A simple example. The two are identical. 
```stata
cnloc address1
cnloc address1 , year(2024)
```

Example 2: Use user-specified parse year.
```stata
cnloc address1 year1
```

Example 3: Use parse year of 2022. Drop parse year, names and administrative division codes of provinces, cities, and counties. Set prefix and suffix for final variables.
```stata
cnloc address1 , year(2022) drop(year name adcode) prefix(a_) suffix(_b)
```


