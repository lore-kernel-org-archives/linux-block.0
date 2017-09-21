Return-Path: <prvs=430e6b2f0=bart.vanassche@wdc.com>
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
Subject: [PATCH v2 4/4] scsi-mq: Reduce suspend latency
Date: Thu, 21 Sep 2017 14:22:55 -0700
Message-Id: <20170921212255.12788-5-bart.vanassche@wdc.com>
In-Reply-To: <20170921212255.12788-1-bart.vanassche@wdc.com>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that it can take 200 ms too long to wait for ongoing requests
to finish. Note: blk_mq_freeze_queue() uses a wait queue to wait
for ongoing requests to finish.

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
index e76fd6e89a81..34e5f0f95d01 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2901,10 +2901,15 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	if (err)
 		return err;
 
-	scsi_run_queue(q);
-	while (atomic_read(&sdev->device_busy)) {
-		msleep_interruptible(200);
+	if (q->mq_ops) {
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
