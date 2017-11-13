Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 Nov 2017 12:37:03 -0800
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, Kernel-team@fb.com,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] block-throttle: avoid double charge
Message-ID: <20171113203703.GP983427@devbig577.frc2.facebook.com>
References: <aac85300238aec9e310b5092260a6ec6e6f02e04.1507918159.git.shli@fb.com>
 <20171113200338.GK983427@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171113200338.GK983427@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 13, 2017 at 12:03:38PM -0800, Tejun Heo wrote:
> So, one question I have is whether we need both BIO_THROTTLED and
> bi_throttled_disk.  Can't we replace BIO_THROTTLED w/
> bi_throttled_disk?

IOW, won't something like the following work?  (not tested yet)

Thanks.

---
 block/bio.c               |    3 +++
 block/blk-throttle.c      |   20 +++++++-------------
 include/linux/blk_types.h |    4 ++++
 3 files changed, 14 insertions(+), 13 deletions(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -597,6 +597,9 @@ void __bio_clone_fast(struct bio *bio, s
 	 * so we don't set nor calculate new physical/hw segment counts here
 	 */
 	bio->bi_disk = bio_src->bi_disk;
+#ifdef CONFIG_BLK_DEV_THROTTLING
+	bio->bi_throttled_disk = bio_src->bi_throttled_disk;
+#endif
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_write_hint = bio_src->bi_write_hint;
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1051,13 +1051,12 @@ static void throtl_charge_bio(struct thr
 	tg->last_io_disp[rw]++;
 
 	/*
-	 * BIO_THROTTLED is used to prevent the same bio to be throttled
+	 * bi_throttled_disk is used to prevent the same bio to be throttled
 	 * more than once as a throttled bio will go through blk-throtl the
 	 * second time when it eventually gets issued.  Set it when a bio
 	 * is being charged to a tg.
 	 */
-	if (!bio_flagged(bio, BIO_THROTTLED))
-		bio_set_flag(bio, BIO_THROTTLED);
+	bio->bi_throttled_disk = bio->bi_disk;
 }
 
 /**
@@ -2131,8 +2130,11 @@ bool blk_throtl_bio(struct request_queue
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	/* see throtl_charge_bio() */
-	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
+	/*
+	 * See throtl_charge_bio().  If a bio is throttled against a disk
+	 * but remapped to other disk, we should throttle it again
+	 */
+	if (bio->bi_throttled_disk == bio->bi_disk || !tg->has_rules[rw])
 		goto out;
 
 	spin_lock_irq(q->queue_lock);
@@ -2223,14 +2225,6 @@ again:
 out_unlock:
 	spin_unlock_irq(q->queue_lock);
 out:
-	/*
-	 * As multiple blk-throtls may stack in the same issue path, we
-	 * don't want bios to leave with the flag set.  Clear the flag if
-	 * being issued.
-	 */
-	if (!throttled)
-		bio_clear_flag(bio, BIO_THROTTLED);
-
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
 		bio->bi_issue_stat.stat |= SKIP_LATENCY;
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -90,6 +90,10 @@ struct bio {
 	void			*bi_cg_private;
 	struct blk_issue_stat	bi_issue_stat;
 #endif
+#ifdef CONFIG_BLK_DEV_THROTTLING
+	/* record which disk the bio is throttled against */
+	struct gendisk		*bi_throttled_disk;
+#endif
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
