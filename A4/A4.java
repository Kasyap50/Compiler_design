import syntaxtree.*;
import visitor.*;

public class A4 {
   public static void main(String [] args) {
      try {
         Node root = new microIRParser(System.in).Goal();
         Object Label_list=root.accept(new GJDepthFirst(),null); // Your assignment part is invoked here.
         Object AllocTable=root.accept(new GJDepthFirstNext(),Label_list);
         AllocTable=root.accept(new GJDepthFirstTemp(),AllocTable);
         root.accept(new GJDepthFirstSecondNext(),AllocTable);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

