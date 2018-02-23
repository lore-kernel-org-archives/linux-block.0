Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42444 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeBWRlB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 12:41:01 -0500
Received: by mail-pf0-f196.google.com with SMTP id t15so3787812pfh.9
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2018 09:41:01 -0800 (PST)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org
Cc: javier@cnexlabs.com, matias@lightnvm.io,
        Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH] lightnvm: fix bad block initialization
Date: Fri, 23 Feb 2018 09:40:16 -0800
Message-Id: <20180223174016.6104-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

fix reading bad block device information to correctly setup the per line
blk_bitmap during lightnvm initialization

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
