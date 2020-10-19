Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D1BC433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DAA2225A
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 08:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgJSIbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 04:31:11 -0400
Received: from smtp.h3c.com ([60.191.123.50]:45106 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbgJSIbK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 04:31:10 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 09J8USuc021549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 16:30:28 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Oct 2020 16:30:31 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>, <raghavendra.kt@linux.vnet.ibm.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhocko@suse.com>, Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] blk-mq: remove the calling of local_memory_node()
Date:   Mon, 19 Oct 2020 16:20:47 +0800
Message-ID: <20201019082047.31113-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09J8USuc021549
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't need to check whether the node is memoryless numa node before
calling allocator interface. SLUB(and SLAB,SLOB) relies on the page
allocator to pick a node. Page allocator should deal with memoryless
nodes just fine. It has zonelists constructed for each possible nodes.
And it will automatically fall back into a node which is closest to the
requested node. As long as __GFP_THISNODE is not enforced of course.

The code comments of kmem_cache_alloc_node() of SLAB also showed this:
 * Fallback to other node is possible if __GFP_THISNODE is not set.

blk-mq code doesn't set __GFP_THISNODE, so we can remove the calling
of local_memory_node().

Fixes: bffed457160ab ("blk-mq: Avoid memoryless numa node encoded in hctx numa_node")

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-mq-cpumap.c | 2 +-
 block/blk-mq.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 0157f2b34..3db84d319 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -89,7 +89,7 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	for_each_possible_cpu(i) {
 		if (index == qmap->mq_map[i])
-			return local_memory_node(cpu_to_node(i));
+			return cpu_to_node(i);
 	}
 
 	return NUMA_NO_NODE;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cdced4aca..48f8366b2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2737,7 +2737,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		for (j = 0; j < set->nr_maps; j++) {
 			hctx = blk_mq_map_queue_type(q, j, i);
 			if (nr_hw_queues > 1 && hctx->numa_node == NUMA_NO_NODE)
-				hctx->numa_node = local_memory_node(cpu_to_node(i));
+				hctx->numa_node = cpu_to_node(i);
 		}
 	}
 }
-- 
2.17.1

