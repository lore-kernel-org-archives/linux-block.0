Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:54271 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750970AbdGFPAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2017 11:00:47 -0400
From: Max Gurtovoy <maxg@mellanox.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2 1/1] null_blk: fix error flow for shared tags during module_init
Date: Thu,  6 Jul 2017 18:00:07 +0300
Message-Id: <1499353207-32376-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In case we use shared tags feature, blk_mq_alloc_tag_set might fail
during module initialization. In that case, fail the load with the
suitble error code. Also move the tagset initialization process after
defining the amount of submition queues.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

Changes from v1:
- fail module loading in case of tagset initialization failure
- call blk_mq_free_tag_set in error flow

---
 drivers/block/null_blk.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 71f4422..85c24ca 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -844,9 +844,6 @@ static int __init null_init(void)
 		queue_mode = NULL_Q_MQ;
 	}
 
-	if (queue_mode == NULL_Q_MQ && shared_tags)
-		null_init_tag_set(&tag_set);
-
 	if (queue_mode == NULL_Q_MQ && use_per_node_hctx) {
 		if (submit_queues < nr_online_nodes) {
 			pr_warn("null_blk: submit_queues param is set to %u.",
@@ -858,11 +855,19 @@ static int __init null_init(void)
 	else if (!submit_queues)
 		submit_queues = 1;
 
+	if (queue_mode == NULL_Q_MQ && shared_tags) {
+		ret = null_init_tag_set(&tag_set);
+		if (ret)
+			return ret;
+	}
+
 	mutex_init(&lock);
 
 	null_major = register_blkdev(0, "nullb");
-	if (null_major < 0)
-		return null_major;
+	if (null_major < 0) {
+		ret = null_major;
+		goto err_tagset;
+	}
 
 	if (use_lightnvm) {
 		ppa_cache = kmem_cache_create("ppa_cache", 64 * sizeof(u64),
@@ -891,6 +896,9 @@ static int __init null_init(void)
 	kmem_cache_destroy(ppa_cache);
 err_ppa:
 	unregister_blkdev(null_major, "nullb");
+err_tagset:
+	if (queue_mode == NULL_Q_MQ && shared_tags)
+		blk_mq_free_tag_set(&tag_set);
 	return ret;
 }
 
-- 
1.7.1
