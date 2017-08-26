Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdHZQfk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Aug 2017 12:35:40 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 13/14] blk-mq-sched: refactor blk_mq_sched_try_merge()
Date: Sun, 27 Aug 2017 00:33:31 +0800
Message-Id: <20170826163332.28971-14-ming.lei@redhat.com>
In-Reply-To: <20170826163332.28971-1-ming.lei@redhat.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces one function __blk_mq_try_merge()
which will be resued for bio merge to sw queue in
the following patch.

No functional change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 28054e49df5d..5af0ff71730c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -228,12 +228,13 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	}
 }
 
-bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-			    struct request **merged_request)
+static bool __blk_mq_try_merge(struct request_queue *q,
+		struct bio *bio, struct request **merged_request,
+		struct request *candidate, enum elv_merge type)
 {
-	struct request *rq;
+	struct request *rq = candidate;
 
-	switch (elv_merge(q, &rq, bio)) {
+	switch (type) {
 	case ELEVATOR_BACK_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
@@ -256,6 +257,15 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		return false;
 	}
 }
+
+bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
+		struct request **merged_request)
+{
+	struct request *rq;
+	enum elv_merge type = elv_merge(q, &rq, bio);
+
+	return __blk_mq_try_merge(q, bio, merged_request, rq, type);
+}
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
 
 /*
-- 
2.9.5
