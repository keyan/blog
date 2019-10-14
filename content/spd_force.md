title: Visualizing Seattle Police Department use-of-force data
date: 2019-10-13 18:38:00
Tags: spd, seattle, civic data, d3, dataviz, leaflet

Using the [Seattle Open Data Portal][data_portal] I collected and analyzed [Seattle PD use-of-force][force-types] data collected over the last 5 years. I wanted to answer:

1. Are there geographic areas that have a disproportionate number of use-of-force incidents?
1. Are there some police officers that are involved in more incidents than others?

Seattle, being quite progressive, has its [own dashboard][dashboard] for visualizing this data, but the maps provided are more difficult to visually inspect and there is no analysis of per-officer aggregated data.

## Methods

All the code and post-processed data are available in the GitHub repo, [spd_force][spd_force], where there are more technical details regarding data retrieval and processing.

## Results

The spatial visualization is interesting to inspect for those who are familiar with Seattle neighborhoods. Unsurprisingly there are more incidents in the busier downtown area and historically diverse and poorer [South End][south_end], but ultimately without additional data layers it isn't easy to draw many conclusions.

<iframe src="https://keyanp.com/spd_force/force.html" width="100%" height="600" frameborder=0></iframe>

When I grouped use-of-force incidents (after removing duplicates) by officer, I noticed that relatively few officers accounted for the majority of cases. Over a total of 10,290 incidents there were 1,144 officers involved, but the top 200 (~17.4%) most frequently involved officers were responsible for just over half (~50.14%) of all incidents.

When visualizing the number of incidents per officer we see that most officers are involved in just one incident, while a few officers are involved in 40+ incidents. One officer was even involved in 92 incidents! I did consider that officer tenure may be skewing this data, but I couldn't control for that because "years of service" information was not included.

<iframe src="https://keyanp.com/spd_force/histogram.html" width="100%" height="460" frameborder=0></iframe>

## Conclusion

There is a continued need to provide public access to this and other SPD statistics in order to ensure visibility into the police force and equity in treatment of citizens. While SPD has been progressive in its data policies, there is a need for increased openness regarding officer specific data. Unfortunately, the "officer id" information in this dataset is simply an internal identifier and not a badge number or other publicly available identifier. The disproportionate involvement of some officers must be investigated further.

[data_portal]: https://data.seattle.gov/
[dashboard]: https://www.seattle.gov/police/information-and-data/use-of-force-data/use-of-force-dashboard
[force-types]: http://www.seattle.gov/police-manual/title-8---use-of-force/8050---use-of-force-definitions
[spd_force]: https://github.com/keyan/spd_force
[south_end]: https://en.wikipedia.org/wiki/South_End,_Seattle
