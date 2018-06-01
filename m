Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44897 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeFAOoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 10:44:05 -0400
Received: by mail-lf0-f67.google.com with SMTP id 36-v6so13260924lfr.11
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 07:44:04 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 08/10] lightnvm: pblk: only try to recover lines with written smeta
Date: Fri,  1 Jun 2018 16:41:12 +0200
Message-Id: <20180601144114.17490-9-mb@lightnvm.io>
In-Reply-To: <20180601144114.17490-1-mb@lightnvm.io>
References: <20180601144114.17490-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When switching between different lun configurations, there is no
guarantee that all lines that contain closed/open chunks have some
valid data to recover.

Check that the smeta chunk has been written to instead. Also
skip bad lines (that does not have enough good chunks).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 788dce87043e..598342833d0d 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -774,18 +774,30 @@ static void pblk_recov_wa_counters(struct pblk *pblk,
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
@@ -824,7 +836,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		line->lun_bitmap = ((void *)(smeta_buf)) +
 						sizeof(struct line_smeta);
 
-		if (!pblk_line_was_written(line, lm))
+		if (!pblk_line_was_written(line, pblk))
 			continue;
 
 		/* Lines that cannot be read are assumed as not written here */
-- 
2.11.0
