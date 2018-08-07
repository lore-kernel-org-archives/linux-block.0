Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [RFC PATCH 07/14] SCSI: don't set .queuedata in scsi_mq_alloc_queue()
Date: Wed,  8 Aug 2018 01:44:26 +0800
Message-Id: <20180807174433.8374-8-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

.queuedata is set in scsi_alloc_sdev() for both non-mq and scsi_mq,
so not necessary to do it in scsi_mq_alloc_queue().

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 52e498fb6280..0c9c38a82cc8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2305,7 +2305,6 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
 	if (IS_ERR(sdev->request_queue))
 		return NULL;
 
-	sdev->request_queue->queuedata = sdev;
 	__scsi_init_queue(sdev->host, sdev->request_queue);
 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
 	return sdev->request_queue;
-- 
2.9.5
