Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A070C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 03:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiFTDuO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 23:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiFTDuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 23:50:12 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA8BE36
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 20:50:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655697010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8fE92pEPHab89y5DccrXQ5VRHM8DKZv1pMAZbSNu6A=;
        b=Xg74ADFn9VFkSqBvOacr7BdRwhXredO7hgHJLZyrskzcziTLPl6sQtKWxuUoURms3KgpDI
        WP3wTIyLP0Vt72TCysNbaIVE/h3bhvWTbkDh8G95Z5IsoTA2DUd5ZrlVLC5ynL1t6EFFbT
        Wj3Ue2Qj3DeXShJti7qPWiwgrCsuZr4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC PATCH 6/6] rnbd-clt: refactor rnbd_clt_change_capacity
Date:   Mon, 20 Jun 2022 11:49:23 +0800
Message-Id: <20220620034923.35633-7-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-1-guoqing.jiang@linux.dev>
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

1. process_msg_open_rsp checks if capacity changed or not before call
rnbd_clt_change_capacity while the checking also make sense for
rnbd_clt_resize_dev_store, let's move the checking into the function.

2. change the parameter type to 'sector_t' then we don't need to cast
it from rnbd_clt_resize_dev_store, and update rnbd_clt_resize_disk too.

3. no need to checking the return value, make it return void.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c |  2 +-
 drivers/block/rnbd/rnbd-clt.c       | 24 ++++++++++++------------
 drivers/block/rnbd/rnbd-clt.h       |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 2be5d87a3ca6..e7c7d9a68168 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -376,7 +376,7 @@ static ssize_t rnbd_clt_resize_dev_store(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	ret = rnbd_clt_resize_disk(dev, (size_t)sectors);
+	ret = rnbd_clt_resize_disk(dev, sectors);
 	if (ret)
 		return ret;
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 2c63cd5ac09d..6c6c4ba3d41d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -68,13 +68,18 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
 	return refcount_inc_not_zero(&dev->refcount);
 }
 
-static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
-				    size_t new_nsectors)
+static void rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
+				     sector_t new_nsectors)
 {
-	rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
+	if (get_capacity(dev->gd) != new_nsectors)
+		return;
+
+	/*
+	 * If the size changed, we need to revalidate it
+	 */
+	rnbd_clt_info(dev, "Device size changed from %llu to %llu sectors\n",
 		      get_capacity(dev->gd), new_nsectors);
 	set_capacity_and_notify(dev->gd, new_nsectors);
-	return 0;
 }
 
 static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
@@ -93,12 +98,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
 	if (dev->dev_state == DEV_STATE_MAPPED_DISCONNECTED) {
 		u64 nsectors = le64_to_cpu(rsp->nsectors);
 
-		/*
-		 * If the device was remapped and the size changed in the
-		 * meantime we need to revalidate it
-		 */
-		if (get_capacity(dev->gd) != nsectors)
-			rnbd_clt_change_capacity(dev, nsectors);
+		rnbd_clt_change_capacity(dev, nsectors);
 		gd_kobj = &disk_to_dev(dev->gd)->kobj;
 		kobject_uevent(gd_kobj, KOBJ_ONLINE);
 		rnbd_clt_info(dev, "Device online, device remapped successfully\n");
@@ -116,7 +116,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
 	return err;
 }
 
-int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize)
+int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize)
 {
 	int ret = 0;
 
@@ -126,7 +126,7 @@ int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize)
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = rnbd_clt_change_capacity(dev, newsize);
+	rnbd_clt_change_capacity(dev, newsize);
 
 out:
 	mutex_unlock(&dev->lock);
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index df237d2ea0d9..a48e040abe63 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -138,7 +138,7 @@ int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
 			   const struct attribute *sysfs_self);
 
 int rnbd_clt_remap_device(struct rnbd_clt_dev *dev);
-int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize);
+int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize);
 
 /* rnbd-clt-sysfs.c */
 
-- 
2.34.1

