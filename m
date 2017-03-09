Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.11-rc2
Message-ID: <2faede4d-81ff-9f64-399b-51b328e2425b@kernel.dk>
Date: Thu, 9 Mar 2017 09:02:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Sending this a bit sooner than I otherwise would have, as a fix in the
merge window had some unfortunate issues and side effects for some
folks.

This pull request contains:

- Fixes from Jan for the bdi registration/unregistration. These have
  been tested by the various parties reporting issues, and should be
  solid at this point.

- Also from Jan, fix for axonram gendisk registration.

- A stable fix for zram from Johannes.

- A small series from Ming, fixing up some long standing issues with
  blk-mq hardware queue kobject initialization and registration.

- A fix for sed opal from Jon, fixing a nonsensical range check and some
  set-but-not-used variables.

- A fix from Neil for a long standing deadlock issue for stacking device
  drivers. With this in place, dm/md don't have to work around the issue
  anymore, and can be properly fixed up.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jan Kara (5):
      block: Allow bdi re-registration
      bdi: Fix use-after-free in wb_congested_put()
      block: Make del_gendisk() safer for disks without queues
      Revert "scsi, block: fix duplicate bdi name registration crashes"
      axonram: Fix gendisk handling

Johannes Thumshirn (1):
      zram: set physical queue limits to avoid array out of bounds accesses

Jon Derrick (1):
      block/sed: Fix opal user range check and unused variables

Ming Lei (4):
      blk-mq: initialize mq kobjects in blk_mq_init_allocated_queue()
      blk-mq: make lifetime consitent between q/ctx and its kobject
      blk-mq: make lifetime consistent between hctx and its kobject
      blk-mq: free hctx->cpumask in release handler of hctx's kobject

NeilBrown (1):
      blk: improve order of bio handling in generic_make_request()

 arch/powerpc/sysdev/axonram.c |  5 ++++-
 block/blk-core.c              | 27 +++++++++++++++++++++------
 block/blk-mq-sysfs.c          | 40 +++++++++++++++++++++++++---------------
 block/blk-mq.c                | 28 ++++++++++------------------
 block/blk-mq.h                |  2 ++
 block/genhd.c                 | 37 ++++++++++---------------------------
 block/sed-opal.c              | 10 ++--------
 drivers/block/zram/zram_drv.c |  2 ++
 drivers/scsi/sd.c             | 41 ++++++++---------------------------------
 include/linux/blkdev.h        |  1 -
 include/linux/genhd.h         |  8 --------
 mm/backing-dev.c              | 43 ++++++++++++++++++++++++++++---------------
 12 files changed, 112 insertions(+), 132 deletions(-)

-- 
Jens Axboe
