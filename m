Return-Path: <BATV+bdb09ad5f0bc9ee27162+5405+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/6] bcache: clean up bio reuse for struct moving_io
Date: Mon, 11 Jun 2018 21:48:03 +0200
Message-Id: <20180611194806.13222-4-hch@lst.de>
In-Reply-To: <20180611194806.13222-1-hch@lst.de>
References: <20180611194806.13222-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Instead of reinitializing the bio everytime we can call bio_reuse when
reusing it.  Also removes the remainder of the moving_init helper
to improve readability.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/movinggc.c | 40 +++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index a24c3a95b2c0..e59bc04c3d74 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -74,29 +74,20 @@ static void read_moving_endio(struct bio *bio)
 	bch_bbio_endio(io->op.c, bio, bio->bi_status, "reading data to move");
 }
 
-static void moving_init(struct moving_io *io)
-{
-	struct bio *bio = &io->bio.bio;
-
-	bio_init(bio, bio->bi_inline_vecs,
-		 DIV_ROUND_UP(KEY_SIZE(&io->w->key), PAGE_SECTORS));
-	bio_get(bio);
-	bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
-
-	bio->bi_iter.bi_size	= KEY_SIZE(&io->w->key) << 9;
-	bio->bi_private		= &io->cl;
-	bch_bio_map(bio, NULL);
-}
-
 static void write_moving(struct closure *cl)
 {
 	struct moving_io *io = container_of(cl, struct moving_io, cl);
 	struct data_insert_op *op = &io->op;
 
 	if (!op->status) {
-		moving_init(io);
+		struct bio *bio = &io->bio.bio;
+
+		bio_reuse(bio);
+		bio_get(bio);
+		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
+		bio->bi_private = &io->cl;
+		bio->bi_iter.bi_sector = KEY_START(&io->w->key);
 
-		io->bio.bio.bi_iter.bi_sector = KEY_START(&io->w->key);
 		op->write_prio		= 1;
 		op->bio			= &io->bio.bio;
 
@@ -156,12 +147,19 @@ static void read_moving(struct cache_set *c)
 		io->op.c	= c;
 		io->op.wq	= c->moving_gc_wq;
 
-		moving_init(io);
 		bio = &io->bio.bio;
-
-		bio_set_op_attrs(bio, REQ_OP_READ, 0);
-		bio->bi_end_io	= read_moving_endio;
-
+		bio_init(bio, bio->bi_inline_vecs,
+			DIV_ROUND_UP(KEY_SIZE(&io->w->key), PAGE_SECTORS));
+		bio_get(bio);
+
+		bio->bi_iter.bi_size = KEY_SIZE(&io->w->key) << 9;
+		bio->bi_iter.bi_sector = KEY_START(&io->w->key);
+		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
+		bio->bi_private = &io->cl;
+		bio->bi_end_io = read_moving_endio;
+
+		bch_bio_map(bio, NULL);
 		if (bch_bio_alloc_pages(bio, GFP_KERNEL))
 			goto err;
 
-- 
2.17.1
