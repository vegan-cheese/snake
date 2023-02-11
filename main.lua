function love.load()
    WINDOW_DIMENSIONS = {}
    WINDOW_DIMENSIONS.width, WINDOW_DIMENSIONS.height = love.window.getMode()
    GRID_AREA_DIMENSIONS = {
        width = WINDOW_DIMENSIONS.width - 100,
        height = WINDOW_DIMENSIONS.height - 100
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
    local grid_square_width = GRID_AREA_DIMENSIONS.width / GRID_SIZE
    local grid_square_height = GRID_AREA_DIMENSIONS.height / GRID_SIZE
    for column, column_table in ipairs(GRID) do
        for row, square_value in ipairs(column_table) do
            local grid_square_pos_x = grid_square_width * (column - 1) + 50
            local grid_square_pos_y = grid_square_height * (row - 1) + 50
        end
    end
end
