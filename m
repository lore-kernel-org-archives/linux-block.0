Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41214 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNQE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Aug 2018 12:04:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so15333953ljy.8
        for <linux-block@vger.kernel.org>; Tue, 14 Aug 2018 06:17:48 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [RFC PATCH 1/1] lightnvm: move bad block and chunk state logic to core
Date: Tue, 14 Aug 2018 15:17:35 +0200
Message-Id: <20180814131735.6853-2-mb@lightnvm.io>
In-Reply-To: <20180814131735.6853-1-mb@lightnvm.io>
References: <20180814131735.6853-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

pblk implements two data paths for recovery line state. One for 1.2
and another for 2.0, instead of having pblk implement these, combine
them in the core to reduce complexity and make available to other
targets.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 166 ++++++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-core.c |   6 +-
 drivers/lightnvm/pblk-init.c | 116 +-----------------------------
 drivers/lightnvm/pblk.h      |   2 +-
 drivers/nvme/host/lightnvm.c |   4 +-
 include/linux/lightnvm.h     |  15 ++--
 6 files changed, 122 insertions(+), 187 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 964352720a03..bb948724f33c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -717,46 +717,6 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
 	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
 }
 
-int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct nvm_chk_meta *meta,
-		struct ppa_addr ppa, int nchks)
-{
-	struct nvm_dev *dev = tgt_dev->parent;
-
-	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
-
-	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
-						(sector_t)ppa.ppa, nchks);
-}
-EXPORT_SYMBOL(nvm_get_chunk_meta);
-
-int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
-		       int nr_ppas, int type)
-{
-	struct nvm_dev *dev = tgt_dev->parent;
-	struct nvm_rq rqd;
-	int ret;
-
-	if (nr_ppas > NVM_MAX_VLBA) {
-		pr_err("nvm: unable to update all blocks atomically\n");
-		return -EINVAL;
-	}
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-
-	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
-	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
-
-	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
-	nvm_free_rqd_ppalist(tgt_dev, &rqd);
-	if (ret) {
-		pr_err("nvm: failed bb mark\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(nvm_set_tgt_bb_tbl);
-
 static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
 {
 	int flags = 0;
@@ -831,26 +791,22 @@ void nvm_end_io(struct nvm_rq *rqd)
 EXPORT_SYMBOL(nvm_end_io);
 
 /*
- * folds a bad block list from its plane representation to its virtual
- * block representation. The fold is done in place and reduced size is
- * returned.
+ * folds a bad block list from its plane representation to its
+ * chunk representation.
  *
- * If any of the planes status are bad or grown bad block, the virtual block
- * is marked bad. If not bad, the first plane state acts as the block state.
+ * If any of the planes status are bad or grown bad, the chunk is marked
+ * offline. If not bad, the first plane state acts as the chunk state.
  */
-int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
+static void nvm_bb_to_chunk(struct nvm_dev *dev, u8 *blks, int nr_blks,
+						struct nvm_chk_meta *meta)
 {
 	struct nvm_geo *geo = &dev->geo;
-	int blk, offset, pl, blktype;
-
-	if (nr_blks != geo->num_chk * geo->pln_mode)
-		return -EINVAL;
+	int blk, pl, offset, blktype;
 
 	for (blk = 0; blk < geo->num_chk; blk++) {
 		offset = blk * geo->pln_mode;
 		blktype = blks[offset];
 
-		/* Bad blocks on any planes take precedence over other types */
 		for (pl = 0; pl < geo->pln_mode; pl++) {
 			if (blks[offset + pl] &
 					(NVM_BLK_T_BAD|NVM_BLK_T_GRWN_BAD)) {
@@ -859,23 +815,117 @@ int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
 			}
 		}
 
-		blks[blk] = blktype;
+		if (blktype == NVM_BLK_T_FREE)
+			meta->state = NVM_CHK_ST_CLOSED;
+		else
+			meta->state = NVM_CHK_ST_OFFLINE;
+
+		meta->type = NVM_CHK_TP_W_SEQ;
+		meta->wi = 0;
+		meta->slba = -1;
+		meta->cnlb = meta->wp = dev->geo.clba;
+
+		meta++;
 	}
 
-	return geo->num_chk;
+	return 0;
+}
+
+static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba, int nchks,
+			   struct nvm_chk_meta *meta)
+{
+	struct nvm_geo *geo = &dev->geo;
+	struct ppa_addr ppa;
+	u8 *blks;
+	int ch, lun, nr_blks;
+	int ret;
+
+	ppa.ppa = slba;
+	ppa = dev_to_generic_addr(dev, ppa);
+
+	if (ppa.g.blk != 0)
+		return -EINVAL;
+
+	if ((nchks % geo->num_chk) != 0)
+		return -EINVAL;
+
+	nr_blks = geo->num_chk * geo->pln_mode;
+
+	blks = kmalloc(nr_blks, GFP_KERNEL);
+	if (!blks)
+		return -ENOMEM;
+
+	for (ch = ppa.g.ch; ch < geo->num_ch; ch++) {
+		for (lun = ppa.g.lun; lun < geo->num_lun; lun++) {
+			struct ppa_addr ppa_tmp;
+
+			if (!nchks)
+				goto out;
+
+			ppa_tmp.ppa = 0;
+			ppa_tmp.a.ch = ch;
+			ppa_tmp.a.lun = lun;
+			ppa_tmp = generic_to_dev_addr(dev, ppa_tmp);
+
+			ret = dev->ops->get_bb_tbl(dev, ppa_tmp, blks);
+			if (ret)
+				goto err;
+
+			nvm_bb_to_chunk(dev, blks, nr_blks, meta);
+
+			meta += geo->num_chk;
+			nchks -= geo->num_chk;
+		}
+	}
+out:
+	return 0;
+err:
+	kfree(blks);
+	return ret;
 }
-EXPORT_SYMBOL(nvm_bb_tbl_fold);
 
-int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
-		       u8 *blks)
+int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
+		       int nchks, struct nvm_chk_meta *meta)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 
 	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
 
-	return dev->ops->get_bb_tbl(dev, ppa, blks);
+	if (dev->geo.version == NVM_OCSSD_SPEC_12)
+		return nvm_get_bb_meta(dev, (sector_t)ppa.ppa, nchks, meta);
+
+	return dev->ops->get_chk_meta(dev, (sector_t)ppa.ppa, nchks, meta);
 }
