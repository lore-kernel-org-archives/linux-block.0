Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>
Subject: [PATCH v2 04/12] block: Change argument type of scsi_req_init()
Date: Wed, 31 May 2017 15:52:38 -0700
Message-ID: <20170531225246.26261-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170531225246.26261-1-bart.vanassche@sandisk.com>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since scsi_req_init() works on a struct scsi_request, change the
argument type into struct scsi_request *.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/scsi_ioctl.c                | 10 +++++++---
 drivers/ide/ide-atapi.c           |  2 +-
 drivers/ide/ide-probe.c           |  2 +-
 drivers/scsi/scsi_lib.c           |  4 +++-
 drivers/scsi/scsi_transport_sas.c |  2 +-
 include/scsi/scsi_request.h       |  2 +-
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index f96c51f5df40..7440de44dd85 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -741,10 +741,14 @@ int scsi_cmd_blk_ioctl(struct block_device *bd, fmode_t mode,
 }
 EXPORT_SYMBOL(scsi_cmd_blk_ioctl);
 
-void scsi_req_init(struct request *rq)
+/**
+ * scsi_req_init - initialize certain fields of a scsi_request structure
+ * @req: Pointer to a scsi_request structure.
+ * Initializes .__cmd[], .cmd, .cmd_len and .sense_len but no other members
+ * of struct scsi_request.
+ */
+void scsi_req_init(struct scsi_request *req)
 {
-	struct scsi_request *req = scsi_req(rq);
-
 	memset(req->__cmd, 0, sizeof(req->__cmd));
 	req->cmd = req->__cmd;
 	req->cmd_len = BLK_MAX_CDB;
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 98e78b520417..5ffecef8b910 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -199,7 +199,7 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 	memset(sense, 0, sizeof(*sense));
 
 	blk_rq_init(rq->q, sense_rq);
-	scsi_req_init(sense_rq);
+	scsi_req_init(req);
 
 	err = blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
 			      GFP_NOIO);
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index c60e5ffc9231..01b2adfd8226 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -745,7 +745,7 @@ static void ide_initialize_rq(struct request *rq)
 {
 	struct ide_request *req = blk_mq_rq_to_pdu(rq);
 
-	scsi_req_init(rq);
+	scsi_req_init(&req->sreq);
 	req->sreq.sense = req->sense;
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e96ffd187558..b629d8cbf0d1 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1136,7 +1136,9 @@ EXPORT_SYMBOL(scsi_init_io);
 /* Called from inside blk_get_request() */
 static void scsi_initialize_rq(struct request *rq)
 {
-	scsi_req_init(rq);
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
+
+	scsi_req_init(&cmd->req);
 }
 
 /* Called after a request has been started. */
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index f5449da6fcad..35598905d785 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -215,7 +215,7 @@ static void sas_host_release(struct device *dev)
 
 static void sas_initialize_rq(struct request *rq)
 {
-	scsi_req_init(rq);
+	scsi_req_init(scsi_req(rq));
 }
 
 static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
diff --git a/include/scsi/scsi_request.h b/include/scsi/scsi_request.h
index f0c76f9dc285..e0afa445ee4e 100644
--- a/include/scsi/scsi_request.h
+++ b/include/scsi/scsi_request.h
@@ -27,6 +27,6 @@ static inline void scsi_req_free_cmd(struct scsi_request *req)
 		kfree(req->cmd);
 }
 
-void scsi_req_init(struct request *);
+void scsi_req_init(struct scsi_request *req);
 
 #endif /* _SCSI_SCSI_REQUEST_H */
-- 
2.12.2
