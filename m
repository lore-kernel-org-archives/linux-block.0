Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD15C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352202073F
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfDPKTp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:19:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:15522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfDPKTp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 06:19:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 03:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="337927081"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2019 03:19:43 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v4 7/7] lightnvm: do not remove instance under global lock
Date:   Tue, 16 Apr 2019 12:16:48 +0200
Message-Id: <20190416101648.10045-8-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190416101648.10045-1-igor.j.konopko@intel.com>
References: <20190416101648.10045-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently all the target instances are removed under global nvm_lock.
This was needed to ensure that nvm_dev struct will not be freed by
hot unplug event during target removal. However, current implementation
has some drawbacks, since the same lock is used when new nvme subsystem
is registered, so we can have a situation, that due to long process of
target removal on drive A, registration (and listing in OS) of the
drive B will take a lot of time, since it will wait for that lock.

Now when we have kref which ensures that nvm_dev will not be freed in
the meantime, we can easily get rid of this lock for a time when we are
removing nvm targets.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/core.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 0e9f7996..0df7454 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -483,7 +483,6 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
 
 /**
  * nvm_remove_tgt - Removes a target from the media manager
- * @dev:	device
  * @remove:	ioctl structure with target name to remove.
  *
  * Returns:
@@ -491,18 +490,27 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
  * 1: on not found
  * <0: on error
  */
-static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
+static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
 {
 	struct nvm_target *t;
+	struct nvm_dev *dev;
 
-	mutex_lock(&dev->mlock);
-	t = nvm_find_target(dev, remove->tgtname);
-	if (!t) {
+	down_read(&nvm_lock);
+	list_for_each_entry(dev, &nvm_devices, devices) {
+		mutex_lock(&dev->mlock);
+		t = nvm_find_target(dev, remove->tgtname);
+		if (t) {
+			mutex_unlock(&dev->mlock);
+			break;
+		}
 		mutex_unlock(&dev->mlock);
-		return 1;
 	}
+	up_read(&nvm_lock);
+
+	if (!t)
+		return 1;
+
 	__nvm_remove_target(t, true);
-	mutex_unlock(&dev->mlock);
 	kref_put(&dev->ref, nvm_free);
 
 	return 0;
@@ -1348,8 +1356,6 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_remove remove;
-	struct nvm_dev *dev;
-	int ret = 0;
 
 	if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
 		return -EFAULT;
@@ -1361,15 +1367,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 		return -EINVAL;
 	}
 
-	down_read(&nvm_lock);
-	list_for_each_entry(dev, &nvm_devices, devices) {
-		ret = nvm_remove_tgt(dev, &remove);
-		if (!ret)
-			break;
-	}
-	up_read(&nvm_lock);
-
-	return ret;
+	return nvm_remove_tgt(&remove);
 }
 
 /* kept for compatibility reasons */
-- 
2.9.5

