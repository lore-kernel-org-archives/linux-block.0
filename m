Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13725C43334
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 13:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiGFNcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiGFNcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:32:09 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6BB24093
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 06:32:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657114327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQz4hxo02O/ERI8ouk8kiuNQTGrlxl6VHggvw9kZINo=;
        b=ryGyOpelcJgivVxaPZRMqL5vx0XZEn+Zv0JzuljsY6Xtrg/EYmjFsRaYREO/Gfa3c/xe8K
        KylFF8WycrQOTt6JWrOA/sc50RfENpIeCTebVoq+vD2sbdNpqGZ7+ecaGIuFWewsyF0YL8
        Ps+zIv7e6nBx3NhxHnQis0Xo3DX7vRU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org
Subject: [PATCH V2 6/8] rnbd-clt: check capacity inside rnbd_clt_change_capacity
Date:   Wed,  6 Jul 2022 21:31:50 +0800
Message-Id: <20220706133152.12058-7-guoqing.jiang@linux.dev>
In-Reply-To: <20220706133152.12058-1-guoqing.jiang@linux.dev>
References: <20220706133152.12058-1-guoqing.jiang@linux.dev>
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

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 53f216be8615..84fd509c2626 100644
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
2.31.1

