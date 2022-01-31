# paradise-explorer-data

Data engineering utilities for [`paradise-explorer`](https://github.com/alphahw/paradise-explorer), powered by node.js.
To run, clone, `cd` into the cloned directory, and then install depdencies (example showing `yarn`):

```
$ yarn
```

## CSV processing

Caution: will process all files in the source folder, ensure only your source CSVs are present.

```
$ node index.mjs "./csv_paradise_papers.2018-02-14/"
```

Resulting files in `./csv-out/`.

## Neo4J query/import utils

- `paradise-papers.cyp` contains a selection of Neo4J Cypher statements to load/view data and create constraints.
  - Additionally, at the bottom, there is a Neo4J admin import tool call to be run with data placed in the `import` folder of a new database.
- `/dump` contains a complete Neo4J dump than can be loaded into GrapheneDP (other Neo4J hosting may also work, but not tested). 

## GraphQL type generation

Before running, Ensure you have
- an `.env` file (see `.env.sample`)
- a running Neo4J database with loaded data (local or remote, should work as long as credentials are correct)

```
$ node graphqlSchemaGenerator.mjs
```

Resulting files in `./graphql-out/`.
