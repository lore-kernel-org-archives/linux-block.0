Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:34462 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdBSOMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2017 09:12:14 -0500
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] lightnvm: Fix error handling
Date: Sun, 19 Feb 2017 15:09:28 +0100
Message-Id: <20170219140928.12968-1-christophe.jaillet@wanadoo.fr>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

According to error handling in this function, it is likely that going to
'out' was expected here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/lightnvm/rrpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index e00b1d7b976f..e68efbcf1188 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -1275,8 +1275,10 @@ static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
 	}
 
 	nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
-	if (nr_blks < 0)
-		return nr_blks;
+	if (nr_blks < 0) {
+		ret = nr_blks;
+		goto out;
+	}
 
 	for (i = 0; i < nr_blks; i++) {
 		if (blks[i] == NVM_BLK_T_FREE)
-- 
2.9.3
