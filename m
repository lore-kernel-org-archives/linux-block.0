Return-Path: <prvs=750bc9d11=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v5 0/9] blk-mq: Implement runtime power management
Date: Tue,  7 Aug 2018 15:51:24 -0700
Message-Id: <20180807225133.27221-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series not only implements runtime power management for blk-mq but
also fixes a starvation issue in the power management code for the legacy
block layer. Please consider this patch series for kernel v4.19.

Thanks,

Bart.

Changes compared to v4:
- Dropped the patches "Give RQF_PREEMPT back its original meaning" and
  "Serialize queue freezing and blk_pre_runtime_suspend()".
- Replaced "percpu_ref_read()" with "percpu_is_in_use()".
- Inserted pm_request_resume() calls in the block layer request allocation
  code such that the context that submits a request no longer has to call
  pm_runtime_get().

Changes compared to v3:
- Avoid adverse interactions between system-wide suspend/resume and runtime
  power management by changing the PREEMPT_ONLY flag into a counter.
- Give RQF_PREEMPT back its original meaning, namely that it is only set for
  ide_preempt requests.
- Remove the flag BLK_MQ_REQ_PREEMPT.
- Removed the pm_request_resume() call.

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
  block: Change the preempt-only flag into a counter
  block: Move power management code into a new source file
  block, scsi: Introduce blk_pm_runtime_exit()
  percpu-refcount: Introduce percpu_ref_is_in_use()
  block: Change the runtime power management approach (1/2)
  block: Change the runtime power management approach (2/2)
  block: Remove blk_pm_requeue_request()
  blk-mq: Insert a blk_pm_put_request() call
  blk-mq: Enable support for runtime power management

 block/Kconfig                   |   5 +
 block/Makefile                  |   1 +
 block/blk-core.c                | 277 ++++----------------------------
 block/blk-mq-debugfs.c          |  11 +-
 block/blk-mq.c                  |   8 +
 block/blk-pm.c                  | 230 ++++++++++++++++++++++++++
 block/blk-pm.h                  |  33 ++++
 block/elevator.c                |  26 +--
 drivers/scsi/scsi_lib.c         |  17 +-
 drivers/scsi/scsi_pm.c          |   1 +
 drivers/scsi/sd.c               |  10 +-
 drivers/scsi/sr.c               |   4 +-
 include/linux/blk-mq.h          |   2 +
 include/linux/blk-pm.h          |  26 +++
 include/linux/blkdev.h          |  38 ++---
 include/linux/percpu-refcount.h |   2 +
 lib/percpu-refcount.c           |  40 +++++
 17 files changed, 420 insertions(+), 311 deletions(-)
 create mode 100644 block/blk-pm.c
 create mode 100644 block/blk-pm.h
 create mode 100644 include/linux/blk-pm.h

-- 
2.18.0
