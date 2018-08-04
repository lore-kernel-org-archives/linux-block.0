Return-Path: <prvs=7477a5644=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v4 00/10] blk-mq: Enable runtime power management
Date: Fri,  3 Aug 2018 17:03:15 -0700
Message-Id: <20180804000325.3610-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series not only enables runtime power management for blk-mq but
also fixes a starvation issue in the power management code for the legacy
block layer. Please consider this patch series for kernel v4.19.

Thanks,

Bart.

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

Bart Van Assche (10):
  block: Change the preempt-only flag into a counter
  block, scsi: Give RQF_PREEMPT back its original meaning
  block, ide: Remove flag BLK_MQ_REQ_PREEMPT
  block: Move power management code into a new source file
  block: Serialize queue freezing and blk_pre_runtime_suspend()
  percpu-refcount: Introduce percpu_ref_read()
  block, scsi: Rework runtime power management
  block: Remove blk_pm_requeue_request()
  blk-mq: Insert blk_pm_{add,put}_request() calls
  blk-mq: Enable support for runtime power management

 block/Kconfig                   |   5 +
 block/Makefile                  |   1 +
 block/blk-core.c                | 281 ++++----------------------------
 block/blk-mq-debugfs.c          |  11 +-
 block/blk-mq-sched.c            |  13 +-
 block/blk-mq.c                  |  13 +-
 block/blk-pm.c                  | 245 ++++++++++++++++++++++++++++
 block/blk-pm.h                  |  37 +++++
 block/elevator.c                |  24 +--
 drivers/ide/ide-pm.c            |   3 +-
 drivers/scsi/scsi_lib.c         |  36 ++--
 drivers/scsi/scsi_pm.c          |   1 +
 drivers/scsi/sd.c               |   1 +
 drivers/scsi/sr.c               |   1 +
 include/linux/blk-mq.h          |   4 +-
 include/linux/blk-pm.h          |  30 ++++
 include/linux/blkdev.h          |  45 ++---
 include/linux/percpu-refcount.h |   2 +
 lib/percpu-refcount.c           |  29 ++++
 19 files changed, 453 insertions(+), 329 deletions(-)
 create mode 100644 block/blk-pm.c
 create mode 100644 block/blk-pm.h
 create mode 100644 include/linux/blk-pm.h

-- 
2.18.0
