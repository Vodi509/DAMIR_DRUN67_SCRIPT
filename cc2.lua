local p = game.Players.LocalPlayer
local g = p:WaitForChild("PlayerGui")
for _,v in pairs(g:GetChildren()) do if v.Name=="SpeedHubDamir" then v:Destroy() end end
local s = Instance.new("ScreenGui",g) s.Name="SpeedHubDamir" s.ResetOnSpawn=false
local T={Main=Color3.fromRGB(15,16,22),Bg=Color3.fromRGB(22,24,33),Stroke=Color3.fromRGB(38,42,56),Green=Color3.fromRGB(0,255,163),Red=Color3.fromRGB(255,46,92),Btn=Color3.fromRGB(30,33,45),White=Color3.new(1,1,1),Grey=Color3.fromRGB(125,131,150),Blue=Color3.fromRGB(0,200,255),Purple=Color3.fromRGB(160,100,255),Orange=Color3.fromRGB(255,140,0)}
local cat=Instance.new("ImageButton",s) cat.Size=UDim2.new(0,48,0,48) cat.Position=UDim2.new(0.02,0,0.12,0) cat.BackgroundColor3=T.Bg cat.Image="rbxassetid://18314115147" cat.ScaleType=Enum.ScaleType.Fit cat.ZIndex=200 cat.Visible=false cat.Active=true cat.Draggable=true
local cc=Instance.new("UICorner",cat) cc.CornerRadius=UDim.new(1,0)
local cs=Instance.new("UIStroke",cat) cs.Thickness=1.5 cs.Color=T.Purple
local m=Instance.new("Frame",s) m.AnchorPoint=Vector2.new(0.5,0.5) m.Position=UDim2.new(0.5,0,0.4,0) m.Size=UDim2.new(0,480,0,320) m.BackgroundColor3=T.Main m.BorderSizePixel=0 m.Active=true m.Draggable=true m.ZIndex=100
local mc=Instance.new("UICorner",m) mc.CornerRadius=UDim.new(0,8)
local ms=Instance.new("UIStroke",m) ms.Thickness=1 ms.Color=T.Stroke
local sb=Instance.new("Frame",m) sb.Size=UDim2.new(0,120,1,0) sb.BackgroundColor3=T.Bg sb.BorderSizePixel=0
local ss=Instance.new("UIStroke",sb) ss.Thickness=1 ss.Color=T.Stroke
local ll=Instance.new("TextLabel",sb) ll.Size=UDim2.new(1,0,0,40) ll.BackgroundTransparency=1 ll.Text="DAMIR HUB" ll.TextColor3=T.Red ll.Font=Enum.Font.GothamBold ll.TextSize=14
local co=Instance.new("Frame",m) co.Position=UDim2.new(0,130,0,10) co.Size=UDim2.new(1,-140,1,-20) co.BackgroundTransparency=1
local tabs={}
local function cT(n)
 local tf=Instance.new("ScrollingFrame",co) tf.Size=UDim2.new(1,0,1,0) tf.BackgroundTransparency=1 tf.CanvasSize=UDim2.new(0,0,2,0) tf.ScrollBarThickness=2 tf.Visible=false
 local ul=Instance.new("UIListLayout",tf) ul.Padding=UDim.new(0,8)
 local tb=Instance.new("TextButton",sb) tb.Size=UDim2.new(0,100,0,30) tb.Position=UDim2.new(0,10,0,45+(#co:GetChildren()*35)) tb.BackgroundColor3=T.Btn tb.Text=n tb.TextColor3=T.White tb.Font=Enum.Font.GothamBold tb.TextSize=11
 local bc=Instance.new("UICorner",tb) bc.CornerRadius=UDim.new(0,4)
 tb.MouseButton1Click:Connect(function() for _,t in pairs(tabs) do t.Visible=false end tf.Visible=true end)
 tabs[n]=tf return tf
end
local ft=cT("🚀 Авто Фарм") local fun=cT("🤡 Fun Zone") tabs["🚀 Авто Фарм"].Visible=true
local fT=Instance.new("TextLabel",ft) fT.Size=UDim2.new(1,0,0,20) fT.BackgroundTransparency=1 fT.Text="ПРОГРАММА «МОЛОТ»" fT.TextColor3=T.White fT.Font=Enum.Font.GothamBold fT.TextSize=12 fT.TextXAlignment=Enum.TextXAlignment.Left
local cf=Instance.new("Frame",ft) cf.Size=UDim2.new(1,0,0,35) cf.BackgroundColor3=T.Bg
local cC=Instance.new("UICorner",cf) cC.CornerRadius=UDim.new(0,6)
local cS=Instance.new("UIStroke",cf) cS.Thickness=1 cS.Color=T.Stroke
local cl=Instance.new("TextLabel",cf) cl.Size=UDim2.new(1,-20,1,0) cl.Position=UDim2.new(0,10,0,0) cl.BackgroundTransparency=1 cl.Text="🚗 Ищу машину..." cl.TextColor3=T.Grey cl.Font=Enum.Font.GothamBold cl.TextSize=11 cl.TextXAlignment=Enum.TextXAlignment.Left
local sl=Instance.new("TextLabel",ft) sl.Size=UDim2.new(1,0,0,18) sl.BackgroundTransparency=1 sl.Text="Ударов: 0 | Сломано: 0 | Авто: 0" sl.TextColor3=T.Grey sl.Font=Enum.Font.Gotham sl.TextSize=10 sl.TextXAlignment=Enum.TextXAlignment.Left
local function gC()
 local c=p.Character if not c then return nil end
 local h=c:FindFirstChildOfClass("Humanoid") if h and h.SeatPart then local s=h.SeatPart local m=s while m do if m:IsA("Model")and m~=c then return m end m=m.Parent end end
 for _,f in pairs({workspace:FindFirstChild("Vehicles"),workspace}) do if f then for _,v in pairs(f:GetChildren()) do if v:IsA("Model") then local o=v:FindFirstChild("Owner") if(o and o.Value==p)then return v end end end end end return nil
end
task.spawn(function() while task.wait(0.3) do pcall(function() local c=gC() if c then cl.Text="🚗 "..c.Name cl.TextColor3=T.Blue else cl.Text="🚗 Сядьте в машину!" cl.TextColor3=T.Red end end) end end)
local fS=function()
 local pg=p:WaitForChild("PlayerGui") for _,g in pairs(pg:GetChildren()) do if g:IsA("ScreenGui") then for _,o in pairs(g:GetDescendants()) do if(o:IsA("TextButton")or o:IsA("ImageButton"))and o.Visible and o.Active then local t=o:IsA("TextButton")and o.Text or"" if o.Name:lower():find("spawn")or t:lower():find("spawn")or t:lower():find("car")then local l=false if t:lower():find("vip")or t:lower():find("pass")then l=true end if not l then return o end end end end end end return nil
end
local cS2=function() local b=fS() if b then pcall(function() if b.MouseButton1Click then firesignal(b.MouseButton1Click) end end) return true end return false end
local ha,aa,hh,cd,afc=false,false,0,0,0
local dH=function() local c=gC() if not c then return false end local r=c.PrimaryPart or c:FindFirstChildWhichIsA("BasePart") if not r then return false end r.Velocity=Vector3.zero r.CFrame=CFrame.new(r.Position.X,80,r.Position.Z) task.wait(0.1) r.Velocity=Vector3.new(0,-500,0) task.wait(0.8) if not c.Parent then cd=cd+1 return true end return false end
local hb=Instance.new("TextButton",ft) hb.Size=UDim2.new(1,0,0,40) hb.BackgroundColor3=T.Btn hb.Text="🔨 ВКЛЮЧИТЬ МОЛОТ" hb.TextColor3=T.Red hb.Font=Enum.Font.GothamBold hb.TextSize=12 hb.BorderSizePixel=0
local hc=Instance.new("UICorner",hb) hc.CornerRadius=UDim.new(0,6)
local hs=Instance.new("UIStroke",hb) hs.Thickness=1 hs.Color=T.Stroke
hb.MouseButton1Click:Connect(function() ha=not ha if ha then aa=false hb.Text="🔨 МОЛОТ РАБОТАЕТ" hb.TextColor3=T.Green hb.BackgroundColor3=Color3.fromRGB(20,35,30) ab.Text="🤖 АВТО-ФАРМ" ab.TextColor3=T.Grey ab.BackgroundColor3=T.Btn task.spawn(function() while ha do dH() hh=hh+1 sl.Text="Ударов: "..hh.." | Сломано: "..cd.." | Авто: "..afc task.wait(0.3) end end) else hb.Text="🔨 ВКЛЮЧИТЬ МОЛОТ" hb.TextColor3=T.Red hb.BackgroundColor3=T.Btn end end)
local ab=Instance.new("TextButton",ft) ab.Size=UDim2.new(1,0,0,40) ab.BackgroundColor3=T.Btn ab.Text="🤖 АВТО-ФАРМ" ab.TextColor3=T.Grey ab.Font=Enum.Font.GothamBold ab.TextSize=12 ab.BorderSizePixel=0
local ac=Instance.new("UICorner",ab) ac.CornerRadius=UDim.new(0,6)
local as=Instance.new("UIStroke",ab) as.Thickness=1 as.Color=T.Stroke
ab.MouseButton1Click:Connect(function() aa=not aa if aa then ha=false ab.Text="🤖 АВТО-ФАРМ РАБОТАЕТ" ab.TextColor3=T.Green ab.BackgroundColor3=Color3.fromRGB(40,25,10) hb.Text="🔨 ВКЛЮЧИТЬ МОЛОТ" hb.TextColor3=T.Red hb.BackgroundColor3=T.Btn task.spawn(function() while aa do local c=gC() if not c then cl.Text="🚗 Респавн..." cS2() task.wait(3) else local d=false for i=1,20 do if not aa then break end d=dH() hh=hh+1 sl.Text="Ударов: "..hh.." | Сломано: "..cd.." | Авто: "..afc if d then break end task.wait(0.2) end if d then afc=afc+1 sl.Text="Ударов: "..hh.." | Сломано: "..cd.." | Авто: "..afc cl.Text="💀 Уничтожена!" task.wait(1) cl.Text="🚗 Респавн..." cS2() task.wait(3) end end end end) else ab.Text="🤖 АВТО-ФАРМ" ab.TextColor3=T.Grey ab.BackgroundColor3=T.Btn end end)
local fuT=Instance.new("TextLabel",fun) fuT.Size=UDim2.new(1,0,0,20) fuT.BackgroundTransparency=1 fuT.Text="💎 AURA GENERATOR" fuT.TextColor3=T.White fuT.Font=Enum.Font.GothamBold fuT.TextSize=12 fuT.TextXAlignment=Enum.TextXAlignment.Left
local aura=0
local al=Instance.new("TextLabel",fun) al.Size=UDim2.new(1,0,0,28) al.BackgroundColor3=T.Bg al.Text="💎 Аура: 0" al.TextColor3=T.Blue al.Font=Enum.Font.GothamBold al.TextSize=13
local aC=Instance.new("UICorner",al) aC.CornerRadius=UDim.new(0,6)
local aa2=Instance.new("TextButton",fun) aa2.Size=UDim2.new(1,0,0,42) aa2.BackgroundColor3=T.Btn aa2.Text="✨ +1 000 000 AURA" aa2.TextColor3=Color3.fromRGB(255,215,0) aa2.Font=Enum.Font.GothamBold aa2.TextSize=13 aa2.BorderSizePixel=0
local ac2=Instance.new("UICorner",aa2) ac2.CornerRadius=UDim.new(0,6)
local as2=Instance.new("UIStroke",aa2) as2.Thickness=1.5 as2.Color=Color3.fromRGB(255,200,0)
aa2.MouseButton1Click:Connect(function() aura=aura+1000000 al.Text="💎 Аура: "..aura end)
local meI=Instance.new("ImageLabel",fun) meI.Size=UDim2.new(0,140,0,140) meI.BackgroundColor3=T.Bg meI.Image="rbxthumb://type=Asset&id=18314115147&w=150&h=150"
local meC=Instance.new("UICorner",meI) meC.CornerRadius=UDim.new(0,6)
local meB=Instance.new("TextButton",fun) meB.Size=UDim2.new(1,0,0,35) meB.BackgroundColor3=T.Btn meB.Text="СЛЕДУЮЩИЙ МЕМ" meB.TextColor3=T.Grey meB.Font=Enum.Font.GothamBold meB.TextSize=11 meB.BorderSizePixel=0
local meC2=Instance.new("UICorner",meB) meC2.CornerRadius=UDim.new(0,6)
meB.MouseButton1Click:Connect(function() local memes={"rbxthumb://type=Asset&id=18314115147&w=150&h=150","rbxthumb://type=Asset&id=6072171427&w=150&h=150","rbxthumb://type=Asset&id=6072166311&w=150&h=150","rbxthumb://type=Asset&id=6072153923&w=150&h=150"} meI.Image=memes[math.random(1,#memes)] end)
-- Кот логика
cat.MouseButton1Click:Connect(function() m.Visible=true cat.Visible=false end)
