# Computer-HW-Rental-Inventory-DB
A database designed to facilitate the needs of a company that rents computer hardware to other business.

This MySQL database makes good use of "Triggers" to efficiently update transaction costs, fees, fines and repair costs automatically when the Hardware or Transactions tables are updated. The design of this Database conforms to all levels of normalization standards including Boyce-Codd Normal Form. Dates must be entered as a single Integer value with no whitespaces or special characters so that costs can be calculated by taking the difference of two date values. A modular arithemetic algorithm is used to convert the date values from Year, Month and Day input to an Int value representing the number of days passed since the beginning of a year.

Main entity-like relations:
-employee
-supplier
-customer
-hardware

More abstract/data related relations:
-orders
-transactions
-repairservices
-customerfees
-fees_fines
-unit_price

Business Use cases:
-`Manager Adds Inventory`
-`Staff Creates Transaction`
-`staff resolves transactions`
-`insert into repairServices`

Relationships (parent table/child table)
-employee/orders
-employee/transactions
-employee/repairservices
-transactions/hardware
-transactions/fees_fines
-transactions/repairservices
-customer/transactions
-customer/repairservices
-customer/customerfees
-orders/hardware
-unit_price/hardware
-supplier/orders

Aggregate Operation Use Cases
-`AGG customer total delinquent accounts`
-`AGG customerFees WhoOwesMost`
-`AGG Emp MAX MIN salary`
-`AGG hardware checked in for type`
-`AGG orders average price`
-`AGG repairservices sum costs+items`
-`AGG supplier lowest rating`
-`AGG transactions average  sale price`
-`AGG unit_price most_expensive and avg_rental_rate`
-`AGGfees_fines total_damageFines, total_lateFees`

Join Operation Use Cases
-`JOIN Customer-transactions past due`
-`JOIN emp-repair-cust repairmanFixes`
-`JOIN Employee-Orders-Supplier whoBoughtSupply`
-`JOIN Employee-transactions whoMadeSales`
-`JOIN Hardware-Orders-Supplier itemsInSupplyOrder`
-`JOIN Hardware-transactions showItems`
-`JOIN Transactions-repair-Hardware hardware_in_repair`

