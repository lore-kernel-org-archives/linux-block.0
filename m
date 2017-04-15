Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755369AbdDOS4h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:37 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 11/19] lightnvm: allow to init targets on factory mode
Date: Sat, 15 Apr 2017 20:55:45 +0200
Message-ID: <20170415185553.16098-12-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Target initialization has two responsibilities: creating the target
partition and instantiating the target. This patch enables to create a
factory partition (e.g., do not trigger recovery on the given target).
This is useful for target development and for being able to restore the
device state at any moment in time without requiring a full-device
erase.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c       | 14 +++++++++++---
 drivers/lightnvm/rrpc.c       |  3 ++-
 include/linux/lightnvm.h      |  3 ++-
 include/uapi/linux/lightnvm.h |  4 ++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5f84d2a..a63b563 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -280,7 +280,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->fops = &nvm_fops;
 	tdisk->queue = tqueue;
 
-	targetdata = tt->init(tgt_dev, tdisk);
+	targetdata = tt->init(tgt_dev, tdisk, create->flags);
 	if (IS_ERR(targetdata))
 		goto err_init;
 
@@ -1244,8 +1244,16 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
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
index a8acf9e..5dba544 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -1506,7 +1506,8 @@ static int rrpc_luns_configure(struct rrpc *rrpc)
 
 static struct nvm_tgt_type tt_rrpc;
 
-static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk)
+static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
+		       int flags)
 {
 	struct request_queue *bqueue = dev->q;
 	struct request_queue *tqueue = tdisk->queue;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index eff7d1f..7dfa56e 100644
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
2.9.3
