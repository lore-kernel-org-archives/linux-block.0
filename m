Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 00/12] Twelve small block layer patches
Date: Thu, 17 Aug 2017 16:22:59 -0700
Message-Id: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The twelve patches in this series are patches I came up with while working
on block drivers and SCSI drivers. Please consider these for inclusion in
kernel v4.14.

Thanks,

Bart.

Bart Van Assche (12):
  block: Fix two comments that refer to .queue_rq() return values
  block: Unexport blk_queue_end_tag()
  blk-mq: Explain when 'active_queues' is decremented
  blk-mq: Make blk_mq_reinit_tagset() calls easier to read
  blk-mq-debugfs: Declare a local symbol static
  blk-mq-debugfs: Generate name-to-text translation tables
  genhd: Annotate all part and part_tbl pointer dereferences
  ide-floppy: Use blk_rq_is_scsi()
  virtio_blk: Use blk_rq_is_scsi()
  xen-blkback: Fix indentation
  xen-blkback: Avoid that gcc 7 warns about fall-through when building
    with W=1
  xen-blkfront: Avoid that gcc 7 warns about fall-through when building
    with W=1

 block/.gitignore                    |   1 +
 block/Makefile                      |  58 ++++++++++++++++
 block/blk-mq-debugfs.c              | 132 +-----------------------------------
 block/blk-mq-tag.c                  |   9 +--
 block/blk-mq.c                      |   8 ++-
 block/blk-tag.c                     |   1 -
 block/genhd.c                       |  15 ++--
 block/partition-generic.c           |  15 +++-
 drivers/block/virtio_blk.c          |   2 +-
 drivers/block/xen-blkback/blkback.c |   5 +-
 drivers/block/xen-blkback/xenbus.c  |   3 +-
 drivers/block/xen-blkfront.c        |   2 +-
 drivers/ide/ide-floppy.c            |   2 +-
 drivers/nvme/host/fc.c              |   4 +-
 drivers/nvme/host/rdma.c            |  11 +--
 include/linux/blk-mq.h              |   5 +-
 16 files changed, 112 insertions(+), 161 deletions(-)
 create mode 100644 block/.gitignore

-- 
2.14.0
