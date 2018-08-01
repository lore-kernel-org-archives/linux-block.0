Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: copy ioprio in __bio_clone_fast()
Date: Wed,  1 Aug 2018 16:38:09 +0200
Message-Id: <20180801143809.5472-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

We need to copy the io priority, too; otherwise the clone will run
with a different priority than the original one.

Fixes: 43b62ce3ff0a ("block: move bio io prio to a new field")
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 8ecc95615941..88129f20623d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -608,6 +608,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
+	bio->bi_ioprio = bio_src->bi_ioprio;
 
 	bio_clone_blkcg_association(bio, bio_src);
 }
@@ -692,6 +693,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
+	bio->bi_ioprio		= bio_src->bi_ioprio;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
-- 
2.12.3
