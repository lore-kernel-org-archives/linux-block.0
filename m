Return-Path: <javier@javigon.com>
Return-Path: <javier@javigon.com>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: pblk: refactor metadata paths
Date: Wed, 29 Aug 2018 10:56:18 +0200
Message-Id: <1535532980-27672-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

pblk maintains two different metadata paths for smeta and emeta, which
store metadata at the start of the line and at the end of the line,
respectively. Until now, these path has been common for writing and
retrieving metadata, however, as these paths diverge, the common code
becomes less clear and unnecessary complicated.

In preparation for further changes to the metadata write path, this
patch separates the write and read paths for smeta and emeta and
removes the synchronous emeta path as it not used anymore (emeta is
scheduled asynchronously to prevent jittering due to internal I/Os).

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 338 ++++++++++++++++++---------------------
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-recovery.c |   4 +-
 drivers/lightnvm/pblk.h          |   4 +-
 4 files changed, 163 insertions(+), 185 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index dbf037b2b32f..09160ec02c5f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -661,12 +661,137 @@ u64 pblk_lookup_page(struct pblk *pblk, struct pblk_line *line)
 	return paddr;
 }
 
-/*
- * Submit emeta to one LUN in the raid line at the time to avoid a deadlock when
- * taking the per LUN semaphore.
- */
-static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
-				     void *emeta_buf, u64 paddr, int dir)
+u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_meta *lm = &pblk->lm;
+	int bit;
+
+	/* This usually only happens on bad lines */
+	bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
+	if (bit >= lm->blk_per_line)
+		return -1;
+
+	return bit * geo->ws_opt;
+}
+
+int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct pblk_line_meta *lm = &pblk->lm;
+	struct bio *bio;
+	struct nvm_rq rqd;
+	u64 paddr = pblk_line_smeta_start(pblk, line);
+	int i, ret;
+
+	memset(&rqd, 0, sizeof(struct nvm_rq));
+
+	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd.dma_meta_list);
+	if (!rqd.meta_list)
+		return -ENOMEM;
+
+	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
+	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
+
+	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
+	if (IS_ERR(bio)) {
+		ret = PTR_ERR(bio);
+		goto free_ppa_list;
+	}
+
+	bio->bi_iter.bi_sector = 0; /* internal bio */
+	bio_set_op_attrs(bio, REQ_OP_READ, 0);
+
+	rqd.bio = bio;
+	rqd.opcode = NVM_OP_PREAD;
+	rqd.nr_ppas = lm->smeta_sec;
+	rqd.is_seq = 1;
+
+	for (i = 0; i < lm->smeta_sec; i++, paddr++)
+		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
+
+	ret = pblk_submit_io_sync(pblk, &rqd);
+	if (ret) {
+		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
+		bio_put(bio);
+		goto free_ppa_list;
+	}
+
+	atomic_dec(&pblk->inflight_io);
+
+	if (rqd.error)
+		pblk_log_read_err(pblk, &rqd);
+
+free_ppa_list:
+	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
+	return ret;
+}
+
+static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
+				 u64 paddr)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct pblk_line_meta *lm = &pblk->lm;
+	struct bio *bio;
+	struct nvm_rq rqd;
+	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
+	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+	int i, ret;
+
+	memset(&rqd, 0, sizeof(struct nvm_rq));
+
+	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd.dma_meta_list);
+	if (!rqd.meta_list)
+		return -ENOMEM;
+
+	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
+	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
+
+	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
+	if (IS_ERR(bio)) {
+		ret = PTR_ERR(bio);
+		goto free_ppa_list;
+	}
+
+	bio->bi_iter.bi_sector = 0; /* internal bio */
+	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+
+	rqd.bio = bio;
+	rqd.opcode = NVM_OP_PWRITE;
+	rqd.nr_ppas = lm->smeta_sec;
+	rqd.is_seq = 1;
+
+	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
+		struct pblk_sec_meta *meta_list = rqd.meta_list;
+
+		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
+		meta_list[i].lba = lba_list[paddr] = addr_empty;
+	}
+
+	ret = pblk_submit_io_sync(pblk, &rqd);
+	if (ret) {
+		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
+		bio_put(bio);
+		goto free_ppa_list;
+	}
+
+	atomic_dec(&pblk->inflight_io);
+
+	if (rqd.error) {
+		pblk_log_write_err(pblk, &rqd);
+		ret = -EIO;
+	}
+
+free_ppa_list:
+	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
+	return ret;
+}
+
+int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
+			 void *emeta_buf)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -675,24 +800,15 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	void *ppa_list, *meta_list;
 	struct bio *bio;
 	struct nvm_rq rqd;
+	u64 paddr = line->emeta_ssec;
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	int min = pblk->min_write_pgs;
 	int left_ppas = lm->emeta_sec[0];
