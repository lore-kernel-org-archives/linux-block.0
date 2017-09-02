Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752660AbdIBPT0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Sep 2017 11:19:26 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 10/14] block: move actual bio merge code into __elv_merge
Date: Sat,  2 Sep 2017 23:17:25 +0800
Message-Id: <20170902151729.6162-11-ming.lei@redhat.com>
In-Reply-To: <20170902151729.6162-1-ming.lei@redhat.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

So that we can reuse __elv_merge() to merge bio
into requests from sw queue in the following patches.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 824cc3e69ac3..e11c7873fc21 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -409,8 +409,9 @@ void elv_dispatch_add_tail(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(elv_dispatch_add_tail);
 
-enum elv_merge elv_merge(struct request_queue *q, struct request **req,
-		struct bio *bio)
+static enum elv_merge __elv_merge(struct request_queue *q,
+		struct request **req, struct bio *bio,
+		struct hlist_head *hash, struct request *last_merge)
 {
 	struct elevator_queue *e = q->elevator;
 	struct request *__rq;
@@ -427,11 +428,11 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
 	/*
 	 * First try one-hit cache.
 	 */
-	if (q->last_merge && elv_bio_merge_ok(q->last_merge, bio)) {
-		enum elv_merge ret = blk_try_merge(q->last_merge, bio);
+	if (last_merge && elv_bio_merge_ok(last_merge, bio)) {
+		enum elv_merge ret = blk_try_merge(last_merge, bio);
 
 		if (ret != ELEVATOR_NO_MERGE) {
-			*req = q->last_merge;
+			*req = last_merge;
 			return ret;
 		}
 	}
@@ -442,7 +443,7 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
 	/*
 	 * See if our hash lookup can find a potential backmerge.
 	 */
-	__rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
+	__rq = rqhash_find(hash, bio->bi_iter.bi_sector);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
 		return ELEVATOR_BACK_MERGE;
@@ -456,6 +457,12 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
 	return ELEVATOR_NO_MERGE;
 }
 
+enum elv_merge elv_merge(struct request_queue *q, struct request **req,
+		struct bio *bio)
+{
+	return __elv_merge(q, req, bio, q->elevator->hash, q->last_merge);
+}
+
 /*
  * Attempt to do an insertion back merge. Only check for the case where
  * we can append 'rq' to an existing request, so we can throw 'rq' away
-- 
2.9.5
