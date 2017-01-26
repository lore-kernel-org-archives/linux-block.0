Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33136 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdAZLrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 06:47:51 -0500
Received: by mail-wm0-f45.google.com with SMTP id d140so4361753wmd.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 03:47:50 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: submit erases using the I/O path
Date: Thu, 26 Jan 2017 12:47:38 +0100
Message-Id: <1485431260-20268-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Until now erases has been submitted as synchronous commands through a
dedicated erase function. In order to allow targets implementing
asynchronous erases, refactor the erase path so that it uses the normal
async I/O submission path. If a target requires sync I/O, it can
implement it internally. Also, adapt rrpc to use the new erase path.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      | 29 --------------------
 drivers/lightnvm/rrpc.c      | 64 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/lightnvm.c | 32 +++++++---------------
 include/linux/lightnvm.h     |  6 ++---
 4 files changed, 75 insertions(+), 56 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 4f4db99..3a3e91d 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -617,35 +617,6 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
-int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas, int flags)
-{
-	struct nvm_dev *dev = tgt_dev->parent;
-	struct nvm_rq rqd;
-	int ret;
-
-	if (!dev->ops->erase_block)
-		return 0;
-
-	nvm_map_to_dev(tgt_dev, ppas);
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-
-	ret = nvm_set_rqd_ppalist(dev, &rqd, ppas, 1, 1);
-	if (ret)
-		return ret;
-
-	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
-
-	rqd.flags = flags;
-
-	ret = dev->ops->erase_block(dev, &rqd);
-
-	nvm_free_rqd_ppalist(dev, &rqd);
-
-	return ret;
-}
-EXPORT_SYMBOL(nvm_erase_blk);
-
 int nvm_get_l2p_tbl(struct nvm_tgt_dev *tgt_dev, u64 slba, u32 nlb,
 		    nvm_l2p_update_fn *update_l2p, void *priv)
 {
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index e00b1d7..bec8a9f 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -407,6 +407,67 @@ static int rrpc_move_valid_pages(struct rrpc *rrpc, struct rrpc_block *rblk)
 	return 0;
 }
 
+static void rrpc_end_io_sync(struct nvm_rq *rqd)
+{
+	struct completion *waiting = rqd->private;
+
+	complete(waiting);
+}
+
+static int pblk_erase_blk(struct rrpc *rrpc, struct ppa_addr ppa)
+{
+	struct nvm_tgt_dev *dev = rrpc->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int nr_secs = geo->plane_mode;
+	struct nvm_rq *rqd;
+	int ret;
+	int i;
+	DECLARE_COMPLETION_ONSTACK(wait);
+
+	rqd = mempool_alloc(rrpc->rq_pool, GFP_KERNEL);
+	if (!rqd)
+		return -ENOMEM;
+	memset(rqd, 0, sizeof(struct nvm_rq));
+
+	rqd->opcode = NVM_OP_ERASE;
+	rqd->nr_ppas = nr_secs;
+	rqd->bio = NULL;
+	rqd->end_io = rrpc_end_io_sync;
+	rqd->private = &wait;
+
+	if (nr_secs > 1) {
+		rqd->ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd->dma_ppa_list);
+		if (!rqd->ppa_list) {
+			pr_err("rrpc: not able to allocate ppa list\n");
+			ret = -ENOMEM;
+			goto free_rqd;
+		}
+
+		for (i = 0; i < nr_secs; i++) {
+			ppa.g.pl = i;
+			rqd->ppa_list[i] = ppa;
+		}
+	} else {
+		rqd->ppa_addr = ppa;
+		rqd->ppa_addr.g.pl = 0;
+	}
+
+	ret = nvm_submit_io(dev, rqd);
+	if (ret) {
+		pr_err("rrpr: erase I/O submission falied: %d\n", ret);
+		goto free_ppa_list;
+	}
+	wait_for_completion_io(&wait);
+
+free_ppa_list:
+	if (nr_secs > 1)
+		nvm_dev_dma_free(dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
+free_rqd:
+	mempool_free(rqd, rrpc->rq_pool);
+	return 0;
+}
+
 static void rrpc_block_gc(struct work_struct *work)
 {
 	struct rrpc_block_gc *gcb = container_of(work, struct rrpc_block_gc,
@@ -414,7 +475,6 @@ static void rrpc_block_gc(struct work_struct *work)
 	struct rrpc *rrpc = gcb->rrpc;
 	struct rrpc_block *rblk = gcb->rblk;
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct ppa_addr ppa;
 
 	mempool_free(gcb, rrpc->gcb_pool);
@@ -430,7 +490,7 @@ static void rrpc_block_gc(struct work_struct *work)
 	ppa.g.lun = rlun->bppa.g.lun;
 	ppa.g.blk = rblk->id;
 
-	if (nvm_erase_blk(dev, &ppa, 0))
+	if (pblk_erase_blk(rrpc, ppa))
 		goto put_back;
 
 	rrpc_put_blk(rrpc, rblk);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 21cac85..3c897ab 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -510,12 +510,16 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	}
 	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
-	rq->ioprio = bio_prio(bio);
-	if (bio_has_data(bio))
-		rq->nr_phys_segments = bio_phys_segments(q, bio);
-
-	rq->__data_len = bio->bi_iter.bi_size;
-	rq->bio = rq->biotail = bio;
+	if (bio) {
+		rq->ioprio = bio_prio(bio);
+		rq->__data_len = bio->bi_iter.bi_size;
+		rq->bio = rq->biotail = bio;
+		if (bio_has_data(bio))
+			rq->nr_phys_segments = bio_phys_segments(q, bio);
+	} else {
+		rq->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
+		rq->__data_len = 0;
+	}
 
 	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
 
@@ -526,21 +530,6 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	return 0;
 }
 