-EXPORT_SYMBOL(nvm_get_tgt_bb_tbl);
+EXPORT_SYMBOL_GPL(nvm_get_chunk_meta);
+
+int nvm_set_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
+		       int nr_ppas, int type)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_rq rqd;
+	int ret;
+
+	if (dev->geo.version == NVM_OCSSD_SPEC_20)
+		return 0;
+
+	if (nr_ppas > NVM_MAX_VLBA) {
+		pr_err("nvm: unable to update all blocks atomically\n");
+		return -EINVAL;
+	}
+
+	memset(&rqd, 0, sizeof(struct nvm_rq));
+
+	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
+	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
+
+	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
+	nvm_free_rqd_ppalist(tgt_dev, &rqd);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvm_set_chunk_meta);
 
 static int nvm_core_init(struct nvm_dev *dev)
 {
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 814204d22a2e..4df90b3e574e 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -27,7 +27,7 @@ static void pblk_line_mark_bb(struct work_struct *work)
 	struct ppa_addr *ppa = line_ws->priv;
 	int ret;
 
-	ret = nvm_set_tgt_bb_tbl(dev, ppa, 1, NVM_BLK_T_GRWN_BAD);
+	ret = nvm_set_chunk_meta(dev, ppa, 1, NVM_BLK_T_GRWN_BAD);
 	if (ret) {
 		struct pblk_line *line;
 		int pos;
@@ -110,7 +110,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
  *
  * The caller is responsible for freeing the returned structure
  */
-struct nvm_chk_meta *pblk_chunk_get_info(struct pblk *pblk)
+struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -126,7 +126,7 @@ struct nvm_chk_meta *pblk_chunk_get_info(struct pblk *pblk)
 	if (!meta)
 		return ERR_PTR(-ENOMEM);
 
-	ret = nvm_get_chunk_meta(dev, meta, ppa, geo->all_chunks);
+	ret = nvm_get_chunk_meta(dev, ppa, geo->all_chunks, meta);
 	if (ret) {
 		kfree(meta);
 		return ERR_PTR(-EIO);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index cc8a59e3c240..25686ce3b0d5 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -540,67 +540,6 @@ static void pblk_lines_free(struct pblk *pblk)
 	kfree(pblk->lines);
 }
 
-static int pblk_bb_get_tbl(struct nvm_tgt_dev *dev, struct pblk_lun *rlun,
-			   u8 *blks, int nr_blks)
-{
-	struct ppa_addr ppa;
-	int ret;
-
-	ppa.ppa = 0;
-	ppa.g.ch = rlun->bppa.g.ch;
-	ppa.g.lun = rlun->bppa.g.lun;
-
-	ret = nvm_get_tgt_bb_tbl(dev, ppa, blks);
-	if (ret)
-		return ret;
-
-	nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
-	if (nr_blks < 0)
-		return -EIO;
-
-	return 0;
-}
-
-static void *pblk_bb_get_meta(struct pblk *pblk)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-	u8 *meta;
-	int i, nr_blks, blk_per_lun;
-	int ret;
-
-	blk_per_lun = geo->num_chk * geo->pln_mode;
-	nr_blks = blk_per_lun * geo->all_luns;
-
-	meta = kmalloc(nr_blks, GFP_KERNEL);
-	if (!meta)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < geo->all_luns; i++) {
-		struct pblk_lun *rlun = &pblk->luns[i];
-		u8 *meta_pos = meta + i * blk_per_lun;
-
-		ret = pblk_bb_get_tbl(dev, rlun, meta_pos, blk_per_lun);
-		if (ret) {
-			kfree(meta);
-			return ERR_PTR(-EIO);
-		}
-	}
-
-	return meta;
-}
-
-static void *pblk_chunk_get_meta(struct pblk *pblk)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-
-	if (geo->version == NVM_OCSSD_SPEC_12)
-		return pblk_bb_get_meta(pblk);
-	else
-		return pblk_chunk_get_info(pblk);
-}
-
 static int pblk_luns_init(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -699,51 +638,7 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
 }
 
