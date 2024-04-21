# flutter-SQFLite

a basic flutter examples using SQFLite

## SQFLite :

- Sqflite is a package in flutter that is used for implementing SQLite databases in flutter.

- If a large amount of data is to be stored locally i.e. on the mobile phone then we can use SQLite database.

- Databases provides faster inserts, updates and queries than otherr local solutions (i.e. shared preferences).

- To use the SQLite database we have sqflite package.

- To perform operations database we need first to open the database i.e. establish a connection with the database.

### 1). openDatabase():

- The openDatabase method from the SQFLite package is called to open the database. An SQLite database is a file in the syatem identified by a path. If relatives, this path is relative to the path obtained by getDatabasesPath(), which is the default database directly on Android and the documents directory on iOS/MacOS.

        ```
        Future<sql.Database> opendb() async {
            return await sql.openDatabase(
                "todo1.db",
                version : 1,
                onCreate : (db, version) async {
                    await createtable(db);
                }
            )
        }
        ```

- The openDatabase method contains the following optional paramaters :

        ```
        Future<Database> openDatabase(String path,
        {
            int? version,
            OnDatabaseConfigureFn? onConfigure,
            OnDatabaseCreateFn? onCreate,
            OnDatabaseVersionChangeFn? onUpgrade,
            OnDatabaseVersion?ChangeFn? onDowngrade,
            OnDatabaseOpenFn? onOpen,
            bool? readOnly = false,
            bool? singleInstance = true
        })
        ```

  - 1. The onCreate method is called if the database does not exist.
  - 2. onUpgarde method is called if the onCreate method is not specified. If the database already exists and [version] is higher than the last database version.
  - 3. onDowngrade method is called if the version is lower than the previous version
  - 4. onOpen method is called after the database version has been set and before openDatabase returns. singleInstance is a boolean flag that is true by default and returns a single instance of the database.

### 2). Create a table in the Database

- To store the data in the database we must create tables.
- To create a table in the database we can call the execute method and specify the query to crate the table.

  ```
  Future<void> createtable(sql.Database db) async {
      await db.database.execute(

          """  CREATE TABLE IF NOT EXISTS todoTasks1( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              title TEXT,
              description TEXT,
              date TEXT,
              done INT ) """,
      );
  }
  ```
