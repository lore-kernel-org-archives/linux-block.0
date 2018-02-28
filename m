Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 00/11] Make all concurrent queue flag manipulations safe
Date: Wed, 28 Feb 2018 11:28:12 -0800
Message-Id: <20180228192823.5191-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

As you probably know there is considerable confusion in the block layer core
and in block drivers about how to protect queue flag changes against
concurrent modifications. Some code protects these changes with the queue
lock, other code uses atomic operations and some code does not protect queue
flag changes against concurrent changes at all. Hence this patch series that
protects all queue flag changes consistently with the queue lock and that
removes functions that are not safe in a concurrent context from the public
block layer header files.

Please consider these patches for kernel v4.17.

Note: it may be a good idea to postpone patch 11 until after the kernel v4.17
merge window to avoid merge conflicts.

Thanks,

Bart.

Bart Van Assche (11):
  block: Reorder the queue flag manipulaton function definitions
  block: Use the queue_flag_*() functions instead of open-coding these
  block: Introduce blk_queue_flag_{set,clear,test_and_{set,clear}}()
  block: Protect queue flag changes with the queue lock
  mtip32xx: Use the blk_queue_flag_*() functions
  bcache: Use the blk_queue_flag_{set,clear}() functions
  iscsi: Use blk_queue_flag_set()
  target/tcm_loop: Use blk_queue_flag_set()
  block: Use blk_queue_flag_*() in drivers instead of queue_flag_*()
  block: Complain if queue_flag_(set|clear)_unlocked() is abused
  block: Move the queue_flag_*() functions from a public into a private
    header file

 block/blk-core.c                            | 93 +++++++++++++++++++++++------
 block/blk-mq.c                              | 17 ++----
 block/blk-settings.c                        |  6 +-
 block/blk-stat.c                            |  6 +-
 block/blk-sysfs.c                           | 22 +++----
 block/blk-timeout.c                         |  6 +-
 block/blk.h                                 | 69 +++++++++++++++++++++
 block/bsg-lib.c                             |  4 +-
 drivers/block/drbd/drbd_nl.c                |  4 +-
 drivers/block/loop.c                        | 10 ++--
 drivers/block/mtip32xx/mtip32xx.c           |  8 +--
 drivers/block/nbd.c                         |  8 +--
 drivers/block/null_blk.c                    |  6 +-
 drivers/block/rbd.c                         |  4 +-
 drivers/block/rsxx/dev.c                    |  6 +-
 drivers/block/skd_main.c                    |  4 +-
 drivers/block/xen-blkfront.c                | 10 ++--
 drivers/block/zram/zram_drv.c               |  6 +-
 drivers/ide/ide-disk.c                      |  4 +-
 drivers/ide/ide-probe.c                     |  2 +-
 drivers/lightnvm/pblk-init.c                |  2 +-
 drivers/md/bcache/super.c                   |  6 +-
 drivers/md/dm-table.c                       | 16 ++---
 drivers/md/md-linear.c                      |  4 +-
 drivers/md/md.c                             |  4 +-
 drivers/md/raid0.c                          |  4 +-
 drivers/md/raid1.c                          |  6 +-
 drivers/md/raid10.c                         |  6 +-
 drivers/md/raid5.c                          |  4 +-
 drivers/mmc/core/queue.c                    |  8 +--
 drivers/mtd/mtd_blkdevs.c                   |  6 +-
 drivers/nvdimm/blk.c                        |  2 +-
 drivers/nvdimm/btt.c                        |  2 +-
 drivers/nvdimm/pmem.c                       |  4 +-
 drivers/nvme/host/core.c                    |  4 +-
 drivers/nvme/host/multipath.c               |  2 +-
 drivers/s390/block/dasd.c                   |  4 +-
 drivers/s390/block/dcssblk.c                |  2 +-
 drivers/s390/block/scm_blk.c                |  4 +-
 drivers/s390/block/xpram.c                  |  4 +-
 drivers/scsi/iscsi_tcp.c                    |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c   |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        |  2 +-
 drivers/scsi/scsi_debug.c                   |  2 +-
 drivers/scsi/scsi_lib.c                     |  2 +-
 drivers/scsi/scsi_transport_sas.c           |  4 +-
 drivers/scsi/sd.c                           |  8 +--
 drivers/target/loopback/tcm_loop.c          |  2 +-
 include/linux/blkdev.h                      | 76 +++--------------------
 50 files changed, 270 insertions(+), 221 deletions(-)

-- 
2.16.2
