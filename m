Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB741C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFD520656
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 11:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgG1LIO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:08:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:37366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgG1LIO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 07:08:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12E7CAC82;
        Tue, 28 Jul 2020 11:08:24 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC] block: Allocate only 1 tag set for a kdump kernel
Date:   Tue, 28 Jul 2020 13:08:09 +0200
Message-Id: <20200728110809.19228-1-dwagner@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do not update nr_hw_queues again after setting it to 1 for a kdump
kernel. This avoids allocating a tag set of size nr_cpu_ids and but
then just using one tag set.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

I stumbled across this and didn't make sense to me that we might
allocated more tag sets than we potently use. But maybe I am
not seeing the obvious thing.

Only compiled tested.

Thanks,
Daniel

 block/blk-mq.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f57d27bfa73..e32cb0217135 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3291,13 +3291,14 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		set->nr_hw_queues = 1;
 		set->nr_maps = 1;
 		set->queue_depth = min(64U, set->queue_depth);
+	} else {
+		/*
+		 * There is no use for more h/w queues than cpus
+		 * if we just have a single map
+		 */
+		if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
+			set->nr_hw_queues = nr_cpu_ids;
 	}
-	/*
-	 * There is no use for more h/w queues than cpus if we just have
-	 * a single map
-	 */
-	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
-		set->nr_hw_queues = nr_cpu_ids;
 
 	if (blk_mq_realloc_tag_set_tags(set, 0, set->nr_hw_queues) < 0)
 		return -ENOMEM;
@@ -3309,7 +3310,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 						  GFP_KERNEL, set->numa_node);
 		if (!set->map[i].mq_map)
 			goto out_free_mq_map;
-		set->map[i].nr_queues = is_kdump_kernel() ? 1 : set->nr_hw_queues;
+		set->map[i].nr_queues = set->nr_hw_queues;
 	}
 
 	ret = blk_mq_update_queue_map(set);
-- 
2.16.4

