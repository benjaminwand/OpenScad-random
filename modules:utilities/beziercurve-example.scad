/*     functions for the distances    */

// roughly the size of parts of curves,
// is a global value
fs = 0.5;

// distance between two points
function dist(a, b) = len(a)==2?
sqrt(                 // two dimensions
    (a[0]-b[0])^2
    +(a[1]-b[1])^2
    ):
sqrt(                 // three dimensions
    (a[0]-b[0])^2
    +(a[1]-b[1])^2
    +(a[2]-b[2])^2
    );

// length of curve
  function length(pts) = [
    // three control points
    if (len(pts) == 3)
        0.43 * dist(pts[0], pts[1])
      + 0.53 * dist(pts[0], pts[2])
      + 0.43 * dist(pts[1], pts[2])
    // four control points
    else if (len(pts) == 4)
        0.35 * dist(pts[0], pts[1])
      + 0.40 * dist(pts[0], pts[2])
      + 0.23 * dist(pts[0], pts[3])
      - 0.09 * dist(pts[1], pts[2])
      + 0.40 * dist(pts[1], pts[2])
    // five control points
    else if (len(pts) == 5)
        0.32 * dist(pts[0], pts[1])
      + 0.35 * dist(pts[0], pts[2])
      + 0.23 * dist(pts[0], pts[3])
      + 0.10 * dist(pts[0], pts[4])
      - 0.13 * dist(pts[1], pts[2])
      + 0.20 * dist(pts[1], pts[3])
      + 0.23 * dist(pts[1], pts[4])
      - 0.13 * dist(pts[2], pts[3])
      + 0.35 * dist(pts[2], pts[4])
      + 0.32 * dist(pts[3], pts[4])
    else
        echo("Wrong number of points")]
  [0];       // makes list into number
  
 /*     calculating the points      */
 
  // determine fn
function b_curv(pts, n) =
  let (fn=
  // is n given? if so fn = n
  n ? n :
  // if no n is given,
  // are there two controlpoints?
  len(pts) == 2 ?
  // if yes: fn = 2
  2 :
  // and if no, calculate:
  length(pts)/fs)
  // now knowing fn,
  // call b_pts() and concatenate points
    [for (i= [0:fn]) 
      concat(b_pts(pts, 1/(fn-1), i))];

// calculate singular points
function b_pts(pts, fn, idx) =
  // has pts more than two points?
  len(pts) > 2 ?
  // it calls itself in smaller portions
    b_pts([for(i=[0:len(pts)-2])
        pts[i]], fn, idx) * fn*idx
      + b_pts([for(i=[1:len(pts)-1])
        pts[i]], fn, idx) * (1-fn*idx)
  // at two points we do the familiar
  // 'p1 · [0...1] + p2 · [1...0]'
    : pts[0] * fn*idx
      + pts[1] * (1-fn*idx);


/*     displaying     */  
      
// points
p1 = [5.5, 0];
p2 = [1.5, 0];
p3 = [0, 2];
p4 = [0, 7];

// calculating the points
points = b_curv([p1, p2, p3, p4]);
//points = b_curv([p2, p3]);

// displaying the calculated points
rainbow(points);

// displaying points as a rainbow
module rainbow (points) {
  for (i= [0 : len(points)-1 ])
  color([cos(20*i)/2+0.5,  // red
        -sin(20*i)/2+0.5,  // green
        -cos(20*i)/2+0.5,  // blue
        1])                // alpha
translate(points[i]) sphere(0.5, $fn=10);
}

// displaying [p1 .. p4]
for (i=[p1, p2, p3, p4])
  translate(i) color("black")
    cylinder(1, 0.2, 0.2, $fn=10);
