Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 12/28] bsg: provide bsg_remove_queue() helper
Date: Thu, 25 Oct 2018 15:10:23 -0600
Message-Id: <20181025211039.11559-13-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

All drivers do unregister + cleanup, provide a helper for that.

Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bsg-lib.c                     | 7 +++++++
 drivers/scsi/scsi_transport_fc.c    | 6 ++----
 drivers/scsi/scsi_transport_iscsi.c | 7 +++----
 drivers/scsi/scsi_transport_sas.c   | 6 ++----
 include/linux/bsg-lib.h             | 1 +
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 1da011ec04e6..267f965af77a 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -296,6 +296,13 @@ static void bsg_exit_rq(struct request_queue *q, struct request *req)
 	kfree(job->reply);
 }
 
+void bsg_remove_queue(struct request_queue *q)
+{
+	bsg_unregister_queue(q);
+	blk_cleanup_queue(q);
+}
+EXPORT_SYMBOL_GPL(bsg_remove_queue);
+
 /**
  * bsg_setup_queue - Create and add the bsg hooks so we can receive requests
  * @dev: device to attach bsg device to
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 98aaffb4c715..4d64956bb5d3 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -3851,10 +3851,8 @@ fc_bsg_rportadd(struct Scsi_Host *shost, struct fc_rport *rport)
 static void
 fc_bsg_remove(struct request_queue *q)
 {
-	if (q) {
-		bsg_unregister_queue(q);
-		blk_cleanup_queue(q);
-	}
+	if (q)
+		bsg_remove_queue(q);
 }
 
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 26b11a775be9..3ead0dba5d8d 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1576,10 +1576,9 @@ static int iscsi_remove_host(struct transport_container *tc,
 	struct Scsi_Host *shost = dev_to_shost(dev);
 	struct iscsi_cls_host *ihost = shost->shost_data;
 
-	if (ihost->bsg_q) {
-		bsg_unregister_queue(ihost->bsg_q);
-		blk_cleanup_queue(ihost->bsg_q);
-	}
+	if (ihost->bsg_q)
+		bsg_remove_queue(ihost->bsg_q);
+
 	return 0;
 }
 
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index cf6d47891d77..c46d642dc133 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -246,10 +246,8 @@ static int sas_host_remove(struct transport_container *tc, struct device *dev,
 	struct Scsi_Host *shost = dev_to_shost(dev);
 	struct request_queue *q = to_sas_host_attrs(shost)->q;
 
-	if (q) {
-		bsg_unregister_queue(q);
-		blk_cleanup_queue(q);
-	}
+	if (q)
+		bsg_remove_queue(q);
 
 	return 0;
 }
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index b13ae143e7ef..9c9b134b1fa5 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -73,6 +73,7 @@ void bsg_job_done(struct bsg_job *job, int result,
 		  unsigned int reply_payload_rcv_len);
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 		bsg_job_fn *job_fn, rq_timed_out_fn *timeout, int dd_job_size);
+void bsg_remove_queue(struct request_queue *q);
 void bsg_job_put(struct bsg_job *job);
 int __must_check bsg_job_get(struct bsg_job *job);
 
-- 
2.17.1