-	int id = line->id;
+	int line_id = line->id;
 	int rq_ppas, rq_len;
-	int cmd_op, bio_op;
 	int i, j;
 	int ret;
 
-	if (dir == PBLK_WRITE) {
-		bio_op = REQ_OP_WRITE;
-		cmd_op = NVM_OP_PWRITE;
-	} else if (dir == PBLK_READ) {
-		bio_op = REQ_OP_READ;
-		cmd_op = NVM_OP_PREAD;
-	} else
-		return -EINVAL;
-
 	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
 							&dma_meta_list);
 	if (!meta_list)
@@ -715,64 +831,43 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, bio_op, 0);
+	bio_set_op_attrs(bio, REQ_OP_READ, 0);
 
 	rqd.bio = bio;
 	rqd.meta_list = meta_list;
 	rqd.ppa_list = ppa_list;
 	rqd.dma_meta_list = dma_meta_list;
 	rqd.dma_ppa_list = dma_ppa_list;
-	rqd.opcode = cmd_op;
+	rqd.opcode = NVM_OP_PREAD;
 	rqd.nr_ppas = rq_ppas;
 
-	if (dir == PBLK_WRITE) {
-		struct pblk_sec_meta *meta_list = rqd.meta_list;
+	for (i = 0; i < rqd.nr_ppas; ) {
+		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line_id);
+		int pos = pblk_ppa_to_pos(geo, ppa);
 
-		rqd.is_seq = 1;
-		for (i = 0; i < rqd.nr_ppas; ) {
-			spin_lock(&line->lock);
-			paddr = __pblk_alloc_page(pblk, line, min);
-			spin_unlock(&line->lock);
-			for (j = 0; j < min; j++, i++, paddr++) {
-				meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
-				rqd.ppa_list[i] =
-					addr_to_gen_ppa(pblk, paddr, id);
-			}
-		}
-	} else {
-		for (i = 0; i < rqd.nr_ppas; ) {
-			struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, id);
-			int pos = pblk_ppa_to_pos(geo, ppa);
+		if (pblk_io_aligned(pblk, rq_ppas))
+			rqd.is_seq = 1;
 
-			if (pblk_io_aligned(pblk, rq_ppas))
-				rqd.is_seq = 1;
-
-			while (test_bit(pos, line->blk_bitmap)) {
-				paddr += min;
-				if (pblk_boundary_paddr_checks(pblk, paddr)) {
-					pblk_err(pblk, "corrupt emeta line:%d\n",
-								line->id);
-					bio_put(bio);
-					ret = -EINTR;
-					goto free_rqd_dma;
-				}
-
-				ppa = addr_to_gen_ppa(pblk, paddr, id);
-				pos = pblk_ppa_to_pos(geo, ppa);
-			}
-
-			if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
-				pblk_err(pblk, "corrupt emeta line:%d\n",
-								line->id);
+		while (test_bit(pos, line->blk_bitmap)) {
+			paddr += min;
+			if (pblk_boundary_paddr_checks(pblk, paddr)) {
 				bio_put(bio);
 				ret = -EINTR;
 				goto free_rqd_dma;
 			}
 
-			for (j = 0; j < min; j++, i++, paddr++)
-				rqd.ppa_list[i] =
-					addr_to_gen_ppa(pblk, paddr, line->id);
+			ppa = addr_to_gen_ppa(pblk, paddr, line_id);
+			pos = pblk_ppa_to_pos(geo, ppa);
 		}
+
+		if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
+			bio_put(bio);
+			ret = -EINTR;
+			goto free_rqd_dma;
+		}
+
+		for (j = 0; j < min; j++, i++, paddr++)
+			rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line_id);
 	}
 
 	ret = pblk_submit_io_sync(pblk, &rqd);
@@ -784,136 +879,19 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	atomic_dec(&pblk->inflight_io);
 
-	if (rqd.error) {
-		if (dir == PBLK_WRITE)
-			pblk_log_write_err(pblk, &rqd);
-		else
-			pblk_log_read_err(pblk, &rqd);
-	}
+	if (rqd.error)
+		pblk_log_read_err(pblk, &rqd);
 
 	emeta_buf += rq_len;
 	left_ppas -= rq_ppas;
 	if (left_ppas)
 		goto next_rq;
+
 free_rqd_dma:
 	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return ret;
 }
 
