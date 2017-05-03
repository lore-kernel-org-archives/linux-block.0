Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36387 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756372AbdECTTK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:10 -0400
Received: by mail-pg0-f48.google.com with SMTP id t7so82975844pgt.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:10 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 0/9] blk-mq-debugfs: scheduler support and cleanups
Date: Wed,  3 May 2017 12:18:53 -0700
Message-Id: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series makes more enhancements to blk-mq-debugfs.

- Patch 1 is a subjective change.
- Patches 2 and 3 are cleanups.
- Patch 4 is Bart's patch from a couple of weeks ago, necessitated by
  patch 6.
- Patch 5 is another cleanup.
- Patch 6 reworks the lifetimes of the debugfs attributes to be tied to
  the structure lifetimes themselves rather being duct taped on to
  sysfs. This is what I should have done in the first place, and would
  have also been a way to fix the same thing we fixed in e869b5462f83
  ("blk-mq: Unregister debugfs attributes earlier"), but I didn't think
  of doing it this way until I started adding scheduler support.
- Patch 7 allows schedulers to register debugfs attributes, implemented
  in patches 8 and 9 for kyber and mq-deadline, respectively.

Please take a look and give it a spin.

Thanks!

Bart Van Assche (1):
  blk-mq: Do not invoke queue operations on a dead queue

Omar Sandoval (8):
  blk-mq-debugfs: separate flags with |
  blk-mq-debugfs: clean up flag definitions
  blk-mq-debugfs: get rid of a bunch of boilerplate
  blk-mq: move debugfs declarations to a separate header file
  blk-mq: untangle debugfs and sysfs
  blk-mq-debugfs: allow schedulers to register debugfs attributes
  kyber: add debugfs attributes
  mq-deadline: add debugfs attributes

 block/blk-core.c         |   8 +-
 block/blk-mq-debugfs.c   | 851 +++++++++++++++++++++--------------------------
 block/blk-mq-debugfs.h   |  79 +++++
 block/blk-mq-sched.c     |  24 +-
 block/blk-mq-sysfs.c     |  10 -
 block/blk-mq.c           |   7 +
 block/blk-mq.h           |  28 --
 block/blk-sysfs.c        |   3 +
 block/kyber-iosched.c    | 130 ++++++++
 block/mq-deadline.c      | 123 +++++++
 include/linux/blk-mq.h   |   5 +
 include/linux/blkdev.h   |   2 +-
 include/linux/elevator.h |   7 +
 13 files changed, 751 insertions(+), 526 deletions(-)
 create mode 100644 block/blk-mq-debugfs.h

-- 
2.12.2
