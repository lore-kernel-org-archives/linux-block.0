Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, Omar Sandoval
	<osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 07/12] block: Add a comment above queue_lockdep_assert_held()
Date: Mon, 19 Jun 2017 15:07:56 -0700
Message-ID: <20170619220801.12557-8-bart.vanassche@wdc.com>
In-Reply-To: <20170619220801.12557-1-bart.vanassche@wdc.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

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
index ff0ae83235ea..c00a6b99e77c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -635,6 +635,13 @@ struct request_queue {
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
2.13.1
