Return-Path: <axboe@kernel.dk>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: Regression: nvme timeouts and oopses
Message-ID: <af308491-a381-f13d-2d87-89bbca68d99e@kernel.dk>
Date: Fri, 11 Nov 2016 11:47:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi,

I've been running into problems when stability testing my 4.10 branch,
and I finally got an easy reproducer today (on the laptop, no less) and
was able to bisect it. Boils down to this:

2253efc850c4cf690516bbc07854eeb1077202ba is the first bad commit
commit 2253efc850c4cf690516bbc07854eeb1077202ba
Author: Bart Van Assche <bart.vanassche@sandisk.com>
Date:   Fri Oct 28 17:20:02 2016 -0700

     blk-mq: Move more code into blk_mq_direct_issue_request()

The symptoms are one of two things:

1) We get command timeouts:

nvme nvme0: I/O 567 QID 14 timeout, aborting
nvme nvme0: Abort status: 0x0
nvme nvme0: I/O 567 QID 14 timeout, reset controller
nvme nvme0: completing aborted command with status:

blk_update_request: I/O error, dev nvme0n1, sector

EXT4-fs warning (device nvme0n1): ext4_end_bio:314: I/O
g to inode 20185097 (offset 0 size 8388608 starting block

Buffer I/O error on device nvme0n1, logical block 247040
Buffer I/O error on device nvme0n1, logical block 247041
Buffer I/O error on device nvme0n1, logical block 247042
Buffer I/O error on device nvme0n1, logical block 247043
Buffer I/O error on device nvme0n1, logical block 247044
Buffer I/O error on device nvme0n1, logical block 247045
Buffer I/O error on device nvme0n1, logical block 247046
Buffer I/O error on device nvme0n1, logical block 247047
Buffer I/O error on device nvme0n1, logical block 247048
Buffer I/O error on device nvme0n1, logical block 247049

No corruption though, the data has been written.

2) We oops in __blk_mq_complete_request(), because __nvme_process_cq()
   -> blk_mq_complete_request() -> __blk_mq_complete_request() gets a
   request that has NULL ->q, ->bio, ->biotail, etc.

I did a manual revert of the patch, see below, and it seems to work fine
with this applied. I'll take a look at why this is, since it isn't
immediately obvious to me. Sending this to get it out there while I take
a deeper look.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d180c989a0e5..365ae17c3f2b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1291,11 +1291,11 @@ static struct request *blk_mq_map_request(struct 
request_queue *q,
  	return rq;
  }

-static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-				      struct request *rq, blk_qc_t *cookie)
+static int blk_mq_direct_issue_request(struct request *rq, blk_qc_t 
*cookie)
  {
  	int ret;
  	struct request_queue *q = rq->q;
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
  	struct blk_mq_queue_data bd = {
  		.rq = rq,
  		.list = NULL,
@@ -1303,9 +1303,6 @@ static void blk_mq_try_issue_directly(struct 
blk_mq_hw_ctx *hctx,
  	};
  	blk_qc_t new_cookie = blk_tag_to_qc_t(rq->tag, hctx->queue_num);

-	if (blk_mq_hctx_stopped(hctx))
-		goto insert;
-
  	/*
  	 * For OK queue, we are done. For error, kill it. Any other
  	 * error (busy), just add it to our list as we previously
@@ -1314,7 +1311,7 @@ static void blk_mq_try_issue_directly(struct 
blk_mq_hw_ctx *hctx,
  	ret = q->mq_ops->queue_rq(hctx, &bd);
  	if (ret == BLK_MQ_RQ_QUEUE_OK) {
  		*cookie = new_cookie;
-		return;
+		return 0;
  	}

  	__blk_mq_requeue_request(rq);
@@ -1323,11 +1320,10 @@ static void blk_mq_try_issue_directly(struct 
blk_mq_hw_ctx *hctx,
  		*cookie = BLK_QC_T_NONE;
  		rq->errors = -EIO;
  		blk_mq_end_request(rq, rq->errors);
-		return;
+		return 0;
  	}

-insert:
-	blk_mq_insert_request(rq, false, true, true);
+	return -1;
  }

  /*
@@ -1414,11 +1410,15 @@ static blk_qc_t blk_mq_make_request(struct 
request_queue *q, struct bio *bio)

  		if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
  			rcu_read_lock();
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
+			if (blk_mq_hctx_stopped(data.hctx) ||
+			    blk_mq_direct_issue_request(old_rq, &cookie) != 0)
+				blk_mq_insert_request(old_rq, false, true, true);
  			rcu_read_unlock();
  		} else {
  			srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
+			if (blk_mq_hctx_stopped(data.hctx) ||
+			    blk_mq_direct_issue_request(old_rq, &cookie) != 0)
+				blk_mq_insert_request(old_rq, false, true, true);
  			srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
  		}
  		goto done;

-- 
Jens Axboe
