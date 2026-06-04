-- checking how many tasks are high, medium and low risk
SELECT Risk_Level, COUNT(*) AS Total_Tasks
FROM construction_dataset
GROUP BY Risk_Level
ORDER BY Total_Tasks DESC;


-- finding which tasks use the most labour and equipment
SELECT Task_ID, Labor_Required, Equipment_Units,
Material_Cost_USD,
ROUND((Labor_Required + Equipment_Units) / 2.0, 2) AS Avg_Resource_Usage
FROM construction_dataset
ORDER BY Avg_Resource_Usage DESC
LIMIT 10;


-- high risk tasks that have a lot of dependencies
SELECT Task_ID, Risk_Level, Dependency_Count,
Task_Duration_Days, Material_Cost_USD
FROM construction_dataset
WHERE Risk_Level = 'High'
AND Dependency_Count >= 3
ORDER BY Dependency_Count DESC;


-- average cost for each risk level to see if high risk = high cost
SELECT Risk_Level,
ROUND(AVG(Material_Cost_USD), 2) AS Avg_Cost,
ROUND(MIN(Material_Cost_USD), 2) AS Min_Cost,
ROUND(MAX(Material_Cost_USD), 2) AS Max_Cost
FROM construction_dataset
GROUP BY Risk_Level
ORDER BY Avg_Cost DESC;


-- long tasks with high constraint scores, these could cause delays
SELECT Task_ID, Task_Duration_Days, Start_Constraint,
Resource_Constraint_Score, Site_Constraint_Score,
ROUND(Resource_Constraint_Score + Site_Constraint_Score, 2) AS Total_Constraint_Score
FROM construction_dataset
WHERE Task_Duration_Days > 60
ORDER BY Total_Constraint_Score DESC
LIMIT 10;