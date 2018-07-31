Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/3] block: don't use bio->bi_vcnt to figure out segment number
Date: Tue, 31 Jul 2018 18:49:12 +0800
Message-Id: <20180731104914.17249-2-ming.lei@redhat.com>
In-Reply-To: <20180731104914.17249-1-ming.lei@redhat.com>
References: <20180731104914.17249-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

It is wrong to use bio->bi_vcnt to figure out how many segments
there are in the bio even though CLONED flag isn't set on this bio,
because this bio may be splitted or advanced.

So always use bio_segments() in blk_recount_segments(), and it shouldn't
cause any performance loss now because the physical segment number is figured
out in blk_queue_split() and BIO_SEG_VALID is set meantime since
bdced438acd83ad83a6c ("block: setup bi_phys_segments after splitting").

Fixes: 7f60dcaaf91 ("block: blk-merge: fix blk_recount_segments()")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index aaec38cc37b8..4a16d4f929da 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -308,13 +308,7 @@ void blk_recalc_rq_segments(struct request *rq)
 
 void blk_recount_segments(struct request_queue *q, struct bio *bio)
 {
-	unsigned short seg_cnt;
-
-	/* estimate segment number by bi_vcnt for non-cloned bio */
-	if (bio_flagged(bio, BIO_CLONED))
-		seg_cnt = bio_segments(bio);
-	else
-		seg_cnt = bio->bi_vcnt;
+	unsigned short seg_cnt = bio_segments(bio);
 
 	if (test_bit(QUEUE_FLAG_NO_SG_MERGE, &q->queue_flags) &&
 			(seg_cnt < queue_max_segments(q)))
-- 
2.9.5
