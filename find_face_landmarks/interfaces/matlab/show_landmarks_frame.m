%% Function shows landmarks

function show_landmarks_frame(frame)
    for f = 1:length(frame.faces)
        rectangle('Position', frame.faces(f).bbox, 'EdgeColor', 'r');
        x = frame.faces(f).landmarks(:,1);
        y = frame.faces(f).landmarks(:,2);
        scatter(x, y, 'g.');
    end
end