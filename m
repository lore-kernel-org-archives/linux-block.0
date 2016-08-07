Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60755 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbcHGUuJ (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sun, 7 Aug 2016 16:50:09 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Final block changes for 4.8-rc1
Message-ID: <0f62a222-0863-4b30-25ce-897b1a383ac0@fb.com>
Date: Sun, 7 Aug 2016 14:49:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

As mentioned in the pull the other day, a few more fixes for this
round, all related to the bio op changes in this series. Two fixes, and
then a cleanup, renaming bio->bi_rw to bio->bi_opf. I wanted to do that
change right after or right before -rc1, so that risk of conflict was
reduced. I just rebased the series on top of current master, and no new
->bi_rw usage has snuck in.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (4):
       block/mm: make bdev_ops->rw_page() take a bool for read/write
       mm: make __swap_writepage() use bio_set_op_attrs()
       target: iblock_execute_sync_cache() should use bio_set_op_attrs()
       block: rename bio bi_rw to bi_opf

  Documentation/block/biodoc.txt            |  4 ++--
  Documentation/device-mapper/dm-flakey.txt |  2 +-
  block/bio-integrity.c                     |  2 +-
  block/bio.c                               |  6 ++---
  block/blk-core.c                          | 26 +++++++++++-----------
  block/blk-merge.c                         |  8 +++----
  block/blk-mq.c                            | 10 ++++-----
  block/blk-throttle.c                      |  8 +++----
  block/cfq-iosched.c                       |  4 ++--
  drivers/block/brd.c                       | 16 ++++++-------
  drivers/block/drbd/drbd_main.c            |  8 +++----
  drivers/block/drbd/drbd_receiver.c        |  2 +-
  drivers/block/drbd/drbd_req.c             |  6 ++---
  drivers/block/drbd/drbd_worker.c          |  2 +-
  drivers/block/pktcdvd.c                   |  2 +-
  drivers/block/umem.c                      |  2 +-
  drivers/block/zram/zram_drv.c             | 23 ++++++++++---------
  drivers/md/bcache/request.c               | 12 +++++-----
  drivers/md/bcache/super.c                 |  2 +-
  drivers/md/bcache/writeback.h             |  2 +-
  drivers/md/dm-cache-target.c              |  8 +++----
  drivers/md/dm-crypt.c                     |  4 ++--
  drivers/md/dm-era-target.c                |  2 +-
  drivers/md/dm-flakey.c                    |  6 ++---
  drivers/md/dm-io.c                        |  6 ++---
  drivers/md/dm-log-writes.c                |  4 ++--
  drivers/md/dm-mpath.c                     |  2 +-
  drivers/md/dm-raid1.c                     | 10 ++++-----
  drivers/md/dm-region-hash.c               |  4 ++--
  drivers/md/dm-snap.c                      |  6 ++---
  drivers/md/dm-stripe.c                    |  4 ++--
  drivers/md/dm-thin.c                      |  8 +++----
  drivers/md/dm-zero.c                      |  2 +-
  drivers/md/dm.c                           | 10 ++++-----
  drivers/md/linear.c                       |  2 +-
  drivers/md/md.c                           |  4 ++--
  drivers/md/multipath.c                    |  8 +++----
  drivers/md/raid0.c                        |  2 +-
  drivers/md/raid1.c                        |  6 ++---
  drivers/md/raid10.c                       |  8 +++----
  drivers/md/raid5-cache.c                  |  2 +-
  drivers/md/raid5.c                        | 20 ++++++++---------
  drivers/nvdimm/btt.c                      | 12 +++++-----
  drivers/nvdimm/pmem.c                     | 16 ++++++-------
  drivers/target/target_core_iblock.c       |  2 +-
  fs/block_dev.c                            |  6 ++---
  fs/btrfs/check-integrity.c                | 10 ++++-----
  fs/btrfs/disk-io.c                        |  2 +-
  fs/btrfs/inode.c                          |  6 ++---
  fs/btrfs/volumes.c                        |  6 ++---
  fs/mpage.c                                |  2 +-
  include/linux/bio.h                       |  4 ++--
  include/linux/blk-cgroup.h                |  4 ++--
  include/linux/blk_types.h                 | 37 
++++++++++++++++---------------
  include/linux/blkdev.h                    |  2 +-
  include/linux/fs.h                        |  3 +--
  include/linux/pagemap.h                   |  2 +-
  include/trace/events/bcache.h             |  8 +++----
  include/trace/events/block.h              | 14 ++++++------
  kernel/trace/blktrace.c                   |  6 ++---
  mm/filemap.c                              |  4 ++--
  mm/page_io.c                              |  5 +++--
  62 files changed, 213 insertions(+), 213 deletions(-)

-- 
Jens Axboe

