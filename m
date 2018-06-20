Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Andrew Jones <drjones@redhat.com>,
	linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()
Date: Wed, 20 Jun 2018 10:55:22 +0800
Message-Id: <20180620025522.8002-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

SCSI probing may synchronously create and destroy a lot of request_queues
for non-existent devices. Any synchronize_rcu() in queue creation or
destroy path may introduce long latency during booting, see detailed
description in comment of blk_register_queue().

This patch removes two synchronize_rcu() inside blk_cleanup_queue()
for this case:

1) commit c2856ae2f315d75(blk-mq: quiesce queue before freeing queue)
need synchronize_rcu() for implementing blk_mq_quiesce_queue(), but
when queue isn't initialized, it isn't necessary to do that since
only pass-through requests are involved, no original issue in
scsi_execute() at all.

2) when only one request queue is attached to tags, no necessary to
call synchronize_rcu() too.

Without this patch, it may take more 20+ seconds for virtio-scsi to
complete disk probe. With this patch, the time becomes less than 100ms.

Reported-by: Andrew Jones <drjones@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>
Cc: linux-scsi@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 8 ++++++--
 block/blk-mq.c   | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cf0ee764b908..f0129e20b773 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -766,9 +766,13 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * make sure all in-progress dispatch are completed because
 	 * blk_freeze_queue() can only complete all requests, and
 	 * dispatch may still be in-progress since we dispatch requests
-	 * from more than one contexts
+	 * from more than one contexts.
+	 *
+	 * No need to quiesce queue if it isn't initialized yet since
+	 * blk_freeze_queue() should be enough for cases of passthrough
+	 * request.
 	 */
-	if (q->mq_ops)
+	if (q->mq_ops && blk_queue_init_done(q))
 		blk_mq_quiesce_queue(q);
 
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70c65bb6c013..63680b243466 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2351,6 +2351,7 @@ static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
 static void blk_mq_del_queue_tag_set(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
+	bool shared = true;
 
 	mutex_lock(&set->tag_list_lock);
 	list_del_rcu(&q->tag_set_list);
@@ -2359,9 +2360,11 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		set->flags &= ~BLK_MQ_F_TAG_SHARED;
 		/* update existing queue */
 		blk_mq_update_tag_set_depth(set, false);
+		shared = true;
 	}
 	mutex_unlock(&set->tag_list_lock);
-	synchronize_rcu();
+	if (shared)
+		synchronize_rcu();
 	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
-- 
2.9.5
