Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:50864 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754313AbcIOPxg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 11:53:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Arnd Bergmann <arnd@arndb.de>,
        "Simon A. F. Lund" <slund@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: propagate device_add() error code
Date: Thu, 15 Sep 2016 17:53:12 +0200
Message-Id: <20160915155325.3009409-1-arnd@arndb.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

device_add() may fail, and all callers are supposed to check the
return value, but one new user in lightnvm doesn't:

drivers/lightnvm/sysfs.c: In function 'nvm_sysfs_register_dev':
drivers/lightnvm/sysfs.c:184:2: error: ignoring return value of 'device_add', declared with attribute warn_unused_result [-Werror=unused-result]

This changes the caller to propagate any error codes, which avoids
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 38c9e260b9f9 ("lightnvm: expose device geometry through sysfs")
---
 drivers/lightnvm/lightnvm.h | 2 +-
 drivers/lightnvm/sysfs.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/lightnvm.h b/drivers/lightnvm/lightnvm.h
index 93f1aacc9f02..305c181509a6 100644
--- a/drivers/lightnvm/lightnvm.h
+++ b/drivers/lightnvm/lightnvm.h
@@ -24,7 +24,7 @@
 #include <linux/lightnvm.h>
 
 /* core -> sysfs.c */
-int nvm_sysfs_register_dev(struct nvm_dev *);
+int __must_check nvm_sysfs_register_dev(struct nvm_dev *);
 void nvm_sysfs_unregister_dev(struct nvm_dev *);
 int nvm_sysfs_register(void);
 void nvm_sysfs_unregister(void);
diff --git a/drivers/lightnvm/sysfs.c b/drivers/lightnvm/sysfs.c
index 72ad089c0269..0338c27ab95a 100644
--- a/drivers/lightnvm/sysfs.c
+++ b/drivers/lightnvm/sysfs.c
@@ -174,6 +174,8 @@ static struct device_type nvm_type = {
 
 int nvm_sysfs_register_dev(struct nvm_dev *dev)
 {
+	int ret;
+
 	if (!dev->parent_dev)
 		return 0;
 
@@ -181,11 +183,12 @@ int nvm_sysfs_register_dev(struct nvm_dev *dev)
 	dev_set_name(&dev->dev, "%s", dev->name);
 	dev->dev.type = &nvm_type;
 	device_initialize(&dev->dev);
-	device_add(&dev->dev);
+	ret = device_add(&dev->dev);
 
-	blk_mq_register_dev(&dev->dev, dev->q);
+	if (!ret)
+		blk_mq_register_dev(&dev->dev, dev->q);
 
-	return 0;
+	return ret;
 }
 
 void nvm_sysfs_unregister_dev(struct nvm_dev *dev)
-- 
2.9.0

