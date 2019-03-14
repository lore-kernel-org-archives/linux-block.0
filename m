Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C04AC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5CA2184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfCNQIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:08:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:11564 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQIv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:08:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073225"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:08:49 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 13/18] lightnvm: pblk: store multiple copies of smeta
Date:   Thu, 14 Mar 2019 17:04:23 +0100
Message-Id: <20190314160428.3559-14-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently there is only one copy of emeta stored per line in pblk. This
is risky, because in case of read error on such a chunk, we are losing
all the data from whole line, what leads to silent data corruption.

This patch changes this behaviour and stores 2 copies of smeta (but
can be easily increased with kernel parameter to different value) in
order to provide higher reliability by storing mirrored copies of
smeta struct and providing possibility to failover to another copy of
that struct in case of read error. Such an approach ensures that copies
of that critical structures will be stored on different dies and thus
predicted UBER is multiple times higher

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     | 125 ++++++++++++++++++++++++++++++++-------
 drivers/lightnvm/pblk-init.c     |  23 +++++--
 drivers/lightnvm/pblk-recovery.c |   2 +-
 drivers/lightnvm/pblk.h          |   1 +
 4 files changed, 123 insertions(+), 28 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a683d1f..4d5cd99 100644
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
@@ -735,7 +736,8 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	if (ret)
 		return ret;
 
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
+	bio = bio_map_kern(dev->q, line->smeta,
+			   lm->smeta_len / lm->smeta_copies, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto clear_rqd;
@@ -746,11 +748,23 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 
 	rqd.bio = bio;
 	rqd.opcode = NVM_OP_PREAD;
-	rqd.nr_ppas = lm->smeta_sec;
+	rqd.nr_ppas = lm->smeta_sec / lm->smeta_copies;
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
@@ -771,16 +785,63 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	return ret;
 }
 
