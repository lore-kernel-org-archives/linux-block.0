Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45165 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932068AbdJMMry (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id q124so21263457wmb.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:54 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 49/58] lightnvm: pblk: consider bad sectors in emeta during recovery
Date: Fri, 13 Oct 2017 14:46:38 +0200
Message-Id: <20171013124647.32668-50-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When recovering lines we need to consider that bad blocks in a line
affect the emeta area size.

Previously it was assumed that the emeta area would grow by the
number of sectors per page * number of bad blocks in the line.

This assumption is not correct - the number of "extra" pages that are
consumed could be both smaller (depending on emeta size) and bigger
(depending on the placement of the bad blocks).

Fix this by calculating the emeta start by iterating backwards
through the line, skipping ppas that map to bad blocks.

Also fix the data types used for ppa indices/counts in
pblk_recov_l2p_from_emeta - we should use u64.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-recovery.c | 46 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index a080cf8..9772a94 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -133,16 +133,16 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_emeta *emeta = line->emeta;
 	struct line_emeta *emeta_buf = emeta->buf;
 	__le64 *lba_list;
-	int data_start, data_end;
-	int nr_valid_lbas, nr_lbas = 0;
-	int i;
+	u64 data_start, data_end;
+	u64 nr_valid_lbas, nr_lbas = 0;
+	u64 i;
 
 	lba_list = pblk_recov_get_lba_list(pblk, emeta_buf);
 	if (!lba_list)
 		return 1;
 
 	data_start = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
-	data_end = lm->sec_per_line - lm->emeta_sec[0];
+	data_end = line->emeta_ssec;
 	nr_valid_lbas = le64_to_cpu(emeta_buf->nr_valid_lbas);
 
 	for (i = data_start; i < data_end; i++) {
@@ -172,8 +172,8 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 	}
 
 	if (nr_valid_lbas != nr_lbas)
-		pr_err("pblk: line %d - inconsistent lba list(%llu/%d)\n",
-				line->id, emeta_buf->nr_valid_lbas, nr_lbas);
+		pr_err("pblk: line %d - inconsistent lba list(%llu/%llu)\n",
+				line->id, nr_valid_lbas, nr_lbas);
 
 	line->left_msecs = 0;
 
@@ -827,10 +827,32 @@ static void pblk_recov_line_add_ordered(struct list_head *head,
 	__list_add(&line->list, t->list.prev, &t->list);
 }
 
+static u64 pblk_line_emeta_start(struct pblk *pblk, struct pblk_line *line)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_meta *lm = &pblk->lm;
+	unsigned int emeta_secs;
+	u64 emeta_start;
+	struct ppa_addr ppa;
+	int pos;
+
+	emeta_secs = lm->emeta_sec[0];
+	emeta_start = lm->sec_per_line;
+
+	while (emeta_secs) {
+		emeta_start--;
+		ppa = addr_to_pblk_ppa(pblk, emeta_start, line->id);
+		pos = pblk_ppa_to_pos(geo, ppa);
+		if (!test_bit(pos, line->blk_bitmap))
+			emeta_secs--;
+	}
+
+	return emeta_start;
+}
+
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *line, *tline, *data_line = NULL;
@@ -930,15 +952,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 	/* Verify closed blocks and recover this portion of L2P table*/
 	list_for_each_entry_safe(line, tline, &recov_list, list) {
-		int off, nr_bb;
-
 		recovered_lines++;
-		/* Calculate where emeta starts based on the line bb */
-		off = lm->sec_per_line - lm->emeta_sec[0];
-		nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
-		off -= nr_bb * geo->sec_per_pl;
 
-		line->emeta_ssec = off;
+		line->emeta_ssec = pblk_line_emeta_start(pblk, line);
 		line->emeta = emeta;
 		memset(line->emeta->buf, 0, lm->emeta_len[0]);
 
-- 
2.9.3
