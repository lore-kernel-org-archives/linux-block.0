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
Subject: [PATCH v5 6/8] scsi: Reduce suspend latency
Date: Mon,  2 Oct 2017 15:52:16 -0700
Message-Id: <20171002225218.18548-7-bart.vanassche@wdc.com>
In-Reply-To: <20171002225218.18548-1-bart.vanassche@wdc.com>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
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
 drivers/scsi/scsi_lib.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 62f905b22821..e0bef5c9dd14 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2927,21 +2927,25 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
 int
 scsi_device_quiesce(struct scsi_device *sdev)
 {
+	struct request_queue *q = sdev->request_queue;
+	bool freeze;
 	int err;
 
 	mutex_lock(&sdev->state_mutex);
+	/*
+	 * Do not attempt to freeze the queue of an already quiesced device
+	 * because that could result in a deadlock.
+	 */
+	freeze = sdev->sdev_state == SDEV_RUNNING;
+	if (freeze)
+		blk_mq_freeze_queue(q);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
 	mutex_unlock(&sdev->state_mutex);
 
-	if (err)
-		return err;
+	if (freeze)
+		blk_mq_unfreeze_queue(q);
 
-	scsi_run_queue(sdev->request_queue);
-	while (atomic_read(&sdev->device_busy)) {
-		msleep_interruptible(200);
-		scsi_run_queue(sdev->request_queue);
-	}
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(scsi_device_quiesce);
 
-- 
2.14.1
