Return-Path: <prvs=7457c2e9b=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v3 0/9] blk-mq: Enable runtime power management
Date: Thu,  2 Aug 2018 11:29:35 -0700
Message-Id: <20180802182944.14442-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series not only enables runtime power management for blk-mq but
also fixes a starvation issue in the power management code for the legacy
block layer. Please consider this patch series for kernel v4.19.

Thanks,

Bart.

Changes compared to v2:
- Fixed the build for CONFIG_BLOCK=n.
- Added a patch that introduces percpu_ref_read() in the percpu-counter code.
- Added a patch that makes it easier to detect missing pm_runtime_get*() calls.
- Addressed Jianchao's feedback including the comment about runtime overhead
  of switching a per-cpu counter to atomic mode.

Changes compared to v1:
- Moved the runtime power management code into a separate file.
- Addressed Ming's feedback.

Bart Van Assche (9):
  block: Fix a comment in a header file
  block: Move power management functions into new source files
  block: Serialize queue freezing and blk_pre_runtime_suspend()
  percpu-refcount: Introduce percpu_ref_read()
  block, scsi: Rework runtime power management
  block: Warn if pm_runtime_get*() has not been called
  block: Remove blk_pm_requeue_request()
  blk-mq: Insert blk_pm_{add,put}_request() calls
  blk-mq: Enable support for runtime power management

 block/Kconfig                   |   5 +
 block/Makefile                  |   1 +
 block/blk-core.c                | 246 +++----------------------------
 block/blk-mq-debugfs.c          |   1 -
 block/blk-mq-sched.c            |  13 +-
 block/blk-mq.c                  |  11 ++
 block/blk-pm.c                  | 253 ++++++++++++++++++++++++++++++++
 block/blk-pm.h                  |  35 +++++
 block/elevator.c                |  24 +--
 drivers/scsi/scsi_pm.c          |   1 +
 drivers/scsi/sd.c               |   5 +-
 drivers/scsi/sr.c               |   1 +
 drivers/scsi/ufs/ufshcd.c       |  10 +-
 include/linux/blk-pm.h          |  30 ++++
 include/linux/blkdev.h          |  37 +----
 include/linux/percpu-refcount.h |   2 +
 lib/percpu-refcount.c           |  29 ++++
 17 files changed, 420 insertions(+), 284 deletions(-)
 create mode 100644 block/blk-pm.c
 create mode 100644 block/blk-pm.h
 create mode 100644 include/linux/blk-pm.h

-- 
2.18.0
