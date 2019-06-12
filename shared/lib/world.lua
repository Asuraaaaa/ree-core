function _RenderMarkerList(list, id, scale)
    for _, blip in pairs(list) do
        DrawMarker(id, blip[1], blip[2], blip[3] - 0.675, 0.0, 0.0, 0.0,
                   90.0, 0.0, 0.0, scale, scale, scale,
                   200, 200, 200, 80, false, false,
                   2, false, 0, 0, false)
    end
end

REE.Lib.World = {
    _RenderMarker     = _RenderMarker,
    _RenderMarkerList = _RenderMarkerList,
}