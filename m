Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46908 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeDPQqu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 12:46:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id j68-v6so23077319lfg.13
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 09:46:49 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: pblk: only try to recover lines with written smeta
Date: Mon, 16 Apr 2018 18:46:15 +0200
Message-Id: <1523897176-6241-2-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1523897176-6241-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1523897176-6241-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When switching between different lun configurations, there is no
guarantee that all lines that contain closed/open chunks have some
valid data to recover.

Check that the smeta chunk has been written to instead. Also
skip bad lines (that does not have enough good chunks).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3e079c2..9cb6d5d 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -865,18 +865,30 @@ static void pblk_recov_wa_counters(struct pblk *pblk,
 }
 
 static int pblk_line_was_written(struct pblk_line *line,
-			    struct pblk_line_meta *lm)
+			    struct pblk *pblk)
 {
 
-	int i;
-	int state_mask = NVM_CHK_ST_OFFLINE | NVM_CHK_ST_FREE;
+	struct pblk_line_meta *lm = &pblk->lm;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct nvm_chk_meta *chunk;
+	struct ppa_addr bppa;
+	int smeta_blk;
 
-	for (i = 0; i < lm->blk_per_line; i++) {
-		if (!(line->chks[i].state & state_mask))
-			return 1;
-	}
+	if (line->state == PBLK_LINESTATE_BAD)
+		return 0;
 
-	return 0;
+	smeta_blk = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
+	if (smeta_blk >= lm->blk_per_line)
+		return 0;
+
+	bppa = pblk->luns[smeta_blk].bppa;
+	chunk = &line->chks[pblk_ppa_to_pos(geo, bppa)];
+
+	if (chunk->state & NVM_CHK_ST_FREE)
+		return 0;
+
+	return 1;
 }
 
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
@@ -915,7 +927,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		line->lun_bitmap = ((void *)(smeta_buf)) +
 						sizeof(struct line_smeta);
 
-		if (!pblk_line_was_written(line, lm))
+		if (!pblk_line_was_written(line, pblk))
 			continue;
 
 		/* Lines that cannot be read are assumed as not written here */
-- 
2.7.4
