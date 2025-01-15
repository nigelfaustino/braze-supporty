This is an example of an app that has all the correct methods for registering a push token and processing push notifications, but never sets a UserNotificationCenter delegate, which results in those methods for processing never actually getting called.


