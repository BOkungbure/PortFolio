<<<<<<< Updated upstream
select * from Portfolio..CovidDeaths order by 3, 4 desc;

-- select * from Portfolio..CovidVaccinations order by 3, 4 desc;


-- selecting data for use

select location, date, total_cases, new_cases, total_deaths, population
from Portfolio..CovidDeaths
order by 3, 4,5,6;


-- Total Cases vs Total Deaths
-- % Of deaths in relation to the total of new cases at any given day
select location, date, total_cases, total_deaths, ROUND((total_deaths*1.0/total_cases)*100,1) AS DeathRatio
from Portfolio..CovidDeaths
where location = 'Canada'
order by date;

-- Total Cases vs Population
-- % of cases when compared to the total population
select location, date, total_cases, total_deaths, population, (total_cases*1.0/population)*100 AS CaseRatio
from Portfolio..CovidDeaths
where location = 'Canada'
order by date;


-- Countries with the highest infection rate

select location, MAX(total_cases) AS HighestNumberofInfections, population, Max((NULLIF(total_cases*1.0,0)/NULLIF(population,0)))*100 AS CaseRatio
from Portfolio..CovidDeaths
group by population, location
order by CaseRatio desc;


-- Countries with the highest death rate
select location, MAX(cast(total_deaths as int)) as TotalDeaths
from Portfolio..CovidDeaths
where continent is not null
group by location
order by TotalDeaths desc;



-- Deaths by Continents
select Continent, MAX(cast(total_deaths as int)) as TotalDeaths
from Portfolio..CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc;

-- Showing continents with the highest rate of deaths per population
select Continent, MAX(cast(total_deaths as int)) as TotalDeaths
from Portfolio..CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc;

-- GLOBAL NUMBERS
select date, total_cases, total_deaths, (NULLIF(total_deaths*1.0,0)/NULLIF(total_cases,0))*100 AS DeathRatio
from Portfolio..CovidDeaths
order by 1, 2;


-- JOINING DATA FROM DEATH TABLE & VACCINATION TABLE
select *
from Portfolio..CovidDeaths
JOIN Portfolio..CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date


-- TOTAL PORTION OF POPULATION THAT HAVE RECEIVED VACCINES
select CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations, 
SUM(CONVERT(bigint, CovidVaccinations.new_vaccinations)) OVER (partition by CovidDeaths.location order by CovidDeaths.location)
as RollingPeopleVaccinated
from Portfolio..CovidDeaths
JOIN Portfolio..CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null
order by 2,3

-- Vaccination Rate w/ CTE
with PopltnvVacctn (continent, location, date, Population, new_vaccinations, RollingPeopleVaccinated)
as 
(
select CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations, 
SUM(CONVERT(bigint, CovidVaccinations.new_vaccinations)) OVER (partition by CovidDeaths.location order by CovidDeaths.location)
as RollingPeopleVaccinated
from Portfolio..CovidDeaths
JOIN Portfolio..CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null
)

select *, (RollingPeopleVaccinated/nullif(Population,0))*100
from PopltnvVacctn
where continent is not null
order by continent, date asc;
=======
select * from Portfolio..CovidDeaths order by 3, 4 desc;

-- select * from Portfolio..CovidVaccinations order by 3, 4 desc;


-- selecting data for use

select location, date, total_cases, new_cases, total_deaths, population
from Portfolio..CovidDeaths
order by 3, 4,5,6;


-- Total Cases vs Total Deaths
-- % Of deaths in relation to the total of new cases at any given day
select location, date, total_cases, total_deaths, ROUND((total_deaths*1.0/total_cases)*100,1) AS DeathRatio
from Portfolio..CovidDeaths
where location = 'Canada'
order by 1, 2;

-- Total Cases vs Population
-- % of cases when compared to the total population
select location, date, total_cases, total_deaths, population, ROUND((total_cases*1.0/population)*100,1) AS CaseRatio
from Portfolio..CovidDeaths
where location = 'Canada'
order by date;


-- Countries with the highest infection rate

select location, MAX(total_cases) AS HighestNumberofInfections, population, Max((NULLIF(total_cases*1.0,0)/NULLIF(population,0)))*100 AS CaseRatio
from Portfolio..CovidDeaths
group by population, location
order by CaseRatio desc;


-- Countries with the highest death rate
select location, MAX(cast(total_deaths as int)) as TotalDeaths
from Portfolio..CovidDeaths
where continent is not null
group by location
order by TotalDeaths desc;



-- Deaths by Continents
select Continent, MAX(cast(total_deaths as int)) as TotalDeaths
from Portfolio..CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc;

-- Showing continents with the highest rate of deaths per population
select Continent, MAX(cast(total_deaths as int)) as TotalDeaths
from Portfolio..CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc;

-- GLOBAL NUMBERS
select date, total_cases, total_deaths, (NULLIF(total_deaths*1.0,0)/NULLIF(total_cases,0))*100 AS DeathRatio
from Portfolio..CovidDeaths
order by 1, 2; 


-- JOINING DATA FROM DEATH TABLE & VACCINATION TABLE
select *
from Portfolio..CovidDeaths
JOIN Portfolio..CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date


-- TOTAL PORTION OF POPULATION THAT HAVE RECEIVED VACCINES
select CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations, 
SUM(CONVERT(bigint, CovidVaccinations.new_vaccinations)) OVER (partition by CovidDeaths.location order by CovidDeaths.location)
as RollingPeopleVaccinated
from Portfolio..CovidDeaths
JOIN Portfolio..CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null
order by 2,3

-- Vaccination Rate w/ CTE
with PopltnvVacctn (continent, location, date, Population, new_vaccinations, RollingPeopleVaccinated)
as 
(
select CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations, 
SUM(CONVERT(bigint, CovidVaccinations.new_vaccinations)) OVER (partition by CovidDeaths.location order by CovidDeaths.location)
as RollingPeopleVaccinated
from Portfolio..CovidDeaths
JOIN Portfolio..CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null
)

select *, (RollingPeopleVaccinated/nullif(Population,0))*100
from PopltnvVacctn
where continent is not null
order by continent, date asc;
>>>>>>> Stashed changes
