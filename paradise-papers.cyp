// constraints

  CREATE CONSTRAINT UniqueOther ON (o:Other) ASSERT o.nodeId IS UNIQUE;
  CREATE CONSTRAINT UniqueOfficer ON (o:Officer) ASSERT o.nodeId IS UNIQUE;
  CREATE CONSTRAINT UniqueIntermediary ON (i:Intermediary) ASSERT i.nodeId IS UNIQUE;
  CREATE CONSTRAINT UniqueEntity ON (e:Entity) ASSERT e.nodeId IS UNIQUE;
  CREATE CONSTRAINT UniqueAddress ON (a:Address) ASSERT a.nodeId IS UNIQUE;

// paradise_papers.nodes.other.csv

  // {
  //  "sourceID": "Paradise Papers - Appleby",
  //  "note": "",
  //  "valid_until": "Appleby data is current through 2014",
  //  "name": "AAK Company Ltd.",
  //  "country_codes": "BMU;IMN",
  //  "countries": "Bermuda;Isle of Man",
  //  "node_id": "80004686"
  // }

  //view data rows in paradise_papers.nodes.other.csv
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.other.csv' AS row
  RETURN row
  LIMIT 3;

  //import data rows in paradise_papers.nodes.other.csv
  :auto USING PERIODIC COMMIT 500
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.other.csv' AS row

  MERGE (o:Other {nodeId: toInteger(row.node_id)})
    SET o.sourceId = row.sourceID,
      o.note = row.note,
      o.validUntil = row.valid_until,
      o.name = row.name,
      o.countryCodes = row.country_codes,
      o.countries = row.countries

  RETURN count(o);

// paradise_papers.nodes.officer.csv

  // {
  //   "sourceID": "Paradise Papers - Malta corporate registry",
  //   "note": "",
  //   "valid_until": "Malta corporate registry data is current through 2016",
  //   "name": "RADOMIR VUKCEVIC",
  //   "country_codes": "",
  //   "countries": "",
  //   "node_id": "59160036",
  //   "status": ""
  // }

  //view data rows in paradise_papers.nodes.officer.csv
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.officer.csv' AS row
  RETURN row
  LIMIT 3;

  //import data rows in paradise_papers.nodes.officer.csv
  :auto USING PERIODIC COMMIT 500
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.officer.csv' AS row
  MERGE (o:Officer {nodeId: toInteger(row.node_id)})
    SET o.sourceId = row.sourceID,
      o.note = row.note,
      o.validUntil = row.valid_until,
      o.name = row.name,
      o.countryCodes = row.country_codes,
      o.countries = row.countries,
      o.status = row.status

  RETURN count(o);

// paradise_papers.nodes.intermediary.csv

  // {
  //   "sourceID": "Paradise Papers - Bahamas corporate registry",
  //   "note": "",
  //   "valid_until": "Bahamas corporate registry data is current through 2016",
  //   "name": "CITITRUST (BAHAMAS) LIMITED",
  //   "country_codes": "BHS",
  //   "countries": "Bahamas",
  //   "node_id": "34304771"
  // }

  //view data rows in paradise_papers.nodes.intermediary.csv
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.intermediary.csv' AS row
  RETURN row
  LIMIT 3;

  //import data rows in paradise_papers.nodes.intermediary.csv
  :auto USING PERIODIC COMMIT 500
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.intermediary.csv' AS row

  MERGE (i:Intermediary {nodeId: toInteger(row.node_id)})
    SET i.sourceId = row.sourceID,
      i.note = row.note,
      i.validUntil = row.valid_until,
      i.name = row.name,
      i.countryCodes = row.country_codes,
      i.countries = row.countries

  RETURN count(i);

