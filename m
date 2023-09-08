Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09396EC875F
	for <linux-block@archiver.kernel.org>; Fri,  8 Sep 2023 00:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjIHA6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Sep 2023 20:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjIHA6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2023 20:58:54 -0400
Received: from out-215.mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5A1BCD
        for <linux-block@vger.kernel.org>; Thu,  7 Sep 2023 17:58:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694134728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ari/qh1ipeC25jnMKiRGz5gX6zIkDBAgflRJ1EiG9Zw=;
        b=c8eHsY9Rhs1TCUthM9Wakbix3sgSkoTTV5lerjSLzcG0t7Jp74Je/42MIiaiUN84aJsK/f
        jSe2YDFcB4Z4oFBvsEvmnIThl1ROAqiUVSxDQXjCLFj2MRWsBIfPefedzvG1Cgs5fU1EGT
        BRGOqY8yzrXgqNEG+MwLLK5Jvvkst1Q=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] blk-mq: fix tags UAF when shrink nr_hw_queues
Date:   Fri,  8 Sep 2023 08:57:02 +0800
Message-ID: <20230908005702.2183908-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

When nr_hw_queues shrink, we free the excess tags before realloc
hw_ctxs for each queue, during that we may need to access those
tags, like blk_mq_tag_idle(hctx) will access queue shared tags.

So slab-use-after-free caused and reported by KASAN. Fix it by
moving the releasing of excess tags to the end.

Fixes: e1dd7bc93029 ("blk-mq: fix tags leak when shrink nr_hw_queues")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs_CK63uoDpGBGZ6DN4OCTpzkR3UaVgK=LX8Owr8ej2ieQ@mail.gmail.com/
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec922c6bccbe..1fafd54dce3c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4405,11 +4405,8 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	struct blk_mq_tags **new_tags;
 	int i;
 
-	if (set->nr_hw_queues >= new_nr_hw_queues) {
-		for (i = new_nr_hw_queues; i < set->nr_hw_queues; i++)
-			__blk_mq_free_map_and_rqs(set, i);
+	if (set->nr_hw_queues >= new_nr_hw_queues)
 		goto done;
-	}
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
@@ -4719,7 +4716,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 {
 	struct request_queue *q;
 	LIST_HEAD(head);
-	int prev_nr_hw_queues;
+	int prev_nr_hw_queues = set->nr_hw_queues;
+	int i;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -4746,7 +4744,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
-	prev_nr_hw_queues = set->nr_hw_queues;
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto reregister;
 
@@ -4781,6 +4778,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
+
+	/* Free the excess tags when nr_hw_queues shrink. */
+	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
+		__blk_mq_free_map_and_rqs(set, i);
 }
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
-- 
2.41.0

