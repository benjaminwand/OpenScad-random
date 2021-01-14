// Thread module, add your parameters and call with 'thread()'

// variables, adjust to your liking
full_circle_height = 2.5; 
degrees = 720;
fn = 80;
thread_polygon =  // 2 dimensions, works like extrude
    [[15,2], 
    [14,3], 
    [15,4]];

// proportions, don't touch
len_poly = len(thread_polygon);
fn_thread = 360/fn;
number_of_layers = degrees * fn/360;

// function call
// thread();

function move_points(thread_polygon) =
    [for (g=[0:fn_thread:degrees])
        concat([for (j = [0:len(thread_polygon)-1])
            [sin(g) * thread_polygon[j][0], 
            -cos(g) * thread_polygon[j][0], 
            thread_polygon[j][1] + full_circle_height * g/360,]
        ])
    ];

module thread(upper_points, lower_points)   
polyhedron( 
    points = [
        for (k=[0:1:degrees], j = [0 : len_poly - 1])
            [((move_points(thread_polygon)[k][j][0])),
            ((move_points(thread_polygon)[k][j][1])),
            ((move_points(thread_polygon)[k][j][2]))]
    ],
    faces = [
                        // upper plane
        [for (i= [0 : len_poly-1]) i], 
                        // towards lower points
        for (i = [0 : number_of_layers -1], j = [0 : len_poly - 1])
                [len_poly * i + (j+1)%len_poly, 
                len_poly * i + j, 
                len_poly * (i+1) + j],
                        // towards upper points
        for (i = [1 : number_of_layers], j = [0 : len_poly - 1])
                [len_poly * i + j, 
                len_poly * i + (j+1) % len_poly, 
                len_poly * (i-1) + (j+1) % len_poly],
                        // lower plane
        [for (i= [len_poly * (number_of_layers+1) -1  : -1 : len_poly * number_of_layers]) i], 
    ]   
);