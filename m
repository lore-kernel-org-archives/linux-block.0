Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x64sm1270532ita.1.2017.03.24.10.39.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 10:39:12 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: include errors in did_work calculation
Message-ID: <f82c3ba7-2c19-1bf4-a68b-1793b3a2ac4e@kernel.dk>
Date: Fri, 24 Mar 2017 11:39:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Currently we return true in blk_mq_dispatch_rq_list() if we queued IO
successfully, but we really want to return whether or not the we made
progress. Progress includes if we got an error return.  If we don't,
this can lead to a hang in blk_mq_sched_dispatch_requests() when a
driver is draining IO by returning BLK_MQ_QUEUE_ERROR instead of
manually ending the IO in error and return BLK_MQ_QUEUE_OK.

Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a4546f060e80..e3b09abf9d5b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -978,7 +978,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 	struct request *rq;
 	LIST_HEAD(driver_list);
 	struct list_head *dptr;
-	int queued, ret = BLK_MQ_RQ_QUEUE_OK;
+	int errors, queued, ret = BLK_MQ_RQ_QUEUE_OK;
 
 	/*
 	 * Start off with dptr being NULL, so we start the first request
@@ -989,7 +989,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
-	queued = 0;
+	errors = queued = 0;
 	while (!list_empty(list)) {
 		struct blk_mq_queue_data bd;
 
@@ -1046,6 +1046,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 		default:
 			pr_err("blk-mq: bad return on queue: %d\n", ret);
 		case BLK_MQ_RQ_QUEUE_ERROR:
+			errors++;
 			rq->errors = -EIO;
 			blk_mq_end_request(rq, rq->errors);
 			break;
@@ -1097,7 +1098,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 			blk_mq_run_hw_queue(hctx, true);
 	}
 
-	return queued != 0;
+	return (queued + errors) != 0;
 }
 
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
