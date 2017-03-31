Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH 0/3] Avoid that scsi-mq queue processing stalls
Date: Fri, 31 Mar 2017 16:12:02 -0700
Message-ID: <20170331231205.16640-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The three patches in this patch series fix the queue lockup I reported
a few days ago on the linux-block mailing list. Please consider these
patches for kernel v4.11.

Thanks,

Bart.

Bart Van Assche (3):
  blk-mq: Introduce blk_mq_ops.restart_queues
  scsi: Add scsi_restart_queues()
  scsi: Ensure that scsi_run_queue() runs all hardware queues

 block/blk-mq-sched.c    | 11 +++--------
 block/blk-mq-sched.h    | 14 --------------
 drivers/scsi/scsi_lib.c | 20 +++++++++++++++++---
 include/linux/blk-mq.h  |  4 ++++
 include/linux/blkdev.h  |  1 -
 5 files changed, 24 insertions(+), 26 deletions(-)

-- 
2.12.0
