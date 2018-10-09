Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39999 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJIS3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:29:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so672137pfj.7
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:13:28 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 04/45] lightnvm: move device L2P detection to core
Date: Tue,  9 Oct 2018 13:11:34 +0200
Message-Id: <20181009111215.7653-5-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A 1.2 device is able to manage the logical to physical mapping
table internally or leave it to the host.

A target only supports one of those approaches, and therefore must
check on initialization. Move this check to core to avoid each target
implement the check.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 5 +++++
 drivers/lightnvm/pblk-init.c | 7 -------
 include/linux/lightnvm.h     | 6 ++++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 68553c7ae937..964352720a03 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -355,6 +355,11 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
+	if ((tt->flags & NVM_TGT_F_HOST_L2P) != (dev->geo.dom & NVM_RSP_L2P)) {
+		pr_err("nvm: device is incompatible with target L2P type.\n");
+		return -EINVAL;
+	}
+
 	if (nvm_target_exists(create->tgtname)) {
 		pr_err("nvm: target name already exists (%s)\n",
 							create->tgtname);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 537e98f2b24a..039f62d05e84 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1210,13 +1210,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
-		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
-							geo->dom);
-		kfree(pblk);
-		return ERR_PTR(-EINVAL);
-	}
-
 	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 8acc2fe277d6..f4a84694e5e2 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -495,9 +495,15 @@ typedef void (nvm_tgt_exit_fn)(void *, bool);
 typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
 typedef void (nvm_tgt_sysfs_exit_fn)(struct gendisk *);
 
+enum {
+	NVM_TGT_F_DEV_L2P = 0,
+	NVM_TGT_F_HOST_L2P = 1 << 0,
+};
+
 struct nvm_tgt_type {
 	const char *name;
 	unsigned int version[3];
+	int flags;
 
 	/* target entry points */
 	nvm_tgt_make_rq_fn *make_rq;
-- 
2.17.1
