Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37560 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeAENQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:16:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so2413919wmd.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:16:48 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 09/25] lightnvm: guarantee target unique name across devs.
Date: Fri,  5 Jan 2018 14:16:05 +0100
Message-Id: <20180105131621.20808-10-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Until now, target unique naming is only guaranteed per device. This is
ok from a lightnvm perspective, but not from a sysfs one, since groups
will collide regardless of the underlying device.

Check that names are unique across all lightnvm-capable devices.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5c2d0f3..d5f231c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -56,6 +56,30 @@ static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
 	return NULL;
 }
 
+static bool nvm_target_exists(const char *name)
+{
+	struct nvm_dev *dev;
+	struct nvm_target *tgt;
+	bool ret = false;
+
+	down_write(&nvm_lock);
+	list_for_each_entry(dev, &nvm_devices, devices) {
+		mutex_lock(&dev->mlock);
+		list_for_each_entry(tgt, &dev->targets, list) {
+			if (!strcmp(name, tgt->disk->disk_name)) {
+				ret = true;
+				mutex_unlock(&dev->mlock);
+				goto out;
+			}
+		}
+		mutex_unlock(&dev->mlock);
+	}
+
+out:
+	up_write(&nvm_lock);
+	return ret;
+}
+
 static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
 {
 	int i;
@@ -259,14 +283,11 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
-	mutex_lock(&dev->mlock);
-	t = nvm_find_target(dev, create->tgtname);
-	if (t) {
-		pr_err("nvm: target name already exists.\n");
-		mutex_unlock(&dev->mlock);
+	if (nvm_target_exists(create->tgtname)) {
+		pr_err("nvm: target name already exists (%s)\n",
+							create->tgtname);
 		return -EINVAL;
 	}
-	mutex_unlock(&dev->mlock);
 
 	ret = nvm_reserve_luns(dev, s->lun_begin, s->lun_end);
 	if (ret)
-- 
2.9.3
