pico-8 cartridge // http://www.pico-8.com
version 36
__lua__

function _init()
	cx=0
	cy=0
	stars={}
end

function _update()
	update_stars()
	
	if btn(⬅️) then cx+=1 end
	if btn(➡️) then cx-=1 end
	if btn(⬇️) then cy-=1 end
	if btn(⬆️) then cy+=1 end
	
	
end

function _draw()
cls()
	draw_stars()
end

function add_star()

	w=20000
	h=10000

	local x=rnd(w)-(w/2)+cx
	local y=rnd(h)-(h/2)+cy
	local z=1
	local dx=rnd(50)-25
	local dy=rnd(50)-25
	local dz=rnd(100)+100
	local c=rnd(16)
	
	add(stars,{
		x=x,y=y,z=z,
		dx=dx,dy=dy,dz=dz,c=c})
	
end

function update_stars()

	add_star()
	
	for st in all(stars) do
	 st.x+=st.dx
	 st.y+=st.dy
	 st.z+=st.dz
	 
	 if st.z>30000 then
	  --del(stars,st)
	  st.dx=0
	  st.dy=0
	  st.dz=0
	  
	  
	 end
	end

end

function draw_stars()

	for st in all(stars) do
	
		pr=proj(st.x,st.y,st.z)
	
		pset(pr.x,pr.y,st.c)
	end

end
-->8

function proj(x1,y1,z1)
	local x0=cx
	local y0=cy
	local z0=128
	
	local t=-z0/(z1-z0)
	
	local x=x0+(x1-x0)*t
	local y=y0+(y1-y0)*t
	
	return {x=x+64,y=y+64}
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
