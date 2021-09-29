// Create dungeon
CREATE (d:Dungeon {id: 1, name: 'Crypt of the Golden Swamp'});

// Import rooms
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/rooms.csv' AS row
CREATE (:Room {id: toInteger(row.id), name: row.name});

// Import treasures
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/treasures.csv' AS row
CREATE (:Treasure {id: toInteger(row.id), name: row.name, gp: toInteger(row.gp)});

// Import monsters
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/monsters.csv' AS row
CREATE (:Monster {id: toInteger(row.id), name: row.name, cr: toInteger(row.cr), xp: toInteger(row.xp)});

// Import relationships
// Dungeon entrances
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/has_entrance.csv' AS row
MATCH (d:Dungeon {id:toInteger(row.id_from)})
MATCH (r:Room {id:toInteger(row.id_to)})
CREATE (d)-[:HAS_ENTRANCE]->(r);

// Dungeon exits
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/has_exit.csv' AS row
MATCH (d:Dungeon {id:toInteger(row.id_from)})
MATCH (r:Room {id:toInteger(row.id_to)})
CREATE (d)-[:HAS_EXIT]->(r);

// Connect rooms
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/leads_to.csv' AS row
MATCH (r1:Room {id:toInteger(row.id_from)})
MATCH (r2:Room {id:toInteger(row.id_to)})
CREATE (r1)-[:LEADS_TO]->(r2);

// Rooms contain treasures 
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/contains_treasure.csv' AS row
MATCH (r:Room {id:toInteger(row.id_from)})
MATCH (t:Treasure {id:toInteger(row.id_to)})
CREATE (r)-[:CONTAINS]->(t);

// Rooms contain monsters 
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/contains_monster.csv' AS row
MATCH (r:Room {id:toInteger(row.id_from)})
MATCH (m:Monster {id:toInteger(row.id_to)})
CREATE (r)-[:CONTAINS]->(m);
