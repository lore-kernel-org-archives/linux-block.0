Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:32224
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751513AbdAaMST (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:18:19 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 09/12] lightnvm: use end_io callback instead of instance
Date: Tue, 31 Jan 2017 13:17:17 +0100
Message-ID: <20170131121720.10971-10-matias@cnexlabs.com>
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When the lightnvm core had the "gennvm" layer between the device and the
target, there was a need for the core to be able to figure out which
target it should send an end_io callback to. Leading to a "double"
end_io, first for the media manager instance, and then for the target
instance. Now that core and gennvm is merged, there is no longer a need
for this, and a single end_io callback will do.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/block/null_blk.c     |  3 ++-
 drivers/lightnvm/core.c      |  7 +++----
 drivers/lightnvm/rrpc.c      |  7 +++----
 drivers/lightnvm/rrpc.h      |  3 ---
 drivers/nvme/host/lightnvm.c |  3 ++-
 include/linux/lightnvm.h     | 10 +++-------
 6 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index e666095..a67b7ea 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -420,7 +420,8 @@ static void null_lnvm_end_io(struct request *rq, int error)
 {
 	struct nvm_rq *rqd = rq->end_io_data;
 
-	nvm_end_io(rqd, error);
+	rqd->error = error;
+	nvm_end_io(rqd);
 
 	blk_put_request(rq);
 }
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 80cd767..4f4db99 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -773,17 +773,16 @@ void nvm_free_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_free_rqd_ppalist);
 
-void nvm_end_io(struct nvm_rq *rqd, int error)
+void nvm_end_io(struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *tgt_dev = rqd->dev;
-	struct nvm_tgt_instance *ins = rqd->ins;
 
 	/* Convert address space */
 	if (tgt_dev)
 		nvm_rq_dev_to_tgt(tgt_dev, rqd);
 
-	rqd->error = error;
-	ins->tt->end_io(rqd);
+	if (rqd->end_io)
+		rqd->end_io(rqd);
 }
 EXPORT_SYMBOL(nvm_end_io);
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 9fb7de3..e00b1d7 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -779,7 +779,7 @@ static void rrpc_end_io_write(struct rrpc *rrpc, struct rrpc_rq *rrqd,
 
 static void rrpc_end_io(struct nvm_rq *rqd)
 {
-	struct rrpc *rrpc = container_of(rqd->ins, struct rrpc, instance);
+	struct rrpc *rrpc = rqd->private;
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_rq *rrqd = nvm_rq_to_pdu(rqd);
 	uint8_t npages = rqd->nr_ppas;
@@ -972,8 +972,9 @@ static int rrpc_submit_io(struct rrpc *rrpc, struct bio *bio,
 
 	bio_get(bio);
 	rqd->bio = bio;
-	rqd->ins = &rrpc->instance;
+	rqd->private = rrpc;
 	rqd->nr_ppas = nr_pages;
+	rqd->end_io = rrpc_end_io;
 	rrq->flags = flags;
 
 	err = nvm_submit_io(dev, rqd);
@@ -1532,7 +1533,6 @@ static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk)
 	if (!rrpc)
 		return ERR_PTR(-ENOMEM);
 
-	rrpc->instance.tt = &tt_rrpc;
 	rrpc->dev = dev;
 	rrpc->disk = tdisk;
 
@@ -1611,7 +1611,6 @@ static struct nvm_tgt_type tt_rrpc = {
 
 	.make_rq	= rrpc_make_rq,
 	.capacity	= rrpc_capacity,
-	.end_io		= rrpc_end_io,
 
 	.init		= rrpc_init,
 	.exit		= rrpc_exit,
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 94e4d73..fdb6ff9 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -102,9 +102,6 @@ struct rrpc_lun {
 };
 
 struct rrpc {
-	/* instance must be kept in top to resolve rrpc in unprep */
-	struct nvm_tgt_instance instance;
-
 	struct nvm_tgt_dev *dev;
 	struct gendisk *disk;
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 3b6cd9b..21cac85 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -484,7 +484,8 @@ static void nvme_nvm_end_io(struct request *rq, int error)
 	struct nvm_rq *rqd = rq->end_io_data;
 
 	rqd->ppa_status = nvme_req(rq)->result.u64;
-	nvm_end_io(rqd, error);
+	rqd->error = error;
+	nvm_end_io(rqd);
 
 	kfree(nvme_req(rq)->cmd);
 	blk_mq_free_request(rq);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ce0b2da..17cd454 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -213,10 +213,6 @@ struct nvm_target {
 	struct gendisk *disk;
 };
 
-struct nvm_tgt_instance {
-	struct nvm_tgt_type *tt;
-};
-
 #define ADDR_EMPTY (~0ULL)
 
 #define NVM_VERSION_MAJOR 1
@@ -227,7 +223,6 @@ struct nvm_rq;
 typedef void (nvm_end_io_fn)(struct nvm_rq *);
 
 struct nvm_rq {
-	struct nvm_tgt_instance *ins;
 	struct nvm_tgt_dev *dev;
 
 	struct bio *bio;
@@ -251,6 +246,8 @@ struct nvm_rq {
 
 	u64 ppa_status; /* ppa media status */
 	int error;
+
+	void *private;
 };
 
 static inline struct nvm_rq *nvm_rq_from_pdu(void *pdu)
@@ -450,7 +447,6 @@ struct nvm_tgt_type {
 	/* target entry points */
 	nvm_tgt_make_rq_fn *make_rq;
 	nvm_tgt_capacity_fn *capacity;
-	nvm_end_io_fn *end_io;
 
 	/* module-specific init/teardown */
 	nvm_tgt_init_fn *init;
@@ -484,7 +480,7 @@ extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, nvm_l2p_update_fn *,
 			   void *);
 extern int nvm_get_area(struct nvm_tgt_dev *, sector_t *, sector_t);
 extern void nvm_put_area(struct nvm_tgt_dev *, sector_t);
-extern void nvm_end_io(struct nvm_rq *, int);
+extern void nvm_end_io(struct nvm_rq *);
 extern int nvm_bb_tbl_fold(struct nvm_dev *, u8 *, int);
 extern int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr, u8 *);
 
-- 
2.9.3

