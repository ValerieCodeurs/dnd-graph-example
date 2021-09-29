// Create dungeon
CREATE (d:Dungeon {id: 1, name: 'Crypt of the Golden Swamp'});

// Import rooms
LOAD CSV FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/rooms.csv' AS line CREATE (:Room {id: toInteger(line[0]), name: line[1]})

// Import treasures
LOAD CSV FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/treasures.csv' AS line CREATE (:Treasure {id: toInteger(line[0]), name: line[1], gp: toInteger(line[2])})

// Import monsters
LOAD CSV FROM 'https://raw.githubusercontent.com/ValerieCodeurs/dnd-graph-example/main/monsters.csv' AS line CREATE (:Monster {id: toInteger(line[0]), name: line[1], cr: toInteger(line[2]), xp: toInteger(line[2])})


// Import relationships
// TO DO
