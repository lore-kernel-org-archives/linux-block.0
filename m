Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36620 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbdF0IkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 04:40:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so4411159wmh.3
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2017 01:40:17 -0700 (PDT)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH] ligtnvm: if LUNs are already allocated fix return
Date: Tue, 27 Jun 2017 10:39:50 +0200
Message-Id: <20170627083950.11312-2-matias@cnexlabs.com>
In-Reply-To: <20170627083950.11312-1-matias@cnexlabs.com>
References: <20170627083950.11312-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

While creating new device with NVM_DEV_CREATE if LUNs are already
allocated ioctl would return -ENOMEM which is wrong.  This patch
propagates -EBUSY from nvm_reserve_luns which is correct response.

Fixes: ade69e243 ("lightnvm: merge gennvm with core")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index b8f82f5..9ff348f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -235,7 +235,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	struct nvm_target *t;
 	struct nvm_tgt_dev *tgt_dev;
 	void *targetdata;
-	int ret;
+	int ret = 0;
 
 	tt = nvm_find_target_type(create->tgttype, 1);
 	if (!tt) {
@@ -252,8 +252,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	}
 	mutex_unlock(&dev->mlock);
 
-	if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
-		return -ENOMEM;
+	ret = nvm_reserve_luns(dev, s->lun_begin, s->lun_end);
+	if (ret)
+		goto err;
 
 	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
 	if (!t) {
@@ -314,8 +315,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	mutex_lock(&dev->mlock);
 	list_add_tail(&t->list, &dev->targets);
 	mutex_unlock(&dev->mlock);
-
-	return 0;
+err:
+	return ret;
 err_sysfs:
 	if (tt->exit)
 		tt->exit(targetdata);
-- 
2.9.3
