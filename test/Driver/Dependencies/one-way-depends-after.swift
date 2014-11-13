// RUN: rm -rf %t && cp -r %S/Inputs/one-way-depends-after/ %t
// RUN: touch -t 201401240005 %t/*.swift
// RUN: touch -t 201401240006 %t/*.o

// RUN: cd %t && %swiftc_driver -c -driver-use-frontend-path %S/Inputs/update-dependencies.py -output-file-map %t/output.json -incremental ./main.swift ./other.swift -module-name main -j1 -v 2>&1 | FileCheck -check-prefix=CHECK-FIRST %s

// CHECK-FIRST-NOT: Handled

// RUN: rm %t/other.o
// RUN: cd %t && %swiftc_driver -c -driver-use-frontend-path %S/Inputs/update-dependencies.py -output-file-map %t/output.json -incremental ./main.swift ./other.swift -module-name main -j1 -v 2>&1 | FileCheck -check-prefix=CHECK-SECOND %s

// CHECK-SECOND-NOT: Handled main.swift
// CHECK-SECOND: Handled other.swift
// CHECK-SECOND-NOT: Handled main.swift

// RUN: rm %t/other.o
// RUN: cd %t && %swiftc_driver -c -driver-use-frontend-path %S/Inputs/update-dependencies.py -output-file-map %t/output.json -incremental ./main.swift ./other.swift -module-name main -j1 -v 2>&1 | FileCheck -check-prefix=CHECK-SECOND %s

// RUN: rm -rf %t && cp -r %S/Inputs/one-way-depends-after/ %t
// RUN: touch -t 201401240005 %t/*.swift
// RUN: touch -t 201401240006 %t/*.o

// RUN: cd %t && %swiftc_driver -c -driver-use-frontend-path %S/Inputs/update-dependencies.py -output-file-map %t/output.json -incremental ./main.swift ./other.swift -module-name main -j1 -v 2>&1 | FileCheck -check-prefix=CHECK-FIRST %s

// RUN: rm %t/main.o
// RUN: cd %t && %swiftc_driver -c -driver-use-frontend-path %S/Inputs/update-dependencies.py -output-file-map %t/output.json -incremental ./main.swift ./other.swift -module-name main -j1 -v 2>&1 | FileCheck -check-prefix=CHECK-THIRD %s

// CHECK-THIRD-NOT: Handled other.swift
// CHECK-THIRD: Handled main.swift
// CHECK-THIRD-NOT: Handled other.swift

// RUN: rm %t/main.o
// RUN: cd %t && %swiftc_driver -c -driver-use-frontend-path %S/Inputs/update-dependencies.py -output-file-map %t/output.json -incremental ./main.swift ./other.swift -module-name main -j1 -v 2>&1 | FileCheck -check-prefix=CHECK-THIRD %s

// RUN: rm %t/other.o
// RUN: cd %t && %swiftc_driver -c -driver-use-frontend-path %S/Inputs/update-dependencies.py -output-file-map %t/output.json -incremental ./main.swift ./other.swift -module-name main -j1 -v 2>&1 | FileCheck -check-prefix=CHECK-FOURTH %s

// CHECK-FOURTH: Handled other.swift
// CHECK-FOURTH: Handled main.swift
