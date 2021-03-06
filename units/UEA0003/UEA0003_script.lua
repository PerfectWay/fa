#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0003/UEA0003_script.lua
#**
#**  Summary  :  UEF sACU Pod Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit

UEA0003 = Class(TConstructionUnit) {
    Parent = nil,

    OnScriptBitSet = function(self, bit)
        TConstructionUnit.OnScriptBitSet(self, bit)
        if bit == 1 then
            self.rebuildDrone = true
        end
    end,
    
    OnScriptBitClear = function(self, bit)
        TConstructionUnit.OnScriptBitClear(self, bit)
        if bit == 1 then
            self.rebuildDrone = false
        end
    end,
    
    SetParent = function(self, parent, podName)
        self.Parent = parent
        self.Pod = podName
        self:SetScriptBit('RULEUTC_WeaponToggle', true)
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        self.Parent:NotifyOfPodDeath(self.Pod, self.rebuildDrone)
        self.Parent = nil
        TConstructionUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

}

TypeClass = UEA0003