Return-Path: <BATV+80a1e3aa0109c64edabc+4700+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/5] blk-mq: Introduce blk_mq_reinit_tagset
Date: Wed,  6 Jul 2016 21:55:48 +0900
Message-Id: <1467809752-31320-2-git-send-email-hch@lst.de>
In-Reply-To: <1467809752-31320-1-git-send-email-hch@lst.de>
References: <1467809752-31320-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Sagi Grimberg <sagi@grimberg.me>

The new nvme-rdma driver will need to reinitialize all the tags as part of
the error recovery procedure (realloc the tag memory region). Add a helper
in blk-mq for it that can iterate over all requests in a tagset to make
this easier.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Ming Lin <ming.l@ssi.samsung.com>
Reviewed-by: Stephen Bates <Stephen.Bates@pmcs.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c     | 26 ++++++++++++++++++++++++++
 include/linux/blk-mq.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 56a0c37..729bac3 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -485,6 +485,32 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+int blk_mq_reinit_tagset(struct blk_mq_tag_set *set)
+{
+	int i, j, ret = 0;
+
+	if (!set->ops->reinit_request)
+		goto out;
+
+	for (i = 0; i < set->nr_hw_queues; i++) {
+		struct blk_mq_tags *tags = set->tags[i];
+
+		for (j = 0; j < tags->nr_tags; j++) {
+			if (!tags->rqs[j])
+				continue;
+
+			ret = set->ops->reinit_request(set->driver_data,
+						tags->rqs[j]);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_mq_reinit_tagset);
+
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cbfd8ca..e43bbff 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -96,6 +96,7 @@ typedef int (init_request_fn)(void *, struct request *, unsigned int,
 		unsigned int, unsigned int);
 typedef void (exit_request_fn)(void *, struct request *, unsigned int,
 		unsigned int);
+typedef int (reinit_request_fn)(void *, struct request *);
 
 typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
@@ -145,6 +146,7 @@ struct blk_mq_ops {
 	 */
 	init_request_fn		*init_request;
 	exit_request_fn		*exit_request;
+	reinit_request_fn	*reinit_request;
 };
 
 enum {
@@ -245,6 +247,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
+int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
-- 
2.1.4
