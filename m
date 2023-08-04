Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E108C04A6A
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 07:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHDHGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 03:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjHDHGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 03:06:47 -0400
Received: from out-90.mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD621724;
        Fri,  4 Aug 2023 00:06:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691132804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N+PDNOldMLpWe69wkWNroeRQ0YSGNugCwYgD/y+ooro=;
        b=wWYdynmWr8j2Zpj7xMyOAs3ezXwF7tkwWlomyVRAePrtrisQ9F1QoabhoFgJiY2j1udwyP
        YjkEZ127YkooBA7JmZZVq+cy9rtCJLeEdG5gnmzrq/dxIwl+TGD24r+BppOHvGctzkLEnC
        S3lZWg0en8KKb6y+Rr3NBbobqsJqMWQ=
From:   chengming.zhou@linux.dev
To:     tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH] blk-iocost: fix queue stats accounting
Date:   Fri,  4 Aug 2023 15:06:09 +0800
Message-ID: <20230804070609.31623-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The q->stats->accounting is not only used by iocost, but iocost only
increase this counter, never decrease it. So queue stats accounting
will always enabled after using iocost once.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index dd64e2066f01..089fcb9cfce3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3301,11 +3301,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (qos[QOS_MIN] > qos[QOS_MAX])
 		goto einval;
 
-	if (enable) {
+	if (enable && !ioc->enabled) {
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = true;
-	} else {
+	} else if (!enable && ioc->enabled) {
+		blk_stat_disable_accounting(disk->queue);
 		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = false;
 	}
-- 
2.41.0