-static int nvme_nvm_erase_block(struct nvm_dev *dev, struct nvm_rq *rqd)
-{
-	struct request_queue *q = dev->q;
-	struct nvme_ns *ns = q->queuedata;
-	struct nvme_nvm_command c = {};
-
-	c.erase.opcode = NVM_OP_ERASE;
-	c.erase.nsid = cpu_to_le32(ns->ns_id);
-	c.erase.spba = cpu_to_le64(rqd->ppa_addr.ppa);
-	c.erase.length = cpu_to_le16(rqd->nr_ppas - 1);
-	c.erase.control = cpu_to_le16(rqd->flags);
-
-	return nvme_submit_sync_cmd(q, (struct nvme_command *)&c, NULL, 0);
-}
-
 static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
@@ -576,7 +565,6 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.set_bb_tbl		= nvme_nvm_set_bb_tbl,
 
 	.submit_io		= nvme_nvm_submit_io,
-	.erase_block		= nvme_nvm_erase_block,
 
 	.create_dma_pool	= nvme_nvm_create_dma_pool,
 	.destroy_dma_pool	= nvme_nvm_destroy_dma_pool,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 17cd454..a75d8c0 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -13,6 +13,9 @@ enum {
 
 	NVM_IOTYPE_NONE = 0,
 	NVM_IOTYPE_GC = 1,
+
+	NVM_COMMAND_SYNC = 0,
+	NVM_COMMAND_ASYNC = 1,
 };
 
 #define NVM_BLK_BITS (16)
@@ -56,7 +59,6 @@ typedef int (nvm_get_l2p_tbl_fn)(struct nvm_dev *, u64, u32,
 typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
 typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
 typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef int (nvm_erase_blk_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
 typedef void (nvm_destroy_dma_pool_fn)(void *);
 typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
@@ -70,7 +72,6 @@ struct nvm_dev_ops {
 	nvm_op_set_bb_fn	*set_bb_tbl;
 
 	nvm_submit_io_fn	*submit_io;
-	nvm_erase_blk_fn	*erase_block;
 
 	nvm_create_dma_pool_fn	*create_dma_pool;
 	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
@@ -475,7 +476,6 @@ extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
 extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
 					const struct ppa_addr *, int, int);
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
-extern int nvm_erase_blk(struct nvm_tgt_dev *, struct ppa_addr *, int);
 extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, nvm_l2p_update_fn *,
 			   void *);
 extern int nvm_get_area(struct nvm_tgt_dev *, sector_t *, sector_t);
-- 
2.7.4

