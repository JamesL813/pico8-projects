pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--init
--debug=true
clear_save=true
yaxis=1
eng_tog=true
flash=true
clouds_enabled=true
world=7
fire={14,10,6,2,0}
defu_pal={[0]=
 -11,-4,2,3,
 -12,12,8,11,
 4,6,9,-5,
 7,-11,10,15
 }
--seed=0
mx=0my=0
cur_pal=defu_pal
gravity=.1
mw=63
mh=63

--[[
0 ocean
1 forrest
2 town
3 airport
]]--


--[[
0 solid
1 tree
2 house
3 damages player

5 auto tiles
6 connects with tiles

]]--

if(debug)mute=true
if(mute)poke(0x5f2f,1)

function _init()
 music(0,3)
-- pal(dark)
 swap_pal()
 pal(dark,1)
 odos={
 	{digits=3},
 	{digits=2},
 	{digits=4}
 } 
 frame=0
	cartdata("base_1")
	title_seed=rnd()
 if debug then
 state(lose_upd,win_drw)
-- 	new_game()
 else
--  mh=31
  new_game(title_seed)
--  upd=title_upd
--  drw=title_drw
--  nupd=title_upd
--  ndrw=title_drw  
 	state(title_upd,title_drw)
-- 	p.x=128
-- 	p.y=128
-- 	mh=63
	 obj_init(63.5,63.5,0,model_rotate,model_draw)	 
	end	
		
	menuitem(1,"invert y-axis",function()yaxis=-yaxis end)
	menuitem(2,"mute",function()mute=not mute poke(0x5f2f,mute and 1 or 0)end)
	menuitem(3,"engine hold",function()eng_tog=not eng_tog end)	
	menuitem(4,"toggle flash",function()flash=not flash end)	
	menuitem(5,"return to title",function()state(title_upd,title_drw)frame=0end)	
end

function new_game(see)
-- mh=63
 map_open=false
	explored={}
	for i=0,world do
	 explored[i]={}
	end

 seed=see or rnd()
-- if(debug)seed=0
	tut={
--		{"",4,5},
		{"🅾️(z/c) toggle on engine",4,0},
		{"⬆️(up key) to pitch",2,50},
		{"⬅️(left) to turn",0,40},
		{"➡️(right) to turn",1,40},
		{"⬇️(down) to pitch",3,20},
		{"❎(x) to drop mail",5,0},
		{"enter to open map",6,0},
		{"enter to close map",6,0},
	}
	if(debug)tut={}
	tut_t=0

	qx,qy=0,0
	menu_i=1
	
	hx=world/2\1
	hy=world/2\1
	mx=hx
	my=hy
	clients={}
	clients_tot=0
	clients_cur=0
	
	for ox=0,world-1do
	 clients[ox]={}
	 for oy=0,world-1do
	  srand(seed+ox+oy*world)
	  local r=rnd()
   local s=land_type(r)+16
   local n=0
   if(land_type(r)>=2)n=rnd(3)\1+4
   clients[ox][oy]=n 
   clients_tot+=n
--   if ox==hx and oy==hy then
--    s=21
--   end
	  mset(ox+96,oy,s)
	  if(s==19)mx=ox my=oy
	 end
	end
--	clients_tot=1
	mset(mx+96,my,19)
	--world wonders
--	local i=0
--	repeat
--	 local x,y=rnd(world),rnd(world)
--	 if(mget(x,y)==0)mset(x+96,y+world,i+160)i+=1
--	until i>6
	explored[mx][my]=true  
 
 objs={}
 upds={}
	map_y=130
	shake=0
	p=obj_init(0,0,60,player_update,model_draw,nil,1.5,1.0625,6/8)	
 fuel=100
 maxfuel=100
 cash=50
 item=15
 p.hp=3
 p.maxhp=3
 p.pal=pals[1]
 p.wing=0
-- p.quest=quests[1]
 p.s=112
 p.sy=6
	p.engine=true

	loopers={}
	local clouds={}
 if clouds_enabled then
	 for i=0,15do 
	  ::_::
	  local x,y=rnd(640),rnd(640)
	  for other in all(clouds)do
	   if dist_2d(other,vector(x,y))<100then
	    goto _
	   end
	  end
	  local typ=.8>rnd()
	  local cloud=obj_init(x,y,60,typ and storm_update or cloud_update,typ and storm_draw or cloud_draw) 
	  add(clouds,cloud)
	  local shadow=obj_init(x,y,10,nil,cloud_shadow,cloud)
	  add(loopers,cloud)
		 del(cloud,shadow)
		end
	end
	waves={}
 for i=0,15do
  add(waves,{x=0,y=0,t=rnd(6)})
 end	

	wakes={}
	state(game_upd,game_drw)
	init_map()
--	p=obj_init(hanger.x,hanger.y+28,0,player_update,plane_draw,nil,1,1)
 
-- for mx=0,10do
--  for my=0,10do
--   srand(seed+mx+my*11)
--   local r=rnd()
--   local s=r>.9and 48 or r>.7and 12 or 11
--   spr(s,mx*8,my*8)
--   
--  end
-- end
-- ::_::goto _

 
-- local ship=obj_init(p.x,p.y,0,model_rotate,model_draw,nil,.5,1,1.2)
-- ship.sy=17*8
-- ship.scale=1.5
-- p.w=12
-- p.h=8.5
 
 obj_init(0,0,-10,nil,plane_shadow).parent=p
	hanger_init(false)
	
end

function init_overworld()
	for ox=0,world-1do
	 for oy=0,world-1do
	  srand(seed+ox+oy*world)
	  local r=rnd()
   local s=land_type(r)+16
   local n=0
   if(land_type(r)>=2)n=rnd(3)\1+4
	  mset(ox+96,oy,s)
	 end
	end
end

function gen_islands()
		for i=0,15do
			local a,r=rnd(),rnd(8)+3
			local l=rnd(32)-r
			circfill(cos(a)*l+31.5,sin(a)*l+31.5,r,1)
		end
		for i=0,999do
		 local x,y=rnd(mw),rnd(mh)
			for e=0,.9,1/4do
				if(pget(x+cos(e),y+sin(e))==0)circfill(x,y,1,0)
			end
		end
end

function init_map()
--	local cost=stat(1)
 name_t=100
 del_obj(houses)
 del_obj(hanger)
 del_obj(body)
 houses={}
 del_obj(hanger)
 srand(seed+mx+my*world)
 map_type=land_type(rnd())
 if map_type>=2then
  customers=rnd(3)\1+4
 end
-- if mx==hx and my==hy then
--  name="old home"
--  reload(0x1000,0x1000,8192)
--  return
-- end
 local isle=rnd(isle_type)
 local desc=rnd(isle_desc)
	if map_type<=0then
	 isle=rnd(sea_type)
  desc=rnd(sea_desc)
	end
 order=rnd(4)\1
 if order==1 then
  name=isle.." of "..desc
 elseif order==2 then
  name="the "..desc.." "..isle
 elseif order==3 then
  name="the "..isle.." of "..desc
 else
  name=desc.." "..isle
 end
	rectfill(0,0,mw,mh,0)
 if(map_type>=1)gen_islands()
 
 for x=0,mw do
		for y=0,mh do
		 mset(x,y,pget(x,y)==1 and 48)
		end
	end
 if(map_type>=1)then
		if map_type>=3then
			for y=0,767,128do
				memcpy(11544+y,112+8192+y,16)
			end
			hanger=obj_init(36*8,35*8+8,0,nil,nil,nil,.2,.2,.2)
		 body=obj_init(36*8,35*8+8,5,nil,nil,nil,1,1.5,.2)
   
--			hanger.w=2
--			hanger.h=3
			body.s=14
--			quest={}
--			for i=0,3do
--			 add(quests,rnd(quest_types))
--			end
		end
		--auto tile
		local dx,dy={-1,1,0,0},{0,0,-1,1}
		
		for x=0,mw do
		 for y=0,mh do
			 if mget(x,y)==48 then
			  local sig=0 
			  for i=1,4 do
      sig=sig|
			   (fget(mget(x+dx[i],y+dy[i]))&64>>6)<<8-i
			  end
			  mset(x,y,sig/16+48)		  
			 end
	  end
	 end

		local placed=0
  if map_type>=2then
--   local n=0
  	repeat
			 local x,y=rnd(mw)\1,rnd(mh)\1
			 if mget(x,y)==63then
			  local m=36+rnd(6)
			  mset(x,y,m)
				 local house=obj_init(x*8+4+64,y*8+4+64,9)
--				 house.s=112
				 house.s=placed<clients[mx][my] and 112 or 4
				 placed+=1
				 add(houses,house)
			 end
--    n+=1
			until placed>=customers
  end
	end	 
	if(map_type>=1)then
	 --trees
	 local trees={}
		for i=0,900do
		 local x,y=rnd(mw),rnd(mh)
		 if mget(x,y)==63then
		  local m=rnd()>.8 and 22 or 32+rnd(4)
		  if(m==22)add(trees,{x=x,y=y})
		  mset(x,y,m)
		 end
		end
		--forrests
		for i=0,200do
  	local tree=rnd(trees)
  	local a=rnd()
  	local x,y=tree.x+cos(a),tree.y+sin(a)
			if mget(x,y)==63then
			 mset(x,y,rnd(3)+22)
			 add(trees,{x=x,y=y})
			end
		end
 end
-- printh("map_cost "..stat(1)-cost)
end

function init_wake(obj)
 add(loopers,add(wakes,{x=obj.x,y=obj.y,t=0}))
end

function obj_init(x,y,z,upd,drw,parent,w,h,d)
 local obj=add(objs,{
 	x=x or 0,
 	y=y or 0,
 	z=z or 0,
 	w=w and w*8 or 4,
 	h=h and h*8 or 4,
 	d=d and d*8 or 4,	
 	upd=upd,
 	drw=drw or spr_draw,
 	spd=.125,
 	a=0,
 	v=0,
 	vz=0,
 	drag=.99,
 	fall=.9,
 	t=0,
 	parent=parent,
 })
 if(upd)add(upds,obj)
 add(parent,obj)
 return obj
end

--dead is for trails to keep parent but also not draw
function del_obj(obj)
 if(obj)obj.dead=true
 del(objs,obj)
 del(wakes,obj)
 del(loopers,obj)
 del(upds,obj)
 for child in all(obj)do
  del_obj(child)
 end
end

function hanger_init(enter)
 if(not hanger)return--!!
  skin_upd()
  deafen()
  sfx(26)
 if enter then
 
  state(hanger_upd,hanger_drw)
  p.x=63.5
  p.y=24
  p.scale=1
  p.z=0
  p.hp=p.maxhp
  fuel=maxfuel
  item=15
  wakes={}
  p.t=0
  for trail in all(trails)do
   for pos in all(trail)do
    del_obj(pos)
   end
  end
  music(11,3)
 else
 	p.x=hanger.x
		p.y=hanger.y+15
-- 	p.x=0
--		p.y=128		
		p.engine=false
		p.a=0
		p.v=0
		p.z=0
		p.scale=.5
		music(0,3)
