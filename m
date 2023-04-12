Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5762CC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 16:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjDLQPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjDLQPU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 12:15:20 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 09:15:09 PDT
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0CEDC
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 09:15:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681315717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bKPEl8cLlrZ/2VwDkHe7tcZKUdIgYwqtpZzpBiFHDM=;
        b=cnCBC4FwQKZKslE1NCHQUuxO6RB9n5wldYgPudjea9JE6Vc63s5tmmAc54YAodnGf2xIif
        JXRFme7vMTMpK53ZoJ/9FULSDVDyiQaQ1s5jHSz54tRERNJ7pnZ8JQnprkAtNqnicgFZyi
        ijnKHZEWNJ3pDH0outC5ygYPvdwfRWA=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/2] blk-throttle: only enable blk-stat when BLK_DEV_THROTTLING_LOW
Date:   Thu, 13 Apr 2023 00:07:54 +0800
Message-Id: <20230412160754.1981705-2-chengming.zhou@linux.dev>
In-Reply-To: <20230412160754.1981705-1-chengming.zhou@linux.dev>
References: <20230412160754.1981705-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

blk_throtl_register() will unconditionally enable blk-stat for gendisk
when register, even when we have no BLK_DEV_THROTTLING_LOW config.

Since the kernel always has only BLK_DEV_THROTTLING config and the
BLK_DEV_THROTTLING_LOW config is still in EXPERIMENTAL state, we can
just skip blk-stat when !BLK_DEV_THROTTLING_LOW.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-throttle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47e9d8be68f3..3c07c9cfa70a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2439,11 +2439,12 @@ void blk_throtl_register(struct gendisk *disk)
 #ifndef CONFIG_BLK_DEV_THROTTLING_LOW
 	/* if no low limit, use previous default */
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
-#endif
 
+#else
 	td->track_bio_latency = !queue_is_mq(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-- 
2.39.2

