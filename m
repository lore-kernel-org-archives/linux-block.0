Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/30] block: remove __blk_put_request()
Date: Wed, 31 Oct 2018 11:59:14 -0600
Message-Id: <20181031175922.8849-23-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Now there's no difference between blk_put_request() and
__blk_put_request() anymore, get rid of the underscore version and
convert the few callers.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c                   | 9 ---------
 block/blk-merge.c                  | 2 +-
 drivers/scsi/osd/osd_initiator.c   | 4 ++--
 drivers/scsi/osst.c                | 2 +-
 drivers/scsi/scsi_error.c          | 2 +-
 drivers/scsi/sg.c                  | 2 +-
 drivers/scsi/st.c                  | 2 +-
 drivers/target/target_core_pscsi.c | 2 +-
 include/linux/blkdev.h             | 1 -
 9 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index da9e859cda4d..bffc80052948 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -800,15 +800,6 @@ void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part)
 }
 EXPORT_SYMBOL_GPL(part_round_stats);
 
-void __blk_put_request(struct request_queue *q, struct request *req)
-{
-	if (unlikely(!q))
-		return;
-
-	blk_mq_free_request(req);
-}
-EXPORT_SYMBOL_GPL(__blk_put_request);
-
 void blk_put_request(struct request *req)
 {
 	blk_mq_free_request(req);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5e4e30a88ced..7fedc0391610 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -839,7 +839,7 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 
 	free = attempt_merge(q, rq, next);
 	if (free) {
-		__blk_put_request(q, free);
+		blk_put_request(free);
 		return 1;
 	}
 
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index e19fa883376f..60cf7c5eb880 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -506,11 +506,11 @@ static void osd_request_async_done(struct request *req, blk_status_t error)
 
 	_set_error_resid(or, req, error);
 	if (req->next_rq) {
-		__blk_put_request(req->q, req->next_rq);
+		blk_put_request(req->next_rq);
 		req->next_rq = NULL;
 	}
 
-	__blk_put_request(req->q, req);
+	blk_put_request(req);
 	or->request = NULL;
 	or->in.req = NULL;
 	or->out.req = NULL;
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index 7a1a1edde35d..664c1238a87f 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -341,7 +341,7 @@ static void osst_end_async(struct request *req, blk_status_t status)
 		blk_rq_unmap_user(SRpnt->bio);
 	}
 
-	__blk_put_request(req->q, req);
+	blk_put_request(req);
 }
 
 /* osst_request memory management */
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index fff128aa9ec2..dd338a8cd275 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1932,7 +1932,7 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 
 static void eh_lock_door_done(struct request *req, blk_status_t status)
 {
-	__blk_put_request(req->q, req);
+	blk_put_request(req);
 }
 
 /**
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c6ad00703c5b..4e27460ec926 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1390,7 +1390,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	 */
 	srp->rq = NULL;
 	scsi_req_free_cmd(scsi_req(rq));
-	__blk_put_request(rq->q, rq);
+	blk_put_request(rq);
 
 	write_lock_irqsave(&sfp->rq_list_lock, iflags);
 	if (unlikely(srp->orphan)) {
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 307df2fa39a3..7ff22d3f03e3 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -530,7 +530,7 @@ static void st_scsi_execute_end(struct request *req, blk_status_t status)
 		complete(SRpnt->waiting);
 
 	blk_rq_unmap_user(tmp);
-	__blk_put_request(req->q, req);
+	blk_put_request(req);
 }
 
 static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 47d76c862014..c062d363dce3 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1094,7 +1094,7 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 		break;
 	}
 
-	__blk_put_request(req->q, req);
+	blk_put_request(req);
 	kfree(pt);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a9f6db8abcda..c502a7f40e84 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -906,7 +906,6 @@ extern blk_qc_t direct_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
-extern void __blk_put_request(struct request_queue *, struct request *);
 extern struct request *blk_get_request(struct request_queue *, unsigned int op,
 				       blk_mq_req_flags_t flags);
 extern int blk_lld_busy(struct request_queue *q);
-- 
2.17.1
