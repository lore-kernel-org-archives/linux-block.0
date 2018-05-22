Return-Path: <prvs=673874c89=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH] Revert "block: Add warning for bi_next not NULL in bio_endio()"
Date: Tue, 22 May 2018 16:55:05 -0700
Message-Id: <20180522235505.20937-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch avoids that KASAN reports the following complaint when
running the srp-test software:

BUG: KASAN: use-after-free in bio_advance+0x110/0x1b0
Read of size 4 at addr ffff88014c7aa950 by task ksoftirqd/10/72
Call Trace:
dump_stack+0x9a/0xeb
print_address_description+0x65/0x270
kasan_report+0x232/0x350
bio_advance+0x110/0x1b0
blk_update_request+0x9d/0x5a0
scsi_end_request+0x4c/0x300 [scsi_mod]
scsi_io_completion+0x71e/0xa40 [scsi_mod]
__blk_mq_complete_request+0x13e/0x220
srp_recv_done+0x454/0x1100 [ib_srp]
__ib_process_cq+0x9a/0xf0 [ib_core]
ib_poll_handler+0x2d/0x90 [ib_core]
irq_poll_softirq+0xe5/0x1e0
__do_softirq+0x112/0x5f0
run_ksoftirqd+0x29/0x50
smpboot_thread_fn+0x30f/0x410
kthread+0x1b2/0x1d0
ret_from_fork+0x24/0x30

This reverts commit 0ba99ca4838bc75481a4bf0e70bad20b0a5457c7.

Fixes: commit 45db54d58de0 ("block: Split out bio_list_copy_data()")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c      | 3 ---
 block/blk-core.c | 8 +-------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0a4df92cd689..e22ebab450f8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1777,9 +1777,6 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
-	if (WARN_ONCE(bio->bi_next, "driver left bi_next not NULL"))
-		bio->bi_next = NULL;
-
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
diff --git a/block/blk-core.c b/block/blk-core.c
index a216b8b137f4..4d69f91a6431 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -277,10 +277,6 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 	bio_advance(bio, nbytes);
 
 	/* don't actually finish bio if it's part of flush sequence */
-	/*
-	 * XXX this code looks suspicious - it's not consistent with advancing
-	 * req->bio in caller
-	 */
 	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
 		bio_endio(bio);
 }
@@ -3115,10 +3111,8 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		struct bio *bio = req->bio;
 		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
 
-		if (bio_bytes == bio->bi_iter.bi_size) {
+		if (bio_bytes == bio->bi_iter.bi_size)
 			req->bio = bio->bi_next;
-			bio->bi_next = NULL;
-		}
 
 		/* Completion has already been traced */
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
-- 
2.16.3
