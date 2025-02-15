VERSION = "1.0.0"

local micro = import("micro")
local buffer = import("micro/buffer")
local config = import("micro/config")
local action = import("micro/action")

function init()
	config.MakeCommand("mdtree", mdtree, config.OptionComplete)
	config.AddRuntimeFile("mdtree", config.RTPlugin, "mdtree.lua")
	config.AddRuntimeFile("mdtree", config.RTPlugin, "bar.lua")
	config.AddRuntimeFile("mdtree", config.RTSyntax, "syntax.yaml")
end

headings = {}

function mdtree(buffer_pane)
	local buf = buffer_pane.Buf

	-- Make sure that you don't create new sidebar when one exists
	if SideBar:IsOpen()
	then
		SideBar:Close()
	else
		-- Prevent opening bar for non-markdown files
		-- NOTE: must be here after check for bar existence
		-- because otherwise bar will be checked if it is md file
		if buf:FileType() ~= "markdown"
		then
			micro.InfoBar():Error("File isn't markdown")
			return
		end		
		SideBar:Create(buffer_pane)
		SideBar.callbacks:Update()
	end
end


-------------------------
-- SideBar callbacks
-------------------------

function SideBar.callbacks:Update()
	SideBar:Clear()
	parse_headings(SideBar.owner.Buf)
	ident_headings()
	print_headings()
end

function SideBar.callbacks:Jump(y)
	SideBar.owner.Cursor:GotoLoc({
		X = 0,
		Y = headings[y + 1].position
	})
	SideBar.owner:Center()
	-- TODO: Make main file active
	-- SideBar.buffer_pane:SetActive(false)
	-- SideBar.owner:SetActive(true)
end
-------------------------
-- Parsing functions
-------------------------

function is_heading(line)
	local head, tail = string.find(line, "#+ .*")
	if head ~= nil and tail ~= nil
	then
		return true
	else
		return false
	end
end

function parse_headings(buf)
	headings = {}
	for i = 0, buf:LinesNum()
	do
		local line = buf:Line(i)	
		if is_heading(line)
		then
			local heading = {text=line, position=i }
			table.insert(headings, heading)
		end
	end
end

function ident_headings()
	for i, heading in ipairs(headings) do
		local head, tail = string.find(heading.text, "^#+")
		local header_level = tail - head
		heading.text = string.rep("   ", header_level) .. heading.text
	end
end

function print_headings()
	for i, heading in ipairs(headings) do
		--Don't add \n in the end of the tree
		if i == #headings
		then
			SideBar:Append(heading.text)
		else
			SideBar:Append(heading.text .. "\n")
		end
	end
end
