Return-Path: <BATV+1e44ea8f521110dda36c+5407+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/6] bcache: don't clone bio in bch_data_verify
Date: Wed, 13 Jun 2018 15:51:57 +0200
Message-Id: <20180613135158.29477-6-hch@lst.de>
In-Reply-To: <20180613135158.29477-1-hch@lst.de>
References: <20180613135158.29477-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We immediately overwrite the biovec array, so instead just allocate
a new bio and copy over the disk, setor and size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index d030ce3025a6..04d146711950 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -110,11 +110,15 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 	struct bio_vec bv, cbv;
 	struct bvec_iter iter, citer = { 0 };
 
-	check = bio_clone_kmalloc(bio, GFP_NOIO);
+	check = bio_kmalloc(GFP_NOIO, bio_segments(bio));
 	if (!check)
 		return;
+	check->bi_disk = bio->bi_disk;
 	check->bi_opf = REQ_OP_READ;
+	check->bi_iter.bi_sector = bio->bi_iter.bi_sector;
+	check->bi_iter.bi_size = bio->bi_iter.bi_size;
 
+	bch_bio_map(check, NULL);
 	if (bch_bio_alloc_pages(check, GFP_NOIO))
 		goto out_put;
 
-- 
2.17.1
