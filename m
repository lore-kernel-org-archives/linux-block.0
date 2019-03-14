Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A9C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EF02186A
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfCNQJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:58120 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfCNQJh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073433"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:09:35 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 18/18] lightnvm: track inflight target creations
Date:   Thu, 14 Mar 2019 17:04:28 +0100
Message-Id: <20190314160428.3559-19-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a counter, which is responsible for tracking inflight
target creations.

When creation process is still in progress, target is not yet on
targets list. This causes a chance for removing whole lightnvm
subsystem by calling nvm_unregister() in the meantime and finally by
causing kernel panic inside target init function.

With this patch we are able to track such a scenarios and wait with
completing nvm_unregister() and freeing memory until target creation
will be completed.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/core.c  | 19 ++++++++++++++++++-
 include/linux/lightnvm.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 838c3d8..490ec6e 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1083,6 +1083,7 @@ static int nvm_core_init(struct nvm_dev *dev)
 	INIT_LIST_HEAD(&dev->targets);
 	mutex_init(&dev->mlock);
 	spin_lock_init(&dev->lock);
+	dev->create_inflight = 0;
 
 	ret = nvm_register_map(dev);
 	if (ret)
@@ -1180,6 +1181,11 @@ void nvm_unregister(struct nvm_dev *dev)
 	struct nvm_target *t, *tmp;
 
 	mutex_lock(&dev->mlock);
+	while (dev->create_inflight > 0) {
+		mutex_unlock(&dev->mlock);
+		io_schedule();
+		mutex_lock(&dev->mlock);
+	}
 	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
 		if (t->dev->parent != dev)
 			continue;
@@ -1213,6 +1219,7 @@ static void nvm_normalize_path(char *path)
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
+	int ret;
 
 	down_write(&nvm_lock);
 	dev = nvm_find_nvm_dev(create->dev);
@@ -1223,7 +1230,17 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
-	return nvm_create_tgt(dev, create);
+	mutex_lock(&dev->mlock);
+	dev->create_inflight++;
+	mutex_unlock(&dev->mlock);
+
+	ret = nvm_create_tgt(dev, create);
+
+	mutex_lock(&dev->mlock);
+	dev->create_inflight--;
+	mutex_unlock(&dev->mlock);
+
+	return ret;
 }
 
 static long nvm_ioctl_info(struct file *file, void __user *arg)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d3b0270..e462d1d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -428,6 +428,8 @@ struct nvm_dev {
 	char name[DISK_NAME_LEN];
 	void *private_data;
 
+	int create_inflight;
+
 	void *rmap;
 
 	struct mutex mlock;
-- 
2.9.5

