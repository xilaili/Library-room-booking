# Library_sys
<title>CSC 517 - Project 1</title><br>
By Xilai Li, Zhiren Lu, Siyu Huang.<br>
<b>The application is hosted here :https://library-room-booking-lxl.herokuapp.com/  </b><br>
Following are the things that are already set up :
<ul>
<li>Pre configured admin with email: <b>useremail: xli47@ncsu.edu , password: kevinlee</b></li>
<li>There are preset member in system</li>
<li>Some room are preset in system</li>
</ul>
<h3>Feature listing</h3>
* <b>Admin</b>
  * <b><u>Self profile</u></b>:
    * An admin can login and update his/her profile details .
  * <b><u>Manage Admins</u></b>: 
    * Admin can view all the admins through the adminlist on the top of the website.
    * delete the admins in the system(except himself and the admin”xli47@ncsu.edu” ):go to the adminlist click the delete button.
    * add admin: admin has two ways to add admins. The first way is to add a new admin by click the add admin/user button. The second way is to go to the users list, and click the add/remove admin button to change a exist user to be admin. 
  * <b><u>Manage Rooms</u></b>: 
    * Admin can create a new room, delete the room, see list of the room. 
    * Only admin can see the history of the room
    * Only admin can cancel the room booked by others: go to the room showpage, if the room is booked by other member,admin also can the cancel button and cancel the room. 
  * <b><u>Manage Members</u></b>: 
    * Displays a list of all library members:click the userslist on the top of the webpage. 
    * See the profile of each member and see the history(only list the latest 10 histories, though history model saved all the history):go to the userslist page and click the user that you want to see.
    * Add/remover admin to a user, see whether the member is the admin in his profile
      * delete user:go to the userlist page click the delete button behind the name of the user
      * add user: click the add user/admin button on the top of the website.
      * change a exist user to be admin: go to the userlist page and click the add/remove admin button.
* <b>Member </b> 
  * Anyone can signup to become a member. He is automatically logged in after signup.He can update his password and name (email update is not allowed).
  * Book a room that is available to member and cancel the room that he booked.
  * See the room that he booked in the profile page and also his history of booking room  in user profile page(show page)
* <b>Test</b>
  * we have write the test case to the user model and user controller.
    * users_controller_test(path:test/controllers/users_controller_test.rb):test the function of the controller
    * user_test(path:test/models/user_test.rb):test the function of the model
    * integration test(path:test/integration/):test the important part of the users, like:login, signup, edit.



