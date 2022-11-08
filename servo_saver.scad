$fa = 1;
$fs = 0.4;
J = 0.001;

//Key parameters for spring strength
spring_strength = 3;//2.5;  //the difference in radius of the outer and inner spring radius
cutoutO = 1;    //Offset of cutout
//Thickness of the servo saver could also be a key parameter for spring strength

pushrodD = 1.7;  //Diameter
servoplateT = 2;    //Thickness of servo connector plate
servoplateR = 12; //Radius of servo plate
screwR = 1.25;   //Radius of screw hole to attach to servo horn
screwO = 0.5*17; //Offet of screw
springringR = 17.5; //Radius of outside of spring ring
springringT = servoplateT;//Thickness of spring ring
springringO = 3.5;//Offset of spring ring
cutoutR = springringR-spring_strength;    //Radius of cutout of spring ring
passR = 5;    //Radius of hole to pass through servo horn screw
//pushrod connector
connW = 14;    //Width of Pushrod Connector
connH = 6;    //Height of Pushrod Connector
connT = servoplateT;  //Thickness of pushrod connector
connO = servoplateR+2;    //Offset of pushrod connector
pushrodholeR = pushrodD*0.5*1.5; //Radius of pushrod hole
pushrodholeO = 0.5*connH;   //Offset of pushrod hole
pushrodS = 0.5*connW+2;   //Separation of pushrod holes

letter_height = 0.5;
letter_size = 4;
font = "Liberation Sans";

module servo_plate(){
    difference()
    {
        cylinder(servoplateT,servoplateR,servoplateR);
        translate([screwO,0,-servoplateT])
        cylinder(servoplateT*3,screwR,screwR);
        translate([-screwO,0,-servoplateT])
        cylinder(servoplateT*3,screwR,screwR);
        translate([0,0,-servoplateT])
        cylinder(servoplateT*3,passR,passR);
        }
}

module spring(){
    translate([0,-springringO,0])
    difference()
    {
    cylinder(springringT,springringR,springringR);
    translate([0,-cutoutO,-J])
        cylinder(springringT+2*J,cutoutR,cutoutR);
    }
}

module pushrod_connector(){
    translate([0,-connO,0])
    difference()
    {
    translate([-0.5*connW,-connH,0])
    cube([connW,connH,connT]);
    translate([0.5*pushrodS,-pushrodholeO,-connT])
    cylinder(connT*3,pushrodholeR,pushrodholeR);
    translate([-0.5*pushrodS,-pushrodholeO,-connT])
    cylinder(connT*3,pushrodholeR,pushrodholeR);
    }
}

module letter(l) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = letter_height) {
		text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
	}
}

module text_spring_strength(){
    //print the difference of the cutoutR from the outer spring radius
    //use for tracking different spring strengths
    translate([0,servoplateR*0.6,servoplateT-J])
    letter(str(spring_strength));
    //print the spring offset
    translate([0,-4-servoplateR*0.4,servoplateT-J])
    letter(str(cutoutO));
}

module servo_saver(){
    servo_plate();
    spring();
    pushrod_connector();
    text_spring_strength();
}

servo_saver();