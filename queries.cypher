// Room with id = 1
MATCH (r:Room) WHERE r.id = 1
RETURN r

// Farming xp
MATCH (r:Room)-[:CONTAINS]->(m:Monster)
RETURN r.name, m.name, m.xp
ORDER BY m.xp DESC

// Getting gold
MATCH (r:Room)-[:CONTAINS]->(t:Treasure)
RETURN r.name, t.name, t.gp
ORDER BY t.gp DESC

// Neighboring rooms
MATCH (:Room {id: 1})-[:LEADS_TO]->(r:Room)
RETURN r.id, r.name

// Nearby room with the biggest treasure
MATCH (:Room {id: 1})-[:LEADS_TO*1..3]->(r:Room)-[:CONTAINS]->(t:Treasure)
RETURN r.id, r.name, t.gp
ORDER BY t.gp DESC
LIMIT 1

// Room with the biggest treasure
MATCH (max:Treasure)
  WITH max(max.gp) as maxgp
MATCH (r:Room)-[:CONTAINS]->(t:Treasure)
  WHERE t.gp = maxgp
RETURN r.name, t.name, t.gp

// Shortest path to the room with the biggest treasure
MATCH (max:Treasure)
	WITH max(max.gp) as maxgp
MATCH (r:Room)-[:CONTAINS]->(t:Treasure)
	WHERE t.gp = maxgp
    WITH r.id as dest_id
MATCH p = (start:Room)-[:LEADS_TO*]->(stop:Room)
	WHERE start.id = 1 AND stop.id = dest_id
RETURN nodes(p), length(p) as len
ORDER BY len ASC
LIMIT 1
