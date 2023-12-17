//
//  BikeDatabaseManager.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 17.12.2023.
//

import Foundation
import SQLite3

class BikeDatabaseManager {
    private var db: OpaquePointer?
    
    init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
            .appendingPathComponent("BikesDatabase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
            return
        }
    }
    
    private func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Bikes(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Brand TEXT,
        Model TEXT,
        Color TEXT,
        ServiceDue INTEGER);
        """
        
        if sqlite3_exec(db, createTableString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error creating table: \(errmsg)")
        }
    }
    
    func fetchBikes() -> [Bike] {
        var bikes = [Bike]()
        let queryStatementString = "SELECT Id, Brand, Model, Color, ServiceDue FROM Bikes;"
        
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let brand = String(cString: sqlite3_column_text(queryStatement, 1))
                let model = String(cString: sqlite3_column_text(queryStatement, 2))
                let colorRawValue = String(cString: sqlite3_column_text(queryStatement, 3))
                let serviceDue = sqlite3_column_int(queryStatement, 4)
                
                let color = Colors(rawValue: colorRawValue) ?? .black
                let bike = Bike(id: Int(id), brand: brand, model: model, color: color, serviceDue: Int(serviceDue))
                bikes.append(bike)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Query preparation failed: \(errorMessage)")
        }
        
        sqlite3_finalize(queryStatement)
        return bikes
    }

    func addBike(bike: Bike) {
        let insertStatementString = "INSERT INTO Bikes (Brand, Model, Color, ServiceDue) VALUES (?, ?, ?, ?);"
        
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (bike.brand as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (bike.model as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (bike.color.rawValue as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 4, Int32(bike.serviceDue))

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }

    func deleteBike(byId id: Int) {
        let deleteStatementString = "DELETE FROM Bikes WHERE Id = ?;"

        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }

        sqlite3_finalize(deleteStatement)
    }
    
    func updateBike(_ bike: Bike) {
        let updateStatementString = "UPDATE Bikes SET Brand = ?, Model = ?, Color = ?, ServiceDue = ? WHERE Id = ?;"

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (bike.brand as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (bike.model as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (bike.color.rawValue as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 4, Int32(bike.serviceDue))
            sqlite3_bind_int(updateStatement, 5, Int32(bike.id!))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }

        sqlite3_finalize(updateStatement)
    }

}
