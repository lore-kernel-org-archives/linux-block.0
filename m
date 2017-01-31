Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:32224
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752003AbdAaMSu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:18:50 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 12/12] lightnvm: allow targets to use sysfs
Date: Tue, 31 Jan 2017 13:17:20 +0100
Message-ID: <20170131121720.10971-13-matias@cnexlabs.com>
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

In order to register through the sysfs interface, a driver needs to know
its kobject. On a disk structure, this happens when the partition
information is added (device_add_disk), which for lightnvm takes place
after the target has been initialized. This means that on target
initialization, the kboject has not been created yet.

This patch adds a target function to let targets initialize their own
kboject as a child of the disk kobject.

Signed-off-by: Javier González <javier@cnexlabs.com>
Added exit typedef and passed gendisk instead of void pointer for exit.
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 9 +++++++++
 include/linux/lightnvm.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index b2cd3d6..9bfe035 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -289,6 +289,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	set_capacity(tdisk, tt->capacity(targetdata));
 	add_disk(tdisk);
 
+	if (tt->sysfs_init && tt->sysfs_init(tdisk))
+		goto err_sysfs;
+
 	t->type = tt;
 	t->disk = tdisk;
 	t->dev = tgt_dev;
@@ -298,6 +301,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	mutex_unlock(&dev->mlock);
 
 	return 0;
+err_sysfs:
+	if (tt->exit)
+		tt->exit(targetdata);
 err_init:
 	put_disk(tdisk);
 err_queue:
@@ -320,6 +326,9 @@ static void __nvm_remove_target(struct nvm_target *t)
 	del_gendisk(tdisk);
 	blk_cleanup_queue(q);
 
+	if (tt->sysfs_exit)
+		tt->sysfs_exit(tdisk);
+
 	if (tt->exit)
 		tt->exit(tdisk->private_data);
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index bc282d2..ca45e4a 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -440,6 +440,8 @@ typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *);
 typedef void (nvm_tgt_exit_fn)(void *);
+typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
+typedef void (nvm_tgt_sysfs_exit_fn)(struct gendisk *);
 
 struct nvm_tgt_type {
 	const char *name;
@@ -453,6 +455,10 @@ struct nvm_tgt_type {
 	nvm_tgt_init_fn *init;
 	nvm_tgt_exit_fn *exit;
 
+	/* sysfs */
+	nvm_tgt_sysfs_init_fn *sysfs_init;
+	nvm_tgt_sysfs_exit_fn *sysfs_exit;
+
 	/* For internal use */
 	struct list_head list;
 };
-- 
2.9.3