-static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
-				   void *chunk_meta)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line_meta *lm = &pblk->lm;
-	int i, chk_per_lun, nr_bad_chks = 0;
-
-	chk_per_lun = geo->num_chk * geo->pln_mode;
-
-	for (i = 0; i < lm->blk_per_line; i++) {
-		struct pblk_lun *rlun = &pblk->luns[i];
-		struct nvm_chk_meta *chunk;
-		int pos = pblk_ppa_to_pos(geo, rlun->bppa);
-		u8 *lun_bb_meta = chunk_meta + pos * chk_per_lun;
-
-		chunk = &line->chks[pos];
-
-		/*
-		 * In 1.2 spec. chunk state is not persisted by the device. Thus
-		 * some of the values are reset each time pblk is instantiated,
-		 * so we have to assume that the block is closed.
-		 */
-		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
-			chunk->state =  NVM_CHK_ST_CLOSED;
-		else
-			chunk->state = NVM_CHK_ST_OFFLINE;
-
-		chunk->type = NVM_CHK_TP_W_SEQ;
-		chunk->wi = 0;
-		chunk->slba = -1;
-		chunk->cnlb = geo->clba;
-		chunk->wp = 0;
-
-		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
-			continue;
-
-		set_bit(pos, line->blk_bitmap);
-		nr_bad_chks++;
-	}
-
-	return nr_bad_chks;
-}
-
-static int pblk_setup_line_meta_20(struct pblk *pblk, struct pblk_line *line,
+static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
 				   struct nvm_chk_meta *meta)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -790,8 +685,6 @@ static int pblk_setup_line_meta_20(struct pblk *pblk, struct pblk_line *line,
 static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
 				 void *chunk_meta, int line_id)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	long nr_bad_chks, chk_in_line;
@@ -804,10 +697,7 @@ static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
 	line->vsc = &l_mg->vsc_list[line_id];
 	spin_lock_init(&line->lock);
 
-	if (geo->version == NVM_OCSSD_SPEC_12)
-		nr_bad_chks = pblk_setup_line_meta_12(pblk, line, chunk_meta);
-	else
-		nr_bad_chks = pblk_setup_line_meta_20(pblk, line, chunk_meta);
+	nr_bad_chks = pblk_setup_line_meta_chk(pblk, line, chunk_meta);
 
 	chk_in_line = lm->blk_per_line - nr_bad_chks;
 	if (nr_bad_chks < 0 || nr_bad_chks > lm->blk_per_line ||
@@ -1058,7 +948,7 @@ static int pblk_lines_init(struct pblk *pblk)
 	if (ret)
 		goto fail_free_meta;
 
-	chunk_meta = pblk_chunk_get_meta(pblk);
+	chunk_meta = pblk_get_chunk_meta(pblk);
 	if (IS_ERR(chunk_meta)) {
 		ret = PTR_ERR(chunk_meta);
 		goto fail_free_luns;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 48b3035df3c4..579b4ea9716c 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -774,7 +774,7 @@ void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
 int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct pblk_c_ctx *c_ctx);
 void pblk_discard(struct pblk *pblk, struct bio *bio);
-struct nvm_chk_meta *pblk_chunk_get_info(struct pblk *pblk);
+struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk);
 struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
 					      struct nvm_chk_meta *lp,
 					      struct ppa_addr ppa);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a156fe3ca7d3..a4b036e240c8 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -567,8 +567,8 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
  * Expect the lba in device format
  */
 static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
-				 struct nvm_chk_meta *meta,
-				 sector_t slba, int nchks)
+				 sector_t slba, int nchks,
+				 struct nvm_chk_meta *meta)
 {
 	struct nvm_geo *geo = &ndev->geo;
 	struct nvme_ns *ns = ndev->q->queuedata;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index f4a84694e5e2..0106984400bc 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -86,8 +86,8 @@ struct nvm_chk_meta;
 typedef int (nvm_id_fn)(struct nvm_dev *);
 typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
 typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
-typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, struct nvm_chk_meta *,
-								sector_t, int);
+typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
+							struct nvm_chk_meta *);
 typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
@@ -532,18 +532,13 @@ extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-
-extern int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev,
-			      struct nvm_chk_meta *meta, struct ppa_addr ppa,
-			      int nchks);
-
-extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
+extern int nvm_get_chunk_meta(struct nvm_tgt_dev *, struct ppa_addr,
+			      int, struct nvm_chk_meta *);
+extern int nvm_set_chunk_meta(struct nvm_tgt_dev *, struct ppa_addr *,
 			      int, int);
 extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
 extern int nvm_submit_io_sync(struct nvm_tgt_dev *, struct nvm_rq *);
 extern void nvm_end_io(struct nvm_rq *);
-extern int nvm_bb_tbl_fold(struct nvm_dev *, u8 *, int);
-extern int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr, u8 *);
 
 #else /* CONFIG_NVM */
 struct nvm_dev_ops;
-- 
2.11.0
