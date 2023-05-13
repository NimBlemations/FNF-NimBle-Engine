package;

#if cpp
typedef Int8 = cpp.Int8;
typedef Int16 = cpp.Int16;
#elseif java
typedef Int8 = java.StdTypes.Int8;
typedef Int16 = java.StdTypes.Int16;
#else
typedef Int8 = Int;
typedef Int16 = Int;
#end