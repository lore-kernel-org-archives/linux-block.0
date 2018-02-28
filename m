Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v5 0/6] Fix races between blkcg code and request queue initialization and cleanup
Date: Wed, 28 Feb 2018 10:15:27 -0800
Message-Id: <20180228181533.29402-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Recently Joseph Qi identified races between the block cgroup code and request
queue initialization and cleanup. This patch series address these races.

This patch series is structured as follows:
- Patches 3..6 fix the aforementioned races.
- Patches 1..3 ensure that all maintained block drivers delete the gendisk
  before cleaning up the request queue because patches 3..6 are only safe
  if block driver shutdown uses this order. The gdrom driver (Sega Dreamcast
  GD-ROM driver) has not been modified because from what I saw in the changelog
  of this driver it seems to me like that driver is no longer in use. According
  to what I found on the web production of Sega Dreamcast was stopped in 2001
  (https://www.theguardian.com/business/2001/feb/01/4).

Please consider these patches for kernel v4.17.

Thanks,

Bart.

Changes between v4 and v5:
- Made the title of patch 4/6 more clear.
- Made the description of this patch series more detailed.

Changes between v3 and v4:
- Added three patches that fix the calling order of del_gendisk() and
  blk_cleanup_queue() in multiple block drivers.

Changes between v2 and v3:
- Added a third patch that fixes a race between the blkcg code and queue
  cleanup.

Changes between v1 and v2:
- Split a single patch into two patches.
- Dropped blk_alloc_queue_node2() and modified all block drivers that call
  blk_alloc_queue_node().

Bart Van Assche (6):
  block/loop: Delete gendisk before cleaning up the request queue
  md: Delete gendisk before cleaning up the request queue
  zram: Delete gendisk before cleaning up the request queue
  block: Add a third argument to blk_alloc_queue_node()
  block: Fix a race between the cgroup code and request queue
    initialization
  block: Fix a race between request queue removal and the block cgroup
    controller
    
Bart Van Assche (6):
  block/loop: Delete gendisk before cleaning up the request queue
  md: Delete gendisk before cleaning up the request queue
  zram: Delete gendisk before cleaning up the request queue
  block: Add 'lock' as third argument to blk_alloc_queue_node()
  block: Fix a race between the cgroup code and request queue
    initialization
  block: Fix a race between request queue removal and the block cgroup
    controller

 block/blk-core.c               | 60 +++++++++++++++++++++++++++++++++++-------
 block/blk-mq.c                 |  2 +-
 block/blk-sysfs.c              |  7 -----
 drivers/block/drbd/drbd_main.c |  3 +--
 drivers/block/loop.c           |  2 +-
 drivers/block/null_blk.c       |  3 ++-
 drivers/block/umem.c           |  7 +++--
 drivers/block/zram/zram_drv.c  |  2 +-
 drivers/ide/ide-probe.c        |  2 +-
 drivers/lightnvm/core.c        |  2 +-
 drivers/md/dm.c                |  2 +-
 drivers/md/md.c                |  6 ++---
 drivers/nvdimm/pmem.c          |  2 +-
 drivers/nvme/host/multipath.c  |  2 +-
 drivers/scsi/scsi_lib.c        |  2 +-
 include/linux/blkdev.h         |  3 ++-
 16 files changed, 70 insertions(+), 37 deletions(-)

-- 
2.16.2
