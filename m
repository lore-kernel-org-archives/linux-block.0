Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 24/54] blk-merge: compute bio->bi_seg_front_size efficiently
Date: Tue, 27 Dec 2016 23:56:13 +0800
Message-Id: <1482854250-13481-25-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

It is enough to check and compute bio->bi_seg_front_size just
after the 1st segment is found, but current code checks that
for each bvec, which is inefficient.

This patch follows the way in  __blk_recalc_rq_segments()
for computing bio->bi_seg_front_size, and it is more efficient
and code becomes more readable too.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-merge.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 182398cb1524..e3abc835e4b7 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -153,22 +153,21 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			bvprvp = &bvprv;
 			sectors += bv.bv_len >> 9;
 
-			if (nsegs == 1 && seg_size > front_seg_size)
-				front_seg_size = seg_size;
 			continue;
 		}
 new_segment:
 		if (nsegs == queue_max_segments(q))
 			goto split;
 
+		if (nsegs == 1 && seg_size > front_seg_size)
+			front_seg_size = seg_size;
+
 		nsegs++;
 		bvprv = bv;
 		bvprvp = &bvprv;
 		seg_size = bv.bv_len;
 		sectors += bv.bv_len >> 9;
 
-		if (nsegs == 1 && seg_size > front_seg_size)
-			front_seg_size = seg_size;
 	}
 
 	do_split = false;
@@ -181,6 +180,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			bio = new;
 	}
 
+	if (nsegs == 1 && seg_size > front_seg_size)
+		front_seg_size = seg_size;
 	bio->bi_seg_front_size = front_seg_size;
 	if (seg_size > bio->bi_seg_back_size)
 		bio->bi_seg_back_size = seg_size;
-- 
2.7.4
