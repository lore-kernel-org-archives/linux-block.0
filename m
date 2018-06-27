Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
Date: Wed, 27 Jun 2018 13:12:31 -0700
Message-Id: <20180627201231.15641-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Although __bio_clone_fast() copies bi_io_vec, it does not copy bi_vcnt,
the number of elements in bi_io_vec[] that contains data. Copy bi_vcnt
such that code that needs this member behaves identically for original
and for cloned requests.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index f7e3d88bd0b6..55f8e0dedd69 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -605,6 +605,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_vcnt = bio_src->bi_vcnt;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	bio_clone_blkcg_association(bio, bio_src);
-- 
2.17.1
