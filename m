Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35565 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdEDHbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:43 -0400
Received: by mail-pf0-f179.google.com with SMTP id v14so3723840pfd.2
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:42 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 00/12] blk-mq-sched: scheduler support and cleanups
Date: Thu,  4 May 2017 00:31:22 -0700
Message-Id: <cover.1493882751.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series makes several enhancements to blk-mq-debugfs. v2 adds
patches 3, 4, and 5. It also exports a couple of symbols needed in
patches 11 and 12.

- Patch 1 is a subjective change.
- Patch 2 is a cleanup.
- Patches 3 and 4 are minor tweaks to the queue "state" attribute.
- Patch 5 renames the hardware queue directories.
- Patch 6 cleans up a bunch of seq_file boilerplate.
- Patch 7 is Bart's patch from a couple of weeks ago, necessitated by
  patch 9.
- Patch 8 is preparation cleanup for patches 9-12.
- Patch 9 reworks the lifetimes of the debugfs attributes to be tied to
  the structure lifetimes themselves rather being duct taped on to
  sysfs. This is what I should have done in the first place, and would
  have also been a way to fix the same thing we fixed in e869b5462f83
  ("blk-mq: Unregister debugfs attributes earlier"), but I didn't think
  of doing it this way until I started adding scheduler support.
- Patch 10 allows schedulers to register debugfs attributes, implemented
  in patches 11 and 12 for kyber and mq-deadline, respectively.

Bart Van Assche (1):
  blk-mq: Do not invoke queue operations on a dead queue

Omar Sandoval (11):
  blk-mq-debugfs: separate flags with |
  blk-mq-debugfs: clean up flag definitions
  blk-mq-debugfs: error on long write to queue "state" file
  blk-mq-debugfs: don't open code strstrip()
  blk-mq-debugfs: rename hw queue directories from <n> to hctx<n>
  blk-mq-debugfs: get rid of a bunch of boilerplate
  blk-mq: move debugfs declarations to a separate header file
  blk-mq: untangle debugfs and sysfs
  blk-mq-debugfs: allow schedulers to register debugfs attributes
  kyber: add debugfs attributes
  mq-deadline: add debugfs attributes

 block/blk-core.c         |   8 +-
 block/blk-mq-debugfs.c   | 870 +++++++++++++++++++++--------------------------
 block/blk-mq-debugfs.h   |  79 +++++
 block/blk-mq-sched.c     |  24 +-
 block/blk-mq-sysfs.c     |  10 -
 block/blk-mq.c           |   7 +
 block/blk-mq.h           |  28 --
 block/blk-sysfs.c        |   3 +
 block/kyber-iosched.c    | 130 +++++++
 block/mq-deadline.c      | 123 +++++++
 include/linux/blk-mq.h   |   5 +
 include/linux/blkdev.h   |   2 +-
 include/linux/elevator.h |   7 +
 13 files changed, 764 insertions(+), 532 deletions(-)
 create mode 100644 block/blk-mq-debugfs.h

-- 
2.12.2
