Return-Path: <prvs=737f04b27=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 0/5] blk-mq: Enable runtime power management
Date: Wed, 25 Jul 2018 15:26:02 -0700
Message-Id: <20180725222607.8854-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series not only enables runtime power management for blk-mq but also
simplifies power management for the legacy block layer. Please consider this
patch series for kernel v4.19.

Thanks,

Bart.

Changes compared to v1:
- Moved the runtime power management code into a separate file.
- Addressed Ming's feedback.

Bart Van Assche (5):
  block: Fix a comment in a header file
  block: Move power management functions into new source files
  block: Serialize queue freezing and blk_pre_runtime_suspend()
  block, scsi: Rework runtime power management
  blk-mq: Enable support for runtime power management

 block/Makefile            |   1 +
 block/blk-core.c          | 237 ++++----------------------------------
 block/blk-mq-debugfs.c    |   1 -
 block/blk-mq.c            |   3 +
 block/blk-pm.c            | 235 +++++++++++++++++++++++++++++++++++++
 block/elevator.c          |  11 +-
 drivers/scsi/scsi_pm.c    |   1 +
 drivers/scsi/sd.c         |   5 +-
 drivers/scsi/sr.c         |   1 +
 drivers/scsi/ufs/ufshcd.c |  10 +-
 include/linux/blk-pm.h    |  28 +++++
 include/linux/blkdev.h    |  36 ++----
 12 files changed, 309 insertions(+), 260 deletions(-)
 create mode 100644 block/blk-pm.c
 create mode 100644 include/linux/blk-pm.h

-- 
2.18.0
