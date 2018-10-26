Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block changes for 4.20-rc1
Message-ID: <8ce17575-5db8-955f-4e79-9874c1641614@kernel.dk>
Date: Fri, 26 Oct 2018 10:00:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A followup pull request for this merge window. This pull request
contains:

- Set of patches improving support for zoned devices. This was ready
  before the merge window, but I was late in picking it up and hence it
  missed the original pull request (Damien, Christoph)

- libata no link power management quirk addition for a Samsung drive
  (Diego Viola)

- Fix for a performance regression in BFQ that went into this merge
  window (Federico Motta)

- Fix for a missing dma mask setting return value check (Gustavo)

- Typo in the gdrom queue failure case (me)

- NULL pointer deref fix for xen-blkfront (Vasilis Liaskovitis)

- Fixing the get_rq trace point placement in blk-mq (Xiaoguang Wang)

- Removal of a set-but-not-read variable in cdrom (zhong jiang)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181026


----------------------------------------------------------------
Christoph Hellwig (1):
      block: add a report_zones method

Damien Le Moal (10):
      scsi: sd_zbc: Rearrange code
      scsi: sd_zbc: Reduce boot device scan and revalidate time
      scsi: sd_zbc: Fix sd_zbc_check_zones() error checks
      block: Introduce blkdev_nr_zones() helper
      block: Limit allocation of zone descriptors for report zones
      block: Introduce BLKGETZONESZ ioctl
      block: Introduce BLKGETNRZONES ioctl
      block: Improve zone reset execution
      block: Expose queue nr_zones in sysfs
      block: Introduce blk_revalidate_disk_zones()

Diego Viola (1):
      libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9

Federico Motta (1):
      block, bfq: fix asymmetric scenarios detection

Gustavo A. R. Silva (1):
      skd: fix unchecked return values

Jens Axboe (1):
      gdrom: fix mistake in assignment of error

Vasilis Liaskovitis (1):
      xen/blkfront: avoid NULL blkfront_info dereference on device removal

Xiaoguang Wang (1):
      blk-mq: place trace_block_getrq() in correct place

zhong jiang (1):
      cdrom: remove set but not used variable 'tocuse'

 block/bfq-wf2q.c               |  18 +-
 block/blk-core.c               |   1 -
 block/blk-lib.c                |  13 +-
 block/blk-mq-debugfs.c         |   1 -
 block/blk-mq.c                 |   4 +-
 block/blk-sysfs.c              |  13 ++
 block/blk-zoned.c              | 359 ++++++++++++++++++-----------
 block/blk.h                    |   8 +
 block/ioctl.c                  |   4 +
 drivers/ata/libata-core.c      |   1 +
 drivers/block/null_blk.h       |  11 +-
 drivers/block/null_blk_main.c  |  30 +--
 drivers/block/null_blk_zoned.c |  57 ++---
 drivers/block/skd_main.c       |   4 +-
 drivers/block/xen-blkfront.c   |   3 +
 drivers/cdrom/gdrom.c          |   8 +-
 drivers/md/dm-flakey.c         |  30 ++-
 drivers/md/dm-linear.c         |  35 +--
 drivers/md/dm-table.c          |  10 +
 drivers/md/dm-zoned-target.c   |   3 +-
 drivers/md/dm.c                | 169 +++++++-------
 drivers/scsi/sd.c              |  15 +-
 drivers/scsi/sd.h              |  15 +-
 drivers/scsi/sd_zbc.c          | 501 +++++++++++------------------------------
 include/linux/blk_types.h      |   2 -
 include/linux/blkdev.h         |  30 ++-
 include/linux/device-mapper.h  |  12 +-
 include/trace/events/f2fs.h    |   1 -
 include/uapi/linux/blkzoned.h  |   3 +
 29 files changed, 620 insertions(+), 741 deletions(-)

-- 
Jens Axboe
