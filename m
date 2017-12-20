Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42257 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755944AbdLTRWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id b199so11380535wme.1
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:22 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 08/25] lightnvm: refactor target type lookup
Date: Wed, 20 Dec 2017 18:21:48 +0100
Message-Id: <20171220172205.26464-9-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
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
