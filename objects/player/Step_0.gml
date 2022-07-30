if keyboard_check_direct(vk_left){
	xmove = -1;
}
else if keyboard_check_direct(vk_right){
	xmove = 1;
}
else{
	xmove = 0;
}

if place_free(x+3,y){
	walledR = false;
}
else{
	walledR = true;
}

if place_free(x-3,y){
	walledL = false;
}
else{
	walledL = true;
}

if place_free(x, y+3){
	grounded = false;
}
else{
	if grounded == false{
		grounded = true;
			//move_contact_solid(270, 3);
	}
}

if(!grounded){
	yspeed += g;
	xaccel = xmove * xair_accel;
}
else{
	yspeed = 0;
	if xmove == 0 {
		if xspeed >= -xfriction || xspeed <= xfriction{
			xspeed = 0
		}
		else{
			xspeed -= xfriction * sign(xspeed);
		}
	}
	else{
		xaccel = xmove * xground_accel;
	}
}
if grounded && keyboard_check_pressed(vk_up){
	yspeed = -jump_speed;
}

xspeed = clamp(xspeed + xaccel, -max_x_speed, max_x_speed);

if walledL {
	xspeed = max(xspeed,0);
    //move_contact_solid(180, 3);
}
if walledR {
	xspeed = min(xspeed,0);
    //move_contact_solid(0, 3);
}

x += xspeed;
y += yspeed;
var otherColi = instance_place(x, y, solidObj);
if otherColi != noone{
	var ang = point_direction(otherColi.x, otherColi.y, x, y);
	if ang < 45 && ang > 315 {
		ang = 0;
	}
	else if ang > 45 && ang < 135 {
		ang = 90;
	}
	else if ang > 135 && ang < 225 {
		ang = 180;	
	}
	else if ang > 225 && ang < 315 {
		ang = 270;	
	}
	move_outside_solid(ang, 0);
}