// paradise_papers.nodes.entity.csv

  // {
  //   "sourceID": "Paradise Papers - Aruba corporate registry",
  //   "company_type": "",
  //   "note": "Closed date stands for Cancelled date.",
  //   "closed_date": "28-OCT-1988",
  //   "jurisdiction": "AW",
  //   "struck_off_date": "",
  //   "service_provider": "",
  //   "countries": "",
  //   "jurisdiction_description": "Aruba",
  //   "valid_until": "Aruba corporate registry data is current through 2016",
  //   "ibcRUC": "",
  //   "name": "OCEAN",
  //   "inactivation_date": "",
  //   "country_codes": "",
  //   "incorporation_date": "26-APR-1983",
  //   "node_id": "85004927",
  //   "status": ""
  // }

  //view data rows in paradise_papers.nodes.entity.csv
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.entity.csv' AS row
  // WITH row WHERE row.status <> ""
  RETURN row
  LIMIT 3;

  //import data rows in paradise_papers.nodes.entity.csv
  :auto USING PERIODIC COMMIT 500
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.entity.csv' AS row

  MERGE (e:Entity {nodeId: toInteger(row.node_id)})
    SET e.sourceId = row.sourceID,
      e.companyType = row.company_type,
      e.note = row.note,
      e.closedDate = row.closed_date,
      e.jurisdiction = row.jurisdiction,
      e.struckOffDate = row.struck_off_date,
      e.serviceProvider = row.service_provider,
      e.countries = row.countries,
      e.jurisdictionDescription = row.jurisdiction_description,
      e.validUntil = row.valid_until,
      e.ibcRUC = row.ibcRUC,
      e.name = row.name,
      e.inactivationDate = row.inactivation_date,
      e.countryCodes = row.country_codes,
      e.incorporationDate = row.incorporation_date,
      e.status = row.status

  RETURN count(e);

// paradise_papers.nodes.address.csv

  // {
  //   "sourceID": "Paradise Papers - Appleby",
  //   "note": "",
  //   "valid_until": "Appleby data is current through 2014",
  //   "address": "6B Chenyu Court",
  //   "name": "6B Chenyu Court; 22-24 Kennedy Road; Hong Kong",
  //   "country_codes": "HKG",
  //   "countries": "Hong Kong",
  //   "node_id": "81014050"
  // }

  //view data rows in paradise_papers.nodes.address.csv
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.address.csv' AS row
  // WITH row WHERE row.status <> ""
  // WITH row WHERE row.node_id = "120004328"
  RETURN row
  LIMIT 3;

  //import data rows in paradise_papers.nodes.address.csv
  :auto USING PERIODIC COMMIT
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.nodes.address.csv' AS row

  MERGE (a:Address {nodeId: toInteger(row.node_id)})
    SET a.sourceId = row.sourceID,
      a.note = row.note,
      a.validUntil = row.valid_until,
      a.address = row.address,
      a.name = row.name,
      a.countryCodes = row.country_codes,
      a.countries = row.countries

  RETURN count(a);

// paradise_papers.edges.csv

  // {
  //   "sourceID": "Paradise Papers - Aruba corporate registry",
  //   "end_date": "",
  //   "valid_until": "Aruba corporate registry data is current through 2016",
  //   "END_ID": "88000379",
  //   "link": "registered address",
  //   "START_ID": "85004927",
  //   "TYPE": "registered_address",
  //   "start_date": ""
  // }

  //view data rows in paradise_papers.edges.csv
  LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.edges.csv' AS row
  RETURN row
  LIMIT 3;

  //import data rows in paradise_papers.edges.csv
  // This runs forever, does not work; see neo4j admin import statements below

  // :auto USING PERIODIC COMMIT 10000
  // LOAD CSV WITH HEADERS FROM 'file:///paradise_papers.edges.csv' AS row

  // MERGE (a {nodeId: toInteger(row.START_ID)}), (b {nodeId: toInteger(row.END_ID)})

  // WITH a, b, row
  // CALL apoc.merge.relationship(a, row.TYPE, {
  //   sourceId: row.sourceID,
  //   startDate: row.start_date,
  //   endDate: row.end_date,
  //   validUntil: row.valid_until
  // }, {}, b) YIELD rel

  // RETURN count(rel);

// Neo4J admin tool import (https://neo4j.com/docs/operations-manual/current/tutorial/neo4j-admin-import/)

bin/neo4j-admin import \
    --force \
    --nodes=import/paradise_papers.nodes.address.csv \
    --nodes=import/paradise_papers.nodes.entity.csv \
    --nodes=import/paradise_papers.nodes.intermediary.csv \
    --nodes=import/paradise_papers.nodes.officer.csv \
    --nodes=import/paradise_papers.nodes.other.csv \
    --relationships=import/paradise_papers.edges.csv \
    --multiline-fields=true