Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36760 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755863AbdDGSbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2017 14:31:25 -0400
Received: by mail-wr0-f179.google.com with SMTP id c55so40942122wrc.3
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2017 11:31:24 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 4/4] lightnvm: allow to init targets on factory mode
Date: Fri,  7 Apr 2017 20:31:14 +0200
Message-Id: <1491589874-26818-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
References: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Target initialization has two responsibilities: creating the target
partition and instantiating the target. This patch enables to create a
factory partition (e.g., do not trigger recovery on the given target).
This is useful for target development and for being able to restore the
device state at any moment in time without requiring a full-device
erase.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c       | 14 +++++++++++---
 drivers/lightnvm/rrpc.c       |  3 ++-
 include/linux/lightnvm.h      |  3 ++-
 include/uapi/linux/lightnvm.h |  4 ++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 28e69a7..e4530c2 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -279,7 +279,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->fops = &nvm_fops;
 	tdisk->queue = tqueue;
 
-	targetdata = tt->init(tgt_dev, tdisk);
+	targetdata = tt->init(tgt_dev, tdisk, create->flags);
 	if (IS_ERR(targetdata))
 		goto err_init;
 
@@ -1243,8 +1243,16 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 	create.tgtname[DISK_NAME_LEN - 1] = '\0';
 
 	if (create.flags != 0) {
-		pr_err("nvm: no flags supported\n");
-		return -EINVAL;
+		__u32 flags = create.flags;
+
+		/* Check for valid flags */
+		if (flags & NVM_TARGET_FACTORY)
+			flags &= ~NVM_TARGET_FACTORY;
+
+		if (flags) {
+			pr_err("nvm: flag not supported\n");
+			return -EINVAL;
+		}
 	}
 
 	return __nvm_configure_create(&create);
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 4e4c299..2c04ff3 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -1515,7 +1515,8 @@ static int rrpc_luns_configure(struct rrpc *rrpc)
 
 static struct nvm_tgt_type tt_rrpc;
 
-static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk)
+static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
+		       int flags)
 {
 	struct request_queue *bqueue = dev->q;
 	struct request_queue *tqueue = tdisk->queue;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index bebea80..e88f7ef 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -436,7 +436,8 @@ static inline int ppa_cmp_blk(struct ppa_addr ppa1, struct ppa_addr ppa2)
 
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
-typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *);
+typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
+				int flags);
 typedef void (nvm_tgt_exit_fn)(void *);
 typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
 typedef void (nvm_tgt_sysfs_exit_fn)(struct gendisk *);
diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
index fd19f36..c8aec4b 100644
--- a/include/uapi/linux/lightnvm.h
+++ b/include/uapi/linux/lightnvm.h
@@ -85,6 +85,10 @@ struct nvm_ioctl_create_conf {
 	};
 };
 
+enum {
+	NVM_TARGET_FACTORY = 1 << 0,	/* Init target in factory mode */
+};
+
 struct nvm_ioctl_create {
 	char dev[DISK_NAME_LEN];		/* open-channel SSD device */
 	char tgttype[NVM_TTYPE_NAME_MAX];	/* target type name */
-- 
2.7.4
