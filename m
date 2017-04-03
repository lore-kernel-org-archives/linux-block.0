Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36443 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdDCVnI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 17:43:08 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so130864338pge.3
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2017 14:43:08 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 4/5] blk-mq: remap queues when adding/removing hardware queues
Date: Mon,  3 Apr 2017 14:42:04 -0700
Message-Id: <4ab0628bf930d80f618609caa564a3a036b6cbc0.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

blk_mq_update_nr_hw_queues() used to remap hardware queues, which is the
behavior that drivers expect. However, commit 4e68a011428a changed
blk_mq_queue_reinit() to not remap queues for the case of CPU
hotplugging, inadvertently making blk_mq_update_nr_hw_queues() not remap
queues as well. This breaks, for example, NBD's multi-connection mode,
leaving the added hardware queues unused. Fix it by making
blk_mq_update_nr_hw_queues() explicitly remap the queues.

Fixes: 4e68a011428a ("blk-mq: don't redistribute hardware queues on a CPU hotplug event")
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 477951d10cc9..b49fdfde7e06 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2483,6 +2483,14 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	return 0;
 }
 
+static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
+{
+	if (set->ops->map_queues)
+		return set->ops->map_queues(set);
+	else
+		return blk_mq_map_queues(set);
+}
+
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -2537,10 +2545,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (!set->mq_map)
 		goto out_free_tags;
 
-	if (set->ops->map_queues)
-		ret = set->ops->map_queues(set);
-	else
-		ret = blk_mq_map_queues(set);
+	ret = blk_mq_update_queue_map(set);
 	if (ret)
 		goto out_free_mq_map;
 
@@ -2632,6 +2637,7 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 		blk_mq_freeze_queue(q);
 
 	set->nr_hw_queues = nr_hw_queues;
+	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
 		blk_mq_queue_reinit(q, cpu_online_mask);
-- 
2.12.2
