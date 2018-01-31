Return-Path: <prvs=562a2f801=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 0/2] block: Fix a race between the throttling code and request queue initialization
Date: Wed, 31 Jan 2018 15:52:58 -0800
Message-Id: <20180131235300.12773-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The two patches in this series fix a recently reported race between the
throttling code and request queue initialization. It would be appreciated
if you could have a look at this patch series.

Thanks,

Bart.

Changes between v1 and v2:
- Split a single patch into two patches.
- Dropped blk_alloc_queue_node2() and modified all block drivers that call
  blk_alloc_queue_node().

Bart Van Assche (2):
  block: Add a third argument to blk_alloc_queue_node()
  block: Fix a race between the throttling code and request queue
    initialization

 block/blk-core.c               | 29 +++++++++++++++++++----------
 block/blk-mq.c                 |  2 +-
 drivers/block/drbd/drbd_main.c |  3 +--
 drivers/block/null_blk.c       |  3 ++-
 drivers/block/umem.c           |  7 +++----
 drivers/ide/ide-probe.c        |  2 +-
 drivers/lightnvm/core.c        |  2 +-
 drivers/md/dm.c                |  2 +-
 drivers/mmc/core/queue.c       |  3 +--
 drivers/nvdimm/pmem.c          |  2 +-
 drivers/nvme/host/multipath.c  |  2 +-
 drivers/scsi/scsi_lib.c        |  2 +-
 include/linux/blkdev.h         |  3 ++-
 13 files changed, 35 insertions(+), 27 deletions(-)

-- 
2.16.0