--		state(game_upd,game_drw)
--	sfx(11)
 end
end
-->8
--updates
function _update60()
 if nupd then
 	upd=nupd
 	drw=ndrw
 	if nupd==lose_upd or nupd==win_upd then
 	 cls()
 	end
 	nupd=nil
 end
-- if btnp(5,1) and debug then
--  end_check()
-- end
 odos[1].typ=fuel
 odos[2].typ=item
 odos[3].typ=cash
 foreach(odos,odometer_upd)
 wave=abs(cos(time()/4)*3\1)
 upd()
end

function title_upd()
 if btnp(❎) then
--  state(game_upd,game_drw)
  sfx(26)
  upd=game_upd
  drw=game_drw
--  new_game(title_seed)
 end
end

function game_upd()
 tut_update()
-- local cost=stat(1)--!!
 if not map_open then
		foreach(waves,wave_update) 
	 foreach(upds,function(o)o:upd()end)
 end
 
--	printh("upd "..stat(1)-cost)--!!
end

function tut_update()
 if(#tut<=0)return
			if btn(tut[1][2]) then
			 tut_t+=1			 
			end
			if tut_t>tut[1][3]then
			 deli(tut,1)
			 tut_t=0
			end
end

function lose_upd()
 if btnp(❎)then
--  state(title_upd,title_drw)
  sfx(24)
  new_game()
 end
end

function win_upd()
 if btnp(🅾️)then
--  state(title_upd,title_drw)
  sfx(24)
  new_game()
 end
 if btnp(❎)then
  state(game_upd,game_drw)
  sfx(24)
--  new_game()
  init_overworld()
  init_map()
 end 
end

trails={
	{ox=0,oy=10,oz=-1},
	{ox=0,oy=-10,oz=-1},
}

function map_check(dx,dy)
 local xcheck,ycheck=p.x<0 or p.x>640,p.y-p.z<0 or p.y-p.z>640
 local dx,dy=sgn(dx),sgn(dy)
 if xcheck or ycheck then
  if xcheck then
 	 mx=(mx+dx)%world
 	 p.x=p.x%638
 	 dy=0
  else
  	my=(my+dy)%world
  	p.y=(p.y-p.z)%638+p.z
  	dx=0
  end
  explored[mx][my]=true
  
	 for pos in all(loopers)do
		 pos.x-=640*dx
		 pos.y-=640*dy
	 end
	 init_map()
 end
end

function player_update(obj)
 --turning, angular velocity
 local av=0
 if(btn(⬅️))av+=0.01sfx(16)
 if(btn(➡️))av-=0.01sfx(16)
 obj.a+=av
 if fuel>0then
  if eng_tog then
  	if(btnp(🅾️))obj.engine=not obj.engine   
  else
  	obj.engine=btn(🅾️)
  end
 else
  obj.engine=false
 end
 
 local a=obj.a
 local dx,dy,dz=cos(a)*obj.v,sin(a)*obj.v,0
 if(btn(⬆️))dz+=1
 
 if(btn(⬇️))dz-=1

 if obj.v>1 or obj.engine then
  if(stat(16)!=9)sfx(9,3)
 	poke(0x34a5,max(2,16-obj.v*8))
  for x=0,7do
	  mset(x*4+65,obj.sy/8\1,mget(x+64,(frame*obj.v/4)%4+12))
	 end
 else
  sfx(9,-2)
--  sfx(9,-2)
 end
 if obj.engine then  
  obj.drag=.9+obj.z/60/20
  obj.v+=.1
  obj.fall=0
  obj.vz=-dz*obj.v/4 
	 fuel=max(fuel-0.01,0)
 else
  obj.fall=.92
  obj.drag=.99
 end
 obj.scale=min(.5+obj.z/120,1)
 if frame%4<1 and obj.hp<obj.maxhp 
-- and rnd()>obj.hp/obj.maxhp 
 then
  local smoke=obj_init(obj.x-cos(a),obj.y-sin(a)-2,obj.z,nil,smoke_draw)
	 smoke.a=rnd()
	 smoke.e=rnd(9)+5
	 add(loopers,smoke)
--	 printh(obj.hp)
	 if obj.hp==2then
	  smoke.c=8
--	  printh("a1")
	 else
	  smoke.c=0
--	  printh("a2")
	 end
--	 smoke.c=ceil(rnd(2))
--	 smoke.c=maxhp/hp*4
	end
	move(obj)
	map_check(dx,dy)
	local m=mget(p.x/8-8,p.y/8-8)
	if obj.z<10 and fget(m,3)then
	 damage(p)
	end
 if obj.v>.1 or av!=0 then
  local c=obj.z<2 and (m==0 and 1 or 8) or 12
	  for pos in all(trails)do	 
	   local x1,y1=pos.ox*obj.scale,pos.oy*obj.scale
				local x=x1*cos(a)-y1*sin(a)+obj.x
				local y=x1*sin(a)+y1*cos(a)+obj.y
			 local z=obj.z+pos.oz
				pos.x=x
				pos.y=y
				pos.z=z
    if frame%7==0then 
    	if obj.z<2 and m==0then
	    	init_wake(pos)
	    	cut_trail()
			 	else
			 	 local old=pos.last			 	
			 	 local new=obj_init(x,y,z,trail_update,trail_draw)
			 	 add(loopers,new)
			 	 new.parent=pos
			 	 pos.last=new
			 	 new.c=c
	     if(old)old.parent=new
		 	end
	  end
	 end
	elseif frame%7==0 or not obj.engine then
	 cut_trail()
 end
  
 if hanger and collide(obj,hanger) then
 	hanger_init(true)
 end
 if btnp(❎) then
  sfx(23)
 	drop_item(obj)
 end
 p.t=max(p.t-1,0)
end

function model_rotate(obj)
 obj.a+=0.001
end

function move(obj) 
	obj.z=mid(0,obj.z-obj.vz,60)
	obj.vz*=obj.fall
	if obj.z==0then
	 if obj.vz>1 and obj==p then
		 obj.vz=0
		 damage()
	 end
	else
	 obj.vz+=gravity
	end	
 obj.x+=cos(obj.a)*obj.v
 obj.y+=sin(obj.a)*obj.v
 obj.v*=obj.drag
end

function item_fall(obj)
 move(obj)
 if obj.z<=0then
  obj.v=0
  explosion(obj)
  sfx(22)
  if mget(obj.x/8-8,obj.y/8-8)==0then
   del_obj(obj)
   init_wake(obj)
  else
	  obj.upd=blink_out
	  local min_d,near=99
	  for house in all(houses)do
		  local dist=dist_2d(house,obj)
				if dist<min_d and house.s==p.s then
				 near=house
				 min_d=dist
				end
	 	end
	 	if min_d<27 then
	 	 local n=min_d/9
		  near.s=ceil(n)
		  sfx(17+n)
		  local n=(min_d<9 and 20 or min_d<18 and 10 or 5)
		  cash+=n
	   local floater=obj_init(obj.x,obj.y,2,nil,floater)
		  floater.txt="$"..n
		  clients_cur+=1
		  clients[mx][my]-=1
		  end_check()
		 end
		end
 end
end

function blink_out(obj)
 obj.t+=.1
 if obj.t>10then
  del_obj(obj)
 end
end

function cut_trail()
	for pos in all(trails)do
	 if(pos.last)pos.last.parent=nil
	 pos.last=nil
	end
end


function hanger_upd()
--	menu={
----	 {
----	  fuel\1,buy_fuel,"fuel"
----	 },
--	 {
--	  p.pal[1],change_pal,"palette"
--	 },
--	 {
--	  p.sy==6 and "biplane" or "monoplane",function()p.sy=p.sy==6 and 38 or 6end,"body"
--	 },
--	 {
--	  d,"wing"
----		 for y=0,7do
----		  poke4(40+(y+1)%8*64,peek4(44+y*64))
----		 end
--	 }
--	}
 model_rotate(p)
 if btnp(❎)then
  sfx(26)
  hanger_init(false)
  state(game_upd,game_drw)
 end

 if(btnp(🅾️))then
  
  local on=menu[menu_i]
  local oth=on.arr[on.i]
  local price=oth[2]
  if price>0then
   if price<=cash then
    cash-=price
    oth[2]=0
    sfx(17)
   else
    sfx(20)
   end
  else
   on.cur=oth
   sfx(18)
  end
 end
 if(btnp(➡️))browse(1)sfx(24)
 if(btnp(⬅️))browse(-1)sfx(25)
 if(btnp(⬇️))sfx(24)menu_i=menu_i%#menu+1
 if(btnp(⬆️))sfx(25)menu_i=(menu_i-2)%#menu+1
end

function skin_upd()
 for i,opt in ipairs(menu)do
-- 	local opt=opt.func
 	opt.func(opt.cur,opt.i)
 end
end

function browse(n)
 local ui=menu[menu_i]
	local func=ui.func
	ui.i=(ui.i+n-1)%#ui.arr+1
	func(ui.arr[ui.i],ui.i)
end

function wave_update(obj)
 obj.t+=.05
 if(obj.t>7)then 
	 obj.x=rnd(128)
	 obj.y=rnd(128)
	 obj.t=0
 end
end

function cloud_update(obj)
--	obj.x=(obj.x+.1+138)%788-138	
	obj.x+=.1
	if obj.x>768then
--	 printh("looped")
  repeat
   ::_::
	  obj.x=rnd(640)
	  obj.y=rnd(640)
	  for other in all(clouds)do
	   if dist_2d(other,obj)<100then
	    goto _
	   end
	  end
	 until dist_2d(obj,p)>128
	end
	if dist_3d(obj,p)<20 and obj.t<=0then
	 explosion(p)
	 obj.t=40
	 sfx(10)
	end
	obj.t-=1
end

function storm_update(obj)
 cloud_update(obj)
	if rnd()>.99 and dist_2d(obj,p)<100 and not map_open then
  sfx(15)
  obj.t=10
  obj.bolt={}
  local x,y=obj.x,obj.y-obj.z
 	for i=0,obj.z,10 do
 	 add(obj.bolt,{x=x,y=y+i})
 	 x+=sin(rnd())*8
 	end
 	local hit=obj.bolt[#obj.bolt]
  explosion(hit)
 	init_wake(hit)
 	if p.z<obj.z and dist_2d(obj,p)<15then
 	 damage()
 	end
 end 
end

function trail_update(obj)
 obj.t+=1
end
-->8
--draws
function _draw()
 local cost=stat(1)--!!
 
 drw()
 if btnp(4,1)then
  deafen()
  sfx(23)
  if(flash)cls(12)
  wait(10)
  fadedown(grayscale)
  drw()
  wait(20)
	 fadeup(grayscale)
	 if(not debug)extcmd("screen")
	 wait(100)
	elseif drw==game_drw then
	 ui_draw()
 end
 if ndrw and not nupd and not debug then
-- wait(10)
 	fadeup(fade)
  ndrw=nil
 end
 rpal()
  frame+=1
-- ?stat(0),0,0,12
end

function title_drw()

-- local x,y=63.5,61.5
-- local l=18
--  rectfill(x-l,y-l,x+l,y+l,5)
--  for i=0,4do
--	  fillp((i%4==0 and ▒ or █))
--	  rect(x-l,y-l,x+l,y+l,12)
--	  l+=1
--	 end
-- fillp(▒)
-- rect(x-l,y-l,x+l,y+l,3)
 
-- l+=1
-- rect(x-l,y-l,x+l,y+l,3)
-- l+=1
-- fillp(▒)
-- rect(x-l,y-l,x+l,y+l,3)
 cls()
 local timer=frame-99
 

 local cy=lerp(0,90,min(1,timer/99))
 clip(0,(128-cy)/2,128,cy)
 
	game_drw()	

	camera()
--	fillp(32767.8)
--	rectfill(0,0,127,127,0)
	clip()
	lvl_txt(0,timer)
 local cost=stat(1)--!!
 fillp()
--	for i=0,7do
--	 rspr(32*i+512+12,8.5+6,12,63,63-i,t()/8,1)
--	end 
-- local y=lerp(
-- local n=frame-30
 timer-=30
 local ax=lerp(-56,38,min(1,(timer)/40))
 local bx=lerp(132,38,min(1,(timer)/40))
 local ay=lerp(140,90+sin(t())*2,min(1,timer/10))
 outline(function()
 cprint("❎ start",ay,timer/16\1%2<1 and 12 or 9)
 print("code by munro",ax,112,9)
 print("music by john",bx,120,9)
-- cprint("code by munro",112,9)
-- cprint("music by john",120,9)
 end)

end

function game_drw()

 sort(objs)
 rectfill(0,0,127,127,5)
 
 cx=p.x-64
 cy=p.y-64-p.z
 if shake>0then
  local a=rnd()
  cx+=cos(a)*shake
  cy+=sin(a)*shake
  shake-=1  
 end
 foreach(waves,wave_draw) 
 camera(cx,cy)
-- rect(0,0,640,640,6)
 local mx,my=cx/8\1,cy/8\1
 local cost=stat(1)--!!
 foreach(wakes,wake_draw)
 
	map(0,0,64,64,64,64)
--	map(cx/8,cy/8,cx+cx%8,cy+cy%8,17,17)
	
--	printh("map_drw "..stat(1)-cost)--!!
 local cost=stat(1)--!!
 foreach(objs,
 function(o)
	 o:drw()
 end)

-- printh("objs_drw "..stat(1)-cost)--!!
 local cost=stat(1)

 foreach(ui,function(o)o:drw()end)
-- printh("ui_drw "..stat(1)-cost)--!!
end

function lose_drw()
 local fire={
  [14]=10,
  [10]=6,
  [6]=2,
  [3]=0
 }
-- cls(15)
 line(0,127,127,127,14)
 for i=0,999do
  local x,y=rnd(128),rnd(128)
  local c=pget(x,y)
  local c= fire[c] and c or 0
  local c=rnd()>.3 and c or fire[c]
  circfill(x,y-2,1,c)
--  abs(pget(x,y)-1)
--  )
 end
 lvl_txt(2)
 outline(function()
  cprint("❎ restart",70+sin(t())*1.9,t()*2\1%2<1 and 9 or 12)
--  cprint("❎ ret",70,12)
 end)
end

function win_drw()
-- cls(15)
 srand(t())
 for i=0,500do
  local x,y=rnd(128),rnd(128)
  circfill(x,y,1,15)
--  circfill(x,y,1,pget(x,y))
 end
 srand(seed)
 for i=0,99do
  local x,y=rnd(128)+sin(t()+rnd())*rnd(4),(rnd(128)+t()*(rnd(16)+16))%136-8
  spr(111,x,y)
 end
-- model_drw
 lvl_txt(4)
 outline(function()
  cprint("🅾️ new world",70,12)
  cprint("❎ keep playing",80,12)
 end)
end

function lvl_txt(y,delay)
 local delay=delay or frame
	outline(function()
  for x=0,7do
   local sy=lerp(-50,24,min(1,(delay-x*8)/30))
   map(x+112,y+9,x*12+18,sy+sin(-t()+x/8)*4,1,2)
  end
	end)
end

function trail_draw(obj)
 local par=obj.parent
-- if(par and not par.dead)line(obj.x,obj.y-obj.z,par.x,par.y-par.z,obj.t>100 and 9 or 12)
 if(par and not par.dead)line(obj.x,obj.y-obj.z,par.x,par.y-par.z,obj.c)
-- if(par and dist_2d(par,obj)>400)printh("test"..(par==trails[2] and 1 or 0))
 if(obj.t>200 or not par)del_obj(obj)
 obj.t+=1
end

function model_draw(obj)
 local w=max(obj.w,obj.h)
--  flip()
-- if pget(obj.x,obj.y)==7then
-- 
--  explosion()
-- end
 if obj.pal then
 	for i=1,4do	 
		 pal(pal_base[i],obj.pal[i+2])
		end	
 end
-- printh(obj==h)
 if obj.t/8\1%2==0and obj==p then
 	for i=0,obj.d-1 do
		 rspr(obj.w+(obj.w*2+8)*i+512,obj.h+obj.sy,w,obj.x,obj.y-i-obj.z,obj.a,obj.scale)
		end
 end
end

function plane_shadow(obj)
 local par=obj.parent
 obj.y=par.y
 poke(0x5f5e,12)
 rspr(12+512+352,8.5+8,12,par.x,par.y,par.a,.5-par.z/999)
 poke(0x5f5e,255)
end

function spr_draw(obj)
 if obj.t\1%2==0 and obj.s then
  local x,y=obj.x,obj.y-obj.z
  if obj.parent then
	  local par=obj.parent
	  x,y=par.x,par.y
	  poke(0x5f5e,12)
	 end
 	spr(obj.s,obj.x-obj.w,obj.y-obj.z-obj.h,obj.w/4,obj.h/4)
  poke(0x5f5e,255)
  if(obj.parent)rpal()
 end
 box(obj)
end

function cloud_draw(obj)
 local x,y=obj.x,obj.y-obj.z
 ovalfill(x-30,y-10,x+30,y+10,12)
-- cloud(obj.x,obj.y-obj.z,obj,12)
-- obj.x=(obj.x+.1+128)%768-128
-- camera()
-- pset(obj.x/8,obj.y/8,12)
-- camera(cx,cy)
-- obj.x+=.1
end

function cloud_shadow(obj)
 local par=obj.parent
 poke(0x5f5e,12)
 local x,y=par.x,par.y
 ovalfill(x-30,y-10,x+30,y+10,12)
-- cloud(par.x,par.y,obj,1)
 poke(0x5f5e,255)
end

function cloud(x,y,obj,c)
	local x,y=x,y
	ovalfill(x-30,y-10,x+30,y+10,c)
end

function particle_draw(obj)
 circfill(obj.x,obj.y-obj.z,obj.t,obj.t>4 and 12 or 9)
 if(obj.t<0)del_obj(obj)
 obj.t-=.2
 obj.x+=cos(obj.a)*obj.spd
 obj.y+=sin(obj.a)*obj.spd
end

function explosion(obj)
 for i=0,10do
  local parti=obj_init(obj.x,obj.y,obj.z,nil,particle_draw)
  parti.spd=rnd(.5)+.5
 	parti.a=rnd()
 	parti.t=7
 end
end

function storm_draw(obj)
 
 --!!
 local c=obj.t>4 and 12 or obj.t>0 and 9 or 0
 if obj.t>0 then
  color(c)
  line()
  for seg in all(obj.bolt)do
   line(seg.x,seg.y)
  end
 	obj.t-=1
 else
  obj.bolt=nil 
 end
 cloud(obj.x,obj.y-obj.z,obj,c)
end

function ui_draw()
 camera()
 map_y=lerp(map_y,map_open and 0 or 150,.1)
 fillp(▒)
 circfill(63,map_y+128,128,0)
-- rectfill(0,map_y,127,map_y+127,0)
 fillp()
 spr(p.s,119,120)
 pal(6,({6,10,14,11,7})[ceil(fuel/20)])
 spr(79,13,120)
 outline(function()
  if drw!=game_drw or map_open then
	 ?"$",2,2,7
	 odometer_draw(3,6,2)
  end
	 odometer_draw(1,2,121,12)	 
	 odometer_draw(2,112,121,12)
  cprint(name,min(name_t,2),12)	 
 end)
 name_t-=1
 if(drw!=game_drw)return
 if(btn(6) or btnp(4,1)) then
  if not btn(5) then
	  poke(0x5f30,1)
	 	map_open=not map_open
	 end
	 deafen()
	 if(map_open)then
	  sfx(8)
	 else
	  sfx(20)
--	  sfx(11)
	 end
	 
	 upd=map_open and map_upd or game_upd
 end

 	local x,y=35,map_y+36
-- 	fillp(23130.1)
 	fillp(▒)
  rectfill(x-2,y-2,x+world*8+1,y+world*8+1,15)
	 fillp()
	 rectfill(x-1,y-1,x+world*8,y+world*8,15)
  map(96,0,x,y,world,world)
  outline(function()
		cprint(clients_cur.."/"..clients_tot,map_y+104,12)
		cprint("mail deliveries",map_y+112,12)
  end)
  for ox=0,world-1 do
   for oy=0,world-1 do
    local rx,ry=x+ox*8,oy*8+y
    if not explored[ox][oy] then
	    rectfill(rx,ry,rx+7,ry+7,15)
	    if mget(ox+96,oy)!=16 then
	     ?"?",rx+2,ry+1,4
	    end
	   elseif clients[ox][oy]>0 and frame/16\1%2==0then
	    outline(function()
	     ?clients[ox][oy],rx+2,ry+1,9
	    end)
    end
   end
  end
--  fillp(▒)
--  local qx,qy=x+qx*8,y+qy*8
--  rect(qx,qy,qx+7,qy+7,6) 
--  fillp()
 local x,y=mx*8+x+p.x/576*8,my*8+y+p.y/576*8
 circfill(x,y,1,0)
 pset(x,y,12)
 tut_draw()
--  lvl_txt(0,24)
--  ?"YOU",x,y,6
--  circ(mx*8+x+p.x/576*8,my*8+y+p.y/576*7,1,0)
end

function wake_draw(obj)
 if(obj.t>3)fillp(▒)
 if(obj.t>6)fillp(░)
 if(obj.t>10)fillp(0xfbfe.8)
 circfill(obj.x,obj.y,obj.t,obj.t>6 and 9 or 12)
 obj.t+=.2
 if obj.t>15 then
  del_obj(obj)
 end
 fillp()
end

function smoke_draw(obj)
 circfill(obj.x,obj.y-obj.z,obj.t+1,fire[obj.c])
 obj.t+=.2
 obj.z+=.5
 obj.x+=cos(obj.a)/8
 obj.y+=sin(obj.a)/8
 if(rnd()>.8)obj.c=min(5,obj.c+1)
 if obj.t>obj.e then
  del_obj(obj)
 end 
end

function hanger_drw()
 camera()
 cls(5)
-- fillp(▒)
-- rectfill(0,0,127,127,4)
-- rectfill(0,0,127,127,4)
-- fillp()
 local y=24
 circfill(63.5,y+4,15,9)
 circfill(63.5,y,15,12)

 model_draw(p)
 local oy=2
 outline(function()
		 for i,option in ipairs(menu)do
		  local y=i*21+y+oy
		 	local txt=option.name
		  cprint(txt,y,15)
		  local item=option.arr[option.i]
		  local txt=item[1]
		  if(i==menu_i)txt="◀ "..txt.." ▶"
		  cprint(txt,y+6,menu_i==i and 12 or 9)	  
		  
		  	
    if item[2]>0 then
		   cprint("costs $"..item[2],y+12,6)
		  elseif option.cur==item then
		   cprint("current",y+12,7)
		  else
		   cprint("owned",y+12,3)
		  end 
		  
		 end
	 cprint("❎ leave hanger",120,12)
	 cprint("🅾️ choose",112,12)
 end)
 ui_draw()
end

function follow_par(obj)
 local par=obj.parent
 obj.x=par.x
 obj.y=par.y
end

function dirt_draw(obj)
 local c=obj.t>20 and 8 or 4
 circfill(obj.x,obj.y-obj.z,2-obj.t/50,8)
 obj.t+=1
-- obj.z+=rnd(.5)
 if(obj.t>90)del_obj(obj)
end

function floater(obj)
 obj.z+=1/8
 outline(function()
  print(obj.txt,obj.x-#obj.txt*2,obj.y-obj.z,12)
 end)
 if(obj.z>16)del_obj(obj)
end

function wave_draw(obj)
 spr(70+obj.t%7,(obj.x-cx)%128,(obj.y-cy)%128)
end

function tut_draw()
 if(#tut<=0)return
 outline(function()
	cprint(tut[1][1],96,12)
	end)
end

-->8
--mechanics
function drop_item(obj)
 if item>0then
  local drop=obj_init(obj.x,obj.y,obj.z-1,item_fall)
  obj_init(0,0,-1,follow_par,nil,drop).s=p.s
  drop.s=p.s
  drop.a=obj.a
  drop.v=obj.v
  item-=1
  sfx(21)
 end 
end

function damage()
 if p.t<1then
	 p.hp-=1
	 sfx(14)
	 p.t=60
	 explosion(p)
	 if p.hp<1 and not debug then
   end_check(false)
	 end
	 shake=10
 end
end

function end_check()
 local n=clients_tot-clients_cur
 if n==0 or p.hp==0 then
  win=n==0
  deafen()
  if win then
	  state(win_upd,win_drw)
	  sfx(13)
	 else 
		 state(lose_upd,lose_drw)
		 sfx(12)
		end
		reload(0,0,12287)
		swap_pal()
		rpal()
		music(-1)
 end
end

--quests={
--	{"deliver mail",2},
--	{"find lost ship",1},
--	{"explore area",1},
--	{"transport",3},
--	{"passenger",3},
--	{"demine area",0},	
--	{"destroy pirate",1},
--}
--quest_descs={
 
	
--}

--quest_i=1

function change_pal(n)
-- pal_i=(pal_i+n-1)%#pals+1
 p.pal=n
end

function change_wing(n,n2)
--	 printh(n[1])
 	local wing=n2
	   for x=0,7do
	    for y=0,7do
	     sset(x+48,y+40,sget(x+wing*8+32,y+56))
	    end
	   end
	   local dark={
	    [2]=2,
	    [6]=2,
	    [14]=10,
	    [10]=10
	   }
	   for x=0,7do
	    for y=0,7do
	     sset(x+40,y+40,dark[sget(x+wing*8+32,y+56)])
	    end
	   end
end

function change_body(n,n2)
-- printh(n2)
	p.sy=n[3]
end

--function change_quest(n)
-- quest_i=(quest_i+n-1)%#quests+1
-- local quest=quests[quest_i]
-- p.quest=quests[quest_i]
-- p.s=quest_i+111
-- local l=1
-- repeat
-- 	qx=rnd(11)\1
--		qy=rnd(11)\1
--		m=mget(qx+96,qy)
-- until m-16==quest[2] and (qx!=mx or qy!=my)
---- repeat
----  local a=rnd()
----  for i=0,1,l/8do
----	  qx=round(mx+sgn(cos(a))*l)%11
----		 qy=round(my+sgn(sin(a))*l)%11
----		 m=mget(qx,qy)
----		 if(m==quest[2])return
----	 end
---- until m==quest[2]
--end

function buy_fuel(n)
 if n>0 then
  local n=min(100-fuel,min(cash,10))
	 fuel+=n
	 cash-=n\1
 else
 	local n=min(fuel,10)
  fuel-=n
  cash+=n\1
 end
end

function tutorial()
	 if(#tut>0)then
	--	 printh(tut[1][2])
		 outline(function()
		 cprint(tut[1][1],96,12)
			end)

		end
end
-->8
--ai/pathfinding

-->8
--particles/palettes

pal_base={6,2,14,10}
pals={
	{"red",0,6,2,14,10},
	{"blue",30,5,1,14,10},
	{"green",30,11,3,14,10},
	{"yellow",30,14,10,6,2},
		
	{"postman",50,12,9,5,1},
	{"curtis",50,1,0,14,10},
	{"rosso",50,6,2,12,11},
	{"beach",50,15,8,5,1},

	{"bare",5,8,4,8,4},
	{"red baron",80,6,2,4,0},
	{"midnight",100,0,0,12,9},
}

wings={
	{"line",0},
	{"double line",20},
	{"triple line",20},
	{"check center",20},
	{"cheker edge",20},
	{"checkboard",20},
	{"dots",30},
	{"roundel",50},
	{"tricolor",50},
	{"cross",50},
	{"cross potent",50},
}

bodies={
	{"biplane",0,6},
	{"monoplane",200,38}
}
wing=0



isle_type=split("bay,beach,land,warf,port,isle,isles,island,bay,bight,cove,inlet,fjord,archipelago,peninsula,enclave,islet,atoll,haven,refuge,retreat,sanctuary,shelter,skerry,reef,key,chain,holm,cay,ait")
isle_desc=split("rock,stone,emerald,ruby,jade,iron,sheep,pig,goat,grass,forrest,wood,flowers,stone,man,wolf,grey,blue,eden,red,green,gold,silver,renewal,old,young,howling,dragon,adriano,adriatic,air,fire,earth,water,gaea,paradise,sandy,seal,fish,shark,starfish,utopia,wind")
port_type=split("harbor,port,haven,dock,pier,marina,yard,anchorage,slipway,wharf,mooring,field,station,strip,aerodome")
sea_desc=split("salty,pale,deep,watery,cold,wavy,coral,red,sky,cerulean,navy,azure,yellow,high,low,blue,white,black")
sea_type=split("ocean,sea,marine,gulf,strait,channel,passage,brine,seaway,sink,puddle,pond")
--natu_desc=split("crusoe,gilligan,unknown")
ruin_desc=split("unknown,danger,ruin,watchful,baleful,wandering,forgotten,lost,fathom,forsaken,fog,damned,storm,myst,mystery,outcast,shadow,skeleton,skull,treasure,uncharted")
--sheep,iron,grass,trees,wood,flowers,stone,man,wolf,death,life,grey,blue,red,green,beast,wealth,ruin,old,young,naked,clothed,howling,watchful,wandering,forgotten,molten,lost,unfathomed")

pal_i=1

 menu={
  {
  	name="color",
  	arr=pals,
  	func=change_pal,
  	i=1,
  	cur=pals[1]
  },
  {
	  name="wing",
	  arr=wings,
	  func=change_wing,
	  i=1,
	  cur=wings[1]
  },
  {
  	name="body",
  	arr=bodies,
  	func=change_body,
  	i=1,
  	cur=bodies[1]
  }
 
 }


--data/saving
--function load_data()
-- if dget(0)!=0 then
--  
-- else
--  init_data()
-- end
--end
--
--function save_data()
-- dset(0,t)
--end
--
--function init_data()
-- dset(0,1)
--end
--
-- if clear_save then
--  for i=0,63do
--   dset(i,0)
--  end
-- end

--function plane_draw(obj)
-- local cost=stat(1)--!!
-- model_draw(obj)
-- for i=0,7do
----	 rspr(7.5+32*i+512,7.5,9,9,obj.x,obj.y-i*z-obj.z,obj.a,obj.scale)
--	 if(i!=1)then
--		 for i=1,4do 
--		 	pal(pal_base[i],pals[pal_i][i+1] or pal_base[i])
--		 end
--		else
--	 	pal(6,pals[pal_i][3] or pal_base[2]) pal(14,pals[pal_i][5] or pal_base[4])
--  end
----  local l=13*obj.scale
----  rect(obj.x-l,obj.y-l,obj.x+l,obj.y+l,9) 	 
----	 rspr(12+32*i+512,8.5+6,12,12,obj.x,obj.y-i-obj.z,obj.a,obj.scale)
----  rpal()s
----  circ(obj.x,obj.y,8,8)
--	end
--	box(obj)--!!
-- rpal()
-- printh("plane_drw "..stat(1)-cost)--!!
--end

-- if frame%8==0 then
-- for y=0,7do
--
----  local l=peek(40+(y+1)%8*64)
--  poke4(40+(y+1)%8*64,peek4(44+y*64))
----  n=l
----  n=peek(44+y*64)
----  n=l
-- end
-- for y=0,7do
--  poke4(44+y*64,peek4(40+y*64))
-- end
-- end
-->8
--helper
dirx,
diry
=
split("-1,1,0,0,1,1,-1,-1"),
split("0,0,-1,1,-1,1,1,-1")
dirx[0]=0
diry[0]=0

dark=split("0,0,0,0,0,0,0,0,0,0,0,0,0,0,0")
--dark=split("-16,-16,-16,-16,-16,-16,-16,-16,-16,-16,-16,-16,-16,-16,-16,-16")
function empty()end

--effects
function outline(func,c)
 local camx,camy=peek(0x5f28)+peek(0x5f29)*256,peek(0x5f2a)+peek(0x5f2b)*256
 pal(dark)
 for i=8,0,-1 do
  camera(camx+dirx[i],camy+diry[i])
  if(i==0)rpal()
  func(i)
 end
end

function cprint(txt,y,c)
 local wid=string_width(txt)
 print(txt,64-wid*2,y,c)
end

function string_width(txt)
 local ws=0
 txt=tostr(txt)
 for i=1,#txt do
  ws+=1
  if ord(sub(txt,i,i))>128 then
   ws+=1
  end
 end
 return ws
end

function rpal()
-- poke(0x5f2e,1)
 palt()
 pal()
 pal(cur_pal,1)
end

function swap_pal()--!!
	cls()
	local pal_new={}
	local i=0
 for y=0,3do
	 for x=0,3do
	  pal_new[sget(x*2,y*2)]=i
	  i+=1
	 end
	end
	for x=0,127do
		for y=0,127do
		 sset(x,y,pal_new[sget(x,y)])
		end
	end
--	memcpy(0,0x6000,8192)
--	rpal()
	
end

--movement
function lerp(a,b,v)
 if abs(a-b)<.1 then
  return b
 end
 return a+(b-a)*v
end

function fmget(x,y,f)
 return fget(mget(x,y),f)
end

function round(x)
 return flr(x + .5)
end


gaps={701,301,132,57,23,10,4,1}
function sort(a)
-- cost=stat(1)
    for gap in all(gaps) do
        for i=gap+1,#a do
            local x=a[i]
            local j=i-gap
            while j>=1 and         
            a[j].y+a[j].z>x.y+x.z do
                a[j+gap]=a[j]
                j-=gap
            end
            a[j+gap]=x
        end
    end
--  if not first then
--   printh(stat(1)-cost)
--   ::_::flip()goto _
--  end
end

function contains(array,a)
 for i=1,#array do
  if array[i]==a then
   return i
  end
 end
end

function state(nupdf,ndrwf)
 camera()
-- if(not debug and ndrw!=title_drw)stamp_cls()
--	upd=nupdf
-- drw=ndrwf
 nupd=nupdf
 ndrw=ndrwf
 if(not debug and frame!=0)fadedown(fade)

-- ndrwf()
-- wait(5)
-- for y=0,127,4do
----  for y=0,127do
----   pset(x,y)
----  end
--  rectfill(0,y,127,y+4,0)
--  flip()
-- end
-- nupd()
-- fameskip=true
-- _update60()
-- if not debug then
--		drw()
--		_draw()
--		stamp_cls(ndrw)
--		flip()	
--	end
end

--function stamp_cls(draw)
-- if(true)return
-- for i=0,9do
--  x=rnd(64)\1*2y=rnd(64)\1*2
--	 rectfill(x,y,x+10,y+12,8)
--	 fillp(▒)
--	 rect(x-1,y-1,x+11,y+13,6)
--	 fillp()
--	 rect(x,y,x+10,y+12,6)
--	 flip()
-- end
--end

function dist_2d(a,b)
 local dx=(a.x-b.x)/64
 local dy=(a.y-b.y)/64
 local dsq=dx*dx+dy*dy
 if(dsq<0) return 32767.99999
 return sqrt(dsq)*64
end

--math
function dist_3d(a,b)
 local dx=(a.x-b.x)/64
 local dy=(a.y-b.y)/64
 local dz=(a.z-b.z)/64
 local dsq=dx*dx+dy*dy+dz*dz
 if(dsq<0) return 32767.99999
 return sqrt(dsq)*64
end

function rspr(sx,sy,w,dx,dy,a,scale)
--[[
sx,sy,dx,dy are center
]]
 local c,s=cos(a)/8,sin(a)/8
 
 local sx1,sx2=dx-w*scale,dx+w*scale
 local mx,my=s*w+sx/8,c*w+sy/8
 local mdx,mdy=-s/scale,-c/scale

 for i=-w,w,1/scale do
  tline
  (
  sx1,dy+i*scale,
  sx2,dy+i*scale,
  mx+c*i,
  my-s*i,
  mdx,mdy
  )
 end
end

function sign(n)
	return n==0 and 0 or sgn(n)
end

function pad(str,n)
 for i=1,n-#tostr(str) do
  str="0"..str
 end
 return str
end

function odometer_upd(odo)
 local val =odo.typ
 if odo.val and abs(val-odo.val)>.96 then
  val=sgn(val-odo.n)/6*abs(val-odo.val)+odo.val
 end
 if(val!=odo.n)odo.n=flr(val)
 odo.val=val
end

function odometer_draw(n,x,y)
 local odo=odos[n]
 if(not odo.val)return
 local val=odo.val
--	if(val!=odo.n)odo.n=flr(val)
	local d=sgn(odo.n-val)
 local cx = peek2(0x5f28)
 local cy = peek2(0x5f2a)
	clip(x-cx,y-cy,odo.digits*4,5)
	for i=1,odo.digits do
  local cur,nex=
  sub(pad(abs(odo.n),odo.digits),i,i),
  sub(pad(abs(odo.n-d),odo.digits),i,i)
  local o=cur!=nex and val%1*6*-d or 0
	 ?cur,i*4+x-4,o+y,12
	 ?nex,i*4+x-4,o+6*d+y,12
	end
	clip()
end
--[[
0 on fuel stopped incorrectly
get rewards for tricks
shadow not placed right
charcthers
clues to find treasure?
spy planes


photography
bombing
mail delivery
passangers
air drawing
barnstorming
weather reporting?
destroy target
dogfighting
exploration
tourist


lakes
castles
lighthouses
cities
ocean
unihabited lands
outposts
inland

]]--
grayscale={
{[0]=0,5,133,5,133,134,133,6,5,6,134,134,7,0,7,6},
{[0]=0,5,130,5,130,134,130,6,5,6,134,134,6,0,6,6},
{[0]=0,133,130,133,130,141,130,134,133,134,141,141,6,0,6,134},
{[0]=0,133,130,133,130,5,130,13,133,13,5,5,6,0,6,13},
{[0]=0,133,130,133,130,5,130,13,133,13,5,5,134,0,134,13},
{[0]=0,133,128,133,128,5,128,13,133,13,5,5,134,0,134,13},
{[0]=0,130,128,130,128,5,128,141,130,141,5,5,134,0,134,141},
{[0]=0,130,128,130,128,133,128,5,130,5,133,133,134,0,134,5},
{[0]=0,128,128,128,128,133,128,5,128,5,133,133,5,0,5,5},
{[0]=0,128,128,128,128,133,128,5,128,5,133,133,5,0,5,5},
{[0]=0,128,128,128,128,130,128,133,128,133,130,130,5,0,5,133},
{[0]=0,128,128,128,128,128,128,130,128,130,128,128,133,0,133,130},
{[0]=0,128,0,128,0,128,0,128,128,128,128,128,130,0,130,128},
{[0]=0,0,0,0,0,128,0,128,0,128,128,128,128,0,128,128},
{[0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
}

fade={
{[0]=128,140,2,3,132,12,8,11,4,6,9,139,7,128,10,15},
{[0]=128,140,2,3,132,12,8,139,4,6,9,139,6,128,10,143},
{[0]=128,140,2,3,132,12,136,139,132,134,9,3,6,128,138,143},
{[0]=128,140,130,131,130,140,136,139,132,13,4,3,6,128,138,134},
{[0]=128,131,130,131,130,140,136,139,132,13,4,3,134,128,138,134},
{[0]=128,131,130,131,130,140,136,3,132,13,4,3,134,128,4,134},
{[0]=128,1,130,131,128,140,132,3,132,141,4,3,134,128,4,134},
{[0]=0,1,130,129,128,131,132,3,132,5,132,131,134,0,4,5},
{[0]=0,1,128,129,128,131,132,3,130,5,132,129,5,0,132,5},
{[0]=0,129,128,129,128,131,130,129,128,5,132,129,5,0,132,5},
{[0]=0,129,128,129,128,1,128,129,128,133,128,129,5,0,133,133},
{[0]=0,129,128,129,128,129,128,129,128,130,128,129,133,0,128,133},
{[0]=0,129,128,0,0,129,128,0,128,128,128,0,130,0,128,128},
{[0]=0,0,0,0,0,129,128,0,0,128,128,0,128,0,128,128},
{[0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
}


function wait(n)
 for i=0,n do
  flip()
 end
end

function fadeup(fade)
--	drw()
--  wait(99)
 pal(fade[15],1)
 wait(5)
	for i=15,1,-1 do
	 pal(fade[i],1)
	 wait(1)
	 
	end
	cur_pal=defu_pal
end

function fadedown(fade)
	for i=1,15 do
	 pal(fade[i],1)
	 flip()
	end
	cur_pal=fade[15]
	printh("fade done")
end

--!!
function box(obj)
if(not obj.w or not debug)return
--rect(obj.x-obj.w,obj.y-obj.h,obj.x+obj.w,obj.y+obj.h,2)
--rect(obj.x-obj.w,obj.y-obj.h-obj.z+obj.d,obj.x+obj.w,obj.y+obj.h-obj.z+obj.d,6)
--rect(obj.x-obj.w,obj.y-obj.h-obj.z-obj.d,obj.x+obj.w,obj.y+obj.h-obj.z-obj.d,6)
end

function collide(a,b)
-- local aw,ah,ad,bw,bh,bd=a.w,a.h,
 return a.x-b.w<b.x+b.w and
     a.x+a.w>b.x-b.w and
     a.y-a.h<b.y+b.h and
     a.y+a.h>b.y-b.h and     
     a.z-a.d<b.z+b.d and
     a.z+a.d>b.d-b.d
end

function deafen()
	for i=0,3do
	 sfx(-1,i)
	end
end

weights={.9,.8,.6,0}
function land_type(n)
 for i,v in ipairs(weights)do
  if n>v then
   return #weights-i
  end
 end
end

function vector(x,y)
 return {x=x,y=y}
end
__gfx__
001122330dddddd00dddddd00dddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000005577dd00000
00112233dd7eeedddd7aaadddd7888dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000055447755dd000
55cc88eed7deededd7daadadd7d88d8d000000000000000000000000000000000000000000000000000000000000000000000000000000000554444775555dd0
55cc88eedeeeeeeddaaaaaadd888888d00000000000000000000000000000000000000000000000000000000000000000000000000000000544444477555555d
446699bbdedeededdaddddadd88dd88d00000000000000000000000000000000000000000000000000000000000000000000000000000000544445577dd5555d
446699bbdeedde3ddaaaaa9dd8d88d2d0000000000000000000000000000000000000000000000000000000000000000000000000000000054455447755dd55d
77ddaaffddeee3ddddaaa9dddd8882dd000000000000000000000000000000000000000000000000000000000000000000000000000000005554444775555ddd
77ddaaff0dddddd00dddddd00dddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000544444477555555d
ccccccccccbbbbcccbbbccccccccbbccccbbbbccccccccccbbbdbbbbbbbdbbbbbbdbbbbbbddddddddddddddddddddddd0000000000000000544445577dd5555d
ccccc1ccccbbbbbcc82bbccccbbb82bccb6dbbbcccccccccbbd3dbbbbbdedbbbbd3dbdbbdddddddddddddddddddddddd000000000000000054455447755dd55d
cccc1c1ccc33bb3cb76bbbccb42b76bcbbbbb6bcccbb82ccbbd3edbbbbdedbbbbd3ddedbddddddddd7777ddddddddddd00000000000000005554444775555ddd
ccccccccbccc33ccbbbb82bcb76bbbbcb6b6bdbccbbb76bcbd33edbbbdeeedbbd333dedbddd7777ddddddddddddddddd0000000000000000544444477555555d
ccccccccbbbbccccbbbb76bcbdddddbcbbbdbb3cc3bbbb3cbd3eeedbbdeeedbbd33deeeddddddddddddddddddddddddd0000000000000000544445577dd5555d
cc1ccccc3bb3cccc3b3bbbbc3bbbbb3c3bbb33cccc3333ccd33eeedbdeeeeedbbd5deeedddddddddd7777ddddddddddd000000000000000054455447755dd55d
c1c1ccccc33cccccc3c3333cc33333ccc333ccccccccccccbdeeeeedbdd4ddbbbbbbd4dbddd7777ddddddddddddddddd00000000000000005554444775555ddd
ccccccccccccccccccccccccccccccccccccccccccccccccbbdd4ddbbbbbbbbbbbbbbbbbdddddddddddddddddddddddd0000000000000000544444477555555d
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb2d2d2d2bbbbbbbbb2d2bbbbb2d2bbbbbb7b7b7bbdddddddddddddddd00000000544447700665555d
bb3bbbbbbbbb3b3bbbbbb3bbbbbbbbbb2d2d2d2b2d2d2d2b8282828bb2d2d2bb828d2dbb828d2d2b2626262bddd7777dd7777ddd00000000544770000006655d
b3bbbbbbbbbbb3bbbbbbbb3bbbbbbbbb8282828b8282828b7777777bb82828bb8282822b7772828b8686868bdddddddddddddddd00000000577000000000066d
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb8282828b8282828b7171717bb82828bb7772828b7172828b8282828bdddddddddddddddd000000007000000000000006
bbbbbbbbbbbbbbbbbbbbbbbbbbbabbbb7777777b7777777b7777777bb77777bb7777778b7777777b7777777bddd7777dd7777ddd000000007000000000000006
bbbb3b3bbb3bbbbbbb3bbbbbbbb3bbbb7171717b7171717b7171717bb71717bb7171717b7171717b7171717bdddddddddddddddd000000007000000000000006
bbbbb3bbbbb3bbbbb3bbbbbbbbb3bbbb6166666b6661666b6166666bb61666bb6166666b6166666b6166666bdddddddddddddddd000000006000000000000006
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddb000000000000000000000000
00333300003333003bbbbbb33bbbbbb300003333000000333bbbbbbb3bbbbbbb3333000033000000bbbbbbb3bbbbbbb33300003333000033bbbbbbbbbbbbbbbb
03aaaa3003aaaa3043bbbb343bbbbbb30333aaaa000333aa43bbbbbb3bbbbbbbaaaa3330aa333000bbbbbb34bbbbbbb3aa3333aaaa3333aabbbbbbbbbbbbbbbb
03bbbb3003bbbb3053bbbb3503bbbb303aaabbbb003aaabb543bbbbb03bbbbbbbbbbaaa3bbaaa300bbbbb345bbbbbb30bbaaaabbbbaaaabbbbbbbbbbbbbbbbbb
03bbbb3003bbbb3013bbbb3103bbbb303bbbbbbb03abbbbb159333bb03bbbbbbbbbbbbb3bbbbba30bb333451bbbbbb30bbbbbbbbbbbbbbbbbb3333bbbbbbbbbb
093333403abbbba30933334003bbbb304333bbbb03bbbbbb0149443303bbbbbbbbbb3334bbbbbb3033444510bbbbbb30bb3333bbbbbbbbbb33444933bbbbbbbb
049444503bbbbbb30494445003bbbb301944333303bbbbbb0014559403bbbbbb33335441bbbbbb3044555100bbbbbb3033544933bbbbbbbb44555494bbbbbbbb
014555103bbbbbb3014555003bbbbbb3011194443abbbbbb000111453bbbbbbb54441110bbbbbba355111000bbbbbbb345111194bbbbbbbb55111145bbbbbbbb
001111003bbbbbb3001111003bbbbbb3000011113bbbbbbb000000113bbbbbbb11110000bbbbbbb311000000bbbbbbb311000011bbbbbbbb11000011bbbbbbbb
002222000088880000a88a00000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddd00
002222000088880000a88a0000026000000ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000d8888dd0
222222220088880000a88a0000062000000ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000d8dd88d0
222222220088880000a88a00007777000000000006000060000000000001000000111000011011000100010000000000000000000000000000000000d88888d0
222222220088880000a88a00007777000000000000000000000100000010100001000100100100101010101011000110100000100000000000000000d88888d0
222222220088880000a22a00000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d88888d0
222222220088880000a00a00000000000008800006000060000000000000000000000000000000000000000000000000000000000000000000000000ddddddd0
222222220088880000a00a0000600600000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
002222000082280000a22a0000f00f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
002222000082280000a22a0000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
002222000082280000a22a00009999008888888822299222888aa888007777000077777007777700007777000077770007700770077777700007700000000000
002222000082280000aaaa00000aa0008888888822299222888aa888077777700777777007777770077777700777777007700770077777700007700000000000
000220000088880000000000000000008888888822299222888aa888077667700776666007766770077667700776677007700770066776600007700000000000
0002200000022000000aa000000880008888888822299222888aa888077007700770000007700770077007700770077007700770000770000007700000000000
00022000a828828a000aa000000880008888888822299222888aa888077007700770000007700770077007700770077007700770000770000007700000000000
00022000a828828a000aa000000880008000000822299222888aa888ccccccc0ccccccc0cccccc600cc00cc00cc00cc00cc00cc0000cc000000cc00000000000
00000000000000000000000000000000000000000000000000000000ccccccc0ccccccc0cccccc000cc00cc00cc00cc00cc00cc0000cc000000cc00000000000
00000000000000000000000000000000000000000000000000000000177117701771111017711770077007700770077007700770000770000007700001666610
00000000000000000000000000000000000000000000000000000000077007700770000007700770077007700770077007700770000770000006600007166170
00000000000000000000000000000000000000000000000000000000077007700770000007700770077007700770077007700770000770000000000007711770
00000000000000000000000000000000000000000000000000000000077007700777777007700770077777700770077007777770000770000007700007677670
00066000000660000000000000000000000000000000000000066000077007700677777007700770067777600770077006777760000770000007700006777760
a772277a0002200000077000000aa0000aa000000a77000000722000066006600066666006600660006666000660066000666600000660000006600000000000
00066000000660000000000000000000000000000000000000066000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dc6666cdd8888dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d7c66c7dd8dd88d0000000000000000000000000888aa8888a8888a88a8aa8a888a8a888a88888a88aa88aa8a888a8888899998889922aa8888aa88888aaaa88
d77cc77dd88888d0000000000000000000000000888aa8888a8888a88a8aa8a8888a8a888a88888a8aa88aa888a888a88922229889922aa8888aa888a88aa88a
d767767dd88888d0000000000000000000000000888aa8888a8888a88a8aa8a888a8a888a88888a8a88aa88aa888a888892aa29889922aa88aaaaaa8aaaaaaaa
d677776dd88888d0000000000000000000066000888aa8888a8888a88a8aa8a8888a8a888a88888aa88aa88a88a888a8892aa29889922aa88aaaaaa8aaaaaaaa
ddddddddddddddd0000077a000000aa000022700888aa8888a8888a88a8aa8a888a8a888a88888a88aa88aa8a888a8888922229889922aa8888aa888a88aa88a
0000000000000000000000000000000000066000888aa8888a8888a88a8aa8a8888a8a888a88888a8aa88aa888a888a88899998889922aa8888aa88888aaaa88
0dddddddddddddd00dddddd0dddddddddddddddd0ddddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddaadd6dd99d99dddd5555ddd455554dd44f444d0dfffd0000000000000000000000000000000000000000000000000000000000000000000000000000000000
d499466dd889889dd567675dd459954ddffffffdddfffdd0a8a8a8a8000000000000000000000000000000000000000000000000000000000000000000000000
d4444ddddd88888dd544445dd49cc94dd44f444ddcccccd08a8a8a8a000000000000000000000000000000000000000000000000000000000000000000000000
d564dd00d882882dd564465dd49cc94dd44f444ddf444fd0a8a8a8a8000000000000000000000000000000000000000000000000000000000000000000000000
d5ddd000d22d22ddd554455dd459954dd44f444ddd4d4dd08a8a8a8a000000000000000000000000000000000000000000000000000000000000000000000000
ddd00000ddddddd0dddddddddddddddddddddddd0ddddd00a8a8a8a8000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000008a8a8a8a000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000055550000006660000b0000077777000000000000000000000880000001100007777770000000000007700000000000000000000000000000000000
006660000044440006606d60000300007777777066666dd006066060008888000011110007777770000000000077770000000000000000000000000000000000
06766600000aa0006660666600b3b0007777777066666dd00066660008888880011111100777777000000000077dd77000000000000000000000000000000000
06666600055555506d00666000333000777777706dd06dd0066006608888888811111111077777700000000077dddd7700000000000000000000000000000000
06666d000028820066dd6d0000333000777777706dd06dd006600660888888881111111107777770000dd0007dddddd700000000000000000000000000000000
0066d00000677600066666d003333300777777706dd06dd000666600888888881111111107777770000dd0007dddddd700000000000000000000000000000000
000d00000028820000d66d6dbbbbbbb06777776066666dd006d66d6088888888111111110000000000000000dddddddd00000000000000000000000000000000
006660000067760000ddd6dd00030000466666406ddd6dd000dddd0088888888111111110000000000000000dddddddd00000000000000000000000000000000
000d00000028820000d6666d00b3b0004008004066d66dd000dddd00888888881111111106cccc6000000000dddddddd00000000000000000000000000000000
066666005567765000d6d6dd0b333b00408980406d666dd000dddd0088888888111111110c6666c000000000dddddddd00000000000000000000000000000000
000d0000442882400d660ddd0333330004555400666d6dd000dddd0088888888111111110666666000000000dddddddd00000000000000000000000000000000
6666666044444440d6600dd0bbbbbbb0040004006ddd6dd000dddd0088888888111111110c6666c000000000dddddddd00000000000000000000000000000000
000d00007777777066000dd0000400000040400066666dd000dddd0088888888111111110666666000088000dddddddd00000000000000000000000000000000
0ddddd007171717066000dd000040000004040006d6d6dd000dddd0088888888111111110c6666c0000880007dddddd700000000000000000000000000000000
ddddddd06166666006600ddd000400000444440066666dd000666600888888881111111100000000000000007dddddd700000000000000000000000000000000
000000000000000000000000000500000555550066666dd006dddd60088888800111111000000000000000000777777000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000770077007700000007777700077770000777770007777700000000000000000
00000000000770000000000000000000000000000000000000000000000000000770077007700000077777700777777007777770077777700000000000000000
00000000000770000000000000000000000000000000000000000000000000000770077007700000077666600776677007766660077666600000000000000000
00000000000770000000000000000000000000000000000000000000000000000770077007700000077000000770077007700000077000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000770077007700000077000000770077007700000077000000000000000000000
0000000000ccc0000000000000000000000000000000000000000000000000000cccccc00cc000000ccccc000cc00cc0ccccccc0ccc000000000000000000000
0000000000ccc0000000000000000000000000000000000000000000000000000cccccc00cc0000001ccccc00cc00cc0ccccccc0ccc000000000000000000000
00000000001770000000000000000000000000000000000000000000000000000117711007700000001117700770077017711110177000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000007700007700000000007700770077007700000077000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000007700007700000000007700770077007700000077000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000007700007777770077777700777777007700000077777700000000000000000
00000000000770000000000000000000000000000000000000000000000000000007700007777770077777600677776007700000067777700000000000000000
00000000000660000000000000000000000000000000000000000000000000000006600006666660066666000066660006600000006666600000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777000077777770000c0c000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000044007aa76660766666700868c6600000000000000000
000000000000000000000000000000000000000000000000000000000000000000000770077007700444f4407aa7777077777770778776600000000000000000
0000000000000000000000000000000000000000000000000000000000000000000007700770077044444f40777766707666767077877cc00770770000000000
00000000000000000000000000000000000000000000000000000000000000000000077007700770444444007667777077777770888886607007007070070070
00000000000000000000000000000000000000000000000000000000000000000000077007700770644446007777667076766670778776600000000007707700
00000000000000000000000000000000000000000000000000000000000000000000077007700770066660000666777077777770778770000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000cc00cc00cc0000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000cc00cc00cc054444f5000808000000000000000000000088888000ccccc
0000000000000000000000000000000000000000000000000000000000000000000007700770077054994f50777877708c8c8c800004400000088888000ccccc
0000000000000000000000000000000000000000000000000000000000000000000007700770077054444f5077787770c77777c0000ff0000088888000ccccc0
0000000000000000000000000000000000000000000000000000000000000000000007700770077054994f508888888087666780000ff0000088888000ccccc0
0000000000000000000000000000000000000000000000000000000000000000000007777777777054444f5077787770c77777c000999900088888000ccccc00
0000000000000000000000000000000000000000000000000000000000000000000006777667776054444f50777877708c8c8c8009999990088888000ccccc00
0000000000000000000000000000000000000000000000000000000000000000000000666006660054444f5000000000000000000f4444f088888000ccccc000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004004002222200011111000
__label__
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrlblrrrrrl3blrrrrrrrrrrrl3llblrrrlblrrrrl3llblrrrlblrrrrrl3blrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrlbbblrrrl33blrrrrrrrrrrl333lblrrlbbblrrl333lblrrlbbblrrrl33blrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrlbbblrrrl3bbblrrrrrrrrrl33lbbblrlbbblrrl33lbbblrlbbblrrrl3bbblrrrrrrrrllllllrrrrrllllllllrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrlbbbbblrl33bbblrrrrrrrrrrlklbbbllbbbbblrrlklbbbllbbbbblrl33bbblrrrrrrrll7777llrrrrl77ll77lrrrrllllllllrrrrrrrrrrrrrrrrrr
rrrrrrrrrll4llrrrlbbbbblrrrrrrrrrrrrl4lrrll4llrrrrrrl4lrrll4llrrrlbbbbblrrrrrrl777777lrrrrl77ll77lrrrrl777777lrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrll4llrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlllllllrrrrrl776677lrrrrl77ll77lrrrrl777777lrrrrrrrrrrrrrrrrrr
3rrrrrrrrrrrrrrrrrrllllllrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrll7777llrrrrl77ll77lrrrrl77ll77lrrrrl667766lrrrrrrrrrrrrrrrrrr
3rrrrrrrrrrrrr332sll7777ll3333333rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl777777lrr3ll77ll77lrrrrl77ll77lrrrrlll77lll3rrrrrrrrrrr3rrrrr
c3rrrrrr3333333322l777777l3333333333333rrrrrrrrrrrrrrrrllllllrrrrrl776677lrrrlcccccccllrrrlccllcclrrrrrrl77lr3rrrrrrrrrrr3rrrrrr
c3rr33333333333322l776677l33333lllllll3333lllllllrrrrrll7777llrrrrl77ll77lrrrlcccccccllrrrlccllcclrrrrrrlcclrrrrrrrrrrrrrrrrrrrr
c333333333323333lll77ll77l3333ll77777l3333l77777llrrrrl777777lrrrrl77ll77lrrrls77ss77lblrrl77ll77lrarrrrlcclrrrrrrrrrrrrrrrrrrrr
s333333333333333lll77ll77l3333l777777l3333l777777lrrrrl776677lrrrllccllccl3rrll77ll77lblrrl77ll77lr3rrrrl77lrrrrrrrrrrrrrrrr3r3r
3333333333333333slcccccccl3333l776666l3333l776677lrrrrl77ll77lrrrlccccccclr3rrl77ll77llrrrl77ll77lr3rrrrl77lrrrrrrrrrrrrrrrrr3rr
33333333333333333lcccccccl3333l77lllllll33l77ll77l33rrl77ll77lk77ls77ss77lrrrrl77ll77lrrrrl777777lrrrrrrl77lrrrrrrrrrrrrrrrrrrrr
33333333333333333ls77ss77l333ll77lllllcl3ll77ll77l333rlccllccl477ll77ll77lrrrrl77ll77lrrrrl677776lrrrrrrl77lrrrrrrrrrrrrrrrlrrrr
33333333333333333ll77ll77l333lcccccccl7l3lcccccc6l333rlccllccl477kl77ll77lrr3rl66ll66lrrrrll6666ll3rrrrrl77lrrrrrrrrrrrrrrlblrrr
333333333333333333l77ll77l333lcccccccl7l3lccccccll3333l77ll77l477kl77ll77lrrr3llllllllrrrrrllllll3rrrrrrl66lrrrrrrrrrrrrrrlblrrr
333333333333333333l77ll77l333ls77ssssl7l3ls77ss77l3333l77ll77lk77ll77ll77lrrrrrrrl33blrrrrrrrrrrrrrrrrrrllllrrrrrrrrrrrrrlbbblrr
333333333333333333l77ll77l333ll77lllll6l3ll77ll77l3333l77ll77l477kl66ll66lrrrrrrrl3bbblrrrrrrrrrrrrrrrrrrrrarrrrrrrrrrrrrlbbblrr
333333333333333333l66ll66l3333l77lllllll33l77ll77l333rl777777l477kllllllll3rrrrrl33bbblrrrrrrrrrrrrr3r3rrrr3rrrrrrrrrrrrlbbbbblr
333333333333333333llllllll3333l777777l3333l77ll77l333rl677776l477kkkkkklrrr3rrrrrlbbbbblrrrrrrrrrrrrr3rrrrr3rrrrrrrrrrrrrll4llrr
333333333333333333333333333333l677777l3333l77ll77l33rrll6666llk77llkkkklrrrrrrrrrrll4llrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
333333333333333333333333333333ll66666l3333l66ll66lrrrrrllllll4477kkllkklrrrrrrrrrrrrrrrrrrrlrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
3333333333333333333333333333333lllllll3333llllllll3rrrrrkkk444477kkkklllrr3rrrrrrrrrrrrrrrl3lrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrr3r3r
r333333333333333333333333333333333333333333333rrr3rrrrrrk44444477kkkkkklr3rrrrrrrrrrrrrrrrl3blrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrr3rr
rrrr333333333333333333333333333333333333333rrrrrrrrrrrrrk4444kk77llkkkklrrrrrrrrrrrrrrrrrl33blrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrr3333333333333333333333333333333rrrrrrrrrrrrrrrrrk44kk4477kkllkklrrrrrrrrrrrrrrrrrl3bbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rr3rrrrrrr3rrr3333333333333333333rrrrrrrrrrrrrrrrrrr3r3rkkk444477kkkklllrrrr3r3rrrrrrrrrl33bbblrrrrrrrrrrrrr3r3rrrrrrrrrrr3rrrrr
rrr3rrrrr3rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrk44444477kkkkkklrrrrr3rrrrrrrrrrrlbbbbblrrrrrrrrrrrrr3rrrrrrrrrrrrr3rrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrk444477ll66kkkklrrrrrrrrrrrrrrrrrrll4llrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrk4477llllll66kklrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrk77llllllllll66lrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlblrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr7llllllllllllll6rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlblrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr7llllllllllllll6rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlbbblrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr7lllllll888llll6rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlbbblrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr6lllllll888llll6rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlbbbbblr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrllllllllaaalllllrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrll4llrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrllllllll888lllllrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlllllllllllllllllllllll888lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrrrrrrrrrrr3r3rrrrrrrrrrrrrrrrrllllllllllllllllllllllll888sllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrllllllllllllllllllllllll888salllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlll7777lllllllllllll8lff888s7lllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrllllllllllllllllllll8l9a88882lllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrrlllllllllllllllllllla82288887sllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrlll7777lllllllllllll8822aaa87sllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrllllllllllllllllllll82228882ssllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrlrrrrrrrlrrrrrrrrrrrrrrrrrrrrrrrrrrrrlllllllllllllllllllllsll622slsllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrl3lrrrrrl3lrrrrr3rrrrrrrrrrrrrrrrrrrrrlll7777lllllllllllllllll622sllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrl3blrrrrl3blrrr3rrrrrrrrrrrrrrrrrrrrrrllllllllllllllllllllllll622sllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rl33blrrrl33blrrrrrrrrrrrrrrrrrrrrrrrrrrllllllllllllllllllllllll699sllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rl3bbblrrl3bbblrrrrrrrrrrrrrrrrrrrrrrrrrlll7777lllllllllllllllll222sllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
l33bbblrl33bbblrrrrr3r3rrrrrrrrrrrrrrrrrllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rlbbbbblrlbbbbblrrrrr3rrrrrrrrrrrrrrrrrrllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrll4llrrrll4llrrrrrrrrrrrrrrrrrrrrrrrrrrlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
rrrlrrrrrrrlrrrrrrrlrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlrrrrrrrlrrrrrrrlrrrrrrlrrrrrrrrrrrrrrrrrrrrrrrrlrrrr
rrlblrrrrrl3lrrrrrl3lrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrr3r3rrrrrrrrrrrl3lrrrrrlblrrrrrlblrrrrl3lrlrrrrrr3r3rrrrrrrrrrrlblrrr
rrlblrrrrrl3blrrrrl3blrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrr3rrrrrrrrrrrrl3blrrrrlblrrrrrlblrrrrl3llblrrrrrr3rrrrrrrrrrrrlblrrr
rlbbblrrrl33blrrrl33blrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl33blrrrlbbblrrrlbbblrrl333lblrrrrrrrrrrrrrrrrrrlbbblrr
rlbbblrrrl3bbblrrl3bbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl3bbblrrlbbblrrrlbbblrrl33lbbblrrrrrrrrrrrrrrrrrlbbblrr
lbbbbblrl33bbblrl33bbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3r3rrr3rrrrrrrrrrrrrl33bbblrlbbbbblrlbbbbblrrlklbbblrr3rrrrrrrrrrrrrlbbbbblr
rll4llrrrlbbbbblrlbbbbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrr3rrrrrrrrrrrrrlbbbbblrll4llrrrll4llrrrrrrl4lrrrr3rrrrrrrrrrrrrll4llrr
rrrrrrrrrrll4llrrrll4llrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrll4llrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrlrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlrrrrrrrlrrrrrrrlrrrrrrrlrrrrrrrlrrrrrrlrrrrrrrrlrrrr
rrrrrrrrrrl3lrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl3lrrrrrl3lrrrrrl3lrrrrrl3lrrrrrlblrrrrl3lrlrrrrl3lrrr
rrrrrrrrrrl3blrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl3blrrrrl3blrrrrl3blrrrrl3blrrrrlblrrrrl3llblrrrl3blrr
rrrrrrrrrl33blrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl33blrrrl33blrrrl33blrrrl33blrrrlbbblrrl333lblrrl33blrr
rrrrrrrrrl3bbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl3bbblrrl3bbblrrl3bbblrrl3bbblrrlbbblrrl33lbbblrl3bbblr
rrrrrrrrl33bbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl33bbblrl33bbblrl33bbblrl33bbblrlbbbbblrrlklbbbll33bbblr
rrrrrrrrrlbbbbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlbbbbblrlbbbbblrlbbbbblrlbbbbblrll4llrrrrrrl4lrrlbbbbbl
rrrrrrrrrrll4llrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlllllllrrrrrllllllllllllllllllllrrll4llrrrll4llrrrll4llrrrrrrrrrrrrrrrrrrrll4llr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrll77777llrrrll77l777l777l777l777lrrlrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlrrrr
rrrrr3rrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrr3rrrrl77l7l77lrrrl7llll7ll7l7l7l7ll7llrl3lrlrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3r3rrrlblrrr
rrrrrr3rrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrr3rrrrrl777l777lrrrl777ll7ll777l77lll7lrrl3llblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrlblrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrl77l7l77lrrrlll7ll7ll7l7l7l7ll7lrl333lblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlbbblrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrll77777llrrrl77lll7ll7l7l7l7ll7lrl33lbbblrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrlbbblrr
rr3rrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrr3r3rlllllllrrrrllllrlllllllllllllllrrlklbbblrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrlbbbbblr
r3rrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrl4lrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrll4llrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrr2l2l2l2rrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrr
rrrrrrrr8282828rrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrrr
rrrrrrrr8282828rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrr7777777rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrr7s7s7s7rrrrrrrrrrrrrrrrrrrrrrrrrrrrr3r3rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3r3rrrrrrrrrrrrrrrrr
rrrrrrrr6s66666rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3rrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr2l2l2l2rrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr8282828rrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr7777777rrrrrrrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr7s7s7s7rrrrrrrrrrrrrrrrrrrrrrrrr
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
lllllllllllllllllllllllllllllllllllllll66ll66l66ll666lllll666l6l6lllll666l6l6l66ll666ll66lllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll6lll6l6l6l6l6lllllll6l6l6l6lllll666l6l6l6l6l6l6l6l6lllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll6lll6l6l6l6l66llllll66ll666lllll6l6l6l6l6l6l66ll6l6lllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll6lll6l6l6l6l6lllllll6l6lll6lllll6l6l6l6l6l6l6l6l6l6lllllllllllllllllllllllllllllllllllllll
lllllllllllllllllllllllllllllllllllllll66l66ll666l666lllll666l666lllll6l6ll66l6l6l6l6l66llllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll666l6l6ll66l666ll66lllll666l6l6lllll666ll66l6l6l66llllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll666l6l6l6llll6ll6lllllll6l6l6l6llllll6ll6l6l6l6l6l6lllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll6l6l6l6l666ll6ll6lllllll66ll666llllll6ll6l6l666l6l6lllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll6l6l6l6lll6ll6ll6lllllll6l6lll6llllll6ll6l6l6l6l6l6lllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllll6l6ll66l66ll666ll66lllll666l666lllll66ll66ll6l6l6l6lllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll

__gff__
000000000000000000000000630004040063046300040a0a0a41414163000404212121210c0c0c0c0c0c0c41416304046363636363636363636363636363636300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000600000000000000000000000000000000000000000000000000000000000000060000030303030303030303030303030303030
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005540550045414500454245004543450045004500565456000000000000000000000000000000000000000000554055003030301b1b3030303030303030303030
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000000510000005200000053000000440000000000000000000000000000000000000000000000000000005100003030301b1b3030303030303030303030
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030191b1b1b1b1b1b1b1b1b1b1b1b1a30
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000302b1b1b1b1b1b1b1b1b1b1b1b1b2c30
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055405500565656000042000000430000000000000000000000000000000000000000000000000000000000000000000030303030303030303030303030303030
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000005100000052000000530000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000e0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005b0000000000000000
00000e1e1f0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005758595a5b575c5d0000000000000000
00001e1e1f1f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006768696a67676c6d0000000000000000
00001e1e1f1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc57c1c95c59585e0000000000000000
00001e2e2f1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060600000000000560000000056000000000000000000000000000000000000000000000000000000000000000000dc67d1d96c69686e0000000000000000
00002e00002f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000646566747273000000000000000000000000000000000000000000000000000000000000000000000000000000000000ca5ccdcd58caca5e0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000636261616263000000560000000056000000000000000000000000000000000000000000000000000000000000000000da6cdddd68dada6e0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000737274666564000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8cb5c00c95aca5d0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d8db6c00d96ada6d0000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005b005c005c005f0000000000000000000000000000000000000000000000000000000000000000000000000000000000c8cb5c00e8e9cb5b0000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006b006c006c006f005d006d005d006e005e00000000000000000000000000000000000000000000000000000000000000d8db6c00f8f9db6b0000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040554000414141004142410045434500450045005654560000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000005100000052000000530000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055405500454145000042000000430000450045000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000005100000052000000530000004400005654560000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0110000011110111101111000100111000010000100001000c1100c1100c110001000010000100111000010011110111101111000100001000010011100001000c1100c1100c1100010000100001001110000100
011000001811018110181151810018110181101811518100181001810018110181101811518100181101811518100181001811018115181051810518110181151810018100181001810018110181101811518100
011000001c1101c1101c115001001c1101c1101c1150010000100001001c1101c1101c115001001c1101c1151c1001c1001c1101c11500100001001c1101c1151c100001001c1001c1001c1101c1101c1151c100
011000001511015110151150010015110151101511500100001000010015110151101511500100151101511521100211001511015115001000010015110151152110000100211002110015110151101511521100
01100000296150060511615006051161500605296150060511615006051161500605296150c605116150c605116150060511615006052961500605116150c60511615006052961500605116150c605116150c605
011000001852018500185001852018500185001852018520185220c500165200c500155200c500135200c500135200c5001550015520155221552215522155221552215522005000050000500005001552016520
01100000185201152218500185201152018500185201152018520165200c500155200c500135200c5001352513520155001552015522165220c500135201352013510135221352213522135120c5001550016500
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000700001275118751207510d70100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701
001400080c6231062313613166131661313613106230c623166030e6030c60314603176030b6030d6030960300603006030060300603006030060300603006030060300603006030060300603006030060300603
000100000c7520a75208752077522d7022d7022d7022e702177020070218702197021a7021b7021c7020070200702007020070200702007020070200702007020070200702007020070200702007020070200702
004000200061003610046100561004610036100361002610016100061000610006100061000610006100161001610016100261004610056100661005610046100261001610026100161001610016100261000610
000b000018052210421704220042170421f032160321e032140321d032120221a02211022190220f012170120b01212012080120f012000020000200002000020000200002000020000200002000020000200002
000a0000167521d752000021f75224752000022275228752000022d75232752000022f7522f7522f7523175232742337323772200002000020000200002000020000200002000020000200002000020000200002
000100003564032650326503265031660306602e6502d6502a65024650226501665007650096500f650166401c640206401f6301d6301a630166300f630086300763006630056300463002630016300163000630
0003000035610396103b6103b6103a610386103061024610176101c61021610216101f6101d610196100e6100d610096100961008610076100761006610056100461004610036100361003610026100161001610
000100000e51219502005020050200502005020050200502005020050200502005020050200502005020050200502005020050200502005020050200502005020050200502005020050200502005020050200502
000900002a7552c7552f7552a705207052d7053170500705007050070528705007050070500705007050070500705007050070500705007050070500705007050070500705007050070500705000000000000000
000900002a7552c7552a7552a705207052d7053170500705007050070528705007050070500705007050070500705007050070500705007050070500705007050070500705007050070500705000000000000000
000900002a7552c755247552a705207052d7053170500705007050070528705007050070500705007050070500705007050070500705007050070500705007050070500705007050070500705000000000000000
000700002075118751127510070100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701007010070100701
000400002375123751207511d75118751127510d75104751067010670106701067010670106701067010570100701007010070100701007010070100701007010070100701007010070100701007010070100701
000100001d05018050130500e0500c0500b0500905008040050400303000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300001265018650006040060400604006040060400604206542465400604006040060400604006040060400604006040060400604006040060400604006040060400604006040060400604006040060400604
000500001d05024050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000240501d050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010300002b55412504335540e5042b55412504335540e5042b55412504335540e5042b54412504335440b5042b5341250433534085042b5241250433524085042b51412504335140a5040b5040e5041150415504
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01010000107001e700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000e00002401026010290102b0102401026010290202b0202402026020290202b0202402026020290302b0302403026030290302b0302403026030290402b04024045210451f0451d0451f0451d0351a0351d035
010e0000290102902029032290322902029022290222902029020290222901200000240202402024030240402e0412e0402e0302e0302e0302e0202d0402d0302d0302d0302d0202d0202d0202d0202d02000000
010e00002b0402b0402b0322b0322d0302d0322904029040290322903229032290322903229022290222902200000000000000000000000000000028010280102903129020260302602021030210202403024020
010e0000180151a0151d0151f015180151a0151d0251f025180251a0251d0251f025180251a0251d0351f035180351a0351d0351f035180351a0351d0451f045180451a0451d0451f045180451a0351d0351f035
010e000022015180151b0251d02522035240351b0451d04522035180351b0251d02522025240151b0151d02522025180351b0351d03522035240251b0251d01522015180251b0251d02522035240351b0251d015
010e00001b0151d01520025220251b0351d03520045220451d0351f03522025240251d0351f03522045240451f0352103524025260251f0352103524025260251b0151d01520025220251b0351d0352004522045
010e000022010220202203222032210302103221032210201f0301f0321f0321f0301a0201a0301a0301a02022010220202203222032210302103221032210201f0301f0321f0321f03026020260302603026020
000e00002703027020270322702227030270222703227020260302602226032260202603026020260302602024031240202403024020240302402024030240202203122020220302202022030220202203022020
010e00000c623006050c6230c62324625006050c6230c6230c623006050c6230c62324625006050c6230c6230c623006050c6230c62324625006050c6230c6230c623006050c6230c62324625006050c6230c623
010e00001805518055000001805518055000001805518055000001805518055000001805500000180550000018055000000000000000000000000000000000001805500000000000000000000000000000000000
010e00001d0551d055000001d0551d055000001d0551d055000001d0551d055000001d055000001d055000001c055000000000000000000000000000000000001c05500000000000000000000000000000000000
010e00002205522055000002205522055000002205522055000002205522055000002205500000220550000022055000000000000000000000000000000000002205500000000000000000000000000000000000
010e00001865518655006001865518655006001865518655006001865518655006001865500600186550060018655006001805318053186551805318053180001865500600186001860000600006000060000600
__music__
00 20616263
01 23216263
00 23226263
00 24266263
00 25276263
00 292a2b2c
00 23212863
00 23222863
00 24262863
02 25272863
02 292a2b2c
00 00010203
01 00040203
00 00040503
02 00040603

