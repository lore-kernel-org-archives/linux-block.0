Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8D6C43334
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 13:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiGFNcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiGFNcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:32:12 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805B8248F5
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 06:32:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657114330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu3JQ0RF8p4FzS6QKpWeczgXpjpA8HJ8tdaD6DfpZJs=;
        b=oS3u+Yn8wHYPFmeMRAxEyFv4nAq+kJgu3CQsUIwFfVwZLV/byWoT3t+pNrJqbQaqBpnHKN
        UCHDAww0s1rXHgoGO+vDr96sI2/FuM2HpgXGo+ZhVHRYTKMSyhQKywIFl6bPQwv1zOP18A
        QPafFnaG80xkzDfJDHN/t0ExbcoPLkA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org
Subject: [PATCH V2 8/8] rnbd-clt: make rnbd_clt_change_capacity return void
Date:   Wed,  6 Jul 2022 21:31:52 +0800
Message-Id: <20220706133152.12058-9-guoqing.jiang@linux.dev>
In-Reply-To: <20220706133152.12058-1-guoqing.jiang@linux.dev>
References: <20220706133152.12058-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to checking the return value, make it return void.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 58e5ffcfbf7c..04da33a22ef4 100644
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
2.31.1

