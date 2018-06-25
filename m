Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Andrew Jones <drjones@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()
Date: Mon, 25 Jun 2018 19:31:49 +0800
Message-Id: <20180625113149.29449-6-ming.lei@redhat.com>
In-Reply-To: <20180625113149.29449-1-ming.lei@redhat.com>
References: <20180625113149.29449-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

SCSI probing may synchronously create and destroy a lot of request_queues
for non-existent devices. Any synchronize_rcu() in queue creation or
destroy path may introduce long latency during booting, see detailed
description in comment of blk_register_queue().

This patch removes one synchronize_rcu() inside blk_cleanup_queue()
for this case, commit c2856ae2f315d75(blk-mq: quiesce queue before freeing queue)
needs synchronize_rcu() for implementing blk_mq_quiesce_queue(), but
when queue isn't initialized, it isn't necessary to do that since
only pass-through requests are involved, no original issue in
scsi_execute() at all.

Without this patch and previous one, it may take more 20+ seconds for
virtio-scsi to complete disk probe. With the two patches, the time becomes
less than 100ms.

Fixes: c2856ae2f315d75 ("blk-mq: quiesce queue before freeing queue")
Reported-by: Andrew Jones <drjones@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Andrew Jones <drjones@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index afd2596ea3d3..222d4fc0e524 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -762,9 +762,13 @@ void blk_cleanup_queue(struct request_queue *q)
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
-- 
2.9.5
