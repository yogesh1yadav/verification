typedef enum {cse,ece,eee,mech,civil} branch;

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
  string name;
  string roll_no;
  int year;
  address add;
  branch b;
  
  function new(string name, string roll_no, int year, address add, branch b);    
    this.name = name;
    this.roll_no = roll_no;
    this.year = year;
    this.add = add;
    this.b = b;    
  endfunction
  
  function void print();    
    $display("name = %s",this.name);
    $display("roll_no = %s",this.roll_no);
    $display("year = %0d",this.year);
    $display("branch = %s",this.b.name());
    add.print();    
  endfunction  

  function void setname(string name);    
    this.name = name;    
  endfunction  
  
  function string getname();    
    return this.name;    
  endfunction
  
  function void setrollno(string roll_no);    
    this.roll_no = roll_no;    
  endfunction
    
  function string getrollno();    
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
endclass:student



//testbench

module student_tb();
  
  address a1 = new("A123", "ashoka", "faridabad", "haryana", 121001);
  student s1 = new("rahul","22PEC001", 2022, a1, ece);
  
  address a2 = new("B567", "ring road", "newdelhi", "delhi", 110046);
  student s2 = new("amit","22PCS008", 2024, a2, cse);
  
  initial begin
	
    $display("Print Student1 details");
	  s1.print();
    
    $display("Print Student2 details");
    s2.print();
    
    $display("update Student1 details using set method");
    s1.setname("king");  
    s1.setrollno("24PCY012");
    s1.setyear(2023);
    s1.setbranch(civil);
    a1.sethouseno("45C");
    a1.setstreet("pmc road");
    a1.setdistrict("pune");
    a1.setstate("maharashtra");
    a1.setpincode(232457);
    s1.setaddress(a1);
    
    $display("name = %s",s1.getname());       
    $display("roll_no = %s",s1.getrollno());       
    $display("year = %0d",s1.getyear());       
    $display("branch = %s",s1.getbranch().name());    
    $display("house_no  = %s",a1.gethouseno());       
    $display("Street  = %s",a1.getstreet());    
    $display("district  = %s",a1.getdistrict());       
    $display("state  = %s",a1.getstate());       
    $display("pincode  = %0d",a1.getpincode());       
    $display("address  = %p",s1.getaddress());    
    
    $display("Print Student1 deatails after modification using get and set methods");
    s1.print();
  end  
endmodule








