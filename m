Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v2 0/8] blk-mq debugfs patches for kernel v4.12
Date: Mon, 17 Apr 2017 09:56:43 -0700
Message-ID: <20170417165651.12693-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Please consider the eight patches in this series for kernel v4.12.
These patches improve blk-mq debugfs support.

Thanks,

Bart.

Changes compared to v1:
- Added two patches and replaced patch 1/6 such that debugfs
  attributes are now unregistered before freeing of a blk-mq queue
  starts instead of checking the "dead" queue flag.
- Changed "rq->cmd_flags ^ op" into "rq->cmd_flags & ~REQ_OP_MASK" as
  proposed by Omar.
- A seq_file pointer is now passed to the new queue_rq callback function
  instead of a fixed-size char buffer.

Bart Van Assche (8):
  blk-mq: Register <dev>/queue/mq after having registered <dev>/queue
  blk-mq: Let blk_mq_debugfs_register() look up the queue name
  blk-mq: Unregister debugfs attributes earlier
  blk-mq: Move the "state" debugfs attribute one level down
  blk-mq: Make blk_flags_show() callers append a newline character
  blk-mq: Show operation, cmd_flags and rq_flags names
  blk-mq: Add blk_mq_ops.show_rq()
  scsi: Implement blk_mq_ops.show_rq()

 block/blk-mq-debugfs.c  | 94 +++++++++++++++++++++++++++++++++++++++++--------
 block/blk-mq-sysfs.c    | 60 ++++++++++++++++---------------
 block/blk-mq.h          |  6 ++--
 block/blk-sysfs.c       |  9 +++--
 drivers/scsi/scsi_lib.c | 26 ++++++++++++++
 include/linux/blk-mq.h  |  6 ++++
 6 files changed, 151 insertions(+), 50 deletions(-)

-- 
2.12.2
