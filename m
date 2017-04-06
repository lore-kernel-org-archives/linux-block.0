Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v3 0/5] Avoid that scsi-mq queue processing stalls
Date: Thu, 6 Apr 2017 11:10:45 -0700
Message-ID: <20170406181050.12137-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The five patches in this patch series fix the queue lockup I reported
recently on the linux-block mailing list. Please consider these patches
for inclusion in the upstream kernel.

Thanks,

Bart.

Changes between v2 and v3:
- Removed the blk_mq_ops.restart_hctx function pointer again.
- Modified blk_mq_sched_restart_queues() such that only a single hardware
  queue is restarted instead of multiple if hardware queues are shared.
- Introduced a new function in the block layer, namely
  blk_mq_delay_run_hw_queue().  

Changes between v1 and v2:
- Reworked scsi_restart_queues() such that it no longer takes the SCSI
  host lock.
- Added two patches - one for exporting blk_mq_sched_restart_hctx() and
  another one to make iterating with RCU over blk_mq_tag_set.tag_list safe.

Bart Van Assche (5):
  blk-mq: Make it safe to use RCU to iterate over
    blk_mq_tag_set.tag_list
  blk-mq: Restart a single queue if tag sets are shared
  blk-mq: Clarify comments in blk_mq_dispatch_rq_list()
  blk-mq: Introduce blk_mq_delay_run_hw_queue()
  scsi: Avoid that SCSI queues get stuck

 block/blk-mq-sched.c    | 60 +++++++++++++++++++++++++++++++++++--------
 block/blk-mq-sched.h    | 16 +-----------
 block/blk-mq.c          | 68 +++++++++++++++++++++++++++++++++++++++----------
 drivers/scsi/scsi_lib.c |  6 ++---
 include/linux/blk-mq.h  |  2 ++
 include/linux/blkdev.h  |  1 -
 6 files changed, 111 insertions(+), 42 deletions(-)

-- 
2.12.0
