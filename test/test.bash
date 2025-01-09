#!/bin/bash
# SPDX-FileCopyrightText: 2025 tento
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc


res=0

error () {
    echo failure: ${1},
	res=$((res + 1))
}


today=`date "+%Y/%m/%d"`
todayweek=`date "+%w"`
weekarray=("Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat")
weekstr=${weekarray[${todayweek}]}

timeout 10 ros2 launch mypkg future_week_calc.launch.py > /tmp/mypkg.log
sleep 2
cat /tmp/mypkg.log
cat /tmp/mypkg.log |
grep "Listen str: ${today} is ${weekstr}" || error "$LINENO"


ros2 run mypkg zellers &
ROS_PID=$!

# { timeout 8 ros2 run mypkg zellers; } &
{ timeout 10 ros2 topic echo /calc_week; } &
PID1=$!
{ ros2 topic pub --once /date std_msgs/msg/UInt32 "data: 20040601"; } 

wait $PID1
# kill -SIGINT $PID1

# wait $PID1
# wait $PID2

sleep 5
cat /tmp/mypkg1.log
cat /tmp/mypkg1.log |
grep "data: 3" || error "$LINENO"


# { timeout 8 ros2 run mypkg zellers; } &
{ timeout 10 ros2 topic echo /calc_week; } &
PID1=$!
{ ros2 topic pub --once /date std_msgs/msg/UInt32 "data: 19920719"; } 

wait $PID1
# kill -SIGINT $PID1

# wait $PID1
# wait $PID2

sleep 5
cat /tmp/mypkg1.log
cat /tmp/mypkg1.log |
grep "data: 3" || error "$LINENO"

# { timeout 8 ros2 run mypkg zellers; } &
{ timeout 10 ros2 topic echo /calc_week > /tmp/mypkg3.log; } &
PID1=$!
{ ros2 topic pub --once /date std_msgs/msg/UInt32 "data: 19780216"; }

wait $PID1
# kill -SIGINT $PID1

# wait $PID1
# wait $PID2

sleep 5
cat /tmp/mypkg1.log
cat /tmp/mypkg1.log |
grep "data: 3" || error "$LINENO"

# { timeout 8 ros2 run mypkg zellers; } &
{ timeout 10 ros2 topic echo /calc_week > /tmp/mypkg4.log; } &
PID1=$!
{ ros2 topic pub --once /date std_msgs/msg/UInt32 "data: 20250105"; } &

wait $PID1
# kill -SIGINT $PID1

# wait $PID1
# wait $PID2

sleep 5
cat /tmp/mypkg1.log
cat /tmp/mypkg1.log |
grep "data: 3" || error "$LINENO"






echo jobs
jobs -l

sleep 3
kill -SIGINT $ROS_PID
sleep 3

echo killed jobs
jobs -l


sleep 5

echo "res= $res"
ls /tmp/
echo 0
cat /tmp/mypkg.log
echo 1
cat /tmp/mypkg1.log
echo 2
cat /tmp/mypkg2.log
echo 3
cat /tmp/mypkg3.log
echo 4
cat /tmp/mypkg4.log


exit $res


