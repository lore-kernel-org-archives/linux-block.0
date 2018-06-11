Return-Path: <BATV+bdb09ad5f0bc9ee27162+5405+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/6] bcache: use bio_reuse instead of bio_reinit where applicable
Date: Mon, 11 Jun 2018 21:48:02 +0200
Message-Id: <20180611194806.13222-3-hch@lst.de>
In-Reply-To: <20180611194806.13222-1-hch@lst.de>
References: <20180611194806.13222-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Use the bio_reuse helper instead of rebuilding the bio_vecs and
size for bios that get reused for the same data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/request.c | 5 +----
 drivers/md/bcache/super.c   | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index ae67f5fa8047..cd2505b9bee9 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -810,12 +810,9 @@ static void cached_dev_read_done(struct closure *cl)
 	 */
 
 	if (s->iop.bio) {
-		bio_reset(s->iop.bio);
+		bio_reuse(s->iop.bio);
 		s->iop.bio->bi_iter.bi_sector = s->cache_miss->bi_iter.bi_sector;
 		bio_copy_dev(s->iop.bio, s->cache_miss);
-		s->iop.bio->bi_iter.bi_size = s->insert_bio_sectors << 9;
-		bch_bio_map(s->iop.bio, NULL);
-
 		bio_copy_data(s->cache_miss, s->iop.bio);
 
 		bio_put(s->cache_miss);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a31e55bcc4e5..cd27eabbab24 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -205,9 +205,7 @@ static void __write_super(struct cache_sb *sb, struct bio *bio)
 	unsigned i;
 
 	bio->bi_iter.bi_sector	= SB_SECTOR;
-	bio->bi_iter.bi_size	= SB_SIZE;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC|REQ_META);
-	bch_bio_map(bio, NULL);
 
 	out->offset		= cpu_to_le64(sb->offset);
 	out->version		= cpu_to_le64(sb->version);
@@ -249,7 +247,7 @@ void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent)
 	down(&dc->sb_write_mutex);
 	closure_init(cl, parent);
 
-	bio_reset(bio);
+	bio_reuse(bio);
 	bio_set_dev(bio, dc->bdev);
 	bio->bi_end_io	= write_bdev_super_endio;
 	bio->bi_private = dc;
@@ -298,7 +296,7 @@ void bcache_write_super(struct cache_set *c)
 
 		SET_CACHE_SYNC(&ca->sb, CACHE_SYNC(&c->sb));
 
-		bio_reset(bio);
+		bio_reuse(bio);
 		bio_set_dev(bio, ca->bdev);
 		bio->bi_end_io	= write_super_endio;
 		bio->bi_private = ca;
-- 
2.17.1
