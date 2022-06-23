Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC33CCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 06:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiFWGWP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiFWGWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 02:22:07 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915143F8AB
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 23:22:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655965325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ww2EUFz7dWcTEK1fBXMHI7SIk4VaOOAjWa/08DU/3n8=;
        b=YvL0YDd0asSDYZSmS31K2umcS9rJNHDG9LXACOXXCnGfVlamPshbFfGhJZRAIp0Xcnv94r
        +NEYdUMZAmTmulySMXclWZmYUthIcOKFrdfkLO/N22QkGEYBoHmX/bWusOjYVVGgOshAi9
        EbxkcPNJmfDGXJqoSYDXwBEI4DgJ1C0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V1 8/8] rnbd-clt: make rnbd_clt_change_capacity return void
Date:   Thu, 23 Jun 2022 14:21:16 +0800
Message-Id: <20220623062116.15976-9-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-1-guoqing.jiang@linux.dev>
References: <20220623062116.15976-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to checking the return value, make it return void.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c77da3d0317e..7a418c4d47e4 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -68,11 +68,11 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
 	return refcount_inc_not_zero(&dev->refcount);
 }
 
-static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
+static void rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
 				    sector_t new_nsectors)
 {
 	if (get_capacity(dev->gd) == new_nsectors)
-		return 0;
+		return;
 
 	/*
 	 * If the size changed, we need to revalidate it
@@ -80,7 +80,6 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
 	rnbd_clt_info(dev, "Device size changed from %llu to %llu sectors\n",
 		      get_capacity(dev->gd), new_nsectors);
 	set_capacity_and_notify(dev->gd, new_nsectors);
-	return 0;
 }
 
 static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
@@ -127,7 +126,7 @@ int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize)
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = rnbd_clt_change_capacity(dev, newsize);
+	rnbd_clt_change_capacity(dev, newsize);
 
 out:
 	mutex_unlock(&dev->lock);
-- 
2.34.1

