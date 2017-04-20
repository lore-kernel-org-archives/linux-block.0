Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:53597 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945750AbdDTSX7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 14:23:59 -0400
Date: Thu, 20 Apr 2017 21:23:56 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias Bjorling <mb@lightnvm.io>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH] lightnvm: propagate pblk_init return to userspace
Message-ID: <20170420182356.GA7866@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From userspace calling ioctl(NVM_DEV_CREATE) was returning ENOMEM for
invalid arguments even though pblk (pblk_init) was returning correctly
-EINVAL to nvm_create_tgt inside core.  This patch propagates the
correct return value to userspace.

Because pblk was introduced recently this only needs to go in 4.12.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/core.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5d7aa45..54a06c3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -235,6 +235,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	struct nvm_target *t;
 	struct nvm_tgt_dev *tgt_dev;
 	void *targetdata;
+	int ret;
 
 	tt = nvm_find_target_type(create->tgttype, 1);
 	if (!tt) {
@@ -255,22 +256,29 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		return -ENOMEM;
 
 	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
-	if (!t)
+	if (!t) {
+		ret = -ENOMEM;
 		goto err_reserve;
+	}
 
 	tgt_dev = nvm_create_tgt_dev(dev, s->lun_begin, s->lun_end);
 	if (!tgt_dev) {
 		pr_err("nvm: could not create target device\n");
+		ret = -ENOMEM;
 		goto err_t;
 	}
 
 	tdisk = alloc_disk(0);
-	if (!tdisk)
+	if (!tdisk) {
+		ret = -ENOMEM;
 		goto err_dev;
+	}
 
 	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
-	if (!tqueue)
+	if (!tqueue) {
+		ret = -ENOMEM;
 		goto err_disk;
+	}
 	blk_queue_make_request(tqueue, tt->make_rq);
 
 	strlcpy(tdisk->disk_name, create->tgtname, sizeof(tdisk->disk_name));
@@ -281,8 +289,10 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->queue = tqueue;
 
 	targetdata = tt->init(tgt_dev, tdisk, create->flags);
-	if (IS_ERR(targetdata))
+	if (IS_ERR(targetdata)) {
+		ret = PTR_ERR(targetdata);
 		goto err_init;
+	}
 
 	tdisk->private_data = targetdata;
 	tqueue->queuedata = targetdata;
@@ -292,8 +302,10 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	set_capacity(tdisk, tt->capacity(targetdata));
 	add_disk(tdisk);
 
-	if (tt->sysfs_init && tt->sysfs_init(tdisk))
+	if (tt->sysfs_init && tt->sysfs_init(tdisk)) {
+		ret = -ENOMEM;
 		goto err_sysfs;
+	}
 
 	t->type = tt;
 	t->disk = tdisk;
@@ -318,7 +330,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	kfree(t);
 err_reserve:
 	nvm_release_luns_err(dev, s->lun_begin, s->lun_end);
-	return -ENOMEM;
+	return ret;
 }
 
 static void __nvm_remove_target(struct nvm_target *t)
-- 
2.9.3
