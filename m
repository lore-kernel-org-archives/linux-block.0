Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32922 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755968AbdLTRW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:27 -0500
Received: by mail-wm0-f68.google.com with SMTP id g130so16680840wme.0
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:26 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 12/25] lightnvm: pblk: refactor emeta consistency check
Date: Wed, 20 Dec 2017 18:21:52 +0100
Message-Id: <20171220172205.26464-13-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Currently pblk_recov_get_lba list does two separate things:
it checks the consistency of the emeta and extracts the lba list.

This patch separates the consistency check to make the code easier
to read and to prepare for version checks of the line emeta
persistent data format version.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-gc.c       |  9 ++++++++-
 drivers/lightnvm/pblk-recovery.c | 15 ++++++++++-----
 drivers/lightnvm/pblk.h          |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 00d5698..9e3f22b 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -169,7 +169,14 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	 * the line untouched. TODO: Implement a recovery routine that scans and
 	 * moves all sectors on the line.
 	 */
-	lba_list = pblk_recov_get_lba_list(pblk, emeta_buf);
+
+	ret = pblk_recov_check_emeta(pblk, emeta_buf);
+	if (ret) {
+		pr_err("pblk: inconsistent emeta (line %d)\n", line->id);
+		goto fail_free_emeta;
+	}
+
+	lba_list = emeta_to_lbas(pblk, emeta_buf);
 	if (!lba_list) {
 		pr_err("pblk: could not interpret emeta (line %d)\n", line->id);
 		goto fail_free_emeta;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 1b272ae..39a2e19 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -111,18 +111,18 @@ int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
 	return 0;
 }
 
-__le64 *pblk_recov_get_lba_list(struct pblk *pblk, struct line_emeta *emeta_buf)
+int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta_buf)
 {
 	u32 crc;
 
 	crc = pblk_calc_emeta_crc(pblk, emeta_buf);
 	if (le32_to_cpu(emeta_buf->crc) != crc)
-		return NULL;
+		return 1;
 
 	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC)
-		return NULL;
+		return 1;
 
-	return emeta_to_lbas(pblk, emeta_buf);
+	return 0;
 }
 
 static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
@@ -137,7 +137,7 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 	u64 nr_valid_lbas, nr_lbas = 0;
 	u64 i;
 
-	lba_list = pblk_recov_get_lba_list(pblk, emeta_buf);
+	lba_list = emeta_to_lbas(pblk, emeta_buf);
 	if (!lba_list)
 		return 1;
 
@@ -938,6 +938,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			goto next;
 		}
 
+		if (pblk_recov_check_emeta(pblk, line->emeta->buf)) {
+			pblk_recov_l2p_from_oob(pblk, line);
+			goto next;
+		}
+
 		if (pblk_recov_l2p_from_emeta(pblk, line))
 			pblk_recov_l2p_from_oob(pblk, line);
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 7b09fb2..f324a7e 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -808,7 +808,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
 void pblk_submit_rec(struct work_struct *work);
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk);
 int pblk_recov_pad(struct pblk *pblk);
-__le64 *pblk_recov_get_lba_list(struct pblk *pblk, struct line_emeta *emeta);
+int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta);
 int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
 			struct pblk_rec_ctx *recovery, u64 *comp_bits,
 			unsigned int comp);
-- 
2.9.3
