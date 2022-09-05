//
// Generated by JTB 1.3.2
//

package visitor;
import syntaxtree.*;
import java.util.*;

/**
 * Provides default methods which visit each node in the tree in depth-first
 * order.  Your visitors may extend this class.
 */
public class GJDepthFirstNext<R,A> extends GJDepthFirst<R,A> {
   //
   // Auto class visitors--probably don't need to be overridden.
   //
   public R visit(NodeList n, A argu) {
      R _ret=null;
      int _count=0;
      for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
         e.nextElement().accept(this,argu);
         _count++;
      }
      return _ret;
   }

   public R visit(NodeListOptional n, A argu) {
      if ( n.present() ) {
         R _ret=null;
         int _count=0;
         Set<String> set=new HashSet<String>();
         for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
            set.add((String)e.nextElement().accept(this,argu));
            _count++;
         }
         _ret=(R)set;
         return _ret;
      }
      else
         return null;
   }

   public R visit(NodeOptional n, A argu) {
      if ( n.present() )
         return n.node.accept(this,argu);
      else
         return null;
   }

   public R visit(NodeSequence n, A argu) {
      R _ret=null;
      int _count=0;
      for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
         e.nextElement().accept(this,argu);
         _count++;
      }
      return _ret;
   }

   public R visit(NodeToken n, A argu) { return null; }

   //
   // User-generated visitor methods below
   //
   
   
   int  statement=1;
   int totalStatements=0;
   public class Sig{
      int next_stat;
      int opt_next;
      Set<String> def;
      Set<String> use;
      
   }

   public Sig createSig() {
	   Sig a = new Sig();
	   a.next_stat=0;
	   a.opt_next=0;
	   a.def=new HashSet<String>();
	   a.use=new HashSet<String>();
	   return a;
   }
    
   HashMap<Integer,Sig> SigTable=new HashMap<Integer,Sig>();

   
    
   public int  print(Sig a) {
	   System.out.println("next-> "+a.next_stat);
	   System.out.println("opt_next->"+a.opt_next);
	   System.out.println("def->"+a.def);
	   System.out.println("use->"+a.use);
	   
	   return 0; 
   }
   
   public class Bound{
	   int start;
	   int end;
   }
   
   public Bound createBound() {
	   Bound a=new Bound();
	   a.start=0;
	   a.end=0;
	   return a;
   }
   
   
   public class FuncBound{
	   int start;
	   int end;
	   HashMap<String,Bound> BoundTable;
   }
   
   public FuncBound createFuncBound(){
	   FuncBound a=new FuncBound();
	   a.start=0;
	   a.end=0;
	   a.BoundTable=new HashMap<String,Bound>();
       return a;
   }
   
   HashMap<Integer,FuncBound> FuncBoundTable=new HashMap<Integer,FuncBound>();
   
   
   HashMap<String,Integer> Label_list=new HashMap<String,Integer>();
   
  
   
   
   Vector<Integer> start_idx=new Vector<Integer>();
   Vector<Integer> end_idx=new Vector<Integer>();
   
   public class Live{
	   Set<String> Live_in;
	   Set<String> Live_out;
   }
   
   public Live createLive() {
	   Live a=new Live();
	   a.Live_in=new HashSet<String>();
	   a.Live_out=new HashSet<String>();
	   return a;
   }
   
   public void Print(Live a) {
	   System.out.println("-----------------------");
	   System.out.println(a.Live_in);
	   System.out.println(a.Live_out);
	   System.out.println("-----------------------");
   }
   
   Vector<Live> LiveTable=new Vector<Live>();
   
   public void liveness(HashMap<Integer,Sig> SigTable,
		   Vector<Integer> start_idx,Vector<Integer> end_idx) {
	   
	   for(int idx=0;idx<start_idx.size();idx++) {
		   int start=start_idx.get(idx);
		   int end=end_idx.get(idx);
//		   System.out.println("start indices : "+start);
//		   System.out.println("end indices : "+end);  
		   for(int i=start;i<=end;i++) {
			   LiveTable.set(i, createLive());
		   }
		   
		   boolean changed = true;
		   Vector<Integer> v=new Vector<Integer>();
		   while(changed) {
			   int num_changed=0;
			   int num_stat=0;
			   
			   for(int i=start;i<=end;i++){
				   Sig a=SigTable.get(i);
				   //print(a);
				   Live live=createLive();
				   live.Live_in.addAll(LiveTable.get(i).Live_in);
				   live.Live_out.addAll(LiveTable.get(i).Live_out);
				   Set<String> temp=new HashSet<String>();
				   Set<String> temp1=new HashSet<String>();
				   temp.addAll(live.Live_out);
				   temp.removeAll(a.def);
				   temp.addAll(a.use);
				   Live live1=createLive();
				   live1.Live_in.removeAll(live1.Live_in);
				   live1.Live_in.addAll(temp);
				   if(a.next_stat!=-1&&a.next_stat!=0) {
					   
					   Live live2=createLive();
					  live2=LiveTable.get(a.next_stat);
					   temp1.addAll(live2.Live_in);
					   if(a.opt_next!=0&&a.opt_next!=-1) {
						   
						   Live live3=createLive();
						   live3=LiveTable.get(a.opt_next);
						   temp1.addAll(live3.Live_in);
					   }
				   }
				   live1.Live_in.addAll(temp);
				   //live1.Live_out.removeAll(live1.Live_out);
				   live1.Live_out.addAll(temp1);
				   LiveTable.set(i, live1);
				   boolean v1=live1.Live_in.equals(live.Live_in);
				   boolean v2=live1.Live_out.equals(live.Live_out);
				   if(v1&&v2) {
					   
					   num_changed++;
				   } 
				   num_stat++;
			   }
			   if(num_changed==num_stat)
			   changed=false;
			   
		   }
		   
	   }
   }
   
   
   public void liveInterval(Vector<Live> LiveTable,Vector<Integer> start_idx,
		   Vector<Integer> end_idx) {
	   for(int idx=0;idx<start_idx.size();idx++) {
	    	  int start=start_idx.get(idx);
	    	  int end=end_idx.get(idx);
	    	  FuncBound Fbd=createFuncBound();
	    	  Fbd.start=start;
	    	  Fbd.end=end;
	    	  for(int i=start;i<=end;i++) {
	    		  Sig a=SigTable.get(i);
	    		  Set<String> set=new HashSet<String>();
	    		  set.addAll(a.def);
	    		  for(String s:set) {
	    			  
	    			  if(Fbd.BoundTable.get(s)==null) {
	    				  Bound b=createBound();
	    				  b.start=i;
	    				  for(int j=i;j<=end;j++) {
	    					  Live l=LiveTable.get(j);
	    					  if(l.Live_in.contains(s)==true) {
	    						  b.end=j;
	    					  }
	    				  }
	    				 Fbd.BoundTable.put(s, b); 
	    			  }
	    		  }
	    	  }
	    	  FuncBoundTable.put(start, Fbd);
	      }
   }
   
   
   HashMap<Integer,Integer> sallocated=new HashMap<Integer,Integer>();
   HashMap<Integer,Integer> slocated=new HashMap<Integer,Integer>();
   public int findFree(Vector<Integer> reg) {
	   for(int i=0;i<reg.size();i++) {
		   if(reg.get(i)==0) {
			   return i;
		   }
	   }
	   return -1;
   }
   
   
   public class Alloc{
	   HashMap<String,Integer>register;
	   HashMap<String,Integer>location;
	   Integer args;
	   String name;
	   Integer maxArgs;
   }
   
   public Alloc createAlloc() {
	   Alloc a=new Alloc();
	   a.register=new HashMap<String,Integer>();
	   a.location=new HashMap<String,Integer>();
	   a.args=0;
	   a.name=null;
	   a.maxArgs=0;
	   return a;
   }
   
   HashMap<String,Alloc> AllocTable=new HashMap<String,Alloc>(); 
   
   HashMap<String,Integer> Args=new HashMap<String,Integer>(); 
   
   class SortFirst implements Comparator<Bound>{
	   @Override
	   public int compare(Bound b1,Bound b2) {
		   if(b1.start>b2.start) {
			   return 1;
		   }
		   if(b1.start<b2.start) {
			   return -1;
		   }
		   return 0;
	   }
   }
   
   class SortEnd implements Comparator<Bound>{
	   @Override
	   public int compare(Bound b1,Bound b2) {
		   if(b1.end>b2.end) {
			   return 1;
		   }
		   if(b1.end<b2.end) {
			   return -1;
		   }
		   return 0;
	   }
   }
   
   public void printBound(Vector<Bound> active) {
	   System.out.print("{");
	   for(Bound b:active) {
		   System.out.print("{"+b.start+","+b.end+"},");
	   }
	   System.out.println("}");
   }
   
   public void expireOldIntervals(Bound b,Vector<Bound> active,
		   Vector<Integer> reg,FuncBound fbd,Alloc a) {
	   Vector<Bound> temp=new Vector<Bound>();
	   Collections.sort(active,new SortEnd());
	   int cnt=0;
	   for(int idx=0;idx<active.size();idx++) {
		   Bound b1=active.get(idx);
		   if(b1.end>=b.start) {
			   return;
		   }
		   
		  
		   for(Map.Entry mapElement : fbd.BoundTable.entrySet()) {
			   if((Bound)mapElement.getValue()==b1) {
				   
				   String s=(String)mapElement.getKey();
				   int i=a.register.get(s);
				   reg.set(i, 0);
			   }
		   }
		   
		   active.remove(b1);
		   Collections.sort(active,new SortEnd());
		  
	   }
	   
	   
	  
	  
   }
   
   
   public void spillAtInterval(Bound b,Vector<Bound> active,
		   Vector<Integer> reg,Alloc a,FuncBound fbd,int start) {
	   Bound spill=active.lastElement();
	   if(spill.end>b.end) {
		   String sp="";
		   for(Map.Entry mapElement:fbd.BoundTable.entrySet()) {
			   if((Bound)mapElement.getValue()==spill) {
				   sp=(String)mapElement.getKey();
			   }
		   }
		   
		   for(Map.Entry mapElement : fbd.BoundTable.entrySet()) {
				 if((Bound)mapElement.getValue()==b) {
					   String s=(String)mapElement.getKey();
					   int i=a.register.get(sp);
					   a.register.put(s,i);
					   active.remove(spill);
					   active.add(b);
					   Collections.sort(active,new SortEnd());
				 }
	      }
		 
		   for(Map.Entry mapElement : fbd.BoundTable.entrySet()) {
			   if((Bound)mapElement.getValue()==spill) {
				   String s=(String)mapElement.getKey();
				   a.register.remove(s);
				   int k=slocated.get(start);
				   a.location.put(s,k);
				   slocated.put(start, k+1);
				   
			   }
		   }
		   
		  
       }
	   else {
		   for(Map.Entry mapElement : fbd.BoundTable.entrySet()) {
				 if((Bound)mapElement.getValue()==b) {
					 String s=(String)mapElement.getKey();
					 int k=slocated.get(start);
					 a.location.put(s, k);
					 slocated.put(start,k+1);
				 }
		   }
	   }
   }  
   
   HashMap<Integer,String> func_Name=new HashMap<Integer,String>();
   
   public void linearScan(FuncBound fbd,
		   int start,int end) {
	  Vector<Bound> active=new Vector<Bound>();
	  Alloc a=createAlloc();
	  String func=func_Name.get(start);
	  a.name=func;
	  AllocTable.put(func, a);
	  slocated.put(start,0);
	  Vector<Integer> reg=new Vector<Integer>();
	  reg.setSize(18);
	  
	  for(int i=0;i<18;i++) {
		  reg.set(i, 0);
	  }
	  int x=sallocated.get(start);
	  a.args=x;
	  sallocated.put(start,Math.min(4, x));
	  
	  for(int i=0;i<sallocated.get(start);i++) {
		  a.register.put("TEMP "+i,i);
		  reg.set(i, 1);
	  }
	  
	  for(int i=sallocated.get(start);i<x;i++) {
		  int k=slocated.get(start);
		  a.location.put("TEMP "+i,k);
		  slocated.put(start,k+1);
	  }
	  
	  Vector<Bound> intervals=new Vector<Bound>();
	  for(Map.Entry mapElement : fbd.BoundTable.entrySet()) {
		  Bound b=(Bound)mapElement.getValue();
		  intervals.add(b);
	  }
	  Collections.sort(intervals,new SortFirst());
	  
	  for(Bound b:intervals) {
		  
		  expireOldIntervals(b,active,reg,fbd,a);
		  
		  x=sallocated.get(start);
		  if(active.size()==18-x) {
			  int cnt=0;
			  for(int i=0;i<18;i++) {
				  if(reg.get(i)==1){
					  cnt++;
				  }
			  }
			  
			  spillAtInterval(b,active,reg,a,fbd,start);
		  }
		  else {
			  
			  active.add(b);
			  Collections.sort(active,new SortEnd());
			 for(Map.Entry mapElement : fbd.BoundTable.entrySet()) {
				 if((Bound)mapElement.getValue()==b) {
					 //System.out.println("reg is : "+reg);
					 a.register.put((String)mapElement.getKey(),findFree(reg));
					 
					 reg.set(findFree(reg),1);
				 }
			 }
			 //reg.set(findFree(reg), 1);
		  }
	  }
	  
   }
   
   
   /**
    * f0 -> "MAIN"
    * f1 -> StmtList()
    * f2 -> "END"
    * f3 -> ( Procedure() )*
    * f4 -> <EOF>
    */
   
   public R visit(Goal n, A argu) {
      
	  R _ret=null;
      Label_list=(HashMap<String,Integer>)argu;
     
	  
      sallocated.put(1, 0);
      func_Name.put(1,"MAIN");
      n.f0.accept(this, argu);
      Sig sig1=createSig();
      SigTable.put(statement, sig1);
      statement++;
      sig1.next_stat=statement;
      String s=n.f0.toString();
      argu=(A)s;
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      Sig sig2=createSig();
      SigTable.put(statement, sig2);
      statement++;
      sig2.next_stat=-1;
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      start_idx.add(1);
      Set set = SigTable.entrySet();
      Iterator iterator = set.iterator();
      while(iterator.hasNext()) {
    	 Map.Entry map = (Map.Entry)iterator.next();
    	 Sig sig=(Sig)map.getValue();
    	 if(sig.next_stat==-1) {
    		 end_idx.add((Integer)map.getKey());
    		 start_idx.add((Integer)map.getKey()+1);
    	 }
    	
      }
      
      
      Collections.sort(start_idx);
      Collections.sort(end_idx);
      start_idx.remove(start_idx.size()-1);
      totalStatements=statement;
      LiveTable.setSize(totalStatements);
      
      
      liveness(SigTable,start_idx,end_idx);
      
      
      
      
      
      liveInterval(LiveTable,start_idx,end_idx);
      
      for(int idx=0;idx<start_idx.size();idx++) {
    	  int start=start_idx.get(idx);
    	  int end=end_idx.get(idx);
    	  FuncBound fbd=FuncBoundTable.get(start);
    	  
    	  linearScan(fbd,start,end);
    	  
    	  
      }
      
      
      _ret=(R)AllocTable;
      return _ret;
   }

   /**
    * f0 -> ( ( Label() )? Stmt() )*
    */
   public R visit(StmtList n, A argu) {
      R _ret=null;
     
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Label()
    * f1 -> "["
    * f2 -> IntegerLiteral()
    * f3 -> "]"
    * f4 -> StmtExp()
    */
   public R visit(Procedure n, A argu) {
      R _ret=null;
      argu=(A)"PROD";
      String s=(String)n.f0.accept(this,argu);
      argu=(A)s;
      Sig sig= createSig();
      SigTable.put(statement,sig);
      statement++;
      sig.next_stat=statement;
      n.f1.accept(this, argu);
      String str=(String)n.f2.accept(this, argu);
      Integer i=Integer.valueOf(str);
      Args.put(s,i);
      sallocated.put(statement-1,i);
      func_Name.put(statement-1, s);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> NoOpStmt()
    *       | ErrorStmt()
    *       | CJumpStmt()
    *       | JumpStmt()
    *       | HStoreStmt()
    *       | HLoadStmt()
    *       | MoveStmt()
    *       | PrintStmt()
    */
   public R visit(Stmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "NOOP"
    */
   public R visit(NoOpStmt n, A argu) {
      R _ret=null;
      
      String s=(String)n.f0.accept(this, argu);
      Sig sig=createSig();
      SigTable.put(statement, sig);
      statement++;
      sig.next_stat=statement;
      return _ret;
   }

   /**
    * f0 -> "ERROR"
    */
   public R visit(ErrorStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      Sig sig=createSig();
      SigTable.put(statement, sig);
      statement++;
      sig.next_stat=statement;
      return _ret;
   }

   /**
    * f0 -> "CJUMP"
    * f1 -> Temp()
    * f2 -> Label()
    */
   public R visit(CJumpStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String use=(String)n.f1.accept(this, argu);
      argu=(A)"CJUMP";
      String s=(String)n.f2.accept(this,argu);
      Sig sig=createSig();
      SigTable.put(statement, sig);
      statement++;
      sig.next_stat=statement;
      sig.opt_next=Label_list.get(s);
      sig.use.add(use);
      return _ret;
   }

   /**
    * f0 -> "JUMP"
    * f1 -> Label()
    */
   public R visit(JumpStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      argu=(A)"JUMP";
      String s=(String)n.f1.accept(this, argu);
      Sig sig=createSig();
      SigTable.put(statement, sig);
      statement++;
      sig.next_stat=statement;
      sig.opt_next=Label_list.get(s);
      return _ret;
   }

   /**
    * f0 -> "HSTORE"
    * f1 -> Temp()
    * f2 -> IntegerLiteral()
    * f3 -> Temp()
    */
   public R visit(HStoreStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String def=(String)n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      String use=(String)n.f3.accept(this, argu);
      Sig sig=createSig();
      SigTable.put(statement, sig);
      statement++;
      sig.next_stat=statement;
      sig.use.add(use);
      sig.use.add(def);
      return _ret;
   }

   /**
    * f0 -> "HLOAD"
    * f1 -> Temp()
    * f2 -> Temp()
    * f3 -> IntegerLiteral()
    */
   public R visit(HLoadStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String def=(String)n.f1.accept(this, argu);
      String use=(String)n.f2.accept(this, argu);
      Sig sig=createSig();
      SigTable.put(statement, sig);
      n.f3.accept(this, argu);
      statement++;
      sig.next_stat=statement;
      sig.use.add(use);
      sig.def.add(def);
      return _ret;
   }

   /**
    * f0 -> "MOVE"
    * f1 -> Temp()
    * f2 -> Exp()
    */
   public R visit(MoveStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String def=(String)n.f1.accept(this, argu);
      Sig sig=createSig();
      SigTable.put(statement,sig);
      sig.def.add(def);
      argu=(A)sig.use;
      n.f2.accept(this, argu);
      statement++;
      sig.next_stat=statement;
      for(String s : sig.use) {
    	  if(s==null) {
    		  System.out.println("hello");
    	  }
      }
      return _ret;
   }

   /**
    * f0 -> "PRINT"
    * f1 -> SimpleExp()
    */
   public R visit(PrintStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String use=(String)n.f1.accept(this, argu);
      Sig sig=createSig();
      SigTable.put(statement, sig);
      if(use!=null)
      sig.use.add(use);
      statement++;
      sig.next_stat=statement;
      return _ret;
   }

   /**
    * f0 -> Call()
    *       | HAllocate()
    *       | BinOp()
    *       | SimpleExp()
    */
   public R visit(Exp n, A argu) {
      R _ret=null;
      
      _ret=n.f0.accept(this, argu);
       if(n.f0.which==3) {
    	   //System.out.println("hello");
    	   Set<String> set=(Set<String>)argu;
    	   if((String)_ret!=null)
    	   set.add((String)_ret);
       }
      return _ret;
   }

   /**
    * f0 -> "BEGIN"
    * f1 -> StmtList()
    * f2 -> "RETURN"
    * f3 -> SimpleExp()
    * f4 -> "END"
    */
   public R visit(StmtExp n, A argu) {
      R _ret=null;
      Sig sig1=createSig();
      SigTable.put(statement, sig1);
      n.f0.accept(this, argu);
      statement++;
      sig1.next_stat=statement;
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      String s=(String)n.f3.accept(this, argu);
      Sig sig2=createSig();
      SigTable.put(statement, sig2);
      statement++;
      sig2.next_stat=statement;
      if(s!=null)
      sig2.use.add(s);
      
      
      Sig sig3=createSig();
      SigTable.put(statement, sig3);
      n.f4.accept(this, argu);
     statement++;
     sig3.next_stat=-1;
      return _ret;
   }

   /**
    * f0 -> "CALL"
    * f1 -> SimpleExp()
    * f2 -> "("
    * f3 -> ( Temp() )*
    * f4 -> ")"
    */
   
   
   public R visit(Call n, A argu) {
      R _ret=null;
      Set<String> s=(Set<String>)argu;
      
      n.f0.accept(this, argu);
      String use=(String)n.f1.accept(this, argu);
      if(use!=null)
    	  s.add(use);
      n.f2.accept(this, argu);
      R r=n.f3.accept(this, argu);
       
      if(r!=null) {
    	  Set<String> set=(Set<String>)r;
    	  s.addAll(set);
      }
      n.f4.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "HALLOCATE"
    * f1 -> SimpleExp()
    */
   public R visit(HAllocate n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String use=(String)n.f1.accept(this, argu);
      Set<String> set=(Set<String>) argu;
      if(use!=null)
      set.add(use);
      return _ret;
   }

   /**
    * f0 -> Operator()
    * f1 -> Temp()
    * f2 -> SimpleExp()
    */
   public R visit(BinOp n, A argu) {
      R _ret=null;
      Set<String> set=(Set<String>)argu;
      n.f0.accept(this, argu);
      String temp=(String)n.f1.accept(this, argu);
      String use=(String)n.f2.accept(this, argu);
      if(use!=null)
      set.add(use);
      if(temp!=null)
      set.add(temp);
      return _ret;
   }

   /**
    * f0 -> "LE"
    *       | "NE"
    *       | "PLUS"
    *       | "MINUS"
    *       | "TIMES"
    *       | "DIV"
    */
   public R visit(Operator n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Temp()
    *       | IntegerLiteral()
    *       | Label()
    */
   public R visit(SimpleExp n, A argu) {
      R _ret=null;
      argu=(A)"EXP";
      if(n.f0.which==0)
      _ret=n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "TEMP"
    * f1 -> IntegerLiteral()
    */
   public R visit(Temp n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      _ret=n.f1.accept(this, argu);
      _ret = (R)("TEMP "+(String)_ret);
      return _ret;
   }

   /**
    * f0 -> <INTEGER_LITERAL>
    */
   public R visit(IntegerLiteral n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      _ret=(R)n.f0.toString();
      
      return _ret;
   }

   /**
    * f0 -> <IDENTIFIER>
    */
   public R visit(Label n, A argu) {
      R _ret=null;
      String str=(String)argu;
      
      n.f0.accept(this, argu);
      String s=n.f0.toString();
      if(str!="JUMP"&&str!="CJUMP"&&str!="PROD"&&str!="EXP") {
    	  //System.out.println("hello "+s);
    	  Sig sig=createSig();
    	 SigTable.put(statement, sig);
    	  statement++;
    	  sig.next_stat=statement;
      }
      _ret=(R)s;
      return _ret;
   }

}