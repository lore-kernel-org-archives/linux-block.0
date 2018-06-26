Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Simplify the bio cloning implementation
Date: Tue, 26 Jun 2018 15:26:24 -0700
Message-Id: <20180626222624.11739-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

There is no good reason to use different code paths for different
request operations. Hence remove the switch/case statement from
bio_clone_bioset().

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f7e3d88bd0b6..4c27cc9ea55e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -691,19 +691,8 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
-	case REQ_OP_WRITE_ZEROES:
-		break;
-	case REQ_OP_WRITE_SAME:
-		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
-		break;
-	default:
-		bio_for_each_segment(bv, bio_src, iter)
-			bio->bi_io_vec[bio->bi_vcnt++] = bv;
-		break;
-	}
+	bio_for_each_segment(bv, bio_src, iter)
+		bio->bi_io_vec[bio->bi_vcnt++] = bv;
 
 	if (bio_integrity(bio_src)) {
 		int ret;
-- 
2.17.1
