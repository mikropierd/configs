local micro = import("micro")
local buffer = import("micro/buffer")

SideBar = {
	buffer_pane = nil,
	owner = nil,
	-- Must be initialized by user
	-- Initialized in mdtree
	callbacks = {}
}

function SideBar:Create(buffer_pane)
	self.owner = buffer_pane
	self:CreatePane(35)
end

function SideBar:CreatePane(size)
	-- Create and configure buffer of sidebar
	local sidebar_buf = buffer.NewBuffer("", "mdtree")

	-- Enable syntax highlighting
	sidebar_buf:SetOptionNative("filetype", "mdtree")

	-- Make the buffer unsavable and uneditable
	sidebar_buf.Type.Scratch = true
	sidebar_buf.Type.Readonly = true

	-- Configure status line to show nothing
	sidebar_buf:SetOptionNative("statusformatl", "")
	sidebar_buf:SetOptionNative("statusformatr", "")

	-- Disable window decorations
	sidebar_buf:SetOptionNative("ruler", false)
	sidebar_buf:SetOptionNative("diff", false)
	sidebar_buf:SetOptionNative("diffgutter", false)
	sidebar_buf:SetOptionNative("scrollbar", false)

	sidebar_buf:SetOptionNative("softwrap", true)

	self.buffer_pane = micro.CurPane():VSplitIndex(sidebar_buf, false)

	-- NOTE: Bugged with current micro version (2.0.13)
	-- Resize the leftmost pane instead of current
	-- https://github.com/zyedidia/micro/issues/3046
	self.buffer_pane:ResizePane(size)
end

function SideBar:Close()
	self.buffer_pane:Quit()
	self.buffer_pane = nil
	self.owner = nil
end

-- To prevent creation new field and modification other methods
function SideBar:IsOpen()
	if self.buffer_pane == nil
	then
		return false
	else
		return true
	end
end

function SideBar:Insert(location, text)
	self.buffer_pane.Buf.EventHandler:Insert(location, text)
end

function SideBar:Append(text)
	local buf = self.buffer_pane.Buf
	self:Insert(buf:End(), text)
end

function SideBar:Clear()
	local buf = self.buffer_pane.Buf
	buf.EventHandler:Remove(buf:Start(), buf:End())
end

function SideBar:SelectLine(line)
	if line ~= nil
	then
		self.buffer_pane.Cursor.Loc.Y = line
	end
	self.buffer_pane.Cursor:DeleteSelection()
	self.buffer_pane:SelectLine()
end

------------------------------------------
-- Hooks of micro
-- NOTE: They aren't part of the `SideBar`
-- so must use `SideBar` instead of `self`
------------------------------------------

function preQuit(buffer_pane)
	-- Handle: when user wants to close bar via `command:Quit`
	if buffer_pane == SideBar.buffer_pane
	then
		SideBar:Close()
		return false
	end
	-- Handle when user wants to close buffer for which bar was created
	if buffer_pane == SideBar.owner
	then
		SideBar:Close()
		return true
	end
end

-- Update information on save
function onSave(buffer_pane)
	if not buffer_pane == SideBar.owner
	then
		SideBar.callbacks:Update()
	end
end

-- Handle if user edited document to show correct information
function onSetActive(buffer_pane)
	if buffer_pane == SideBar.buffer_pane
	then
		SideBar.callbacks:Update()
	end
end

-- Handle when user wants to select some entry
function preInsertNewline(buffer_pane)
	if buffer_pane == SideBar.buffer_pane
	then
		SideBar.callbacks:Jump(SideBar.buffer_pane.Cursor.Y)
		return false
	end
end


------------------------------------------
-- Cursor movement hooks
------------------------------------------

-- NOTE: Workaround that emulates normal Deselect behavior
function preCursorDown(buffer_pane)
	if buffer_pane == SideBar.buffer_pane
	then
		buffer_pane:Deselect()
		buffer_pane.Cursor:End()
		buffer_pane.Cursor:Down()
		SideBar:SelectLine()
		return false
	end
	return true
end


-- Can be used instead of above workaround after micro merge https://github.com/zyedidia/micro/pull/3091
-- function onCursorDown(buffer_pane)
-- 	if buffer_pane == SideBar.buffer_pane
-- 	then
-- 		SideBar:SelectLine()
-- 	end
-- 	return true
-- end

function onCursorUp(buffer_pane)
	if buffer_pane == SideBar.buffer_pane
	then
		SideBar:SelectLine()	
	end
	return true
end

-- TODO: Handle when user tries to interact with bar in any way different from
-- up, down select

function onCursorRight(buffer_pane)
end

function onCursorLeft(buffer_pane)
end
