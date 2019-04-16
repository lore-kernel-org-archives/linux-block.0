Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF10C10F14
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455D8206BA
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfDPKTn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:19:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:15522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfDPKTn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 06:19:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 03:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="337927071"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2019 03:19:41 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v4 6/7] lightnvm: track inflight target creations
Date:   Tue, 16 Apr 2019 12:16:47 +0200
Message-Id: <20190416101648.10045-7-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190416101648.10045-1-igor.j.konopko@intel.com>
References: <20190416101648.10045-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When creation process is still in progress, target is not yet on
targets list. This causes a chance for removing whole lightnvm
subsystem by calling nvm_unregister() in the meantime and finally by
causing kernel panic inside target init function.

This patch changes the behaviour by adding kref variable which tracks
all the users of nvm_dev structure. When nvm_dev is allocated, kref
value is set to 1. Then before every target creation the value is
increased and decreased after target removal. The extra reference
is decreased when nvm subsystem is unregistered.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/core.c  | 41 +++++++++++++++++++++++++++++++----------
 include/linux/lightnvm.h |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index e2abe88..0e9f7996 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -45,6 +45,8 @@ struct nvm_dev_map {
 	int num_ch;
 };
 
+static void nvm_free(struct kref *ref);
+
 static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
 {
 	struct nvm_target *tgt;
@@ -501,6 +503,7 @@ static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 	}
 	__nvm_remove_target(t, true);
 	mutex_unlock(&dev->mlock);
+	kref_put(&dev->ref, nvm_free);
 
 	return 0;
 }
@@ -1094,15 +1097,16 @@ static int nvm_core_init(struct nvm_dev *dev)
 	return ret;
 }
 
-static void nvm_free(struct nvm_dev *dev)
+static void nvm_free(struct kref *ref)
 {
-	if (!dev)
-		return;
+	struct nvm_dev *dev = container_of(ref, struct nvm_dev, ref);
 
 	if (dev->dma_pool)
 		dev->ops->destroy_dma_pool(dev->dma_pool);
 
-	nvm_unregister_map(dev);
+	if (dev->rmap)
+		nvm_unregister_map(dev);
+
 	kfree(dev->lun_map);
 	kfree(dev);
 }
@@ -1139,7 +1143,13 @@ static int nvm_init(struct nvm_dev *dev)
 
 struct nvm_dev *nvm_alloc_dev(int node)
 {
-	return kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
+	struct nvm_dev *dev;
+
+	dev = kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
+	if (dev)
+		kref_init(&dev->ref);
+
+	return dev;
 }
 EXPORT_SYMBOL(nvm_alloc_dev);
 
@@ -1147,12 +1157,16 @@ int nvm_register(struct nvm_dev *dev)
 {
 	int ret, exp_pool_size;
 
-	if (!dev->q || !dev->ops)
+	if (!dev->q || !dev->ops) {
+		kref_put(&dev->ref, nvm_free);
 		return -EINVAL;
+	}
 
 	ret = nvm_init(dev);
-	if (ret)
+	if (ret) {
+		kref_put(&dev->ref, nvm_free);
 		return ret;
+	}
 
 	exp_pool_size = max_t(int, PAGE_SIZE,
 			      (NVM_MAX_VLBA * (sizeof(u64) + dev->geo.sos)));
@@ -1162,7 +1176,7 @@ int nvm_register(struct nvm_dev *dev)
 						  exp_pool_size);
 	if (!dev->dma_pool) {
 		pr_err("nvm: could not create dma pool\n");
-		nvm_free(dev);
+		kref_put(&dev->ref, nvm_free);
 		return -ENOMEM;
 	}
 
@@ -1184,6 +1198,7 @@ void nvm_unregister(struct nvm_dev *dev)
 		if (t->dev->parent != dev)
 			continue;
 		__nvm_remove_target(t, false);
+		kref_put(&dev->ref, nvm_free);
 	}
 	mutex_unlock(&dev->mlock);
 
@@ -1191,13 +1206,14 @@ void nvm_unregister(struct nvm_dev *dev)
 	list_del(&dev->devices);
 	up_write(&nvm_lock);
 
-	nvm_free(dev);
+	kref_put(&dev->ref, nvm_free);
 }
 EXPORT_SYMBOL(nvm_unregister);
 
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
+	int ret;
 
 	down_write(&nvm_lock);
 	dev = nvm_find_nvm_dev(create->dev);
@@ -1208,7 +1224,12 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
-	return nvm_create_tgt(dev, create);
+	kref_get(&dev->ref);
+	ret = nvm_create_tgt(dev, create);
+	if (ret)
+		kref_put(&dev->ref, nvm_free);
+
+	return ret;
 }
 
 static long nvm_ioctl_info(struct file *file, void __user *arg)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d3b0270..4d0d565 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -428,6 +428,7 @@ struct nvm_dev {
 	char name[DISK_NAME_LEN];
 	void *private_data;
 
+	struct kref ref;
 	void *rmap;
 
 	struct mutex mlock;
-- 
2.9.5

