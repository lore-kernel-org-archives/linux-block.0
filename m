Return-Path: <axboe@kernel.dk>
Date: Tue, 9 Jan 2018 08:29:56 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: fix kernel oops in blk_mq_tag_idle()
Message-ID: <20180109152954.GA5512@kernel.dk>
References: <20180109132829.31479-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180109132829.31479-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 09 2018, Ming Lei wrote:
> HW queues may be unmapped in some cases, such as blk_mq_update_nr_hw_queues(),
> then we need to check it before calling blk_mq_tag_idle(), otherwise
> the following kernel oops can be triggered, so fix it by checking if
> the hw queue is unmapped since it doesn't make sense to idle the tags
> any more after hw queues are unmapped.

Seems cleaner to just move the mapped check to the idling function,
especially since we already have the same check in the other spot where
we call the idling.


diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..10e7e1ef8297 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -63,6 +63,8 @@ static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
+	if (!blk_mq_hw_queue_mapped(hctx))
+		return;
 	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED))
 		return;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 111e1aa5562f..4d9f79bfdca2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -873,11 +873,8 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	} else {
 		struct blk_mq_hw_ctx *hctx;
 
-		queue_for_each_hw_ctx(q, hctx, i) {
-			/* the hctx may be unmapped, so check it here */
-			if (blk_mq_hw_queue_mapped(hctx))
-				blk_mq_tag_idle(hctx);
-		}
+		queue_for_each_hw_ctx(q, hctx, i)
+			blk_mq_tag_idle(hctx);
 	}
 	blk_queue_exit(q);
 }

-- 
Jens Axboe
