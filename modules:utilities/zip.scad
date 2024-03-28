function zip(list1, list2) = [
for (i= [0:(len(list1) + len(list2)-2)]) 
    (i % 2 == 0) ? list1[i/2] : list2[i/2]
];