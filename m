Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdHEG6Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Aug 2017 02:58:25 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 19/20] blk-mq-sched: refactor blk_mq_sched_try_merge()
Date: Sat,  5 Aug 2017 14:57:04 +0800
Message-Id: <20170805065705.12989-20-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-1-ming.lei@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
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
index b11f53d1e1f3..7fb7949ed7ce 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -214,12 +214,13 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	}
 }
 
-bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-			    struct request **merged_request)
+static inline bool __blk_mq_try_merge(struct request_queue *q,
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
@@ -242,6 +243,15 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
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
2.9.4
