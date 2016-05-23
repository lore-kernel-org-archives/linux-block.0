Return-Path: <linux-block-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:34774 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbcEWJLE (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 23 May 2016 05:11:04 -0400
From: Wenwei Tao <wwtao0320@163.com>
To: mb@lightnvm.io
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	ww.tao0320@gmail.com
Subject: [RFC PATCH 2/2] lightnvm: Append device name to target name
Date: Mon, 23 May 2016 17:13:34 +0800
Message-Id: <1463994814-3388-2-git-send-email-wwtao0320@163.com>
In-Reply-To: <1463994814-3388-1-git-send-email-wwtao0320@163.com>
References: <1463994814-3388-1-git-send-email-wwtao0320@163.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Wenwei Tao <ww.tao0320@gmail.com>

We may create targets with same name on different
backend devices, this is not what we want, so append
the device name to target name to make the new target
name unique in the system.

Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
---
 drivers/lightnvm/gennvm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 39ff0af..ecb09cb 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -43,9 +43,18 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	struct gendisk *tdisk;
 	struct nvm_tgt_type *tt;
 	struct nvm_target *t;
+	char tgtname[DISK_NAME_LEN];
 	void *targetdata;
 	int ret = -ENOMEM;
 
+	if (strlen(dev->name) + strlen(create->tgtname) + 1 > DISK_NAME_LEN) {
+		pr_err("nvm: target name too long. %s:%s\n",
+				dev->name, create->tgtname);
+		return -EINVAL;
+	}
+
+	sprintf(tgtname, "%s%s", dev->name, create->tgtname);
+
 	tt = nvm_find_target_type(create->tgttype, 1);
 	if (!tt) {
 		pr_err("nvm: target type %s not found\n", create->tgttype);
@@ -53,7 +62,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	}
 
 	mutex_lock(&gn->lock);
-	t = gen_find_target(gn, create->tgtname);
+	t = gen_find_target(gn, tgtname);
 	if (t) {
 		pr_err("nvm: target name already exists.\n");
 		ret = -EINVAL;
@@ -73,7 +82,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	if (!tdisk)
 		goto err_queue;
 
-	sprintf(tdisk->disk_name, "%s", create->tgtname);
+	sprintf(tdisk->disk_name, "%s", tgtname);
 	tdisk->flags = GENHD_FL_EXT_DEVT;
 	tdisk->major = 0;
 	tdisk->first_minor = 0;
-- 
1.8.3.1


