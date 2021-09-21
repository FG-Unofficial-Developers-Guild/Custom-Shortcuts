
function onInit()
	Token.onWheel = onWheel;
	registerOptions();
end

function registerOptions()
	OptionsManager.registerOption2("FACING",false, "option_header_hotkeys", "option_label_Facing", "option_entry_cycler", 
		{ labels = "option_val_ctrl|option_val_alt|option_val_wheel", values = "ctrl|alt|wheel", baselabel = "option_val_shift", baseval = "shift", default = "shift" });
	OptionsManager.registerOption2("SCALING",false, "option_header_hotkeys", "option_label_Scaling", "option_entry_cycler", 
		{ labels = "option_val_shift|option_val_alt|option_val_wheel", values = "shift|alt|wheel", baselabel = "option_val_ctrl", baseval = "ctrl", default = "ctrl" });
end

function onWheel(target, notches)
	local sOptFacing = OptionsManager.getOption("FACING");
	local bFacing = false;
	local sOptScale = OptionsManager.getOption("SCALING");
	local bScaling = false;
	if sOptFacing == "shift" and Input.isShiftPressed() then
		bFacing = true;
	elseif sOptFacing == "ctrl" and Input.isControlPressed() then
		bFacing = true;
	elseif sOptFacing == "alt" and Input.isAltPressed() then
		bFacing = true;
	elseif sOptFacing == "wheel" and not Input.isShiftPressed() and not Input.isControlPressed() and not Input.isAltPressed() then
		bFacing = true;
	end
	if sOptScale == "shift" and Input.isShiftPressed() then
		bScaling = true;
	elseif sOptScale == "ctrl" and Input.isControlPressed() then
		bScaling = true;
	elseif sOptScale == "alt" and Input.isAltPressed() then
		bScaling = true;
	elseif sOptScale == "wheel" and not Input.isShiftPressed() and not Input.isControlPressed() and not Input.isAltPressed() then
		bScaling = true;
	end
	
	if bFacing then
		local vImage = ImageManager.getImageControl(target, true);
		local OrientationCount = vImage.getTokenOrientationCount();
		target.setOrientation((target.getOrientation()+notches)%OrientationCount);
		return true;
	end
	if bScaling then
		local scale = target.getScale();
		if UtilityManager.isClientFGU() then
			local adj = notches * 0.1;
			if adj < 0 then
				scale = scale * (1 + adj);
			else
				scale = scale * (1 / (1 - adj));
			end
		else
			-- if Input.isShiftPressed() then
				-- scale = math.floor(scale + notches);
				-- if scale < 1 then
					-- scale = 1;
				-- end
			-- else
				scale = scale + (notches * 0.1);
				if scale < 0.1 then
					scale = 0.1;
				end
			-- end
		end
		target.setScale(scale); 
		return true; 
	end
	if Input.isShiftPressed() or Input.isControlPressed() then
		return true;
	end
end