function love.load()
    WINDOW_DIMENSIONS = {}
    WINDOW_DIMENSIONS.width, WINDOW_DIMENSIONS.height = love.window.getMode()
    GRID_AREA_DIMENSIONS = {
        width = 500,
        height = 500
    }

    GRID_SIZE = 15

    GRID = {}
    for column = 1, GRID_SIZE, 1 do
        GRID[column] = {}
        for row = 1, GRID_SIZE, 1 do
            GRID[column][row] = 0
        end
    end

    -- Each snake body part is a table of the x and y position
    local centre_position = math.floor(GRID_SIZE / 2)
    SNAKE_BODY_PARTS = {
        {x = centre_position,     y = centre_position},
        {x = centre_position - 1, y = centre_position},
        {x = centre_position - 2, y = centre_position}
    }
    -- The direction that the head is facing can be 1 (UP), 2 (RIGHT), 3 (DOWN) or 4 (LEFT)
    HEAD_DIRECTION = 2
    -- The amount of time between movements of the snake.
    MOVE_TIME_SECONDS = 0.5
    MOVE_TIMER = 0.0

    FOOD_POS = {x = centre_position + 5, y = centre_position}
end

local function colliding_with_body_part()
    local head_pos = SNAKE_BODY_PARTS[1]
    for index, position in pairs(SNAKE_BODY_PARTS) do
        if index > 1 then -- Ensure that the collided body part is not the head
            if  (head_pos == position) then
                return true
            end
        end
    end
    return false
end

local function check_for_collisions()
    local head_pos = SNAKE_BODY_PARTS[1]

    if  (head_pos.y > GRID_SIZE and HEAD_DIRECTION == 3)
     or (head_pos.y == 0        and HEAD_DIRECTION == 1)
     or (head_pos.x > GRID_SIZE and HEAD_DIRECTION == 2)
     or (head_pos.x == 0        and HEAD_DIRECTION == 4)
     or colliding_with_body_part() then
        return true
    else
        return false
    end
end

local function move_snake_tail_parts(previous_snake_pos)
    -- Loop through each tail part and set it to the part in front of it from the previous position
    for index = 1, #SNAKE_BODY_PARTS, 1 do
        if index > 1 then
            SNAKE_BODY_PARTS[index] = previous_snake_pos[index - 1]
        end
    end
end

local function copy_table(tab)
    local new_table = {}
    for index, position in ipairs(tab) do
        table.insert(new_table, index, {x = position.x, y = position.y})
    end
    return new_table
end

-- Move the snake 1 square in the direction it is facing
local function move_snake()
    local previous_snake_pos = copy_table(SNAKE_BODY_PARTS)
    if HEAD_DIRECTION == 1 then
        SNAKE_BODY_PARTS[1].y = SNAKE_BODY_PARTS[1].y - 1
    elseif HEAD_DIRECTION == 2 then
        SNAKE_BODY_PARTS[1].x = SNAKE_BODY_PARTS[1].x + 1
    elseif HEAD_DIRECTION == 3 then
        SNAKE_BODY_PARTS[1].y = SNAKE_BODY_PARTS[1].y + 1
    elseif HEAD_DIRECTION == 4 then
        SNAKE_BODY_PARTS[1].x = SNAKE_BODY_PARTS[1].x - 1
    end
    move_snake_tail_parts(previous_snake_pos)
end

function love.keyreleased(key, scancode)
    if key == "w" or key == "up" then
        HEAD_DIRECTION = 1
    elseif key == "d" or key == "right" then
        HEAD_DIRECTION = 2
    elseif key == "s" or key == "down" then
        HEAD_DIRECTION = 3
    elseif key == "a" or key == "left" then
        HEAD_DIRECTION = 4
    end
end

