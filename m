Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v4 00/10] blk-mq debugfs patches for kernel v4.12
Date: Fri, 21 Apr 2017 16:40:16 -0700
Message-ID: <20170421234026.18970-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Please consider the ten patches in this series for kernel v4.12.
These patches improve blk-mq debugfs support.

Thanks,

Bart.

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
  blk-mq: Check blk_mq_debugfs_register() return value
  blk-mq: Unregister debugfs attributes earlier
  blk-mq: Move the "state" debugfs attribute one level down
  blk-mq: Make blk_flags_show() callers append a newline character
  blk-mq: Show operation, cmd_flags and rq_flags names
  blk-mq: Add blk_mq_ops.show_rq()
  scsi: Implement blk_mq_ops.show_rq()

 block/blk-core.c        |   5 +++
 block/blk-mq-debugfs.c  | 102 +++++++++++++++++++++++++++++++++++++++---------
 block/blk-mq-sysfs.c    |  64 ++++++++++++++++++++++--------
 block/blk-mq.h          |  14 +++----
 block/blk-sysfs.c       |   6 +--
 drivers/scsi/scsi_lib.c |  11 ++++++
 include/linux/blk-mq.h  |   6 +++
 7 files changed, 164 insertions(+), 44 deletions(-)

-- 
2.12.2
