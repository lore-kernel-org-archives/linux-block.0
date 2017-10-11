Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbdJKJxR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 05:53:17 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/3] block: remove blk_mq_reinit_tagset
Date: Wed, 11 Oct 2017 12:53:08 +0300
Message-Id: <1507715588-1041-4-git-send-email-sagi@grimberg.me>
In-Reply-To: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
References: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No callers left.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-tag.c     | 7 -------
 include/linux/blk-mq.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index bce1c76fc768..c81b40ecd3f1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -327,13 +327,6 @@ int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
 }
 EXPORT_SYMBOL_GPL(blk_mq_tagset_iter);
 
-int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
-			 int (reinit_request)(void *, struct request *))
-{
-	return blk_mq_tagset_iter(set, set->driver_data, reinit_request);
-}
-EXPORT_SYMBOL_GPL(blk_mq_reinit_tagset);
-
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6bc29f73a9aa..cfd64e500d82 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -261,8 +261,6 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
 		int (reinit_request)(void *, struct request *));
-int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
-			 int (reinit_request)(void *, struct request *));
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.7.4
