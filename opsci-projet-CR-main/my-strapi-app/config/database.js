module.exports = ({ env }) => ({
    connection: {
      client: env('DATABASE_CLIENT', 'postgres'),
      connection: {
        host: env('DATABASE_HOST', 'strapiDB'),
        port: env.int('DATABASE_PORT', 5432),
        database: env('DATABASE_NAME', 'strapi'),
        user: env('DATABASE_USERNAME', 'strapi'),
        password: env('DATABASE_PASSWORD', 'safepassword'),
        schema: env('DATABASE_SCHEMA', 'public'),
        ssl: false,
      },
      debug: false,
    },
  });