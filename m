Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E7C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 06:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiFWGWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiFWGWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 02:22:02 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421CE36B42
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 23:22:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655965319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Evc/bZwnEkQuSEpuL+ukkCOu5Wg3hfABaeekb6F52SE=;
        b=X7ia/RtNLzHhNOZSIemHONEwq0HAfkXEq3mtO+JonsIyLKWSqRUzFRLKe5FTbVKL29li8Z
        Tq1fxxuEeOVLcrXezlFapKhU1kWwXLnGmaGZKfy+WNSrqpMzd3aLGz3ZCobDuaFhQo+HKt
        Kjqy9nCMrj+Kw9KYEqJSLDAYB5lVEic=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V1 6/8] rnbd-clt: check capacity inside rnbd_clt_change_capacity
Date:   Thu, 23 Jun 2022 14:21:14 +0800
Message-Id: <20220623062116.15976-7-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-1-guoqing.jiang@linux.dev>
References: <20220623062116.15976-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, process_msg_open_rsp checks if capacity changed or not before
call rnbd_clt_change_capacity while the checking also make sense for
rnbd_clt_resize_dev_store, let's move the checking into the function.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index da2ba9477b1e..a9bfab53bbf7 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -71,6 +71,12 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
 static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
 				    size_t new_nsectors)
 {
+	if (get_capacity(dev->gd) == new_nsectors)
+		return 0;
+
+	/*
+	 * If the size changed, we need to revalidate it
+	 */
 	rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
 		      get_capacity(dev->gd), new_nsectors);
 	set_capacity_and_notify(dev->gd, new_nsectors);
@@ -93,12 +99,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
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
-- 
2.34.1

