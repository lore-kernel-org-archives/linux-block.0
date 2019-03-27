Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B48C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EB12087C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfC0MmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:42:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:33640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfC0MmG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 08:42:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 05:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="137680455"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2019 05:42:04 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v3 07/10] lightnvm: pblk: store multiple copies of smeta
Date:   Wed, 27 Mar 2019 13:38:58 +0100
Message-Id: <20190327123901.12323-8-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190327123901.12323-1-igor.j.konopko@intel.com>
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently there is only one copy of smeta stored per line in pblk. This
is risky, because in case of read error on such a chunk, we are losing
all the data from whole line, what leads to silent data corruption.

This patch changes this behaviour and allows to store more then one
copy of the smeta (specified by module parameter) in order to provide
higher reliability by storing mirrored copies of smeta struct and
providing possibility to failover to another copy of that struct in
case of read error. Such an approach ensures that copies of that
critical structures will be stored on different dies and thus predicted
UBER is multiple times higher

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/pblk-core.c     | 124 ++++++++++++++++++++++++++++++++-------
 drivers/lightnvm/pblk-init.c     |  23 ++++++--
 drivers/lightnvm/pblk-recovery.c |  14 +++--
 drivers/lightnvm/pblk-rl.c       |   3 +-
 drivers/lightnvm/pblk.h          |   1 +
 5 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 06ac3f0..9d9a9e2 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -720,13 +720,14 @@ u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line)
 	return bit * geo->ws_opt;
 }
 
-int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
+static int pblk_line_smeta_read_copy(struct pblk *pblk,
+				     struct pblk_line *line, u64 paddr)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct bio *bio;
 	struct nvm_rq rqd;
-	u64 paddr = pblk_line_smeta_start(pblk, line);
 	int i, ret;
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
@@ -749,8 +750,20 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	rqd.nr_ppas = lm->smeta_sec;
 	rqd.is_seq = 1;
 
-	for (i = 0; i < lm->smeta_sec; i++, paddr++)
-		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
+	for (i = 0; i < rqd.nr_ppas; i++, paddr++) {
+		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+		int pos = pblk_ppa_to_pos(geo, ppa);
+
+		while (test_bit(pos, line->blk_bitmap)) {
+			paddr += pblk->min_write_pgs;
+			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+			pos = pblk_ppa_to_pos(geo, ppa);
+		}
+
+		rqd.ppa_list[i] = ppa;
+		pblk_get_meta(pblk, rqd.meta_list, i)->lba =
+				  cpu_to_le64(ADDR_EMPTY);
+	}
 
 	ret = pblk_submit_io_sync(pblk, &rqd);
 	if (ret) {
@@ -771,16 +784,63 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	return ret;
 }
 
-static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
-				 u64 paddr)
+int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	int i, ret = 0;
+	u64 paddr = pblk_line_smeta_start(pblk, line);
+
+	for (i = 0; i < lm->smeta_copies; i++) {
+		ret = pblk_line_smeta_read_copy(pblk, line,
+						paddr + (i * lm->smeta_sec));
+		if (!ret) {
+			/*
+			 * Just one successfully read copy of smeta is
+			 * enough for us for recovery, don't need to
+			 * read another one.
+			 */
+			return ret;
+		}
+	}
+	return ret;
+}
+
+static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct bio *bio;
 	struct nvm_rq rqd;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
