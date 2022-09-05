class Factorial{
    public static void main(String[] a){
        System.out.println(new Fact().ComputeFac());
    }
    
}

class Fact{

   
    public int ComputeFac (){
        int num_aux;//int num;
        int num;
        Fact sum;
        //int s;
        if ((num <= 1)&&(num != 1)) // Initially it was num <= 0
            num_aux = 1; // Initially it was num_aux = 1
        else
            num_aux = num * (this.ComputeFac()) ;
        return num_aux ;
    }
    
}


