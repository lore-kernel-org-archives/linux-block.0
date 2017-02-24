Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33104 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdBXQOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 11:14:21 -0500
Received: by mail-wr0-f169.google.com with SMTP id u47so16183221wrb.0
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2017 08:14:21 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/3] lightnvm: free reverse device map
Date: Fri, 24 Feb 2017 17:14:06 +0100
Message-Id: <1487952846-29476-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1487952846-29476-1-git-send-email-javier@cnexlabs.com>
References: <1487952846-29476-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Free the reverse mapping table correctly on target tear down

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index ca48792..f1cb485 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -413,6 +413,18 @@ static int nvm_register_map(struct nvm_dev *dev)
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
@@ -994,7 +1006,7 @@ void nvm_free(struct nvm_dev *dev)
 	if (dev->dma_pool)
 		dev->ops->destroy_dma_pool(dev->dma_pool);
 
-	kfree(dev->rmap);
+	nvm_unregister_map(dev);
 	kfree(dev->lptbl);
 	kfree(dev->lun_map);
 	kfree(dev);
-- 
2.7.4
