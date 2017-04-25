Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v5 00/10] blk-mq debugfs patches for kernel v4.12
Date: Tue, 25 Apr 2017 13:37:35 -0700
Message-ID: <20170425203745.19946-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Please consider the ten patches in this series for kernel v4.12.
These patches improve blk-mq debugfs support.

Thanks,

Bart.

Changes compared to v4:
- Modified patch 4 such that debugfs registration failures no longer cause
  block device registration to fail.
- Modified patch 8 such that it no longer introduces new sparse warnings.
- Modified patch 9 such that .show_rq() is only defined if CONFIG_BLK_DEBUG_FS
  is enabled.
- Moved the definition of scsi_show_rq() to a new file in patch 10 and changed
  the implementation of scsi_show_rq() such that it now uses
  __scsi_format_command().

Changes compared to v3:
- Changed the mutex_lock_interruptible() calls back to mutex_lock()
  calls.
- Added a patch that renames the functions for registering and
  unregistering the "mq" directory in debugfs.
- Moved the changes that add checking of the blk_mq_debugfs_register()
  return value into a separate patch.
- Moved the unregistration of the "mq" directory into blk_cleanup_queue().
- Removed uninteresting information from scsi_show_rq().
- Added Reviewed-by tag to the patches that got a positive review.

Changes compared to v2:
- Changed the mutex_lock() calls in registration methods into
  mutex_lock_interruptible() since these functions can be called from
  the context of a user space process.
- Avoid that the blk_mq_register_dev() changes in patch 1/8 cause a
  deadlock.

Changes compared to v1:
- Added two patches and replaced patch 1/6 such that debugfs
  attributes are now unregistered before freeing of a blk-mq queue
  starts instead of checking the "dead" queue flag.
- Changed "rq->cmd_flags ^ op" into "rq->cmd_flags & ~REQ_OP_MASK" as
  proposed by Omar.
- A seq_file pointer is now passed to the new queue_rq callback function
  instead of a fixed-size char buffer.
Bart Van Assche (10):
  blk-mq: Register <dev>/queue/mq after having registered <dev>/queue
  blk-mq: Let blk_mq_debugfs_register() look up the queue name
  blk-mq-debugfs: Rename functions for registering and unregistering the
    mq directory
  blk-mq: Only unregister hctxs for which registration succeeded
  blk-mq: Unregister debugfs attributes earlier
  blk-mq: Move the "state" debugfs attribute one level down
  blk-mq: Make blk_flags_show() callers append a newline character
  blk-mq: Show operation, cmd_flags and rq_flags names
  blk-mq: Add blk_mq_ops.show_rq()
  scsi: Implement blk_mq_ops.show_rq()

 block/blk-core.c            |   5 +++
 block/blk-mq-debugfs.c      | 102 ++++++++++++++++++++++++++++++++++++--------
 block/blk-mq-sysfs.c        |  61 +++++++++++++++++++-------
 block/blk-mq.h              |  14 +++---
 block/blk-sysfs.c           |   6 +--
 drivers/scsi/Makefile       |   1 +
 drivers/scsi/scsi_debugfs.c |  13 ++++++
 drivers/scsi/scsi_debugfs.h |   4 ++
 drivers/scsi/scsi_lib.c     |   4 ++
 include/linux/blk-mq.h      |   8 ++++
 10 files changed, 174 insertions(+), 44 deletions(-)
 create mode 100644 drivers/scsi/scsi_debugfs.c
 create mode 100644 drivers/scsi/scsi_debugfs.h

-- 
2.12.2
