Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39023 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJISbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so652537pgv.6
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:45 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 27/45] lightnvm: pblk: calculate line pad distance in helper
Date: Tue,  9 Oct 2018 13:11:57 +0200
Message-Id: <20181009111215.7653-28-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

If a line is padded, calculate the pad distance directly on the helper
being used for this purpose.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 13 ++++++++++---
 drivers/lightnvm/pblk.h          |  8 --------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0322ab915ddc..8036c3eb6372 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -380,6 +380,15 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	return ret;
 }
 
+static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int distance = geo->mw_cunits * geo->all_luns * geo->ws_opt;
+
+	return (distance > line->left_msecs) ? line->left_msecs : distance;
+}
+
 /* When this function is called, it means that not all upper pages have been
  * written in a page that contains valid data. In order to recover this data, we
  * first find the write pointer on the device, then we pad all necessary
@@ -495,9 +504,7 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 		line->left_msecs += nr_error_bits;
 		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
 
-		pad_secs = pblk_pad_distance(pblk);
-		if (pad_secs > line->left_msecs)
-			pad_secs = line->left_msecs;
+		pad_secs = pblk_pad_distance(pblk, line);
 
 		ret = pblk_recov_pad_oob(pblk, line, pad_secs);
 		if (ret)
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a2cc581951ef..d123cff82589 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -986,14 +986,6 @@ static inline int pblk_line_vsc(struct pblk_line *line)
 	return le32_to_cpu(*line->vsc);
 }
 
-static inline int pblk_pad_distance(struct pblk *pblk)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-
-	return geo->mw_cunits * geo->all_luns * geo->ws_opt;
-}
-
 static inline int pblk_ppa_to_line_id(struct ppa_addr p)
 {
 	return p.a.blk;
-- 
2.17.1
