Return-Path: <prvs=32144e98a9=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH] block: set make_request_fn manually in blk_mq_update_nr_hw_queues
Date: Fri, 10 Feb 2017 13:03:33 -0500
Message-ID: <1486749813-2167-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Calling blk_queue_make_request resets a bunch of settings on the
request_queue, but all we really want is to update the make_request_fn,
so do this directly so we don't lose things like the logical and
physical block sizes.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index be183e61..eccbb13 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2627,10 +2627,14 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
 
+		/*
+		 * Manually set the make_request_fn as blk_queue_make_request
+		 * resets a lot of the queue settings.
+		 */
 		if (q->nr_hw_queues > 1)
-			blk_queue_make_request(q, blk_mq_make_request);
+			q->make_request_fn = blk_mq_make_request;
 		else
-			blk_queue_make_request(q, blk_sq_make_request);
+			q->make_request_fn = blk_sq_make_request;
 
 		blk_mq_queue_reinit(q, cpu_online_mask);
 	}
-- 
2.7.4
