Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46366 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbeBVILP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 03:11:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id m1so1728140pgp.13
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2018 00:11:15 -0800 (PST)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org
Cc: Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH] lightnvm: fix bad block initialization
Date: Thu, 22 Feb 2018 00:10:59 -0800
Message-Id: <20180222081059.23002-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

fix reading bad block device information to correctly setup the per line blk_bitmap during lightnvm initialization 

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 86a94a7faa96..e0eba150ac7e 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -461,10 +461,11 @@ static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	int i, bb_cnt = 0;
+	int blk_per_lun = geo->nr_chks * geo->plane_mode;
 
 	for (i = 0; i < blk_per_line; i++) {
 		struct pblk_lun *rlun = &pblk->luns[i];
-		u8 *lun_bb_log = bb_log + i * blk_per_line;
+		u8 *lun_bb_log = bb_log + i * blk_per_lun;
 
 		if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
 			continue;
-- 
2.14.1
