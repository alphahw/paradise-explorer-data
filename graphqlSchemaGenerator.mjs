import fs from 'fs';

import 'dotenv/config';

import neo4jIntrospector from '@neo4j/introspector';
const { toGraphQLTypeDefs } = neo4jIntrospector;
import neo4j from 'neo4j-driver';

const driver = neo4j.driver(
    process.env.NEO4J_URL,
    neo4j.auth.basic(process.env.NEO4J_USER, process.env.NEO4J_PASSWORD)
);

const sessionFactory = () => driver.session({ defaultAccessMode: neo4j.session.READ })

// We create a async function here until "top level await" has landed
// so we can use async/await
async function main() {
    const typeDefs = await toGraphQLTypeDefs(sessionFactory)
    fs.writeFileSync('./graphql-out/schema.graphql', typeDefs)
    await driver.close();
}
main()
