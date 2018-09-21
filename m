Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v10 0/8] blk-mq: Implement runtime power management
Date: Fri, 21 Sep 2018 13:31:14 -0700
Message-Id: <20180921203122.49743-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

One of the pieces that is missing before blk-mq can be made the default is
implementing runtime power management support for blk-mq.  This patch series
not only implements runtime power management for blk-mq but also fixes a
starvation issue in the power management code for the legacy block
layer. Please consider this patch series for the upstream kernel.

Thanks,

Bart.

Changes compared to v9:
- Left out the patches that document the functions that iterate over requests
  and also the patch that introduces blk_mq_queue_rq_iter().
- Simplified blk_pre_runtime_suspend(): left out the check whether no requests
  are in progress.
- Fixed the race between blk_queue_enter(), queue freezing and runtime power
  management that Ming had identified.
- Added a new patch that introduces percpu_ref_resurrect().

Changes compared to v8:
- Fixed the race that was reported by Jianchao.
- Fixed another spelling issue in a source code comment.

Changes compared to v7:
- Addressed Jianchao's feedback about patch "Make blk_get_request() block for
  non-PM requests while suspended".
- Added two new patches - one that documents the functions that iterate over
  requests and one that introduces a new function that iterates over all
  requests associated with a queue.

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

Bart Van Assche (8):
  block: Move power management code into a new source file
  block, scsi: Change the preempt-only flag into a counter
  block: Split blk_pm_add_request() and blk_pm_put_request()
  block: Schedule runtime resume earlier
  percpu-refcount: Introduce percpu_ref_resurrect()
  block: Allow unfreezing of a queue while requests are in progress
  block: Make blk_get_request() block for non-PM requests while
    suspended
  blk-mq: Enable support for runtime power management

 block/Kconfig                   |   3 +
 block/Makefile                  |   1 +
 block/blk-core.c                | 270 ++++----------------------------
 block/blk-mq-debugfs.c          |  10 +-
 block/blk-mq.c                  |   4 +-
 block/blk-pm.c                  | 216 +++++++++++++++++++++++++
 block/blk-pm.h                  |  69 ++++++++
 block/elevator.c                |  22 +--
 drivers/scsi/scsi_lib.c         |  11 +-
 drivers/scsi/scsi_pm.c          |   1 +
 drivers/scsi/sd.c               |   1 +
 drivers/scsi/sr.c               |   1 +
 include/linux/blk-pm.h          |  24 +++
 include/linux/blkdev.h          |  37 ++---
 include/linux/percpu-refcount.h |   1 +
 lib/percpu-refcount.c           |  28 +++-
 16 files changed, 401 insertions(+), 298 deletions(-)
 create mode 100644 block/blk-pm.c
 create mode 100644 block/blk-pm.h
 create mode 100644 include/linux/blk-pm.h

-- 
2.19.0.444.g18242da7ef-goog
