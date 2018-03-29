Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42637 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeC2WHT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id a22-v6so10327830lfg.9
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:18 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 19/37] lightnvm: fix bad block initialization
Date: Fri, 30 Mar 2018 00:05:06 +0200
Message-Id: <20180329220524.30363-20-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

fix reading bad block device information to correctly setup the per line
blk_bitmap during lightnvm initialization

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 43b835678f48..ee936c1ff764 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -460,10 +460,11 @@ static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
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
2.11.0
