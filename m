Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v2 0/5] Avoid that scsi-mq queue processing stalls
Date: Mon, 3 Apr 2017 16:22:23 -0700
Message-ID: <20170403232228.11208-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The five patches in this patch series fix the queue lockup I reported
last week on the linux-block mailing list. Please consider these patches
for kernel v4.11.

Thanks,

Bart.

Changes compared to v1 of this patch:
- Reworked scsi_restart_queues() such that it no longer takes the SCSI
  host lock.
- Added two patches - one for exporting blk_mq_sched_restart_hctx() and
  another one to make iterating with RCU over blk_mq_tag_set.tag_list safe.

Bart Van Assche (5):
  block: Export blk_mq_sched_restart_hctx()
  block: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list
  blk-mq: Introduce blk_mq_ops.restart_hctx
  scsi: Add scsi_restart_queues()
  scsi: Ensure that scsi_run_queue() runs all hardware queues

 block/blk-mq-sched.c    | 22 ++++++++--------------
 block/blk-mq-sched.h    | 14 --------------
 block/blk-mq.c          |  6 ++++++
 drivers/scsi/scsi_lib.c | 20 +++++++++++++++++---
 include/linux/blk-mq.h  |  8 ++++++++
 include/linux/blkdev.h  |  1 -
 6 files changed, 39 insertions(+), 32 deletions(-)

-- 
2.12.0
