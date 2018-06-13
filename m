Return-Path: <BATV+1e44ea8f521110dda36c+5407+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/6] bcache: clean up bio reuse for struct dirty_io
Date: Wed, 13 Jun 2018 15:51:56 +0200
Message-Id: <20180613135158.29477-5-hch@lst.de>
In-Reply-To: <20180613135158.29477-1-hch@lst.de>
References: <20180613135158.29477-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Instead of reinitializing the bio everytime we can call bio_reuse when
reusing it.  Also moves the private data initialization out of
dirty_init, which is renamed to suit the remaining functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/writeback.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index ad45ebe1a74b..0b6d07eab87c 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -179,19 +179,12 @@ struct dirty_io {
 	struct bio		bio;
 };
 
-static void dirty_init(struct keybuf_key *w)
+static void dirty_init_prio(struct keybuf_key *w)
 {
 	struct dirty_io *io = w->private;
-	struct bio *bio = &io->bio;
 
-	bio_init(bio, bio->bi_inline_vecs,
-		 DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS));
 	if (!io->dc->writeback_percent)
-		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
-
-	bio->bi_iter.bi_size	= KEY_SIZE(&w->key) << 9;
-	bio->bi_private		= w;
-	bch_bio_map(bio, NULL);
+		bio_set_prio(&io->bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
 }
 
 static void dirty_io_destructor(struct closure *cl)
@@ -285,10 +278,12 @@ static void write_dirty(struct closure *cl)
 	 * to clean up.
 	 */
 	if (KEY_DIRTY(&w->key)) {
-		dirty_init(w);
-		bio_set_op_attrs(&io->bio, REQ_OP_WRITE, 0);
+		bio_reuse(&io->bio, KEY_SIZE(&w->key) << 9);
+		dirty_init_prio(w);
+		io->bio.bi_opf = REQ_OP_WRITE;
 		io->bio.bi_iter.bi_sector = KEY_START(&w->key);
 		bio_set_dev(&io->bio, io->dc->bdev);
+		io->bio.bi_private	= w;
 		io->bio.bi_end_io	= dirty_endio;
 
 		/* I/O request sent to backing device */
@@ -399,13 +394,18 @@ static void read_dirty(struct cached_dev *dc)
 			io->dc		= dc;
 			io->sequence    = sequence++;
 
-			dirty_init(w);
-			bio_set_op_attrs(&io->bio, REQ_OP_READ, 0);
+			bio_init(&io->bio, io->bio.bi_inline_vecs,
+				DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS));
+			dirty_init_prio(w);
+			io->bio.bi_opf = REQ_OP_READ;
+			io->bio.bi_iter.bi_size = KEY_SIZE(&w->key) << 9;
 			io->bio.bi_iter.bi_sector = PTR_OFFSET(&w->key, 0);
 			bio_set_dev(&io->bio,
 				    PTR_CACHE(dc->disk.c, &w->key, 0)->bdev);
+			io->bio.bi_private	= w;
 			io->bio.bi_end_io	= read_dirty_endio;
 
+			bch_bio_map(&io->bio, NULL);
 			if (bch_bio_alloc_pages(&io->bio, GFP_KERNEL))
 				goto err_free;
 
-- 
2.17.1
