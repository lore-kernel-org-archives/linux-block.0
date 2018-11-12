Return-Path: <jdelvare@suse.de>
Date: Mon, 12 Nov 2018 10:29:59 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v3] block: copy ioprio in __bio_clone_fast()
Message-ID: <20181112102959.6d2f4984@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.com>

We need to copy the io priority, too; otherwise the clone will run
with a different priority than the original one.

Fixes: 43b62ce3ff0a ("block: move bio io prio to a new field")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Changes since v2:
 * Rebased on kernel v4.20-rc2.

 block/bio.c    |    1 +
 block/bounce.c |    1 +
 2 files changed, 2 insertions(+)

--- linux-4.20-rc2.orig/block/bio.c	2018-11-12 10:00:34.875181186 +0100
+++ linux-4.20-rc2/block/bio.c	2018-11-12 10:00:42.804275169 +0100
@@ -608,6 +608,7 @@ void __bio_clone_fast(struct bio *bio, s
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
+	bio->bi_ioprio = bio_src->bi_ioprio;
 
 	bio_clone_blkcg_association(bio, bio_src);
 }
--- linux-4.20-rc2.orig/block/bounce.c	2018-11-12 09:34:19.478031060 +0100
+++ linux-4.20-rc2/block/bounce.c	2018-11-12 10:04:25.742906302 +0100
@@ -251,6 +251,7 @@ static struct bio *bounce_clone_bio(stru
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
+	bio->bi_ioprio		= bio_src->bi_ioprio;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:


-- 
Jean Delvare
SUSE L3 Support
