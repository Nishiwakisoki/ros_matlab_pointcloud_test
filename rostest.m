% ROS ノードの初期化
rosinit;

pcpub = rospublisher("/pc_test_node","sensor_msgs/PointCloud2","DataFormat","struct");

xyz = uint8(10*rand(128,128,3));
emptyRosMsg = rosmessage(pcpub);
rosMsg = rosWriteXYZ(emptyRosMsg,xyz,"PointStep",32);

% メッセージのフレーム ID を設定
rosMsg.Header.FrameId = 'base_link'; % 使用するフレーム ID を指定
r = rosrate(1);
reset(r)
for i = 1:100
	time = r.TotalElapsedTime;
	send(pcpub,rosMsg);
	waitfor(r);
end



% ROS ノードの終了
rosshutdown;