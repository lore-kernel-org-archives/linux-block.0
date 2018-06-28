Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36646 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934956AbeF1JMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 05:12:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so2464798plp.3
        for <linux-block@vger.kernel.org>; Thu, 28 Jun 2018 02:12:38 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Date: Thu, 28 Jun 2018 11:12:01 +0200
Message-Id: <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The Open-Channel 1.2 spec does not define a mechanism for the host to
recover the block (chunk) state. As a consequence, a newly format device
will need to reconstruct the state. Currently, pblk assumes that blocks
are not erased, which might cause double-erases in case that the device
does not protect itself against them (which is not specified in the spec
either).

This patch, reconstructs the state based on read errors. If the first
sector of a block returns and empty page (NVM_RSP_ERR_EMPTYPAGE), then
the block s marked free, i.e., erased and ready to be used
(NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
(NVM_CHK_ST_CLOSED). Note that even if a block is open and not fully
written, it has to be erased in order to be used again.

One caveat of this approach is that blocks that have been erased at a
moment in time, will always be considered as erased. However, some media
might become unstable if blocks are not erased before usage. Since pblk
would follow this principle after the state of all blocks fall under
pblk's domain, we can consider this as an initialization problem. The
trade-off would be to fall back to the old behavior and risk premature
media wearing.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 138 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3b8aa4a64cac..ce25f1473d8e 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -697,47 +697,138 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
 }
 
+static void pblk_state_complete(struct kref *ref)
+{
+	struct pblk_pad_rq *pad_rq = container_of(ref, struct pblk_pad_rq, ref);
+
+	complete(&pad_rq->wait);
+}
+
+static void pblk_end_io_state(struct nvm_rq *rqd)
+{
+	struct pblk_pad_rq *pad_rq = rqd->private;
+	struct pblk *pblk = pad_rq->pblk;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line *line;
+	struct nvm_chk_meta *chunk;
+	int pos;
+
+	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
+	pos = pblk_ppa_to_pos(geo, rqd->ppa_addr);
+
+	chunk = &line->chks[pos];
+
+	if (rqd->error == NVM_RSP_ERR_EMPTYPAGE)
+		chunk->state = NVM_CHK_ST_FREE;
+	else
+		chunk->state = NVM_CHK_ST_CLOSED;
+
+	bio_put(rqd->bio);
+	pblk_free_rqd(pblk, rqd, PBLK_READ);
+	kref_put(&pad_rq->ref, pblk_state_complete);
+}
+
+static int pblk_check_chunk_state(struct pblk *pblk, struct nvm_chk_meta *chunk,
+				struct ppa_addr ppa, struct pblk_pad_rq *pad_rq)
+{
+	struct nvm_rq *rqd;
+	struct bio *bio;
+	int ret;
+
+	bio = bio_alloc(GFP_KERNEL, 1);
+
+	if (pblk_bio_add_pages(pblk, bio, GFP_KERNEL, 1))
+		goto fail_free_bio;
+
+	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
+
+	rqd->bio = bio;
+	rqd->opcode = NVM_OP_PREAD;
+	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
+	rqd->nr_ppas = 1;
+	rqd->ppa_addr = ppa;
+	rqd->end_io = pblk_end_io_state;
+	rqd->private = pad_rq;
+
+	kref_get(&pad_rq->ref);
+
+	ret = pblk_submit_io(pblk, rqd);
+	if (ret) {
+		pr_err("pblk: I/O submissin failed: %d\n", ret);
+		goto fail_free_rqd;
+	}
+
+	return NVM_IO_OK;
+
+fail_free_rqd:
+	pblk_free_rqd(pblk, rqd, PBLK_READ);
+	pblk_bio_free_pages(pblk, bio, 0, bio->bi_vcnt);
+fail_free_bio:
+	bio_put(bio);
+
+	return NVM_IO_ERR;
+}
+
 static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
 				   void *chunk_meta)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
+	struct pblk_pad_rq *pad_rq;
 	int i, chk_per_lun, nr_bad_chks = 0;
 
+	pad_rq = kmalloc(sizeof(struct pblk_pad_rq), GFP_KERNEL);
+	if (!pad_rq)
+		return -1;
+
+	pad_rq->pblk = pblk;
+	init_completion(&pad_rq->wait);
+	kref_init(&pad_rq->ref);
+
 	chk_per_lun = geo->num_chk * geo->pln_mode;
 
 	for (i = 0; i < lm->blk_per_line; i++) {
 		struct pblk_lun *rlun = &pblk->luns[i];
 		struct nvm_chk_meta *chunk;
-		int pos = pblk_ppa_to_pos(geo, rlun->bppa);
+		struct ppa_addr ppa = rlun->bppa;
+		int pos = pblk_ppa_to_pos(geo, ppa);
 		u8 *lun_bb_meta = chunk_meta + pos * chk_per_lun;
 
 		chunk = &line->chks[pos];
 
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
 		chunk->type = NVM_CHK_TP_W_SEQ;
 		chunk->wi = 0;
 		chunk->slba = -1;
 		chunk->cnlb = geo->clba;
 		chunk->wp = 0;
 
-		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
+		if (lun_bb_meta[line->id] != NVM_BLK_T_FREE) {
+			chunk->state = NVM_CHK_ST_OFFLINE;
+			set_bit(pos, line->blk_bitmap);
+			nr_bad_chks++;
+
 			continue;
+		}
 
-		set_bit(pos, line->blk_bitmap);
-		nr_bad_chks++;
+		/*
+		 * In 1.2 spec. chunk state is not persisted by the device.
+		 * Recover the state based on media response.
+		 */
+		ppa.g.blk = line->id;
+		pblk_check_chunk_state(pblk, chunk, ppa, pad_rq);
 	}
 
+	kref_put(&pad_rq->ref, pblk_state_complete);
+
+	if (!wait_for_completion_io_timeout(&pad_rq->wait,
+				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
+		pr_err("pblk: state recovery timed out\n");
+		return -1;
+	}
+
+	kfree(pad_rq);
 	return nr_bad_chks;
 }
 
@@ -1036,6 +1127,23 @@ static int pblk_line_meta_init(struct pblk *pblk)
 	return 0;
 }
 
+static void check_meta(struct pblk *pblk, struct pblk_line *line)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_meta *lm = &pblk->lm;
+	int i;
+
+	for (i = 0; i < lm->blk_per_line; i++) {
+		struct pblk_lun *rlun = &pblk->luns[i];
+		struct nvm_chk_meta *chunk;
+		struct ppa_addr ppa = rlun->bppa;
+		int pos = pblk_ppa_to_pos(geo, ppa);
+
+		chunk = &line->chks[pos];
+	}
+}
+
 static int pblk_lines_init(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -1077,6 +1185,8 @@ static int pblk_lines_init(struct pblk *pblk)
 			goto fail_free_lines;
 
 		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
+
+		check_meta(pblk, line);
 	}
 
 	if (!nr_free_chks) {
-- 
2.7.4
