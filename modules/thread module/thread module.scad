// Thread module, add your parameters and call with 'thread()'

// variables
full_circle_height = 2.5; 
degrees = 720;
fn = 10;
thread_polygon =  // 2-dimensions, works like extrude
    [[15,2], 
    [14,3], 
    [15,4]];

// proportions, don't touch
len_poly = len(thread_polygon);
fn_thread = 360/fn;

// function call
// loft_screw();

function move_points(thread_polygon) =
    [for (g=[0:fn_thread:degrees])
        concat([for (j = [0:len(thread_polygon)-1])
            [sin(g) * thread_polygon[j][0], 
            -cos(g) * thread_polygon[j][0], 
            thread_polygon[j][1] + full_circle_height * g/360,]
        ])
    ];

module loft_screw(){
    for(k=[0:1:degrees])
        loft(
        move_points(thread_polygon)[k],
        move_points(thread_polygon)[k+1]);
};

module loft(upper_points, lower_points)   
polyhedron( 
    points = [
        for (i = [0 : 1], j = [0 : len_poly - 1])
            [((upper_points[j][0] * (1 - i)) + (lower_points[j][0] * i)),
            ((upper_points[j][1] * (1 - i)) + (lower_points[j][1] * i)),
            ((upper_points[j][2] * (1 - i)) + (lower_points[j][2] * i))]
    ],
    faces = [
        [for (i = [0 : len_poly -1]) i],   // Upper plane.
        for (i = [0 : len_poly -1])        // Towards lower points.
            [ (i+1)%len_poly, i, len_poly + i, // Towards upper points.
            len_poly + i, len_poly + (i+1) % len_poly, (i+1) % len_poly],
        [for (i= [len_poly * 2 -1 : -1 : len_poly]) i], // Lower plane.
    ]
);
        