-u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line_meta *lm = &pblk->lm;
-	int bit;
-
-	/* This usually only happens on bad lines */
-	bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
-	if (bit >= lm->blk_per_line)
-		return -1;
-
-	return bit * geo->ws_opt;
-}
-
-static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
-				     u64 paddr, int dir)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct pblk_line_meta *lm = &pblk->lm;
-	struct bio *bio;
-	struct nvm_rq rqd;
-	__le64 *lba_list = NULL;
-	int i, ret;
-	int cmd_op, bio_op;
-
-	if (dir == PBLK_WRITE) {
-		bio_op = REQ_OP_WRITE;
-		cmd_op = NVM_OP_PWRITE;
-		lba_list = emeta_to_lbas(pblk, line->emeta->buf);
-	} else if (dir == PBLK_READ_RECOV || dir == PBLK_READ) {
-		bio_op = REQ_OP_READ;
-		cmd_op = NVM_OP_PREAD;
-	} else
-		return -EINVAL;
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-
-	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd.dma_meta_list);
-	if (!rqd.meta_list)
-		return -ENOMEM;
-
-	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
-	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
-
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		ret = PTR_ERR(bio);
-		goto free_ppa_list;
-	}
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, bio_op, 0);
-
-	rqd.bio = bio;
-	rqd.opcode = cmd_op;
-	rqd.is_seq = 1;
-	rqd.nr_ppas = lm->smeta_sec;
-
-	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
-		struct pblk_sec_meta *meta_list = rqd.meta_list;
-
-		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
-
-		if (dir == PBLK_WRITE) {
-			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
-
-			meta_list[i].lba = lba_list[paddr] = addr_empty;
-		}
-	}
-
-	/*
-	 * This I/O is sent by the write thread when a line is replace. Since
-	 * the write thread is the only one sending write and erase commands,
-	 * there is no need to take the LUN semaphore.
-	 */
-	ret = pblk_submit_io_sync(pblk, &rqd);
-	if (ret) {
-		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
-		bio_put(bio);
-		goto free_ppa_list;
-	}
-
-	atomic_dec(&pblk->inflight_io);
-
-	if (rqd.error) {
-		if (dir == PBLK_WRITE) {
-			pblk_log_write_err(pblk, &rqd);
-			ret = 1;
-		} else if (dir == PBLK_READ)
-			pblk_log_read_err(pblk, &rqd);
-	}
-
-free_ppa_list:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
-
-	return ret;
-}
-
-int pblk_line_read_smeta(struct pblk *pblk, struct pblk_line *line)
-{
-	u64 bpaddr = pblk_line_smeta_start(pblk, line);
-
-	return pblk_line_submit_smeta_io(pblk, line, bpaddr, PBLK_READ_RECOV);
-}
-
-int pblk_line_read_emeta(struct pblk *pblk, struct pblk_line *line,
-			 void *emeta_buf)
-{
-	return pblk_line_submit_emeta_io(pblk, line, emeta_buf,
-						line->emeta_ssec, PBLK_READ);
-}
-
 static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			    struct ppa_addr ppa)
 {
@@ -1150,7 +1128,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	line->smeta_ssec = off;
 	line->cur_sec = off + lm->smeta_sec;
 
-	if (init && pblk_line_submit_smeta_io(pblk, line, off, PBLK_WRITE)) {
+	if (init && pblk_line_smeta_write(pblk, line, off)) {
 		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
 		return 0;
 	}
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index b0f0c637df3a..73e64c1b55ef 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -148,7 +148,7 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
 	if (!emeta_buf)
 		return NULL;
 
-	ret = pblk_line_read_emeta(pblk, line, emeta_buf);
+	ret = pblk_line_emeta_read(pblk, line, emeta_buf);
 	if (ret) {
 		pblk_err(pblk, "line %d read emeta failed (%d)\n",
 				line->id, ret);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index c641a9ed5f39..95ea5072b27e 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -839,7 +839,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			continue;
 
 		/* Lines that cannot be read are assumed as not written here */
-		if (pblk_line_read_smeta(pblk, line))
+		if (pblk_line_smeta_read(pblk, line))
 			continue;
 
 		crc = pblk_calc_smeta_crc(pblk, smeta_buf);
@@ -909,7 +909,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		line->emeta = emeta;
 		memset(line->emeta->buf, 0, lm->emeta_len[0]);
 
-		if (pblk_line_read_emeta(pblk, line, line->emeta->buf)) {
+		if (pblk_line_emeta_read(pblk, line, line->emeta->buf)) {
 			pblk_recov_l2p_from_oob(pblk, line);
 			goto next;
 		}
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 6195e3f5d2e6..e29fd35d2991 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -817,8 +817,8 @@ void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
 		     void (*work)(struct work_struct *), gfp_t gfp_mask,
 		     struct workqueue_struct *wq);
 u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line);
-int pblk_line_read_smeta(struct pblk *pblk, struct pblk_line *line);
-int pblk_line_read_emeta(struct pblk *pblk, struct pblk_line *line,
+int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line);
+int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 			 void *emeta_buf);
 int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr erase_ppa);
 void pblk_line_put(struct kref *ref);
-- 
2.7.4
