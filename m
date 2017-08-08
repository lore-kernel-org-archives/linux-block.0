Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 21/49] blk-merge: compute bio->bi_seg_front_size efficiently
Date: Tue,  8 Aug 2017 16:45:20 +0800
Message-Id: <20170808084548.18963-22-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

It is enough to check and compute bio->bi_seg_front_size just
after the 1st segment is found, but current code checks that
for each bvec, which is inefficient.

This patch follows the way in  __blk_recalc_rq_segments()
for computing bio->bi_seg_front_size, and it is more efficient
and code becomes more readable too.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 99038830fb42..d91f07813dee 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -145,22 +145,21 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
@@ -173,6 +172,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			bio = new;
 	}
 
+	if (nsegs == 1 && seg_size > front_seg_size)
+		front_seg_size = seg_size;
 	bio->bi_seg_front_size = front_seg_size;
 	if (seg_size > bio->bi_seg_back_size)
 		bio->bi_seg_back_size = seg_size;
-- 
2.9.4
