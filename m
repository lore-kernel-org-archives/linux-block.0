Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k66sm57859itg.8.2017.03.14.07.57.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 07:57:51 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq-sched: don't run the queue async from
 blk_mq_try_issue_directly()
Message-ID: <3ac4f49e-3bc0-7fc6-e93a-db9ec7ad21cf@kernel.dk>
Date: Tue, 14 Mar 2017 08:57:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

If we have scheduling enabled, we jump directly to insert-and-run.
That's fine, but we run the queue async and we don't pass in information
on whether we can block from this context or not. Fixup both these
cases.

Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 159187a28d66..4196d6bee92d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1434,7 +1434,8 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
 }
 
-static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
+static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
+				      bool can_block)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
@@ -1475,7 +1476,7 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
 	}
 
 insert:
-	blk_mq_sched_insert_request(rq, false, true, true, false);
+	blk_mq_sched_insert_request(rq, false, true, false, can_block);
 }
 
 /*
@@ -1569,11 +1570,11 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
 			rcu_read_lock();
-			blk_mq_try_issue_directly(old_rq, &cookie);
+			blk_mq_try_issue_directly(old_rq, &cookie, false);
 			rcu_read_unlock();
 		} else {
 			srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
-			blk_mq_try_issue_directly(old_rq, &cookie);
+			blk_mq_try_issue_directly(old_rq, &cookie, true);
 			srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
 		}
 		goto done;

-- 
Jens Axboe
