Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37960 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeAENQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:16:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so2415603wme.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:16:47 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 08/25] lightnvm: refactor target type lookup
Date: Fri,  5 Jan 2018 14:16:04 +0100
Message-Id: <20180105131621.20808-9-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Refactor target type lookup to use/not use locks explicitly instead of
using a hidden parameter to make the function locking.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 6d6d2c1..5c2d0f3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -220,21 +220,25 @@ static const struct block_device_operations nvm_fops = {
 	.owner		= THIS_MODULE,
 };
 
-static struct nvm_tgt_type *nvm_find_target_type(const char *name, int lock)
+static struct nvm_tgt_type *__nvm_find_target_type(const char *name)
 {
-	struct nvm_tgt_type *tmp, *tt = NULL;
+	struct nvm_tgt_type *tt;
 
-	if (lock)
-		down_write(&nvm_tgtt_lock);
+	list_for_each_entry(tt, &nvm_tgt_types, list)
+		if (!strcmp(name, tt->name))
+			return tt;
 
-	list_for_each_entry(tmp, &nvm_tgt_types, list)
-		if (!strcmp(name, tmp->name)) {
-			tt = tmp;
-			break;
-		}
+	return NULL;
+}
+
+static struct nvm_tgt_type *nvm_find_target_type(const char *name)
+{
+	struct nvm_tgt_type *tt;
+
+	down_write(&nvm_tgtt_lock);
+	tt = __nvm_find_target_type(name);
+	up_write(&nvm_tgtt_lock);
 
-	if (lock)
-		up_write(&nvm_tgtt_lock);
 	return tt;
 }
 
@@ -249,7 +253,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	void *targetdata;
 	int ret;
 
-	tt = nvm_find_target_type(create->tgttype, 1);
+	tt = nvm_find_target_type(create->tgttype);
 	if (!tt) {
 		pr_err("nvm: target type %s not found\n", create->tgttype);
 		return -EINVAL;
@@ -523,7 +527,7 @@ int nvm_register_tgt_type(struct nvm_tgt_type *tt)
 	int ret = 0;
 
 	down_write(&nvm_tgtt_lock);
-	if (nvm_find_target_type(tt->name, 0))
+	if (__nvm_find_target_type(tt->name))
 		ret = -EEXIST;
 	else
 		list_add(&tt->list, &nvm_tgt_types);
-- 
2.9.3
