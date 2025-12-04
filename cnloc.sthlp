{smcl}
{* *! version 1.0.0  2025-12-05}{...}
{title:Title}

{pstd}
{cmd:cnloc} {hline 2} Stata interface for the Python cnloc package. Address parsing for Chinese administrative divisions. {p_end}


{title:Syntax}

{phang2}{cmd:cnloc} address_var [ year_var , {opt year(str)} {opt mode(str)} {opt drop(str)} {opt pre:fix(str)} {opt suf:fix(str)} ]{p_end}

{synoptset 13 tabbed}{synopthdr}
{synoptline}
{synopt: {opt year(str)} } year for matching. An interger or variable name. Default is {opt year(2024)}. Valid range is from 1980 to 2024, and invalid years will be clipped to the default year 2024. Alternative method is to use year_var. {p_end}
{synopt: {opt mode(str)} } matching mode. Default is {opt mode(1)}. {opt mode(1)} is left to right (high to low, province to county), following string order. {opt mode(2)} is low to high (county to province), ignoring string order; not recommended for basic use {p_end}
{synopt: {opt drop(str)} } variable list to drop in the final output. Default is None. {opt drop(year)} drops the year variable. {opt drop(name)} drops full-name variables of province_name, city_name, and county_name. {opt drop(adcode)} drops administrative-division-code variables of province_adcode, city_adcode, and county_adcode. {opt drop(id)} drops unique IDs of province_id, city_id, and county_id variables {p_end}
{synopt: {opt pre:fix(str)} } prefix to add to variable names {p_end}
{synopt: {opt suf:fix(str)} } suffix to add to variable names {p_end}


{title:Description}

{pstd}
{cmd:cnloc} is an interface for the Python cnloc package, which parses Chinese address to get province, city, and county names (_name), administrative division codes (_adcode), and unique IDs (_id) from addresses. {p_end}

{pstd}
This command requires Python package {cmd:cnloc}.{p_end}

{p 8 12 2}{cmd:pip install cnloc}{p_end}

{pstd}
Currently, the {cmd:county_id} is unreliable! Only province- and city-level IDs are manually verified. {p_end}


{title:Examples}

{pstd}
Prepare sample address data{p_end}

{phang2}{cmd}. clear{p_end}
{phang2}{cmd}. set obs 34{p_end}
{phang2}{cmd}. gen address1 = ""{p_end}
{phang2}{cmd}. local address_list `" "朝阳" "朝阳市" "朝阳县" "朝阳区" "朝阳市朝阳" "朝阳朝阳" "北京朝阳" "辽宁朝阳" "荆州" "荆州市" "荆州区" "荆州市荆州区" "荆州市荆州" "荆州荆州" "荆州荆州区" "湖北荆州" "湖北荆州沙市" "鼓楼区" "江苏鼓楼区" "南京鼓楼区" "江苏徐州鼓楼区" "南山" "广东省深圳市南山区深南大道" "深圳南山" "广东南山" "深圳市华侨城东部工业区" "深圳东门南路2006号宝丰大厦五楼" "中国深圳市深南大道" "海淀" "北京市海淀区中关村大街1号" "海淀中关村大街1号" "中关村大街1号" "马鞍山市经济技术开发区红旗南路51号" "银川市西夏区北京西路630号" "'{p_end}
{phang2}{cmd}. local i = 1{p_end}
{phang2}{cmd}. foreach addr in `address_list' {{p_end}
{phang2}{cmd}.     replace address1 = "`addr'" if _n == `i'{p_end}
{phang2}{cmd}.     local i = `i' + 1{p_end}
{phang2}{cmd}. }{p_end}
{phang2}{cmd}. gen year1 = 2024{p_end}


{pstd}
Example 1: A simple example. The two are identical. {p_end}

{phang2}{cmd}. cnloc address1 {p_end}
{phang2}{cmd}. cnloc address1 , year(2024) {p_end}

{pstd}
Example 2: Use user-specified parse year.{p_end}

{phang2}{cmd}. cnloc address1 year1 {p_end}

{pstd}
Example 3: Use parse year of 2022. Drop parse year, names and administrative division codes of provinces, cities, and counties. Set prefix and suffix for final variables. {p_end}

{phang2}{cmd}. cnloc address1 , year(2022) drop(year name adcode) prefix(a_) suffix(_b) {p_end}



{title:Author}

{pstd}Maobin Xu{p_end}
{pstd}Email: {browse "mailto:maobinxu@foxmail.com":maobinxu@foxmail.com}{p_end}