Return-Path: <prvs=4411c008b=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 7/8] scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
Date: Mon,  2 Oct 2017 15:52:17 -0700
Message-Id: <20171002225218.18548-8-bart.vanassche@wdc.com>
In-Reply-To: <20171002225218.18548-1-bart.vanassche@wdc.com>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Make the quiesce state visible to the block layer for the next
patch in this series.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/scsi_lib.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e0bef5c9dd14..534c81de0880 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2940,8 +2940,16 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	if (freeze)
 		blk_mq_freeze_queue(q);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
+	if (err == 0)
+		blk_set_preempt_only(q);
 	mutex_unlock(&sdev->state_mutex);
 
+	/*
+	 * Ensure that the effect of blk_set_preempt_only() is globally
+	 * visible before unfreezing the queue.
+	 */
+	if (err == 0)
+		synchronize_rcu();
 	if (freeze)
 		blk_mq_unfreeze_queue(q);
 
@@ -2966,8 +2974,10 @@ void scsi_device_resume(struct scsi_device *sdev)
 	 */
 	mutex_lock(&sdev->state_mutex);
 	if (sdev->sdev_state == SDEV_QUIESCE &&
-	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0)
+	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0) {
+		blk_clear_preempt_only(sdev->request_queue);
 		scsi_run_queue(sdev->request_queue);
+	}
 	mutex_unlock(&sdev->state_mutex);
 }
 EXPORT_SYMBOL(scsi_device_resume);
-- 
2.14.1
