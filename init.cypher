// Create dungeon
CREATE (d:Dungeon {id: 1, name: 'Crypt of the Golden Swamp'});

// Import rooms
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/rooms.csv' AS row
CREATE (:Room {id: toInteger(row.id), name: row.name});

// Import treasures
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/treasures.csv' AS row
CREATE (:Treasure {id: toInteger(rowid), name: row.name, gp: toInteger(row.gp)});

// Import monsters
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/monsters.csv' AS row
CREATE (:Monster {id: toInteger(row.id), name: row.name, cr: toInteger(row.cr), xp: toInteger(row.xp)});

// Import relationships
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/monsters.csv' AS row
MATCH (r1:Room {id:row.id_from}), (r2:Room {id:row.id_to})
CREATE (r1)-[:LEADS_TO]->(r2);
