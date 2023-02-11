function love.load()
    WINDOW_DIMENSIONS = {}
    WINDOW_DIMENSIONS.width, WINDOW_DIMENSIONS.height = love.window.getMode()
    GRID_AREA_DIMENSIONS = {
        width = 500,
        height = 500
    }

    GRID_SIZE = 9

    GRID = {}
    for column = 1, GRID_SIZE, 1 do
        GRID[column] = {}
        for row = 1, GRID_SIZE, 1 do
            GRID[column][row] = 0
        end
    end
end

function love.update()

end

function love.draw()

    love.graphics.clear(0, 0.4, 0)

    local grid_square_area = {
        x_px = GRID_AREA_DIMENSIONS.width / GRID_SIZE,
        y_px = GRID_AREA_DIMENSIONS.height / GRID_SIZE
    }

    for column, row in ipairs(GRID) do
        for index, value in ipairs(row) do


            local grid_square_pos = {
                x_px = grid_square_area.x_px * (column - 1) + 50,
                y_px = grid_square_area.y_px * (index - 1) + 100
            }

            -- Draw a rectange for each grid square
            love.graphics.setColor(0, 0.6, 0)
            love.graphics.rectangle(
                "fill",
                grid_square_pos.x_px,
                grid_square_pos.y_px,
                grid_square_area.x_px,
                grid_square_area.y_px
            )

            -- Draw an outline for each grid square
            love.graphics.setColor(0, 0.4, 0)
            love.graphics.rectangle(
                "line",
                grid_square_pos.x_px,
                grid_square_pos.y_px,
                grid_square_area.x_px,
                grid_square_area.y_px
            )

        end -- row - for loop
    end -- column - for loop
end -- love.draw() - function
