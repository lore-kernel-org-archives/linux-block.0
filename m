Return-Path: <prvs=431df6ef2=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 6/6] scsi-mq: Reduce suspend latency
Date: Fri, 22 Sep 2017 15:14:05 -0700
Message-Id: <20170922221405.22091-7-bart.vanassche@wdc.com>
In-Reply-To: <20170922221405.22091-1-bart.vanassche@wdc.com>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that it can take 200 ms too long to wait for requests to
finish. Note: blk_mq_freeze_queue() uses a wait queue to wait
for ongoing requests to finish.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/scsi_lib.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ca84fd2d93ea..c5e66bb0c94d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2939,10 +2939,20 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	if (err)
 		return err;
 
-	scsi_run_queue(q);
-	while (atomic_read(&sdev->device_busy)) {
-		msleep_interruptible(200);
+	if (q->mq_ops) {
+		/*
+		 * Ensure write order of the PREEMPT_ONLY queue flag and
+		 * q_usage_counter. See also blk_queue_enter().
+		 */
+		smp_wmb();
+		blk_mq_freeze_queue(q);
+		blk_mq_unfreeze_queue(q);
+	} else {
 		scsi_run_queue(q);
+		while (atomic_read(&sdev->device_busy)) {
+			msleep_interruptible(200);
+			scsi_run_queue(q);
+		}
 	}
 	return 0;
 }
-- 
2.14.1