-static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
-				 u64 paddr)
+int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	int i, ret = 0, smeta_sec = lm->smeta_sec / lm->smeta_copies;
+	u64 paddr = pblk_line_smeta_start(pblk, line);
+
+	for (i = 0; i < lm->smeta_copies; i++) {
+		ret = pblk_line_smeta_read_copy(pblk, line,
+						paddr + (i * smeta_sec));
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
+	int smeta_cpy_len = lm->smeta_len / lm->smeta_copies;
+	int smeta_cpy_sec = lm->smeta_sec / lm->smeta_copies;
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
+	if (lm->smeta_sec > pblk->max_write_pgs) {
+		rq_writes = lm->smeta_copies;
+	} else {
+		rq_writes = 1;
+		for (i = 1; i < lm->smeta_copies; i++) {
+			memcpy(line->smeta + i * smeta_cpy_len,
+			       line->smeta, smeta_cpy_len);
+		}
+		smeta_cpy_len = lm->smeta_len;
+		smeta_cpy_sec = lm->smeta_sec;
+	}
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
@@ -788,7 +849,8 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	if (ret)
 		return ret;
 
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
+next_rq:
+	bio = bio_map_kern(dev->q, line->smeta, smeta_cpy_len, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto clear_rqd;
@@ -799,15 +861,23 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 
 	rqd.bio = bio;
 	rqd.opcode = NVM_OP_PWRITE;
-	rqd.nr_ppas = lm->smeta_sec;
+	rqd.nr_ppas = smeta_cpy_sec;
 	rqd.is_seq = 1;
 
-	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
-		struct pblk_sec_meta *meta = pblk_get_meta(pblk,
-							   rqd.meta_list, i);
+	for (i = 0; i < rqd.nr_ppas; i++, paddr++) {
+		void *meta_list = rqd.meta_list;
+		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+		int pos = pblk_ppa_to_pos(geo, ppa);
+
+		while (test_bit(pos, line->blk_bitmap)) {
+			paddr += pblk->min_write_pgs;
+			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+			pos = pblk_ppa_to_pos(geo, ppa);
+		}
 
-		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
-		meta->lba = lba_list[paddr] = addr_empty;
+		rqd.ppa_list[i] = ppa;
+		pblk_get_meta(pblk, meta_list, i)->lba = addr_empty;
+		lba_list[paddr] = addr_empty;
 	}
 
 	ret = pblk_submit_io_sync_sem(pblk, &rqd);
@@ -822,8 +892,13 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
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
@@ -1149,7 +1224,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	u64 off;
 	int bit = -1;
-	int emeta_secs;
+	int emeta_secs, smeta_secs;
 
 	line->sec_in_line = lm->sec_per_line;
 
@@ -1165,13 +1240,19 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	/* Mark smeta metadata sectors as bad sectors */
-	bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
-	off = bit * geo->ws_opt;
-	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
+	smeta_secs = lm->smeta_sec;
+	bit = -1;
+	while (smeta_secs) {
+		bit = find_next_zero_bit(line->blk_bitmap, lm->blk_per_line,
+					bit + 1);
+		off = bit * geo->ws_opt;
+		bitmap_set(line->map_bitmap, off, geo->ws_opt);
+		line->cur_sec = off + geo->ws_opt;
+		smeta_secs -= geo->ws_opt;
+	}
 	line->sec_in_line -= lm->smeta_sec;
-	line->cur_sec = off + lm->smeta_sec;
 
-	if (init && pblk_line_smeta_write(pblk, line, off)) {
+	if (init && pblk_line_smeta_write(pblk, line)) {
 		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
 		return 0;
 	}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b7845f6..e771df6 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -27,6 +27,11 @@ static unsigned int write_buffer_size;
 module_param(write_buffer_size, uint, 0644);
 MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
 
+static unsigned int smeta_copies = 2;
+
+module_param(smeta_copies, int, 0644);
+MODULE_PARM_DESC(smeta_copies, "number of smeta copies");
+
 struct pblk_global_caches {
 	struct kmem_cache	*ws;
 	struct kmem_cache	*rec;
@@ -977,18 +982,25 @@ static int pblk_line_meta_init(struct pblk *pblk)
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
 	 */
-	i = 1;
+	i = lm->smeta_copies;
 add_smeta_page:
-	lm->smeta_sec = i * geo->ws_opt;
+	lm->smeta_sec = lm->smeta_copies * geo->ws_opt;
 	lm->smeta_len = lm->smeta_sec * geo->csecs;
 
 	smeta_len = sizeof(struct line_smeta) + lm->lun_bitmap_len;
+	smeta_len *= lm->smeta_copies;
 	if (smeta_len > lm->smeta_len) {
-		i++;
+		i += lm->smeta_copies;
 		goto add_smeta_page;
 	}
 
@@ -1008,10 +1020,11 @@ static int pblk_line_meta_init(struct pblk *pblk)
 
 	lm->emeta_bb = geo->all_luns > i ? geo->all_luns - i : 0;
 
-	lm->min_blk_line = 1;
-	if (geo->all_luns > 1)
+	lm->min_blk_line = lm->smeta_copies;
+	if (geo->all_luns > lm->smeta_copies) {
 		lm->min_blk_line += DIV_ROUND_UP(lm->smeta_sec +
 					lm->emeta_sec[0], geo->clba);
+	}
 
 	if (lm->min_blk_line > lm->blk_per_line) {
 		pblk_err(pblk, "config. not supported. Min. LUN in line:%d\n",
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 2132260..4e4db38 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -672,7 +672,7 @@ static int pblk_line_was_written(struct pblk_line *line,
 
 	if (chunk->state & NVM_CHK_ST_CLOSED ||
 	    (chunk->state & NVM_CHK_ST_OPEN
-	     && chunk->wp >= lm->smeta_sec))
+	     && chunk->wp >= (lm->smeta_sec / lm->smeta_copies)))
 		return 1;
 
 	return 0;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a42bbfb..5d1040a 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -549,6 +549,7 @@ struct pblk_line_mgmt {
 struct pblk_line_meta {
 	unsigned int smeta_len;		/* Total length for smeta */
 	unsigned int smeta_sec;		/* Sectors needed for smeta */
+	unsigned int smeta_copies;	/* Number of smeta copies */
 
 	unsigned int emeta_len[4];	/* Lengths for emeta:
 					 *  [0]: Total
-- 
2.9.5

