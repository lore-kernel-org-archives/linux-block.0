Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754147AbdDOS4Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:16 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 01/19] lightnvm: Fix error handling
Date: Sat, 15 Apr 2017 20:55:35 +0200
Message-ID: <20170415185553.16098-2-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

According to error handling in this function, it is likely that going to
'out' was expected here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/rrpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index e00b1d7..e68efbc 100644
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
