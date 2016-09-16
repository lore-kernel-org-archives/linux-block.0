Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33343 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934931AbcIPMZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 08:25:43 -0400
Received: by mail-pa0-f68.google.com with SMTP id oz2so3431597pac.0
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2016 05:25:42 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
Cc: keith.busch@intel.com, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 7/7] lightnvm: propagate device_add() error code
Date: Fri, 16 Sep 2016 14:25:09 +0200
Message-Id: <1474028709-30260-8-git-send-email-m@bjorling.me>
In-Reply-To: <1474028709-30260-1-git-send-email-m@bjorling.me>
References: <1474028709-30260-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

device_add() may fail, and all callers are supposed to check the
return value, but one new user in lightnvm doesn't:

drivers/lightnvm/sysfs.c: In function 'nvm_sysfs_register_dev':
drivers/lightnvm/sysfs.c:184:2: error: ignoring return value of 'device_add',
  declared with attribute warn_unused_result [-Werror=unused-result]

This changes the caller to propagate any error codes, which avoids
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 38c9e260b9f9 ("lightnvm: expose device geometry through sysfs")
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/lightnvm.h | 2 +-
 drivers/lightnvm/sysfs.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/lightnvm.h b/drivers/lightnvm/lightnvm.h
index 93f1aac..305c181 100644
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
index 72ad089..0338c27 100644
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
2.1.4

