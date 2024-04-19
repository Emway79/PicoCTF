"""
Find the hidden part of the flag by hashing the username and creating a string out of specific indices of the hash in hex format.
Indices in order are: 4, 5, 3, 6, 2, 7, 1, 8
"""

import hashlib

username_trial = b"MORTON"

enc = hashlib.sha256(username_trial).hexdigest()
key = enc[4] + enc[5] + enc[3] + enc[6] + enc[2] + enc[7] + enc[1] + enc[8]

print(key)
