#!/usr/bin/env sh
# Fine-grained swiftdeps files use multiple lines for each graph node.
# Compress such a file so that each entry is one line of the form:
# <kind> <aspect> <context> <name> <isProvides>
# Also sort for consistency, since the node order can vary.

awk '/kind:/ {k = $2; f  = "<no fingerprint>"}; /aspect:/ {a = $2}; /context:/ {c = $2}; /name/ {n = $2}; /sequenceNumber/ {s = $2}; /fingerprint:/ {f = $2 }; /isProvides:/ {isP = $2; print k, a, c, n, isP, f}' | sort
