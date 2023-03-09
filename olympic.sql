#To explore the data
#To count the number of records in the dataset:
SELECT COUNT(*) FROM campusx.olympics;

#To display the first 10 records in the dataset:
SELECT * FROM campusx.olympics LIMIT 10;

#To find the average age of the athletes:
SELECT AVG(Age) FROM olympics; 

#To find the number of male and female athletes:
SELECT Sex, COUNT(*) FROM campusx.olympics GROUP BY Sex;

#Which countries have won the most medals in the history of the Olympics?
SELECT Country, COUNT(*) AS Medals
FROM olympics
WHERE Medal IS NOT NULL
GROUP BY Country
ORDER BY Medals DESC;

#Which sports have the highest number of participants?
SELECT Sport, COUNT(DISTINCT Name) AS Participants
FROM campusx.olympics
GROUP BY Sport
ORDER BY Participants DESC;

#Which events have the highest number of gold medalists?
SELECT Event, COUNT(*) AS Golds
FROM campusx.olympics
WHERE Medal = 'Gold'
GROUP BY Event
ORDER BY Golds DESC;

#list of all events, countries, and the number of medals won, number of unique participants, and number of gold/silver/bronze medals won in each event
SELECT Event, Country, COUNT(*) AS Medals, 
    COUNT(DISTINCT Name) AS Participants, 
    SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Golds,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silvers,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronzes
FROM campusx.olympics
WHERE Medal IS NOT NULL
GROUP BY Event, Country
ORDER BY Event, Medals DESC;

#To find the countries with the most medals:
SELECT Country, COUNT(*) AS Medals
FROM olympics
WHERE Medal IS NOT NULL
GROUP BY Country
ORDER BY Medals DESC
LIMIT 10;

#To find the sports with the highest number of participants:
SELECT Sport, COUNT(DISTINCT Name) AS Participants
FROM olympics
GROUP BY Sport
ORDER BY Participants DESC
LIMIT 10;


#To find the events with the highest number of gold medalists:
SELECT Event, COUNT(*) AS Golds
FROM olympics
WHERE Medal = 'Gold'
GROUP BY Event
ORDER BY Golds DESC
LIMIT 10;

#What is the average age of medal winners by sport and gender?
SELECT Sport, Sex, AVG(Age) AS AvgAge
FROM olympics
WHERE Medal IS NOT NULL
GROUP BY Sport, Sex
ORDER BY AvgAge DESC;


#Which countries have the highest number of gold medals per capita?
SELECT Country, Population, COUNT(*) AS Golds, COUNT(*) / Population AS GoldsPerCapita
FROM (
    SELECT DISTINCT Country, Population, Name, Medal
    FROM olympics
    JOIN countries ON olympics.NOC = countries.NOC
    WHERE Medal = 'Gold'
) AS GoldMedals
GROUP BY Country, Population
HAVING COUNT(*) > 50
ORDER BY GoldsPerCapita DESC;


#Who are the most successful athletes across all Olympics, based on the number of medals won?
SELECT Name, COUNT(*) AS TotalMedals
FROM olympics
WHERE Medal IS NOT NULL
GROUP BY Name
ORDER BY TotalMedals DESC
LIMIT 10;


#Which sports have the highest number of medalists who have won medals in multiple Olympics?
SELECT Sport, COUNT(DISTINCT Name) AS MultiMedalists
FROM olympics
WHERE Medal IS NOT NULL
GROUP BY Sport
HAVING COUNT(DISTINCT Name) > 100
ORDER BY MultiMedalists DESC;
