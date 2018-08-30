Return-Path: <ming.lei@redhat.com>
Date: Thu, 30 Aug 2018 19:24:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	linux-block@vger.kernel.org
Subject: Re: bvec_iter rewind API
Message-ID: <20180830112414.GA8186@ming.t460p>
References: <20180828233325.GA32495@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180828233325.GA32495@kmo-pixel>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 28, 2018 at 07:33:25PM -0400, Kent Overstreet wrote:
> I just came across bi_done and your patch that added it -
> f9df1cd99e bio: add bvec_iter rewind API
> 
> I invite you to think through what happens to a bio that gets split by something
> further down the stack, and then rewound after completion:
> 
> To create the first half of the split, you just truncate the iterator by setting
> bio->bi_iter.bi_size to be the length you want. So if the original bio becomes
> the first half of the split, we've lost the original value for bi_size. After
> completion, bio_rewind_iter will rewind the bio to the start position the
> original code expects, but the bio will _not_ have the same size as it did when
> that code submitted it.
> 
> So if bio_rewind_iter() is being used because we want to restore the bio to what
> it was when we submitted it, this is bogus.
> 
> To create the second half of the split, we just advance the bio's iterator up to
> where we want the split to start. So this shouldn't prevent us from restoring
> the bio to the state it was in when it was created by rewinding it.
> 
> Except if you look at bio_split(), it sets bi_done to 0, and git blame reveals
> an interesting commit message...
> 
>     block: reset bi_iter.bi_done after splitting bio
>     
>     After the bio has been updated to represent the remaining sectors, reset
>     bi_done so bio_rewind_iter() does not rewind further than it should.
>     
>     This resolves a bio_integrity_process() failure on reads where the
>     original request was split.
> 
> *sigh*
> 
> The original code was bogus, and so was the fix. If a bio is split _AFTER_ a
> chunk of code in the stack sees it - and wants to restore it to the state it was
> it when it saw it after it completes - then not touching bi_done gives us the
> result we want. But if the bio was split _BEFORE_ that chunk of code sees it,
> rewinding it without ever touching bi_done will rewind it to be _LARGER_ than
> the bio that chunk of code saw.
> 
> So what should bi_done be? There is no correct answer - fundamentally, bi_done
> _cannot_ do what you're trying to do with it. Advancing or truncating an
> iterator destroys information, and stacked layers can manipulate bio iterators
> in arbitrary ways.
> 
> The correct way, the ONLY way, to restore a bio's iterator to a previous state
> after it's been submitted and other code has messed with it, is to save the
> entire iterator state: before you submit the bio, you save a copy of
> bio->bi_iter in your driver's private state, and then you restore it after
> completion.

I agree, and it isn't good to introduce extra update of .bi_done in fast path
too, and it just makes things complicated in concept.

Maybe we can do the following way, and looks it works in scsi_debug/dix
test.

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 67b5fb861a51..839c332069a9 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -306,6 +306,8 @@ bool bio_integrity_prep(struct bio *bio)
 	if (bio_data_dir(bio) == WRITE) {
 		bio_integrity_process(bio, &bio->bi_iter,
 				      bi->profile->generate_fn);
+	} else {
+		bip->bio_iter = bio->bi_iter;
 	}
 	return true;
 
@@ -331,19 +333,13 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 		container_of(work, struct bio_integrity_payload, bip_work);
 	struct bio *bio = bip->bip_bio;
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
-	struct bvec_iter iter = bio->bi_iter;
 
 	/*
 	 * At the moment verify is called bio's iterator was advanced
 	 * during split and completion, we need to rewind iterator to
 	 * it's original position.
 	 */
-	if (bio_rewind_iter(bio, &iter, iter.bi_done)) {
-		bio->bi_status = bio_integrity_process(bio, &iter,
-						       bi->profile->verify_fn);
-	} else {
-		bio->bi_status = BLK_STS_IOERR;
-	}
+	bio->bi_status = bio_integrity_process(bio, &bip->bio_iter, bi->profile->verify_fn);
 
 	bio_integrity_free(bio);
 	bio_endio(bio);
diff --git a/block/bio.c b/block/bio.c
index b12966e415d3..529c1a65b1e8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -283,6 +283,8 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
 
+	WARN_ON(max_vecs > UIO_MAXIOV);
+
 	bio->bi_io_vec = table;
 	bio->bi_max_vecs = max_vecs;
 }
@@ -1807,7 +1809,6 @@ struct bio *bio_split(struct bio *bio, int sectors,
 		bio_integrity_trim(split);
 
 	bio_advance(bio, split->bi_iter.bi_size);
-	bio->bi_iter.bi_done = 0;
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 51371740d2a8..14b4fa266357 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -170,27 +170,11 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio)) {
+	if (bio_no_advance_iter(bio))
 		iter->bi_size -= bytes;
-		iter->bi_done += bytes;
-	} else {
+	else
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
-	}
-}
-
-static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
-		unsigned int bytes)
-{
-	iter->bi_sector -= bytes >> 9;
-
-	if (bio_no_advance_iter(bio)) {
-		iter->bi_size += bytes;
-		iter->bi_done -= bytes;
-		return true;
-	}
-
-	return bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
 }
 
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
@@ -353,6 +337,8 @@ struct bio_integrity_payload {
 	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
 	unsigned short		bip_flags;	/* control flags */
 
+	struct bvec_iter	bio_iter;	/* for rewinding parent bio */
+
 	struct work_struct	bip_work;	/* I/O completion */
 
 	struct bio_vec		*bip_vec;
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index fe7a22dd133b..5ebfd0500fe7 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -38,11 +38,8 @@ struct bvec_iter {
 						   sectors */
 	unsigned int		bi_size;	/* residual I/O count */
 
-	unsigned int		bi_idx;		/* current index into bvl_vec */
-
-	unsigned int            bi_done;	/* number of bytes completed */
-
-	unsigned int            bi_bvec_done;	/* number of bytes completed in
+	unsigned int		bi_idx:10;	/* current index into bvl_vec */
+	unsigned int            bi_bvec_done:22;	/* number of bytes completed in
 						   current bvec */
 };
 
@@ -85,7 +82,6 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		bytes -= len;
 		iter->bi_size -= len;
 		iter->bi_bvec_done += len;
-		iter->bi_done += len;
 
 		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
 			iter->bi_bvec_done = 0;
@@ -95,30 +91,6 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	return true;
 }
 
-static inline bool bvec_iter_rewind(const struct bio_vec *bv,
-				     struct bvec_iter *iter,
-				     unsigned int bytes)
-{
-	while (bytes) {
-		unsigned len = min(bytes, iter->bi_bvec_done);
-
-		if (iter->bi_bvec_done == 0) {
-			if (WARN_ONCE(iter->bi_idx == 0,
-				      "Attempted to rewind iter beyond "
-				      "bvec's boundaries\n")) {
-				return false;
-			}
-			iter->bi_idx--;
-			iter->bi_bvec_done = __bvec_iter_bvec(bv, *iter)->bv_len;
-			continue;
-		}
-		bytes -= len;
-		iter->bi_size += len;
-		iter->bi_bvec_done -= len;
-	}
-	return true;
-}
-
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
Thanks,
Ming
