Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/3] scsi: Ensure that scsi_run_queue() runs all hardware queues
Date: Fri, 31 Mar 2017 16:12:05 -0700
Message-ID: <20170331231205.16640-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170331231205.16640-1-bart.vanassche@sandisk.com>
References: <20170331231205.16640-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

commit 52d7f1b5c2f3 ("blk-mq: Avoid that requeueing starts stopped
queues") removed the blk_mq_stop_hw_queue() call from scsi_queue_rq()
for the BLK_MQ_RQ_QUEUE_BUSY case. blk_mq_start_stopped_hw_queues()
only runs queues that had been stopped. Hence change the
blk_mq_start_stopped_hw_queues() call in scsi_run_queue() into
blk_mq_run_hw_queues(). Remove the blk_mq_start_stopped_hw_queues()
call from scsi_end_request() because __blk_mq_finish_request()
already runs all hardware queues if needed.

Fixes: commit 52d7f1b5c2f3 ("blk-mq: Avoid that requeueing starts stopped queues")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/scsi/scsi_lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1d804e33971a..3323878423ac 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -496,7 +496,7 @@ static void scsi_run_queue(struct request_queue *q)
 		scsi_starved_list_run(sdev->host);
 
 	if (q->mq_ops)
-		blk_mq_start_stopped_hw_queues(q, false);
+		blk_mq_run_hw_queues(q, false);
 	else
 		blk_run_queue(q);
 }
@@ -681,8 +681,6 @@ static bool scsi_end_request(struct request *req, int error,
 		if (scsi_target(sdev)->single_lun ||
 		    !list_empty(&sdev->host->starved_list))
 			kblockd_schedule_work(&sdev->requeue_work);
-		else
-			blk_mq_start_stopped_hw_queues(q, true);
 	} else {
 		unsigned long flags;
 
-- 
2.12.0
