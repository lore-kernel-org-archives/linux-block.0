Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.12-rc
Message-ID: <807cadff-89de-2a9b-f882-b8729e4e0fb0@kernel.dk>
Date: Wed, 21 Jun 2017 18:48:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This pull request contains a set of fixes for xen-blkback by way of
Konrad, and a performance regression fix for blk-mq for shared tags. The
latter could account for as much as a 50x reduction in performance, with
the test case from the user with 500 name spaces. A more realistic setup
on my end with 32 drives showed a 3.5x drop. The fix has been thoroughly
tested before being committed.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jan Beulich (1):
      xen-blkback: don't leak stack data via response ring

Jens Axboe (2):
      Merge branch 'stable/for-jens-4.12' of git://git.kernel.org/.../konrad/xen into for-linus
      blk-mq: fix performance regression with shared tags

Juergen Gross (3):
      xen/blkback: fix disconnect while I/Os in flight
      xen/blkback: don't free be structure too early
      xen/blkback: don't use xen_blkif_get() in xen-blkback kthread

 block/blk-mq-sched.c                | 58 +++++++++++++++++++++++++++++--------
 block/blk-mq-sched.h                |  9 ------
 block/blk-mq.c                      | 16 ++++++++--
 drivers/block/xen-blkback/blkback.c | 26 ++++++++---------
 drivers/block/xen-blkback/common.h  | 26 ++++-------------
 drivers/block/xen-blkback/xenbus.c  | 15 +++++-----
 include/linux/blkdev.h              |  2 ++
 7 files changed, 87 insertions(+), 65 deletions(-)

-- 
Jens Axboe
