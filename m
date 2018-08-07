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
Subject: [RFC PATCH 06/14] SCSI: pass scsi_device to scsi_mq_prep_fn
Date: Wed,  8 Aug 2018 01:44:25 +0800
Message-Id: <20180807174433.8374-7-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patchset will introduce per-host admin queue, so it may not to get
'scsi_device' via q->queuedata.

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
 drivers/scsi/scsi_lib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 435347f58328..52e498fb6280 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1971,10 +1971,9 @@ static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
 		sizeof(struct scatterlist);
 }
 
-static int scsi_mq_prep_fn(struct request *req)
+static int scsi_mq_prep_fn(struct scsi_device *sdev, struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
-	struct scsi_device *sdev = req->q->queuedata;
 	struct Scsi_Host *shost = sdev->host;
 	struct scatterlist *sg;
 
@@ -2070,7 +2069,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_dec_target_busy;
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
-		ret = prep_to_mq(scsi_mq_prep_fn(req));
+		ret = prep_to_mq(scsi_mq_prep_fn(sdev, req));
 		if (ret != BLK_STS_OK)
 			goto out_dec_host_busy;
 		req->rq_flags |= RQF_DONTPREP;
-- 
2.9.5
