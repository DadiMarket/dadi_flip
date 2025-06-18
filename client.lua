-- Función para cargar configuración JSON
local function loadConfig()
    local configFile = LoadResourceFile(GetCurrentResourceName(), 'config.json')
    return json.decode(configFile)
end

-- Función para cargar locales JSON
local function loadLocales()
    local localeFile = LoadResourceFile(GetCurrentResourceName(), 'locales/es.json') -- Cambia 'es' por tu idioma
    return json.decode(localeFile)
end

-- Cargar configuración y locales
local config = loadConfig()
local locale = loadLocales()

---@param vehicle number? id of the vehicle, default closes vehicle
---@param flipTest boolean? costom fliping task
local function flipVehicle(vehicle, flipTest)
    if cache.vehicle then return end
    if not vehicle then vehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), config.maxDistance, false) end
    if not vehicle then return exports.qbx_core:Notify(locale.error.no_vehicle_nearby, 'error') end
    local peedCoords = GetEntityCoords(cache.ped)
    local vehicleCoords = GetEntityCoords(vehicle)

    if #(peedCoords - vehicleCoords) > config.maxDistance then
        return exports.qbx_core:Notify(locale.error.no_vehicle_nearby, 'error')
    end

    if flipTest or lib.progressBar({
        label = locale.progress.flipping_car,
        duration = config.flipingTime,
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            mouse = false,
            combat = true
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then
        SetVehicleOnGroundProperly(vehicle)
        exports.qbx_core:Notify(locale.success.flipped_car, 'success')
    else
        exports.qbx_core:Notify(locale.error.canceled, 'error')
    end
end

-- Función para verificar si el vehículo está volcado
local function isVehicleFlipped(vehicle)
    if not vehicle then return false end
    
    local roll = GetEntityRoll(vehicle)
    local pitch = GetEntityPitch(vehicle)
    
    -- Verifica si el vehículo está volcado (usando el ángulo del config)
    if math.abs(roll) > config.minFlipAngle or math.abs(pitch) > config.minFlipAngle then
        return true
    end
    
    return false
end

-- Función para verificar si hay jugadores en el vehículo
local function hasPlayersInVehicle(vehicle)
    if not vehicle then return false end
    
    for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
        local ped = GetPedInVehicleSeat(vehicle, i)
        if ped ~= 0 and IsPedAPlayer(ped) then
            return true
        end
    end
    
    return false
end

-- Registrar ox_target global para vehículos
CreateThread(function()
    exports.ox_target:addGlobalVehicle({
        {
            name = 'flip_vehicle',
            icon = 'fa-solid fa-car-crash',
            label = 'Voltear Vehículo',
            onSelect = function(data)
                flipVehicle(data.entity)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                -- Solo mostrar si está configurado para permitir jugadores dentro o no hay jugadores
                local playersInside = hasPlayersInVehicle(entity)
                local canFlip = config.allowFlipWithPlayers or not playersInside
                
                -- Solo mostrar la opción si el vehículo está volcado y se cumple la condición de jugadores
                return isVehicleFlipped(entity) and canFlip
            end,
            distance = config.maxDistance
        }
    })
end)

-- Limpieza al cerrar el recurso
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    exports.ox_target:removeGlobalVehicle('flip_vehicle')
end)

---@deprecated use FlipVehicle instead
exports('flipVehicle', flipVehicle)

exports('FlipVehicle', flipVehicle)