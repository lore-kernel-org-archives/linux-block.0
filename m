Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.17-rc2
Message-ID: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
Date: Wed, 25 Apr 2018 10:50:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

I ended up sitting on this about a week longer than I wanted to,
since we were hashing out details with a timeout change. I've now
killed that patch, so we can flush the existing queue in due time.

This pull request contains:

- Fix for an old regression, where entering the queue can be disturbed
  by a signal to the process. This can cause spurious EIO. Fix from Alan
  Jenkins.

- cdrom information leak fix from Dan.

- Trivial helper for testing queue FUA from Dave Chinner, part of his
  O_DIRECT FUA series.

- Series of swim fixes from Finn that actually makes it work again.

- Loop O_DIRECT corruption fix, which caused data corruption in
  production for us. From me.

- BFQ crash fix from me.

- bcache maintainer update. Michael no longer has the time to do it,
  Coly has stepped up to serve as the new maintainer.

- blkcg locking fixes from Jiang Biao.

- Revert of a change from this merge window from Ming, that causes an
  issue on some hardware.

- Minor clarification doc addition from Linus Walleij.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180425


----------------------------------------------------------------
Alan Jenkins (1):
      block: do not use interruptible wait anywhere

Dan Carpenter (1):
      cdrom: information leak in cdrom_ioctl_media_changed()

Dave Chinner (1):
      block: add blk_queue_fua() helper function

Finn Thain (8):
      m68k/mac: Don't remap SWIM MMIO region
      block/swim: Fix array bounds check
      block/swim: Remove extra put_disk() call from error path
      block/swim: Don't log an error message for an invalid ioctl
      block/swim: Rename macros to avoid inconsistent inverted logic
      block/swim: Check drive type
      block/swim: Fix IO error at end of medium
      block/swim: Select appropriate drive on device open

Jens Axboe (4):
      loop: remove cmd->rq member
      loop: handle short DIO reads
      bfq-iosched: ensure to clear bic/bfqq pointers when preparing request
      bcache: mark Coly Li as bcache maintainer

Jianchao Wang (1):
      blk-mq: start request gstate with gen 1

Jiang Biao (3):
      blkcg: don't hold blkcg lock when deactivating policy
      blkcg: small fix on comment in blkcg_init_queue
      blkcg: init root blkcg_gq under lock

Linus Walleij (1):
      block: mq: Add some minor doc for core structs

Michael Lyle (1):
      MAINTAINERS: Remove me as maintainer of bcache

Ming Lei (1):
      Revert "blk-mq: remove code for dealing with remapping queue"

 MAINTAINERS            |  2 +-
 block/bfq-iosched.c    | 10 +++++++-
 block/blk-cgroup.c     | 28 ++++++++++------------
 block/blk-core.c       | 15 ++++++------
 block/blk-mq.c         | 41 +++++++++++++++++++++++++++++---
 block/blk-mq.h         |  3 +++
 drivers/block/loop.c   | 64 +++++++++++++++++++++++++++++++++-----------------
 drivers/block/loop.h   |  1 -
 drivers/block/swim.c   | 49 +++++++++++++++++---------------------
 drivers/block/swim3.c  |  6 ++---
 drivers/cdrom/cdrom.c  |  2 +-
 include/linux/blk-mq.h |  3 +++
 include/linux/blkdev.h |  1 +
 13 files changed, 144 insertions(+), 81 deletions(-)

-- 
Jens Axboe
