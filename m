Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:22295 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757320AbdEMTum (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2017 15:50:42 -0400
Date: Sat, 13 May 2017 22:50:38 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: [PATCH] ligtnvm: if LUNs are already allocated fix return
Message-ID: <20170513195038.GA8782@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

While creating new device with NVM_DEV_CREATE if LUNs are already
allocated ioctl would return -ENOMEM which is wrong.  This patch
propagates -EBUSY from nvm_reserve_luns which is correct response.

Fixes: ade69e243 ("lightnvm: merge gennvm with core")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 6a4aa60..440deb5 100644
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
