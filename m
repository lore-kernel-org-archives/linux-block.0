Return-Path: <prvs=4341bde3a=bart.vanassche@wdc.com>
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
Subject: [PATCH v4 5/7] scsi: Reduce suspend latency
Date: Mon, 25 Sep 2017 13:29:22 -0700
Message-Id: <20170925202924.16603-6-bart.vanassche@wdc.com>
In-Reply-To: <20170925202924.16603-1-bart.vanassche@wdc.com>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
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
 drivers/scsi/scsi_lib.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 62f905b22821..c261498606c4 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2927,6 +2927,7 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
 int
 scsi_device_quiesce(struct scsi_device *sdev)
 {
+	struct request_queue *q = sdev->request_queue;
 	int err;
 
 	mutex_lock(&sdev->state_mutex);
@@ -2936,11 +2937,8 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	if (err)
 		return err;
 
-	scsi_run_queue(sdev->request_queue);
-	while (atomic_read(&sdev->device_busy)) {
-		msleep_interruptible(200);
-		scsi_run_queue(sdev->request_queue);
-	}
+	blk_mq_freeze_queue(q);
+	blk_mq_unfreeze_queue(q);
 	return 0;
 }
 EXPORT_SYMBOL(scsi_device_quiesce);
-- 
2.14.1
