Return-Path: <prvs=423213d9ff=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 0/6] Lots of NBD fixes and enhancements
Date: Tue, 28 Feb 2017 11:57:05 -0500
Message-ID: <1488301031-3199-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This is kind of a big batch of patches, but they all depend on eachother so it
was hard to tease out the fixes from the enhancements without making my life
miserable.

FIXES:
nbd: set queue timeout properly
nbd: handle ERESTARTSYS properly

The ERSTARTSYS one in particular is pretty awful as we can tear down a whole
device if a userspace app has a signal pending while submitting IO.  This is big
and scary but I had a debug patch on top of this to randomly induce ERESTARTSYS
to make sure it was behaving properly.

ENHANCEMENTS:

1) Handle signle path failures gracefully.  This is the first step to handling
reconnects gracefully, but for right now we can easily fall back on other
connections if we happen to lose one connection.

2) Ref counting and bdev change.  This is in preparation for the netlink patch
and handling reconnects and the such better.

3) Netlink interface.  Trying to add the nbd-control thing was controversial,
and I realized the more I wanted to do with monitoring and stuff I would need to
use netlink for anyway.  With this new interface we can easily configure and
disconnect devices, dynamically add devices if we are past our pre-allocated
limit, and dynamically find free devices to use if we don't want to try and hunt
for a device.  The userspace patch to utilize this is kind of rough but can be
found in my github tree

https://github.com/josefbacik/nbd

These have been pretty well tested, but I'd like to hear any thoughts on the new
interface.  Thanks,

Josef
