Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:36725 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbeKFW66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 17:58:58 -0500
Received: by mail-it1-f193.google.com with SMTP id w7-v6so17603627itd.1
        for <linux-block@vger.kernel.org>; Tue, 06 Nov 2018 05:33:42 -0800 (PST)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 2/7] lightnvm: pblk: account for write error sectors in emeta
Date: Tue,  6 Nov 2018 14:33:25 +0100
Message-Id: <20181106133330.26570-3-hans.ml.holmberg@owltronix.com>
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Lines inflicted with write errors lines might be recovered
if they have not been recycled after write error garbage collection.

Ensure that the emeta accounting of valid lbas is correct
for such lines to avoid recovery inconsistencies.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3ddd16f47106..750f04b8a227 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -105,14 +105,20 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 }
 
 /* Map remaining sectors in chunk, starting from ppa */
-static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
+static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa,
+		int rqd_ppas)
 {
 	struct pblk_line *line;
 	struct ppa_addr map_ppa = *ppa;
+	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+	__le64 *lba_list;
 	u64 paddr;
 	int done = 0;
+	int n = 0;
 
 	line = pblk_ppa_to_line(pblk, *ppa);
+	lba_list = emeta_to_lbas(pblk, line->emeta->buf);
+
 	spin_lock(&line->lock);
 
 	while (!done)  {
@@ -121,10 +127,17 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 		if (!test_and_set_bit(paddr, line->map_bitmap))
 			line->left_msecs--;
 
+		if (n < rqd_ppas && lba_list[paddr] != addr_empty)
+			line->nr_valid_lbas--;
+
+		lba_list[paddr] = addr_empty;
+
 		if (!test_and_set_bit(paddr, line->invalid_bitmap))
 			le32_add_cpu(line->vsc, -1);
 
 		done = nvm_next_ppa_in_chk(pblk->dev, &map_ppa);
+
+		n++;
 	}
 
 	line->w_err_gc->has_write_err = 1;
@@ -202,7 +215,7 @@ static void pblk_submit_rec(struct work_struct *work)
 
 	pblk_log_write_err(pblk, rqd);
 
-	pblk_map_remaining(pblk, ppa_list);
+	pblk_map_remaining(pblk, ppa_list, rqd->nr_ppas);
 	pblk_queue_resubmit(pblk, c_ctx);
 
 	pblk_up_rq(pblk, c_ctx->lun_bitmap);
-- 
2.17.1
