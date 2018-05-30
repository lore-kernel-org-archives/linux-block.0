Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: keith.busch@intel.com,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] blk-mq: only iterate over inflight requests in blk_mq_tagset_busy_iter
Date: Wed, 30 May 2018 18:51:00 +0200
Message-Id: <20180530165100.31186-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We already check for started commands in all callbacks, but we should
also protect against already completed commands.  Do this by taking
the checks to common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c                |  2 +-
 drivers/block/mtip32xx/mtip32xx.c | 12 ++----------
 drivers/block/nbd.c               |  5 +----
 drivers/nvme/host/core.c          |  3 ---
 drivers/nvme/host/fc.c            |  3 ---
 5 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4e58fc28a06..70356a2a11ab 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -271,7 +271,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq)
+	if (rq && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		iter_data->fn(rq, iter_data->data, reserved);
 
 	return true;
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 95657b814543..c73626decb46 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2725,15 +2725,11 @@ static void mtip_softirq_done_fn(struct request *rq)
 	blk_mq_end_request(rq, cmd->status);
 }
 
-static void mtip_abort_cmd(struct request *req, void *data,
-							bool reserved)
+static void mtip_abort_cmd(struct request *req, void *data, bool reserved)
 {
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct driver_data *dd = data;
 
-	if (!blk_mq_request_started(req))
-		return;
-
 	dbg_printk(MTIP_DRV_NAME " Aborting request, tag = %d\n", req->tag);
 
 	clear_bit(req->tag, dd->port->cmds_to_issue);
@@ -2741,14 +2737,10 @@ static void mtip_abort_cmd(struct request *req, void *data,
 	mtip_softirq_done_fn(req);
 }
 
-static void mtip_queue_cmd(struct request *req, void *data,
-							bool reserved)
+static void mtip_queue_cmd(struct request *req, void *data, bool reserved)
 {
 	struct driver_data *dd = data;
 
-	if (!blk_mq_request_started(req))
-		return;
-
 	set_bit(req->tag, dd->port->cmds_to_issue);
 	blk_abort_request(req);
 }
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8860b24098bc..17d1d97d491e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -666,11 +666,8 @@ static void recv_work(struct work_struct *work)
 
 static void nbd_clear_req(struct request *req, void *data, bool reserved)
 {
-	struct nbd_cmd *cmd;
+	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 
-	if (!blk_mq_request_started(req))
-		return;
-	cmd = blk_mq_rq_to_pdu(req);
 	cmd->status = BLK_STS_IOERR;
 	blk_mq_complete_request(req);
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7ad3cfc9d4e1..1744d8dcadfd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -251,9 +251,6 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
-	if (!blk_mq_request_started(req))
-		return;
-
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ac35a80f5532..0bad65803271 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2393,9 +2393,6 @@ nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
 
-	if (!blk_mq_request_started(req))
-		return;
-
 	__nvme_fc_abort_op(ctrl, op);
 }
 
-- 
2.17.0
