# README

# Library Room Booking App

By Bhavesh Kasliwal, Rishabh Sinha, Rishi Jain.

Server URL: https://mighty-tundra-19161.herokuapp.com/

Ruby version: 	2.3

Rails version: 	5.0

Database: 		PostgreSQL

Preconfigured Super-Admin:

Username: superman@batman.com

Password: wonderwoman

Major Features: 

  •	Library members can create accounts, create and modify their profile, create and cancel room reservations and see their history.

  •	Admins can modify their profile, manage other admins, manage rooms, manage library members.

  •	Super-Admin cannot be modified or deleted by other admins.
  
Special Scenarios: 
 
  • Room is deleted: The history of the room is deleted. If there are any bookings for that room then those are cancelled. Room is removed from the library member's history as well.
  
  •	Library Member is deleted: The history of the Library Member is cleared and the member is removed from the room history as well. Any bookings pertaining to the library member is cancelled.
  
Extra Features:

  •	The user can send a notification message to other library members in his/her team with the details of the reservation by passing a comma separated list of the emails of his/her team members in the email section while making the reservation.
  
  • The admin make multiple reservations for a library member.

# Note:
Please do not mess with the Super-Admin account, as there might be others also who will be using the same account for different purposes.
