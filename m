Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44835 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750782AbdFREj2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 00:39:28 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Sun, 18 Jun 2017 14:38:56 +1000
Subject: [PATCH 00/13] block: assorted cleanup for bio splitting and cloning.
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149776047907.23258.8058071140236879834.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a resend of my series of patches working
towards removing the bioset work queues.

This set is based on for-4.13/block.

It incorporates the revised versions of all the patches that were
resent following feedback on the last set.

It also includes a minor grammatic improvement to a comment, and
simple changes to compensate for a couple of changes to the block tree
since the last posting.

I hope to eventually get rid of the new BIOSET_NEED_RESCUER flag,
but that needs work in dm and probably bcache first.

Thanks,
NeilBrown


---

NeilBrown (13):
      blk: remove bio_set arg from blk_queue_split()
      blk: replace bioset_create_nobvec() with a flags arg to bioset_create()
      blk: make the bioset rescue_workqueue optional.
      blk: use non-rescuing bioset for q->bio_split.
      block: Improvements to bounce-buffer handling
      rbd: use bio_clone_fast() instead of bio_clone()
      drbd: use bio_clone_fast() instead of bio_clone()
      pktcdvd: use bio_clone_fast() instead of bio_clone()
      lightnvm/pblk-read: use bio_clone_fast()
      xen-blkfront: remove bio splitting.
      bcache: use kmalloc to allocate bio in bch_data_verify()
      block: remove bio_clone() and all references.
      block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()


 Documentation/block/biodoc.txt      |    2 -
 block/bio.c                         |   73 ++++++++++++++++-------------------
 block/blk-core.c                    |    4 +-
 block/blk-merge.c                   |   31 ++-------------
 block/blk-mq.c                      |    2 -
 block/bounce.c                      |   32 ++++++++++++---
 drivers/block/drbd/drbd_int.h       |    3 +
 drivers/block/drbd/drbd_main.c      |   13 ++++++
 drivers/block/drbd/drbd_req.c       |    2 -
 drivers/block/drbd/drbd_req.h       |    2 -
 drivers/block/pktcdvd.c             |   14 +++++--
 drivers/block/ps3vram.c             |    2 -
 drivers/block/rbd.c                 |   16 +++++++-
 drivers/block/rsxx/dev.c            |    2 -
 drivers/block/umem.c                |    2 -
 drivers/block/xen-blkfront.c        |   54 +-------------------------
 drivers/lightnvm/pblk-init.c        |   16 ++++++--
 drivers/lightnvm/pblk-read.c        |    2 -
 drivers/lightnvm/pblk.h             |    1 
 drivers/lightnvm/rrpc.c             |    2 -
 drivers/md/bcache/debug.c           |    2 -
 drivers/md/bcache/super.c           |    8 +++-
 drivers/md/dm-crypt.c               |    3 +
 drivers/md/dm-io.c                  |    3 +
 drivers/md/dm.c                     |    5 +-
 drivers/md/md.c                     |    6 +--
 drivers/md/raid1.c                  |    2 -
 drivers/md/raid10.c                 |    2 -
 drivers/md/raid5-cache.c            |    2 -
 drivers/md/raid5-ppl.c              |    2 -
 drivers/md/raid5.c                  |    2 -
 drivers/s390/block/dcssblk.c        |    2 -
 drivers/s390/block/xpram.c          |    2 -
 drivers/target/target_core_iblock.c |    2 -
 fs/block_dev.c                      |    2 -
 fs/btrfs/extent_io.c                |    3 +
 fs/xfs/xfs_super.c                  |    3 +
 include/linux/bio.h                 |   12 ++----
 include/linux/blkdev.h              |    3 -
 39 files changed, 168 insertions(+), 173 deletions(-)

--
Signature
