//
//  MDI105_class1UnitTestingBundle.swift
//  MDI105-class1UnitTestingBundle
//
//  Created by Brandon Bennington on 25/08/25.
//

import Testing
import MDI105_class1

struct MDI105_class1UnitTestingBundle {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let books = getBookListFromDB()//
        #expect(books)
    }

}
