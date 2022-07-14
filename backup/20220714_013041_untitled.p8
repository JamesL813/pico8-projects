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

	w=1000
	h=1000

	local x=rnd(w)-w/2
	local y=rnd(h)-h/2
	local z=rnd(128)
	local dx=0
	local dy=0
	local dz=rnd(100)+100
	
	add(stars,{
		x=x,y=y,z=z,
		dx=dx,dy=dy,dz=dz})
	
end

function update_stars()

	add_star()
	
	for st in all(stars) do
	 st.x+=st.dx
	 st.y+=st.dy
	 st.z+=st.dz
	 
	 if st.z>10000 then
	  --del(stars,st)
	  st.dz=0
	 end
	end

end

function draw_stars()

	for st in all(stars) do
	
		pr=proj(st.x,st.y,st.z)
	
		pset(pr.x,pr.y,7)
	end

end
-->8

function proj(x1,y1,z1)
	local x0=cx
	local y0=cy
	local z0=-1000
	
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