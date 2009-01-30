Discussion
==========

This is an attempt to create a minimalist, maths-aware forum that allows users 
to discuss academic papers.

Key Features
============

Here are the minimal set of features I hope to implement:

 * Papers have a title, abstract, and one or more authors.

 * Users can post comments on papers that can contain LaTeX which will be 
   rendered as images. Previews will be provided.

 * Comments on a paper will notify its authors and others who have commented
   on the paper via email.

 * Paper authors and commentators can ask not to received comments.

 * Users can edit their comments

 * Simple CAPTCHAs will be used to limit spam comments

User Interaction
================

All interaction is via email. There will be no user accounts. Sessions will be
handled by cookies.

To edit a comment or start/stop email notification on a thread the user will
need to log in. This is achieved by asking the user to go to a URL that is 
specific to his or her email address. This URL is sent to the user's email 
address. It will look something like this:

	http://discussionsite.com/login/jl29cjv03sdfn

The garbage at the end of the URL is essentially a password. Since the damage
at stake is low (Someone may edit someone else's comment. Whoop-ti-do!) 
the level of security is lowered to increase convenience (No accounts and 
passwords to remember). 

Once the user visits this URL, a cookie is set that allows the user to edit 
any comment that has been associated with that user's email address in the past.
The user may also switch on and off notifications for comments on a 
thread-by-thread basis.

Authors log in using exactly the same mechanism but may also opt out of 
notifications for comments on their papers (which is on by default).
