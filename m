Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH 0/6] blk-mq debugfs patches for kernel v4.12
Date: Tue, 11 Apr 2017 13:58:36 -0700
Message-ID: <20170411205842.28137-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Please consider the six patches in this series for kernel v4.12. The
first patch in this series is a bug fix for code that has already
been queued for kernel v4.12. The second patch implements a change
requested by Omar. Patches 3-6 are blk-mq debugfs enhancements.

Thanks,

Bart.

Bart Van Assche (6):
  blk-mq: Do not invoke queue operations on a dead queue
  blk-mq: Move the "state" debugfs attribute one level down
  blk-mq: Make blk_flags_show() callers append a newline character
  blk-mq: Show operation, cmd_flags and rq_flags names
  blk-mq: Add blk_mq_ops.show_rq()
  scsi: Implement blk_mq_ops.show_rq()

 block/blk-mq-debugfs.c  | 99 +++++++++++++++++++++++++++++++++++++++++++------
 drivers/scsi/scsi_lib.c | 27 ++++++++++++++
 include/linux/blk-mq.h  |  6 +++
 3 files changed, 120 insertions(+), 12 deletions(-)

-- 
2.12.0
