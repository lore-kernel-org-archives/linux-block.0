Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38937 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeJDOFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Oct 2018 10:05:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so7568911edi.6
        for <linux-block@vger.kernel.org>; Thu, 04 Oct 2018 00:14:05 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: pblk: retrieve chunk metadata on erase
Date: Thu,  4 Oct 2018 09:13:55 +0200
Message-Id: <1538637235-25469-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
References: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On the OCSSD 2.0 spec, the device populates the metadata pointer (if
provided) when a chunk is reset. Implement this path in pblk. This is
the base for implementing wear-leveling and supporting variable size
chunks (e.g., due to the device mapping out certain sectors).

For 1.2, reset the write pointer and the state on core so that the erase
path is transparent to pblk wrt OCSSD version.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-core.c | 54 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2..dceaae4e795f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -750,9 +750,40 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
+/* Take only addresses in generic format */
+static void nvm_set_chunk_state_12(struct nvm_dev *dev, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
+	int i;
+
+	for (i = 0; i < rqd->nr_ppas; i++) {
+		struct ppa_addr ppa;
+		struct nvm_chk_meta *chunk;
+
+		chunk = ((struct nvm_chk_meta *)rqd->meta_list) + i;
+
+		if (rqd->error)
+			chunk->state = NVM_CHK_ST_OFFLINE;
+		else
+			chunk->state = NVM_CHK_ST_FREE;
+
+		chunk->wp = 0;
+		chunk->wi = 0;
+		chunk->type = NVM_CHK_TP_W_SEQ;
+		chunk->cnlb = dev->geo.clba;
+
+		/* recalculate slba for the chunk */
+		ppa = ppa_list[i];
+		ppa.g.pg = ppa.g.pl = ppa.g.sec = 0;
+
+		chunk->slba = generic_to_dev_addr(dev, ppa).ppa;
+	}
+}
+
 int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_geo *geo = &dev->geo;
 	int ret;
 
 	if (!dev->ops->submit_io_sync)
@@ -765,8 +796,12 @@ int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 
 	/* In case of error, fail with right address format */
 	ret = dev->ops->submit_io_sync(dev, rqd);
+
 	nvm_rq_dev_to_tgt(tgt_dev, rqd);
 
+	if (geo->version == NVM_OCSSD_SPEC_12 && rqd->opcode == NVM_OP_ERASE)
+		nvm_set_chunk_state_12(dev, rqd);
+
 	return ret;
 }
 EXPORT_SYMBOL(nvm_submit_io_sync);
@@ -775,10 +810,15 @@ void nvm_end_io(struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *tgt_dev = rqd->dev;
 
-	/* Convert address space */
-	if (tgt_dev)
+	if (tgt_dev) {
+		/* Convert address space */
 		nvm_rq_dev_to_tgt(tgt_dev, rqd);
 
+		if (tgt_dev->geo.version == NVM_OCSSD_SPEC_12 &&
+						rqd->opcode == NVM_OP_ERASE)
+			nvm_set_chunk_state_12(tgt_dev->parent, rqd);
+	}
+
 	if (rqd->end_io)
 		rqd->end_io(rqd);
 }
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..2507c4838283 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -80,7 +80,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct nvm_chk_meta *chunk;
+	struct nvm_chk_meta *chunk, *dev_chunk;
 	struct pblk_line *line;
 	int pos;
 
@@ -90,22 +90,42 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 
 	atomic_dec(&line->left_seblks);
 
+	/* pblk submits a single erase per command */
+	dev_chunk = rqd->meta_list;
+
+	chunk->state = dev_chunk->state;
+	chunk->type = dev_chunk->type;
+	chunk->wi = dev_chunk->wi;
+	chunk->cnlb = dev_chunk->cnlb;
+	chunk->wp = dev_chunk->wp;
+
 	if (rqd->error) {
 		trace_pblk_chunk_reset(pblk_disk_name(pblk),
 				&rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
 
-		chunk->state = NVM_CHK_ST_OFFLINE;
+#ifdef CONFIG_NVM_PBLK_DEBUG
+		if (chunk->state != NVM_CHK_ST_OFFLINE)
+			print_chunk(pblk, chunk,
+				"corrupted erase chunk state", rqd->error);
+#endif
+
 		pblk_mark_bb(pblk, line, rqd->ppa_addr);
 	} else {
 		trace_pblk_chunk_reset(pblk_disk_name(pblk),
 				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
 
-		chunk->state = NVM_CHK_ST_FREE;
+#ifdef CONFIG_NVM_PBLK_DEBUG
+		if (chunk->state != NVM_CHK_ST_FREE || chunk->wp ||
+						dev_chunk->slba != chunk->slba)
+			print_chunk(pblk, chunk,
+				"corrupted erase chunk state", rqd->error);
+#endif
 	}
 
 	trace_pblk_chunk_state(pblk_disk_name(pblk), &rqd->ppa_addr,
 				chunk->state);
 
+	pblk_free_rqd_meta(pblk, rqd);
 	atomic_dec(&pblk->inflight_io);
 }
 
@@ -923,14 +943,16 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	return ret;
 }
 
-static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			    struct ppa_addr ppa)
+static int pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
+			   struct ppa_addr ppa)
 {
 	rqd->opcode = NVM_OP_ERASE;
 	rqd->ppa_addr = ppa;
 	rqd->nr_ppas = 1;
 	rqd->is_seq = 1;
 	rqd->bio = NULL;
+
+	return pblk_alloc_rqd_meta(pblk, rqd);
 }
 
 static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
@@ -938,10 +960,12 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 	struct nvm_rq rqd = {NULL};
 	int ret;
 
+	ret = pblk_setup_e_rq(pblk, &rqd, ppa);
+	if (ret)
+		return ret;
+
 	trace_pblk_chunk_reset(pblk_disk_name(pblk), &ppa,
-				PBLK_CHUNK_RESET_START);
-
-	pblk_setup_e_rq(pblk, &rqd, ppa);
+						PBLK_CHUNK_RESET_START);
 
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
@@ -1746,11 +1770,15 @@ void pblk_line_put_wq(struct kref *ref)
 int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct nvm_rq *rqd;
-	int err;
+	int ret;
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_ERASE);
 
-	pblk_setup_e_rq(pblk, rqd, ppa);
+	ret = pblk_setup_e_rq(pblk, rqd, ppa);
+	if (ret) {
+		pblk_free_rqd(pblk, rqd, PBLK_ERASE);
+		return ret;
+	}
 
 	rqd->end_io = pblk_end_io_erase;
 	rqd->private = pblk;
@@ -1761,8 +1789,8 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
-	err = pblk_submit_io(pblk, rqd);
-	if (err) {
+	ret = pblk_submit_io(pblk, rqd);
+	if (ret) {
 		struct nvm_tgt_dev *dev = pblk->dev;
 		struct nvm_geo *geo = &dev->geo;
 
@@ -1771,7 +1799,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 					pblk_ppa_to_pos(geo, ppa));
 	}
 
-	return err;
+	return ret;
 }
 
 struct pblk_line *pblk_line_get_data(struct pblk *pblk)
-- 
2.7.4
