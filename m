Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 0/6] blk-mq: Implement runtime power management
Date: Mon, 17 Sep 2018 13:11:13 -0700
Message-Id: <20180917201124.26161-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series not only implements runtime power management for blk-mq but
also fixes a starvation issue in the power management code for the legacy
block layer. Please consider this patch series for the upstream kernel.

Thanks,

Bart.

Changes compared to v6:
- Left out the patches that split RQF_PREEMPT in three flags.
- Left out the patch that introduces the SCSI device state SDEV_SUSPENDED.
- Left out the patch that introduces blk_pm_runtime_exit().
- Restored the patch that changes the PREEMPT_ONLY flag into a counter.

Changes compared to v5:
- Introduced a new flag RQF_DV that replaces RQF_PREEMPT for SCSI domain
  validation.
- Introduced a new request queue state QUEUE_FLAG_DV_ONLY for SCSI domain
  validation.
- Instead of using SDEV_QUIESCE for both runtime suspend and SCSI domain
  validation, use that state for domain validation only and introduce a new
  state for runtime suspend, namely SDEV_QUIESCE.
- Reallow system suspend during SCSI domain validation.
- Moved the runtime resume call from the request allocation code into
  blk_queue_enter().
- Instead of relying on q_usage_counter, iterate over the tag set to determine
  whether or not any requests are in flight.

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

Bart Van Assche (6):
  block: Move power management code into a new source file
  block, scsi: Change the preempt-only flag into a counter
  block: Split blk_pm_add_request() and blk_pm_put_request()
  block: Schedule runtime resume earlier
  block: Make blk_get_request() block for non-PM requests while
    suspended
  blk-mq: Enable support for runtime power management

 block/Kconfig           |   3 +
 block/Makefile          |   1 +
 block/blk-core.c        | 271 +++++-----------------------------------
 block/blk-mq-debugfs.c  |  10 +-
 block/blk-mq.c          |   2 +
 block/blk-pm.c          | 244 ++++++++++++++++++++++++++++++++++++
 block/blk-pm.h          |  69 ++++++++++
 block/elevator.c        |  22 +---
 drivers/scsi/scsi_lib.c |  11 +-
 drivers/scsi/scsi_pm.c  |   1 +
 drivers/scsi/sd.c       |   1 +
 drivers/scsi/sr.c       |   1 +
 include/linux/blk-pm.h  |  24 ++++
 include/linux/blkdev.h  |  37 ++----
 14 files changed, 402 insertions(+), 295 deletions(-)
 create mode 100644 block/blk-pm.c
 create mode 100644 block/blk-pm.h
 create mode 100644 include/linux/blk-pm.h

-- 
2.18.0
