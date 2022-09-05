package visitor;
import java.util.*;






public class SymbolTable{
	   TreeMap<String,String> var;//stores the variables and the type of a method declaration
	   TreeMap<String,Vector<R> > inOut;//stores the arguments type 
	   TreeMap<String,SymbolTable> method;//name of the method and it's table
	   TreeMap<String,String> aType;//accesstype of the method declaration.
	   String parentClass;//
};


