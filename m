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
Subject: [PATCH v3 4/6] scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
Date: Fri, 22 Sep 2017 15:14:03 -0700
Message-Id: <20170922221405.22091-5-bart.vanassche@wdc.com>
In-Reply-To: <20170922221405.22091-1-bart.vanassche@wdc.com>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Make the quiesce state visible to the block layer for the next
patch in this series.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/scsi_lib.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 62f905b22821..ca84fd2d93ea 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2927,19 +2927,22 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
 int
 scsi_device_quiesce(struct scsi_device *sdev)
 {
+	struct request_queue *q = sdev->request_queue;
 	int err;
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
+	if (err == 0)
+		blk_set_preempt_only(q, true);
 	mutex_unlock(&sdev->state_mutex);
 
 	if (err)
 		return err;
 
-	scsi_run_queue(sdev->request_queue);
+	scsi_run_queue(q);
 	while (atomic_read(&sdev->device_busy)) {
 		msleep_interruptible(200);
-		scsi_run_queue(sdev->request_queue);
+		scsi_run_queue(q);
 	}
 	return 0;
 }
@@ -2962,8 +2965,10 @@ void scsi_device_resume(struct scsi_device *sdev)
 	 */
 	mutex_lock(&sdev->state_mutex);
 	if (sdev->sdev_state == SDEV_QUIESCE &&
-	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0)
+	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0) {
+		blk_set_preempt_only(sdev->request_queue, false);
 		scsi_run_queue(sdev->request_queue);
+	}
 	mutex_unlock(&sdev->state_mutex);
 }
 EXPORT_SYMBOL(scsi_device_resume);
-- 
2.14.1
