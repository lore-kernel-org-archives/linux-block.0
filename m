Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56177 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdJKJxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 05:53:14 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/3] block: introduce blk_mq_tagset_iter
Date: Wed, 11 Oct 2017 12:53:06 +0300
Message-Id: <1507715588-1041-2-git-send-email-sagi@grimberg.me>
In-Reply-To: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
References: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Iterator helper to apply a function on all the
tags in a given tagset. export it as it will be used
outside the block layer later on.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-tag.c     | 16 +++++++++++-----
 include/linux/blk-mq.h |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 6714507aa6c7..bce1c76fc768 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -298,12 +298,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
-			 int (reinit_request)(void *, struct request *))
+int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
+			 int (fn)(void *, struct request *))
 {
 	int i, j, ret = 0;
 
-	if (WARN_ON_ONCE(!reinit_request))
+	if (WARN_ON_ONCE(!fn))
 		goto out;
 
 	for (i = 0; i < set->nr_hw_queues; i++) {
@@ -316,8 +316,7 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
 			if (!tags->static_rqs[j])
 				continue;
 
-			ret = reinit_request(set->driver_data,
-					     tags->static_rqs[j]);
+			ret = fn(data, tags->static_rqs[j]);
 			if (ret)
 				goto out;
 		}
@@ -326,6 +325,13 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(blk_mq_tagset_iter);
+
+int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
+			 int (reinit_request)(void *, struct request *))
+{
+	return blk_mq_tagset_iter(set, set->driver_data, reinit_request);
+}
 EXPORT_SYMBOL_GPL(blk_mq_reinit_tagset);
 
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 50c6485cb04f..6bc29f73a9aa 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -259,6 +259,8 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
+		int (reinit_request)(void *, struct request *));
 int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
 			 int (reinit_request)(void *, struct request *));
 
-- 
2.7.4
