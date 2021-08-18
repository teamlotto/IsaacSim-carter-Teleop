# IsaacSim-carter-Teleop
![image](https://user-images.githubusercontent.com/69780812/129903573-0dbb98df-da47-4c87-ab13-d8683fcc0848.png)
## PREPARATION
- ros-melodic
  - ROS Master (Server, 로컬 환경에서 roscore 실행) 
  - ROS Client (Client, 도커 컨테이너 Isaac-sim 환경)
  - Serever에 teleop 패키지가 다운로드 되어있어야합니다.
    - ```shell
      sudo apt-get install ros-melodic-teleop-twist-keyboard
      ```
- Custom docker container
  - isaac-sim nvcr.io docker ([참고링크](https://docs.nvidia.com/ngc/ngc-overview/index.html#generating-api-key)) 기반 isaac-sdk, ros-melodic을 설치한 도커 이미지입니다.
  - [Our Team's Docker Hub](https://hub.docker.com/orgs/lottoworld777/repositories)
  - ![image](https://user-images.githubusercontent.com/69780812/129685629-71147ca7-b776-4600-a402-25bc2de71ac0.png)
- Model
  - carter
- 현재 Repository를 git clone 해주세요.
## My Running Order
### 1. Carter URDF 불러오기
![image](https://user-images.githubusercontent.com/69780812/129904216-45c73be0-6eeb-4c29-9685-a79175bb5458.png)
- 상단 메뉴에서 Isaac Utils > URDF Importer

![image](https://user-images.githubusercontent.com/69780812/129904351-74f53761-6b6e-4727-9203-3f051325792e.png)
- Joint Drive Type : Velocity
- Uncheck : Fix Base Link
- Click Select and Parse URDF

![image](https://user-images.githubusercontent.com/69780812/129904443-48e05415-7e9e-46a1-99ee-e23d9693779e.png)
- 위를 실행한 후에 Click Import Robot To Stage
### 2. Carter Properties 설정 준비 및 진행
![image](https://user-images.githubusercontent.com/69780812/129905467-cf7798a2-f6f4-473b-9cea-016aea018529.png)
- carter를 /World 로 Drag 해서 넣어줍니다. (필요한 과정은 아닌 것 같긴함.)

![image](https://user-images.githubusercontent.com/69780812/129905137-0260d966-408e-43a2-81e3-d7e32d4a5544.png)
- Create > Isacc > ROS > Differential Base 생성 후 /carter로 Drag 합니다.
  - Differential Base가 /cmd_vel 이라는 토픽을 Subscribe하고, /odom 토픽을 Publish 합니다.

![image](https://user-images.githubusercontent.com/69780812/129905771-5e8d5f6b-637d-431d-bd3d-d2cebf39954b.png)
- Create > Xfrom > /carter/chassis_link 로 Drag 해줍니다.
- ROS_Differential_Base 의 Property에서 Raw USD Properties의 설정값들을 변경해줍니다.
  - leftWheelJointName : left_wheel
  - rightWheelJointName : right_wheel

### 3. 실행
```shell
roscore
rostopic list
```
- roscore를 실행하고 나면, 기본 토픽들만 있습니다.
- roscore를 실행하고 나서 Isaac-Sim을 Play 해줍니다.
  - 다시 rostopic list를 확인하면 아래 토픽들만 있을 것입니다.
  - ```shell
    /cmd_vel
    /odom
    /rosout
    /rosout_agg
    /tf
    ```
```shell
rosrun teleop_twist_keyboard teleop_twist_keyboard.py
```
- teleop 패키지를 실행해줍니다.
  - 실행시, 방향키 설명이 나오니 u,i,j ... 등의 키를 이용해서 제어합니다.
  - Twist 메시지의 제어값을 확인하려면 rostopic echo cmd_vel
  - Odom 메시지의 변화를 확인하려면 rostopic echo odom

![isaac-sim-joint-carter-teleop](https://user-images.githubusercontent.com/69780812/129910526-d72dc24b-472e-4928-8c13-abda28e71e8b.gif)
