import syntaxtree.*;
import visitor.*;

public class A2{
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
         //System.out.println("Program parsed successfully");
         Object s=root.accept(new GJDepthFirst(),null); // Your assignment part is invoked here.
         root.accept(new GJDepthFirstNext(),s);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