local function add_to_end_of_snake()
    local current_end_of_snake = SNAKE_BODY_PARTS[#SNAKE_BODY_PARTS]
    local current_second_to_last_segment = SNAKE_BODY_PARTS[#SNAKE_BODY_PARTS - 1]
    if current_end_of_snake.y >= current_second_to_last_segment.y then
        table.insert(SNAKE_BODY_PARTS, {current_end_of_snake.x, current_end_of_snake.y + 1})
    elseif current_end_of_snake.y <= current_second_to_last_segment.y then
        table.insert(SNAKE_BODY_PARTS, {current_end_of_snake.x, current_end_of_snake.y - 1})
    elseif current_end_of_snake.x >= current_second_to_last_segment.x then
        table.insert(SNAKE_BODY_PARTS, {current_end_of_snake.x + 1, current_end_of_snake.y})
    elseif current_end_of_snake.x <= current_second_to_last_segment.x then
        table.insert(SNAKE_BODY_PARTS, {current_end_of_snake.x - 1, current_end_of_snake.y})
    end
end

---------------------------------
---------UPDATE FUNCTION---------
---------------------------------
function love.update()
    if GAME_OVER == true then return end

    MOVE_TIMER = MOVE_TIMER + love.timer.getDelta()
    if MOVE_TIMER >= MOVE_TIME_SECONDS then

        move_snake()

        -- Check if the player has lost the game
        if check_for_collisions() == true then
            print("Game Over!")
            GAME_OVER = true
            --love.event.push("quit")
        end

        if SNAKE_BODY_PARTS[1] == FOOD_POS then
            add_to_end_of_snake()
            FOOD_POS.x = love.math.random(15)
            FOOD_POS.y = love.math.random(15)
        end

        -- Reset the timer
        MOVE_TIMER = MOVE_TIMER - MOVE_TIME_SECONDS
    end
end

local function draw_grid_squares()
    BORDER_WIDTH_PX = 4
    local grid_square_area = {
        x_px = GRID_AREA_DIMENSIONS.width / GRID_SIZE,
        y_px = GRID_AREA_DIMENSIONS.height / GRID_SIZE
    }

    for column, row in pairs(GRID) do
        for index, value in pairs(row) do


            local grid_square_pos = {
                x_px = grid_square_area.x_px * (column - 1) + 50 + (BORDER_WIDTH_PX / 2),
                y_px = grid_square_area.y_px * (index - 1) + 100 + (BORDER_WIDTH_PX / 2)
            }

            -- Draw a rectange for each grid square
            love.graphics.setColor(0, 0.6, 0)
            love.graphics.rectangle(
                "fill",
                grid_square_pos.x_px,
                grid_square_pos.y_px,
                grid_square_area.x_px - BORDER_WIDTH_PX,
                grid_square_area.y_px - BORDER_WIDTH_PX
            )

        end -- row - for loop
    end -- column - for loop
end

local function get_grid_square_data_from_coordinate(coordinate)
    local grid_square_area = {
        x_px = GRID_AREA_DIMENSIONS.width / GRID_SIZE,
        y_px = GRID_AREA_DIMENSIONS.height / GRID_SIZE
    }
    local grid_square_pos = {
        x_px = grid_square_area.x_px * (coordinate.x - 1) + 50 + (BORDER_WIDTH_PX / 2),
        y_px = grid_square_area.y_px * (coordinate.y - 1) + 100 + (BORDER_WIDTH_PX / 2)
    }
    return {
        x_px = grid_square_pos.x_px,
        y_px = grid_square_pos.y_px,
        width_px = grid_square_area.x_px,
        height_px = grid_square_area.y_px
    }
end

local function draw_snake()
    for index, coordinate in pairs(SNAKE_BODY_PARTS) do
        if coordinate.x < GRID_SIZE or coordinate.x > 0
        or coordinate.y < GRID_SIZE or coordinate.y > 0 then
            local grid_square_data = get_grid_square_data_from_coordinate(coordinate)
            if index == 1 then
                love.graphics.setColor(0, 0, 1)
                love.graphics.rectangle(
                    "fill",
                    grid_square_data.x_px,
                    grid_square_data.y_px,
                    grid_square_data.width_px,
                    grid_square_data.height_px
                )
            else
                love.graphics.setColor(0, 1, 0)
                love.graphics.rectangle(
                    "fill",
                    grid_square_data.x_px,
                    grid_square_data.y_px,
                    grid_square_data.width_px,
                    grid_square_data.height_px
                )
            end -- head check
        end -- out of bounds check
    end -- for loop
end --function

local function draw_food()
    local grid_square_data = get_grid_square_data_from_coordinate(FOOD_POS)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "fill",
        grid_square_data.x_px,
        grid_square_data.y_px,
        grid_square_data.width_px,
        grid_square_data.height_px
    )
end

---------------------------------
----------DRAW FUNCTION----------
---------------------------------
function love.draw()
    love.graphics.clear(0, 0.4, 0)
    draw_grid_squares()
    draw_food()
    draw_snake()
end
