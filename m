Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753773AbdDOS4U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:20 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 03/19] lightnvm: submit erases using the I/O path
Date: Sat, 15 Apr 2017 20:55:37 +0200
Message-ID: <20170415185553.16098-4-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Until now erases have been submitted as synchronous commands through a
dedicated erase function. In order to enable targets implementing
asynchronous erases, refactor the erase path so that it uses the normal
async I/O submission functions. If a target requires sync I/O, it can
implement it internally. Also, adapt rrpc to use the new erase path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Fixed spelling error.
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c      | 54 +++++++++++++++++++++++++++-----------------
 drivers/lightnvm/rrpc.c      |  3 +--
 drivers/nvme/host/lightnvm.c | 32 ++++++++------------------
 include/linux/lightnvm.h     |  8 +++----
 4 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5262ba6..95105c4 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -590,11 +590,11 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	nvm_set_rqd_ppalist(dev, &rqd, ppas, nr_ppas, 1);
+	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
 	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
 
 	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
-	nvm_free_rqd_ppalist(dev, &rqd);
+	nvm_free_rqd_ppalist(tgt_dev, &rqd);
 	if (ret) {
 		pr_err("nvm: failed bb mark\n");
 		return -EINVAL;
@@ -626,34 +626,45 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
-int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas, int flags)
+static void nvm_end_io_sync(struct nvm_rq *rqd)
 {
-	struct nvm_dev *dev = tgt_dev->parent;
+	struct completion *waiting = rqd->private;
+
+	complete(waiting);
+}
+
+int nvm_erase_sync(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
+								int nr_ppas)
+{
+	struct nvm_geo *geo = &tgt_dev->geo;
 	struct nvm_rq rqd;
 	int ret;
-
-	if (!dev->ops->erase_block)
-		return 0;
-
-	nvm_map_to_dev(tgt_dev, ppas);
+	DECLARE_COMPLETION_ONSTACK(wait);
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	ret = nvm_set_rqd_ppalist(dev, &rqd, ppas, 1, 1);
+	rqd.opcode = NVM_OP_ERASE;
+	rqd.end_io = nvm_end_io_sync;
+	rqd.private = &wait;
+	rqd.flags = geo->plane_mode >> 1;
+
+	ret = nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
 	if (ret)
 		return ret;
 
-	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
+	ret = nvm_submit_io(tgt_dev, &rqd);
+	if (ret) {
+		pr_err("rrpr: erase I/O submission failed: %d\n", ret);
+		goto free_ppa_list;
+	}
+	wait_for_completion_io(&wait);
 
-	rqd.flags = flags;
-
-	ret = dev->ops->erase_block(dev, &rqd);
-
-	nvm_free_rqd_ppalist(dev, &rqd);
+free_ppa_list:
+	nvm_free_rqd_ppalist(tgt_dev, &rqd);
 
 	return ret;
 }
-EXPORT_SYMBOL(nvm_erase_blk);
+EXPORT_SYMBOL(nvm_erase_sync);
 
 int nvm_get_l2p_tbl(struct nvm_tgt_dev *tgt_dev, u64 slba, u32 nlb,
 		    nvm_l2p_update_fn *update_l2p, void *priv)
@@ -732,10 +743,11 @@ void nvm_put_area(struct nvm_tgt_dev *tgt_dev, sector_t begin)
 }
 EXPORT_SYMBOL(nvm_put_area);
 
-int nvm_set_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd,
+int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 			const struct ppa_addr *ppas, int nr_ppas, int vblk)
 {
-	struct nvm_geo *geo = &dev->geo;
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_geo *geo = &tgt_dev->geo;
 	int i, plane_cnt, pl_idx;
 	struct ppa_addr ppa;
 
@@ -773,12 +785,12 @@ int nvm_set_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd,
 }
 EXPORT_SYMBOL(nvm_set_rqd_ppalist);
 
-void nvm_free_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd)
+void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
 	if (!rqd->ppa_list)
 		return;
 
-	nvm_dev_dma_free(dev, rqd->ppa_list, rqd->dma_ppa_list);
+	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
 }
 EXPORT_SYMBOL(nvm_free_rqd_ppalist);
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index e68efbc..4e4c299 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -414,7 +414,6 @@ static void rrpc_block_gc(struct work_struct *work)
 	struct rrpc *rrpc = gcb->rrpc;
 	struct rrpc_block *rblk = gcb->rblk;
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct ppa_addr ppa;
 
 	mempool_free(gcb, rrpc->gcb_pool);
@@ -430,7 +429,7 @@ static void rrpc_block_gc(struct work_struct *work)
 	ppa.g.lun = rlun->bppa.g.lun;
 	ppa.g.blk = rblk->id;
 
-	if (nvm_erase_blk(dev, &ppa, 0))
+	if (nvm_erase_sync(rrpc->dev, &ppa, 1))
 		goto put_back;
 
 	rrpc_put_blk(rrpc, rblk);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index fd98954..4ea9c93 100644
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
index ca45e4a..e11163f 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -56,7 +56,6 @@ typedef int (nvm_get_l2p_tbl_fn)(struct nvm_dev *, u64, u32,
 typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
 typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
 typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef int (nvm_erase_blk_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
 typedef void (nvm_destroy_dma_pool_fn)(void *);
 typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
@@ -70,7 +69,6 @@ struct nvm_dev_ops {
 	nvm_op_set_bb_fn	*set_bb_tbl;
 
 	nvm_submit_io_fn	*submit_io;
-	nvm_erase_blk_fn	*erase_block;
 
 	nvm_create_dma_pool_fn	*create_dma_pool;
 	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
@@ -479,10 +477,10 @@ extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
 			      int, int);
 extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
 extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
-extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
+extern int nvm_erase_sync(struct nvm_tgt_dev *, struct ppa_addr *, int);
+extern int nvm_set_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq *,
 					const struct ppa_addr *, int, int);
-extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
-extern int nvm_erase_blk(struct nvm_tgt_dev *, struct ppa_addr *, int);
+extern void nvm_free_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq *);
 extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, nvm_l2p_update_fn *,
 			   void *);
 extern int nvm_get_area(struct nvm_tgt_dev *, sector_t *, sector_t);
-- 
2.9.3
