Return-Path: <prvs=585cc836a=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v4 0/6] Fix races between blkcg code and request queue initialization and cleanup
Date: Thu, 22 Feb 2018 17:08:02 -0800
Message-Id: <20180223010808.25765-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Recently Joseph Qi identified races between the block cgroup code and request
queue initialization and cleanup. This patch series address these races. Please
consider these patches for kernel v4.17.

Thanks,

Bart.

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
