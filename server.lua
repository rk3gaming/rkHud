local resource = GetCurrentResourceName()

lib.versionCheck('rk3gaming/rkHud')

if not LoadResourceFile(resource, 'web/build/dist/index.html') then
    CreateThread(function()
        while true do
            print('^1[ERROR] The UI hasn\'t been built, the HUD won\'t work correctly. Please build it or install a release https://github.com/rk3gaming/rkHud^0')
            Wait(10000)
        end
    end)
end
