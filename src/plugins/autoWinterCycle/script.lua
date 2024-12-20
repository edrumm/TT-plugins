local settings

function script:init()
    settings = Util.optStorage(TheoTown.getStorage(), self:getDraft():getId()..":settings")
    settings.enableAutoWinterCycle = settings.enableAutoWinterCycle == nil and true or settings.enableAutoWinterCycle
    City.setFunVar("winter", 0)
end

function setWinter()
    if settings.enableAutoWinterCycle and not DSA.isInMoon() then
        local month = City.getMonth()
        if month >= 11 or month <= 2 then
            City.setFunVar("winter", 1)
        else
            City.setFunVar("winter", 0)
        end
    end
end

function script:settings()
    return {
        {
            name = 'Auto winter cycle',
            value = settings.enableAutoWinterCycle,
            onChange = function(state) settings.enableAutoWinterCycle = state end
        }
    }
end

function script:enterCity()
    setWinter()
end

function script:leaveCity()
    City.setFunVar("winter", 0)
end

function script:nextMonth()
    setWinter()
end