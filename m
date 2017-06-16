Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
 <20170616073339.GC8682@infradead.org>
 <0ac0bb7e-ce8d-cb63-985c-ab2d1f3402f1@kernel.dk>
 <20170616155206.GB27209@infradead.org>
 <ed334779-20b6-3fef-d66d-cd63a493a92f@kernel.dk>
Message-ID: <943e8057-bb9a-5c92-16cf-4d5ee6979586@kernel.dk>
Date: Fri, 16 Jun 2017 10:14:01 -0600
MIME-Version: 1.0
In-Reply-To: <ed334779-20b6-3fef-d66d-cd63a493a92f@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 09:59 AM, Jens Axboe wrote:
> On 06/16/2017 09:52 AM, Christoph Hellwig wrote:
>> On Fri, Jun 16, 2017 at 08:35:07AM -0600, Jens Axboe wrote:
>>>> Agreed.  In fact I'd go a little further:  we should have a
>>>>
>>>> 	u16 hints;
>>>>
>>>> that goes all the way down from fcntl to the driver, right now
>>>> we'll allocate the first 3 bits for the write lifetime hints (2.5,
>>>> so we have one value spare, as they don't need to flags but can be
>>>> enum values), leaving more space for other kinds of hints.
>>>
>>> Did you see v5? It adds enum write_hint and passes it all the way down,
>>> until we transform them into rq/bio flags.
>>
>> Yes.  But with all the way down I mean all the way down to the driver :)
> 
> Only missing part is the request flags. And why make that any different
> than the flags we already have now? It'd be trivial to pack the value
> into the request flags as well, but I'm struggling to see the point of
> that, honestly.
> 
> Please expand on why you think changing the request flags to also
> carry that value would be useful, as opposed to just mapping it when
> we setup the request. If you have a valid concern I don't mind making
> the change, but I just don't see one right now.

So that would look like the below change on top of the current v5. I
skipped the callers, since those are all easy
s/bio_op_write_hint/write_hint_to_opf changes.


diff --git a/block/bio.c b/block/bio.c
index 758d83d91bb0..888e7801c638 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2082,22 +2082,6 @@ void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
 
 #endif /* CONFIG_BLK_CGROUP */
 
-static const unsigned int rwf_write_to_opf_flag[] = {
-	0, REQ_WRITE_SHORT, REQ_WRITE_MEDIUM, REQ_WRITE_LONG, REQ_WRITE_EXTREME
-};
-
-/*
- * Convert WRITE_LIFE_* hints into req/bio flags
- */
-unsigned int bio_op_write_hint(enum write_hint hint)
-{
-	if (WARN_ON_ONCE(hint >= ARRAY_SIZE(rwf_write_to_opf_flag)))
-		return 0;
-
-	return rwf_write_to_opf_flag[hint];
-}
-EXPORT_SYMBOL_GPL(bio_op_write_hint);
-
 static void __init biovec_init_slabs(void)
 {
 	int i;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index e9360dc5ea07..d1b04b0e99cf 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -443,7 +443,6 @@ extern struct bio *bio_copy_kern(struct request_queue *, void *, unsigned int,
 				 gfp_t, int);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
-extern unsigned int bio_op_write_hint(enum write_hint hint);
 
 void generic_start_io_acct(int rw, unsigned long sectors,
 			   struct hd_struct *part);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 23646eb433e7..f4d348cd3a6b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/bvec.h>
+#include <linux/fs.h>
 
 struct bio_set;
 struct bio;
@@ -201,10 +202,9 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
-	__REQ_WRITE_SHORT,	/* short life time write */
-	__REQ_WRITE_MEDIUM,	/* medium life time write */
-	__REQ_WRITE_LONG,	/* long life time write */
-	__REQ_WRITE_EXTREME,	/* extremely long life time write */
+	__REQ_WRITE_HINT_SHIFT,	/* 3 bits for life time hint */
+	__REQ_WRITE_HINT_PAD1,
+	__REQ_WRITE_HINT_PAD2,
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -225,13 +225,12 @@ enum req_flag_bits {
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
-#define REQ_WRITE_SHORT		(1ULL << __REQ_WRITE_SHORT)
-#define REQ_WRITE_MEDIUM	(1ULL << __REQ_WRITE_MEDIUM)
-#define REQ_WRITE_LONG		(1ULL << __REQ_WRITE_LONG)
-#define REQ_WRITE_EXTREME	(1ULL << __REQ_WRITE_EXTREME)
+#define REQ_WRITE_SHORT		(WRITE_HINT_SHORT << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_MEDIUM	(WRITE_HINT_MEDIUM << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_LONG		(WRITE_HINT_LONG << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_EXTREME	(WRITE_HINT_EXTREME << __REQ_WRITE_HINT_SHIFT)
 
-#define REQ_WRITE_LIFE_MASK	(REQ_WRITE_SHORT | REQ_WRITE_MEDIUM | \
-					REQ_WRITE_LONG | REQ_WRITE_EXTREME)
+#define REQ_WRITE_LIFE_MASK	(0x7 << __REQ_WRITE_HINT_SHIFT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
@@ -328,4 +327,9 @@ static inline bool op_write_hint_valid(unsigned int opf)
 	return (opf & REQ_WRITE_LIFE_MASK) != 0;
 }
 
+static inline unsigned int write_hint_to_opf(enum write_hint hint)
+{
+	return hint << __REQ_WRITE_HINT_SHIFT;
+}
+
 #endif /* __LINUX_BLK_TYPES_H */


-- 
Jens Axboe
