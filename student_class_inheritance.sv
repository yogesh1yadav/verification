typedef enum {cse,ece,mech,civil} branch;

class address;
  string house_no, street, district, state;
  int pincode;
  
  function new(string house_no, street, district, state, int pincode);
    this.house_no = house_no;
    this.street = street;
    this.district=district;
    this.state = state;
    this.pincode = pincode;
  endfunction
  
  function void print();
    $display("house_no = %s",this.house_no);
    $display("street = %s",this.street);
    $display("district = %s",this.district);
    $display("state = %s",this.state);
    $display("pincode = %0d",this.pincode);
  endfunction
  
  function void sethouseno(string house_no);  
    this.house_no = house_no;
  endfunction
  
  function string gethouseno();
    return this.house_no;
  endfunction
  
  function void setstreet(string street);    
    this.street = street;   
  endfunction

  function string getstreet();   
    return this.street;   
  endfunction

  function void setdistrict(string district);    
    this.district = district;   
  endfunction
  
  function string getdistrict();   
    return this.district;   
  endfunction  
  
  function void setstate(string state);    
    this.state = state;   
  endfunction  

  function string getstate();    
    return this.state;   
  endfunction
  
  function int getpincode();   
    return this.pincode;   
  endfunction
  
  function void setpincode(int pincode);    
    this.pincode = pincode;    
  endfunction
    
endclass:address



class student;
  static int last_roll_no;
  string name;
  int roll_no;
  int year;
  address add;
  branch b;
  longint fees;
  
  function new(string name, int year, address add, branch b, longint fees);    
    this.name = name;
    this.roll_no = ++last_roll_no;
    this.year = year;
    this.add = add;
    this.b = b;    
    this.fees= fees;
  endfunction
  
  
  function void print();    
    $display("name = %s",this.name);
    $display("roll_no = %0d",this.roll_no);
    $display("year = %0d",this.year);
    $display("branch = %s",this.b.name());
    $display("tution fees=%0d",this.fees);
    add.print();    
  endfunction  

  function void setname(string name);    
    this.name = name;    
  endfunction  
  
  function string getname();    
    return this.name;    
  endfunction
  
  function  void setrollno( );    
    this.roll_no = ++last_roll_no;
    //last_roll++;
  endfunction
    
  function int getrollno();    
    return this.roll_no;    
  endfunction
 
  function void setyear(int year);    
    this.year = year;    
  endfunction
  
  function int getyear();    
    return this.year;    
  endfunction
  
  function void setaddress(address add);    
    this.add = add;    
  endfunction
  
  function address getaddress();   
    return this.add;    
  endfunction
  
  function void setbranch(branch b);   
    this.b = b;   
  endfunction  
  
  function branch getbranch();   
    return this.b;   
  endfunction  
  
  function longint getfees();    
    return this.fees;    
  endfunction
endclass:student

// typedef enum {os, python, c, java} cse_subjects;
// typedef enum {thermal , mechanics, automation} mech_subjects;
// typedef enum {analog, digital, verilog, controlsystem} ece_subjects;

class mechanical extends student;
  string mech_subjects;
  longint fees;
  
  
  function new(string name , int year, address add,longint fees,string mech_subjects);
    super.new(name, year, add,mech, fees);
    this.mech_subjects=mech_subjects;
    this.fees=super.fees+ super.fees*0.1;
  endfunction
    
  function void print();
    super.print();
    $display("mech student all subjects= %s", this.mech_subjects);
    $display("mech branch student total fees=%0d",this.fees);
    
  endfunction
  
endclass

class computer_science extends student;
  string cse_subjects;
  longint fees;
  
  
  function new(string name , int year, address add,longint fees,string cse_subjects);
    super.new(name, year, add, cse, fees);
    this.cse_subjects=cse_subjects;
    this.fees=super.fees+ super.fees*0.2;
  endfunction
    
  function void print();
    super.print();
    $display("cse student all subjects= %s", this.cse_subjects);
    $display("cse branch student total fees=%0d",this.fees);
    
  endfunction
  
endclass

class electronics extends student;
  string ece_subjects;
  longint fees;
  
  
  function new(string name , int year, address add,longint fees,string ece_subjects);
    super.new(name, year, add, ece, fees);
    this.ece_subjects=ece_subjects;
    this.fees=super.fees+ super.fees*0.3;
  endfunction
    
  function void print();
    super.print();
    $display("ece student all subjects= %s", this.ece_subjects);
    $display("ece branch student total fees=%0d",this.fees);
    
  endfunction
  
endclass

//testbench
module top_tb();
  address a1 = new("A123", "ashoka", "faridabad", "haryana", 121001);
  mechanical m1=new("rahul", 2022, a1, 10000,"thermal , mechanics, automation");
  
  address a2 = new("B567", "ring road", "newdelhi", "delhi", 110046);
  computer_science c1=new("amit", 2024, a2, 10000,"os, python, c, java");
 
  address a3 = new("65f", "gandhi road", "newdelhi", "delhi", 110054);
  electronics e1=new("ravi", 2024, a3, 10000,"analog, digital, verilog,controlsystem");
 
  initial begin
    $display("Print new student details");
    m1.print();
    
    $display("Print new student details");    
    c1.print();
    
    $display("Print new student details");    
    e1.print();
  end
endmodule




