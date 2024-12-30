
function length(pts) = [
    if (len(pts) == 3) 
        0.43 * dist(pts[0], pts[1])
      + 0.53 * dist(pts[0], pts[2])
      + 0.43 * dist(pts[1], pts[2])
    else if (len(pts) == 4)         
        0.35 * dist(pts[0], pts[1])
      + 0.40 * dist(pts[0], pts[2])
      + 0.23 * dist(pts[0], pts[3])
      - 0.09 * dist(pts[1], pts[2])
      + 0.40 * dist(pts[1], pts[2])
      + 0.35 * dist(pts[2], pts[3])
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
        echo("Wrong number of points")
        ][0]; 

function dist(a, b) = len(a)==2?
sqrt(
    (a[0]-b[0])^2
    +(a[1]-b[1])^2
    ):
sqrt(
    (a[0]-b[0])^2
    +(a[1]-b[1])^2
    +(a[2]-b[2])^2
    );
      
      
      
// examples      
echo(length([[5.5, 0], [1.5, 0], [0, 2]]));
echo(length([[5.5, 0], [1.5, 0], [0, 2], [0, 7]]));
echo(length([[5.5, 0], [1.5, 0], [0, 2], [0, 7], [1, 7]]));
echo(length([2]));
echo(dist([5.5, 0],[1.5, 2]));
echo(dist([5.5, 0,3],[1.5, 2,55]));
