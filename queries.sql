/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals;
SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered is true AND escape_attempt < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempt FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered is true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
ALTER TABLE animals ADD COLUMN specie VARCHAR;
SELECT * FROM animals;
UPDATE animals SET specie = 'unspecified';
ROLLBACK;
SELECT * FROM animals;
BEGIN
UPDATE animals SET specie = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET specie = 'Pokemon' WHERE specie is NULL;
COMMIT;
SELECT * FROM animals;
BEGIN
DELETE FROM animals; 
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
ROLLBACK sp1;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempt = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempt) FROM animals GROUP BY neutered;
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;
SELECT AVG(escape_attempt) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

-- Update species_id in animal table
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';
-- Update owner_id in animals table
UPDATE animals SET owners_id = 1 WHERE name = 'Agumon'
UPDATE animals SET owners_id = 2 WHERE name  = 'Gabumon' OR name ='Pikachu';
UPDATE animal SET species_id = 1 WHERE name NOT LIKE '%mon';

-- Update owner_id in animal table
UPDATE animal SET owners_id = 1 WHERE name = 'Agumon';

UPDATE animal SET owners_id = 2 WHERE name  = 'Gabumon' OR name ='Pikachu';

UPDATE animals SET owners_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals SET owners_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals SET owners_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';
--  write querries using JOIN

SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT animals.name, owners.full_name FROM animals RIGHT JOIN owners ON animals.owners_id = owners.id;

SELECT species.name, COUNT(animals.species_id) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;

SELECT animals.name from animals JOIN owners ON owners.id = animals.owners_id JOIN species on species.id = animals.species_id WHERE animals.species_id = '2' AND animals.owners_id = '2';

SELECT animals.name from animals JOIN owners ON owners.id = animals.owners_id WHERE animals.escape_attempt = '0' AND animals.owners_id = '5';

SELECT full_name, COUNT(owners_id) FROM owners JOIN animals on owners.id = animals.owners_id GROUP BY full_name ORDER BY COUNT (owners_id) desc limit 1;

-- JOIN TABLES and write querries for many to many relation

SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animals_id WHERE vets_id = '1' ORDER BY visits.date_of_visit desc limit 1;

SELECT COUNT(DISTINCT animals_id) FROM visits WHERE vets_id = '2';

SELECT vets.name, specialization.vets_id, specialization.species_id FROM vets LEFT JOIN specialization ON specialization.vets_id = vets.id;

SELECT animals.name , visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vets_id = '3';

SELECT animals.name, COUNT(animals_id) FROM animals JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY COUNT(animals_id) desc limit 1;

SELECT animals.name, date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id WHERE vets_id = '2'ORDER BY visits.date_of_visit ASC LIMIT '1';

SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE visits.date_of_visit = (SELECT MIN(date_of_visit) FROM visits);

SELECT *, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE visits.date_of_visit = (SELECT MIN(date_of_visit) FROM visits);

SELECT COUNT(visits.animals_id) FROM visits JOIN vets ON vets.id = visits.vets_id WHERE vets_id = '2';

SELECT species.name, COUNT(animals.species_id) FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Vet Maisy Smith' GROUP BY species.name ORDER BY COUNT(animals.species_id) desc limit 1;

SELECT full_name, COUNT(owners_id) FROM owners JOIN animals on owners.id = animals.owners_id GROUP BY full_name ORDER BY COUNT (owners_id) desc limit 1;
