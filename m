Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 10/13] blk-mq: only allocate a single mq_map per tag_set
Date: Tue, 14 Jun 2016 21:59:03 +0200
Message-Id: <1465934346-20648-11-git-send-email-hch@lst.de>
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

The mapping is identical for all queues in a tag_set, so stop wasting
memory for building multiple.  Note that for now I've kept the mq_map
pointer in the request_queue, but we'll need to investigate if we can
remove it without suffering from the additional indirection.  The same
would apply to the mq_ops pointer as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 22 ++++++++++++++--------
 include/linux/blk-mq.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f972d32..622cb22 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1930,7 +1930,6 @@ void blk_mq_release(struct request_queue *q)
 		kfree(hctx);
 	}
 
-	kfree(q->mq_map);
 	q->mq_map = NULL;
 
 	kfree(q->queue_hw_ctx);
@@ -2029,9 +2028,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
-	q->mq_map = blk_mq_make_queue_map(set);
-	if (!q->mq_map)
-		goto err_map;
+	q->mq_map = set->mq_map;
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
@@ -2081,8 +2078,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return q;
 
 err_hctxs:
-	kfree(q->mq_map);
-err_map:
 	kfree(q->queue_hw_ctx);
 err_percpu:
 	free_percpu(q->queue_ctx);
@@ -2304,14 +2299,22 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (!set->tags)
 		return -ENOMEM;
 
+	set->mq_map = blk_mq_make_queue_map(set);
+	if (!set->mq_map)
+		goto out_free_tags;
+
 	if (blk_mq_alloc_rq_maps(set))
-		goto enomem;
+		goto out_free_mq_map;
 
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
 
 	return 0;
-enomem:
+
+out_free_mq_map:
+	kfree(set->mq_map);
+	set->mq_map = NULL;
+out_free_tags:
 	kfree(set->tags);
 	set->tags = NULL;
 	return -ENOMEM;
@@ -2327,6 +2330,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 			blk_mq_free_rq_map(set, set->tags[i], i);
 	}
 
+	kfree(set->mq_map);
+	set->mq_map = NULL;
+
 	kfree(set->tags);
 	set->tags = NULL;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2498fdf..0a3b138 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -65,6 +65,7 @@ struct blk_mq_hw_ctx {
 };
 
 struct blk_mq_tag_set {
+	unsigned int		*mq_map;
 	struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
 	unsigned int		queue_depth;	/* max hw supported */
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
