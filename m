Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54860 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbeBZNTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 08:19:17 -0500
Received: by mail-wm0-f68.google.com with SMTP id z81so17371730wmb.4
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 05:19:16 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove unused variable
Date: Mon, 26 Feb 2018 14:18:49 +0100
Message-Id: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove unused variable after a previous cleanup (a8112b631adb)

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ce6a7cfdba66..e6cb4317bb50 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	int nr_bb = 0;
 	u64 off;
 	int bit = -1;
 	int emeta_secs;
@@ -1087,8 +1086,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 		bitmap_or(line->map_bitmap, line->map_bitmap, l_mg->bb_aux,
 							lm->sec_per_line);
 		line->sec_in_line -= geo->c.clba;
-		if (bit >= lm->emeta_bb)
-			nr_bb++;
 	}
 
 	/* Mark smeta metadata sectors as bad sectors */
-- 
2.7.4
