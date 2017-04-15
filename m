Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754787AbdDOS4Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:24 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 05/19] lightnvm: free reverse device map
Date: Sat, 15 Apr 2017 20:55:39 +0200
Message-ID: <20170415185553.16098-6-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Free the reverse mapping table correctly on target tear down

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 95105c4..a14c52c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -411,6 +411,18 @@ static int nvm_register_map(struct nvm_dev *dev)
 	return -ENOMEM;
 }
 
+static void nvm_unregister_map(struct nvm_dev *dev)
+{
+	struct nvm_dev_map *rmap = dev->rmap;
+	int i;
+
+	for (i = 0; i < dev->geo.nr_chnls; i++)
+		kfree(rmap->chnls[i].lun_offs);
+
+	kfree(rmap->chnls);
+	kfree(rmap);
+}
+
 static void nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 {
 	struct nvm_dev_map *dev_map = tgt_dev->map;
@@ -992,7 +1004,7 @@ void nvm_free(struct nvm_dev *dev)
 	if (dev->dma_pool)
 		dev->ops->destroy_dma_pool(dev->dma_pool);
 
-	kfree(dev->rmap);
+	nvm_unregister_map(dev);
 	kfree(dev->lptbl);
 	kfree(dev->lun_map);
 	kfree(dev);
-- 
2.9.3
