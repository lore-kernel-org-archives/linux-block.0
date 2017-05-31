Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 06/12] block: Add a comment above queue_lockdep_assert_held()
Date: Wed, 31 May 2017 15:52:40 -0700
Message-ID: <20170531225246.26261-7-bart.vanassche@sandisk.com>
In-Reply-To: <20170531225246.26261-1-bart.vanassche@sandisk.com>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Add a comment above the queue_lockdep_assert_held() macro that
explains the purpose of the q->queue_lock test.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cbc0028290e4..1e73b4df13a9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -634,6 +634,13 @@ struct request_queue {
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
 				 (1 << QUEUE_FLAG_POLL))
 
+/*
+ * @q->queue_lock is set while a queue is being initialized. Since we know
+ * that no other threads access the queue object before @q->queue_lock has
+ * been set, it is safe to manipulate queue flags without holding the
+ * queue_lock if @q->queue_lock == NULL. See also blk_alloc_queue_node() and
+ * blk_init_allocated_queue().
+ */
 static inline void queue_lockdep_assert_held(struct request_queue *q)
 {
 	if (q->queue_lock)
-- 
2.12.2
