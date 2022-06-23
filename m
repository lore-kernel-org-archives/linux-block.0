Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22363C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 06:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiFWGWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiFWGWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 02:22:04 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7233DDDD
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 23:22:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655965322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijmeut83hRbw4GAZ2VUTCoNYwjZ9E/FeQpogxjVWcVw=;
        b=IBQd5abLKU61JXHgZk0FyMwfsVsgaW3Wp5FiCPebz3ZOzwd5sdqdAARrIrpqYM7JQv3/b/
        AbvVH9COAGfKsdjX3qFm7QWZAMETGU8OVgkATnJ+CbwkejntTXzTULDdVIA5+zs+I47YIM
        ZZcHvtRaGTLEDyUywXfguKbxO7aBWik=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V1 7/8] rnbd-clt: pass sector_t type for resize capacity
Date:   Thu, 23 Jun 2022 14:21:15 +0800
Message-Id: <20220623062116.15976-8-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-1-guoqing.jiang@linux.dev>
References: <20220623062116.15976-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let's change the parameter type to 'sector_t' then we don't need to cast
it from rnbd_clt_resize_dev_store, and update rnbd_clt_resize_disk too.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
 drivers/block/rnbd/rnbd-clt.c       | 6 +++---
 drivers/block/rnbd/rnbd-clt.h       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

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
index a9bfab53bbf7..c77da3d0317e 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -69,7 +69,7 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
 }
 
 static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
-				    size_t new_nsectors)
+				    sector_t new_nsectors)
 {
 	if (get_capacity(dev->gd) == new_nsectors)
 		return 0;
@@ -77,7 +77,7 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
 	/*
 	 * If the size changed, we need to revalidate it
 	 */
-	rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
+	rnbd_clt_info(dev, "Device size changed from %llu to %llu sectors\n",
 		      get_capacity(dev->gd), new_nsectors);
 	set_capacity_and_notify(dev->gd, new_nsectors);
 	return 0;
@@ -117,7 +117,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
 	return err;
 }
 
-int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize)
+int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize)
 {
 	int ret = 0;
 
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

