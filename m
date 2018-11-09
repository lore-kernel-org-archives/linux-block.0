Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 3/7] scsi: push blk_status_t up into scsi_setup_{fs,scsi}_cmnd
Date: Fri,  9 Nov 2018 14:42:37 +0100
Message-Id: <20181109134241.29346-4-hch@lst.de>
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

This just moves the prep_to_mq calls up in preparation of further removal
of BLKPREP_* usage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_lib.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5ecabb3e77b7..e665c25da144 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1177,7 +1177,20 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	scsi_add_cmd_to_list(cmd);
 }
 
-static int scsi_setup_scsi_cmnd(struct scsi_device *sdev, struct request *req)
+static inline blk_status_t prep_to_mq(int ret)
+{
+	switch (ret) {
+	case BLKPREP_OK:
+		return BLK_STS_OK;
+	case BLKPREP_DEFER:
+		return BLK_STS_RESOURCE;
+	default:
+		return BLK_STS_IOERR;
+	}
+}
+
+static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
+		struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 
@@ -1190,7 +1203,7 @@ static int scsi_setup_scsi_cmnd(struct scsi_device *sdev, struct request *req)
 	if (req->bio) {
 		int ret = scsi_init_io(cmd);
 		if (unlikely(ret))
-			return ret;
+			return prep_to_mq(ret);
 	} else {
 		BUG_ON(blk_rq_bytes(req));
 
@@ -1201,29 +1214,31 @@ static int scsi_setup_scsi_cmnd(struct scsi_device *sdev, struct request *req)
 	cmd->cmnd = scsi_req(req)->cmd;
 	cmd->transfersize = blk_rq_bytes(req);
 	cmd->allowed = scsi_req(req)->retries;
-	return BLKPREP_OK;
+	return BLK_STS_OK;
 }
 
 /*
  * Setup a normal block command.  These are simple request from filesystems
  * that still need to be translated to SCSI CDBs from the ULD.
  */
-static int scsi_setup_fs_cmnd(struct scsi_device *sdev, struct request *req)
+static blk_status_t scsi_setup_fs_cmnd(struct scsi_device *sdev,
+		struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 
 	if (unlikely(sdev->handler && sdev->handler->prep_fn)) {
 		int ret = sdev->handler->prep_fn(sdev, req);
 		if (ret != BLKPREP_OK)
-			return ret;
+			return prep_to_mq(ret);
 	}
 
 	cmd->cmnd = scsi_req(req)->cmd = scsi_req(req)->__cmd;
 	memset(cmd->cmnd, 0, BLK_MAX_CDB);
-	return scsi_cmd_to_driver(cmd)->init_command(cmd);
+	return prep_to_mq(scsi_cmd_to_driver(cmd)->init_command(cmd));
 }
 
-static int scsi_setup_cmnd(struct scsi_device *sdev, struct request *req)
+static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
+		struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 
@@ -1581,18 +1596,6 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	return 0;
 }
 
-static inline blk_status_t prep_to_mq(int ret)
-{
-	switch (ret) {
-	case BLKPREP_OK:
-		return BLK_STS_OK;
-	case BLKPREP_DEFER:
-		return BLK_STS_RESOURCE;
-	default:
-		return BLK_STS_IOERR;
-	}
-}
-
 /* Size in bytes of the sg-list stored in the scsi-mq command-private data. */
 static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
 {
@@ -1600,7 +1603,7 @@ static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
 		sizeof(struct scatterlist);
 }
 
-static int scsi_mq_prep_fn(struct request *req)
+static blk_status_t scsi_mq_prep_fn(struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 	struct scsi_device *sdev = req->q->queuedata;
@@ -1705,7 +1708,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_dec_target_busy;
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
-		ret = prep_to_mq(scsi_mq_prep_fn(req));
+		ret = scsi_mq_prep_fn(req);
 		if (ret != BLK_STS_OK)
 			goto out_dec_host_busy;
 		req->rq_flags |= RQF_DONTPREP;
-- 
2.19.1