-	int i, ret;
+	u64 paddr = 0;
+	int smeta_wr_len = lm->smeta_len;
+	int smeta_wr_sec = lm->smeta_sec;
+	int i, ret, rq_writes;
+
+	/*
+	 * Check if we can write all the smeta copies with
+	 * a single write command.
+	 * If yes -> copy smeta sector into multiple copies
+	 * in buffer to write.
+	 * If no -> issue writes one by one using the same
+	 * buffer space.
+	 * Only if all the copies are written correctly
+	 * we are treating this line as valid for proper
+	 * UBER reliability.
+	 */
+	if (lm->smeta_sec * lm->smeta_copies > pblk->max_write_pgs) {
+		rq_writes = lm->smeta_copies;
+	} else {
+		rq_writes = 1;
+		for (i = 1; i < lm->smeta_copies; i++) {
+			memcpy(line->smeta + i * lm->smeta_len,
+			       line->smeta, lm->smeta_len);
+		}
+		smeta_wr_len *= lm->smeta_copies;
+		smeta_wr_sec *= lm->smeta_copies;
+	}
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
@@ -788,7 +848,8 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	if (ret)
 		return ret;
 
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
+next_rq:
+	bio = bio_map_kern(dev->q, line->smeta, smeta_wr_len, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto clear_rqd;
@@ -799,15 +860,23 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 
 	rqd.bio = bio;
 	rqd.opcode = NVM_OP_PWRITE;
-	rqd.nr_ppas = lm->smeta_sec;
+	rqd.nr_ppas = smeta_wr_sec;
 	rqd.is_seq = 1;
 
-	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
-		struct pblk_sec_meta *meta = pblk_get_meta(pblk,
-							   rqd.meta_list, i);
+	for (i = 0; i < rqd.nr_ppas; i++, paddr++) {
+		void *meta_list = rqd.meta_list;
+		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+		int pos = pblk_ppa_to_pos(geo, ppa);
 
-		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
-		meta->lba = lba_list[paddr] = addr_empty;
+		while (test_bit(pos, line->blk_bitmap)) {
+			paddr += pblk->min_write_pgs;
+			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+			pos = pblk_ppa_to_pos(geo, ppa);
+		}
+
+		rqd.ppa_list[i] = ppa;
+		pblk_get_meta(pblk, meta_list, i)->lba = addr_empty;
+		lba_list[paddr] = addr_empty;
 	}
 
 	ret = pblk_submit_io_sync_sem(pblk, &rqd);
@@ -822,8 +891,13 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	if (rqd.error) {
 		pblk_log_write_err(pblk, &rqd);
 		ret = -EIO;
+		goto clear_rqd;
 	}
 
+	rq_writes--;
+	if (rq_writes > 0)
+		goto next_rq;
+
 clear_rqd:
 	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
@@ -1020,7 +1094,7 @@ static void pblk_line_setup_metadata(struct pblk_line *line,
 	line->smeta = l_mg->sline_meta[meta_line];
 	line->emeta = l_mg->eline_meta[meta_line];
 
-	memset(line->smeta, 0, lm->smeta_len);
+	memset(line->smeta, 0, lm->smeta_len * lm->smeta_copies);
 	memset(line->emeta->buf, 0, lm->emeta_len[0]);
 
 	line->emeta->mem = 0;
@@ -1147,7 +1221,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	u64 off;
 	int bit = -1;
-	int emeta_secs;
+	int emeta_secs, smeta_secs;
 
 	line->sec_in_line = lm->sec_per_line;
 
@@ -1163,13 +1237,19 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	/* Mark smeta metadata sectors as bad sectors */
-	bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
-	off = bit * geo->ws_opt;
-	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
-	line->sec_in_line -= lm->smeta_sec;
-	line->cur_sec = off + lm->smeta_sec;
+	smeta_secs = lm->smeta_sec * lm->smeta_copies;
+	bit = -1;
+	while (smeta_secs) {
+		bit = find_next_zero_bit(line->blk_bitmap, lm->blk_per_line,
+					bit + 1);
+		off = bit * geo->ws_opt;
+		bitmap_set(line->map_bitmap, off, geo->ws_opt);
+		line->cur_sec = off + geo->ws_opt;
+		smeta_secs -= lm->smeta_sec;
+	}
+	line->sec_in_line -= (lm->smeta_sec * lm->smeta_copies);
 
-	if (init && pblk_line_smeta_write(pblk, line, off)) {
+	if (init && pblk_line_smeta_write(pblk, line)) {
 		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
 		return 0;
 	}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b351c7f..4f6d214 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -27,6 +27,11 @@ static unsigned int write_buffer_size;
 module_param(write_buffer_size, uint, 0644);
 MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
 
+static unsigned int smeta_copies = 1;
+
+module_param(smeta_copies, int, 0644);
+MODULE_PARM_DESC(smeta_copies, "number of smeta copies");
+
 struct pblk_global_caches {
 	struct kmem_cache	*ws;
 	struct kmem_cache	*rec;
@@ -864,7 +869,8 @@ static int pblk_line_mg_init(struct pblk *pblk)
 	 * emeta depends on the number of LUNs allocated to the pblk instance
 	 */
 	for (i = 0; i < PBLK_DATA_LINES; i++) {
-		l_mg->sline_meta[i] = kmalloc(lm->smeta_len, GFP_KERNEL);
+		l_mg->sline_meta[i] = kmalloc(lm->smeta_len
+						* lm->smeta_copies, GFP_KERNEL);
 		if (!l_mg->sline_meta[i])
 			goto fail_free_smeta;
 	}
@@ -964,6 +970,12 @@ static int pblk_line_meta_init(struct pblk *pblk)
 	lm->mid_thrs = lm->sec_per_line / 2;
 	lm->high_thrs = lm->sec_per_line / 4;
 	lm->meta_distance = (geo->all_luns / 2) * pblk->min_write_pgs;
+	lm->smeta_copies = smeta_copies;
+
+	if (lm->smeta_copies < 1 || lm->smeta_copies > geo->all_luns) {
+		pblk_err(pblk, "unsupported smeta copies parameter\n");
+		return -EINVAL;
+	}
 
 	/* Calculate necessary pages for smeta. See comment over struct
 	 * line_smeta definition
@@ -995,10 +1007,11 @@ static int pblk_line_meta_init(struct pblk *pblk)
 
 	lm->emeta_bb = geo->all_luns > i ? geo->all_luns - i : 0;
 
-	lm->min_blk_line = 1;
-	if (geo->all_luns > 1)
-		lm->min_blk_line += DIV_ROUND_UP(lm->smeta_sec +
-					lm->emeta_sec[0], geo->clba);
+	lm->min_blk_line = lm->smeta_copies;
+	if (geo->all_luns > lm->smeta_copies) {
+		lm->min_blk_line += DIV_ROUND_UP((lm->smeta_sec
+			* lm->smeta_copies) + lm->emeta_sec[0], geo->clba);
+	}
 
 	if (lm->min_blk_line > lm->blk_per_line) {
 		pblk_err(pblk, "config. not supported. Min. LUN in line:%d\n",
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index a9085b0..9a992af 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -51,7 +51,8 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 	if (!lba_list)
 		return 1;
 
-	data_start = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
+	data_start = pblk_line_smeta_start(pblk, line)
+					+ (lm->smeta_sec * lm->smeta_copies);
 	data_end = line->emeta_ssec;
 	nr_valid_lbas = le64_to_cpu(emeta_buf->nr_valid_lbas);
 
@@ -134,7 +135,8 @@ static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
 	if (lm->blk_per_line - nr_bb != valid_chunks)
 		pblk_err(pblk, "recovery line %d is bad\n", line->id);
 
-	pblk_update_line_wp(pblk, line, written_secs - lm->smeta_sec);
+	pblk_update_line_wp(pblk, line, written_secs -
+					(lm->smeta_sec * lm->smeta_copies));
 
 	return written_secs;
 }
@@ -377,12 +379,14 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	__le64 *lba_list;
-	u64 paddr = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
+	u64 paddr = pblk_line_smeta_start(pblk, line) +
+					(lm->smeta_sec * lm->smeta_copies);
 	bool padded = false;
 	int rq_ppas, rq_len;
 	int i, j;
 	int ret;
-	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
+	u64 left_ppas = pblk_sec_in_open_line(pblk, line) -
+					(lm->smeta_sec * lm->smeta_copies);
 
 	if (pblk_line_wps_are_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
@@ -706,7 +710,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 		line = &pblk->lines[i];
 
-		memset(smeta, 0, lm->smeta_len);
+		memset(smeta, 0, lm->smeta_len * lm->smeta_copies);
 		line->smeta = smeta;
 		line->lun_bitmap = ((void *)(smeta_buf)) +
 						sizeof(struct line_smeta);
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index b014957..944372c 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -218,7 +218,8 @@ void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
 	unsigned int rb_windows;
 
 	/* Consider sectors used for metadata */
-	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
+	sec_meta = ((lm->smeta_sec * lm->smeta_copies)
+			+ lm->emeta_sec[0]) * l_mg->nr_free_lines;
 	blk_meta = DIV_ROUND_UP(sec_meta, geo->clba);
 
 	rl->high = pblk->op_blks - blk_meta - lm->blk_per_line;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 3a84c8a..0999245 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -547,6 +547,7 @@ struct pblk_line_mgmt {
 struct pblk_line_meta {
 	unsigned int smeta_len;		/* Total length for smeta */
 	unsigned int smeta_sec;		/* Sectors needed for smeta */
+	unsigned int smeta_copies;	/* Number of smeta copies */
 
 	unsigned int emeta_len[4];	/* Lengths for emeta:
 					 *  [0]: Total
-- 
2.9.5

