Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754712AbdDOS4a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:30 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 08/19] lightnvm: double-clear of dev->lun_map on target init error
Date: Sat, 15 Apr 2017 20:55:42 +0200
Message-ID: <20170415185553.16098-9-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

The dev->lun_map bits are cleared twice if an target init error occurs.
First in the target clean routine, and then next in the nvm_tgt_create
error function. Make sure that it is only cleared once by extending
nvm_remove_tgt_devi() with a clear bit, such that clearing of bits can
ignored when cleaning up a successful initialized target.

Signed-off-by: Javier González <javier@cnexlabs.com>
Fix style.
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index a14c52c..5eea3d5 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -89,7 +89,7 @@ static void nvm_release_luns_err(struct nvm_dev *dev, int lun_begin,
 		WARN_ON(!test_and_clear_bit(i, dev->lun_map));
 }
 
-static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
+static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev, int clear)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 	struct nvm_dev_map *dev_map = tgt_dev->map;
@@ -100,11 +100,14 @@ static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
 		int *lun_offs = ch_map->lun_offs;
 		int ch = i + ch_map->ch_off;
 
-		for (j = 0; j < ch_map->nr_luns; j++) {
-			int lun = j + lun_offs[j];
-			int lunid = (ch * dev->geo.luns_per_chnl) + lun;
+		if (clear) {
+			for (j = 0; j < ch_map->nr_luns; j++) {
+				int lun = j + lun_offs[j];
+				int lunid = (ch * dev->geo.luns_per_chnl) + lun;
 
-			WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
+				WARN_ON(!test_and_clear_bit(lunid,
+							dev->lun_map));
+			}
 		}
 
 		kfree(ch_map->lun_offs);
@@ -309,7 +312,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 err_queue:
 	blk_cleanup_queue(tqueue);
 err_dev:
-	nvm_remove_tgt_dev(tgt_dev);
+	nvm_remove_tgt_dev(tgt_dev, 0);
 err_t:
 	kfree(t);
 err_reserve:
@@ -332,7 +335,7 @@ static void __nvm_remove_target(struct nvm_target *t)
 	if (tt->exit)
 		tt->exit(tdisk->private_data);
 
-	nvm_remove_tgt_dev(t->dev);
+	nvm_remove_tgt_dev(t->dev, 1);
 	put_disk(tdisk);
 
 	list_del(&t->list);
-- 
2.9.3
