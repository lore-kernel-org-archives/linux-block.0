Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v6 00/12] blk-mq: Implement runtime power management
Date: Thu,  9 Aug 2018 12:41:37 -0700
Message-Id: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series not only implements runtime power management for blk-mq but
also fixes a starvation issue in the power management code for the legacy
block layer. Please consider this patch series for the upstream kernel.

Thanks,

Bart.

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

Bart Van Assche (12):
  block, scsi: Introduce request flag RQF_DV
  scsi: Alter handling of RQF_DV requests
  scsi: Only set RQF_DV for requests used for domain validation
  scsi: Introduce the SDEV_SUSPENDED device status
  block, scsi: Rename QUEUE_FLAG_PREEMPT_ONLY into DV_ONLY and introduce
    PM_ONLY
  scsi: Reallow SPI domain validation during system suspend
  block: Move power management code into a new source file
  block, scsi: Introduce blk_pm_runtime_exit()
  block: Split blk_pm_add_request() and blk_pm_put_request()
  block: Change the runtime power management approach (1/2)
  block: Change the runtime power management approach (2/2)
  blk-mq: Enable support for runtime power management

 block/Kconfig                     |   5 +
 block/Makefile                    |   1 +
 block/blk-core.c                  | 310 ++++++------------------------
 block/blk-mq-debugfs.c            |   4 +-
 block/blk-mq.c                    |   4 +-
 block/blk-pm.c                    | 262 +++++++++++++++++++++++++
 block/blk-pm.h                    |  69 +++++++
 block/elevator.c                  |  22 +--
 drivers/ide/ide-pm.c              |   3 +-
 drivers/scsi/scsi_lib.c           | 266 ++++++++++++++++++-------
 drivers/scsi/scsi_pm.c            |   7 +-
 drivers/scsi/scsi_sysfs.c         |   2 +
 drivers/scsi/scsi_transport_spi.c |  26 +--
 drivers/scsi/sd.c                 |  10 +-
 drivers/scsi/sr.c                 |   4 +-
 include/linux/blk-mq.h            |   6 +-
 include/linux/blk-pm.h            |  26 +++
 include/linux/blkdev.h            |  41 ++--
 include/scsi/scsi_device.h        |  15 +-
 include/scsi/scsi_transport_spi.h |   1 -
 20 files changed, 673 insertions(+), 411 deletions(-)
 create mode 100644 block/blk-pm.c
 create mode 100644 block/blk-pm.h
 create mode 100644 include/linux/blk-pm.h

-- 
2.18.0
