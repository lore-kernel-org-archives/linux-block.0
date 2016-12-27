Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Mike Christie <mchristi@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH v1 17/54] block: introduce bio_clone_sp()
Date: Tue, 27 Dec 2016 23:56:06 +0800
Message-Id: <1482854250-13481-18-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Firstly bio_clone() and bio_clone_bioset() are changed
to clone mp bvecs because our iterator helpers are capable
of splitting mp bvecs into sp bvecs.

But sometimes we still need cloned bio with singlepage bvecs,
for example, in bio bounce/bcache(bch_data_verify), bvecs of
cloned bio need to be updated.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/bio.c         | 27 +++++++++++++++++++++------
 include/linux/bio.h | 42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 10398969353b..a76ed8a780de 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -630,16 +630,22 @@ EXPORT_SYMBOL(bio_clone_fast);
  * 	@bio_src: bio to clone
  *	@gfp_mask: allocation priority
  *	@bs: bio_set to allocate from
+ *	@sp_bvecs: if clone to singlepage bvecs.
  *
  *	Clone bio. Caller will own the returned bio, but not the actual data it
  *	points to. Reference count of returned bio will be one.
+ *
+ *	If @sp_bvecs is true, the caller must make sure number of singlepage
+ *	bvecs is less than maximum bvec count.
+ *
  */
-struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
-			     struct bio_set *bs)
+struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
+			       struct bio_set *bs, bool sp_bvecs)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	struct bio *bio;
+	unsigned segs;
 
 	/*
 	 * Pre immutable biovecs, __bio_clone() used to just do a memcpy from
@@ -663,7 +669,12 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	 *    __bio_clone_fast() anyways.
 	 */
 
-	bio = bio_alloc_bioset(gfp_mask, bio_segments(bio_src), bs);
+	if (sp_bvecs)
+		segs = bio_segments(bio_src);
+	else
+		segs = bio_segments_mp(bio_src);
+
+	bio = bio_alloc_bioset(gfp_mask, segs, bs);
 	if (!bio)
 		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
@@ -680,8 +691,12 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
 		break;
 	default:
-		bio_for_each_segment(bv, bio_src, iter)
-			bio->bi_io_vec[bio->bi_vcnt++] = bv;
+		if (sp_bvecs)
+			bio_for_each_segment(bv, bio_src, iter)
+				bio->bi_io_vec[bio->bi_vcnt++] = bv;
+		else
+			bio_for_each_segment_mp(bv, bio_src, iter)
+				bio->bi_io_vec[bio->bi_vcnt++] = bv;
 		break;
 	}
 
@@ -699,7 +714,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 
 	return bio;
 }
-EXPORT_SYMBOL(bio_clone_bioset);
+EXPORT_SYMBOL(__bio_clone_bioset);
 
 /**
  *	bio_add_pc_page	-	attempt to add page to bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2bd4e6f2087a..0f2859f96468 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -219,7 +219,7 @@ static inline void bio_advance_iter_mp(struct bio *bio, struct bvec_iter *iter,
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
-static inline unsigned bio_segments(struct bio *bio)
+static inline unsigned __bio_segments(struct bio *bio, bool mp)
 {
 	unsigned segs = 0;
 	struct bio_vec bv;
@@ -241,12 +241,26 @@ static inline unsigned bio_segments(struct bio *bio)
 		break;
 	}
 
-	bio_for_each_segment(bv, bio, iter)
-		segs++;
+	if (!mp)
+		bio_for_each_segment(bv, bio, iter)
+			segs++;
+	else
+		bio_for_each_segment_mp(bv, bio, iter)
+			segs++;
 
 	return segs;
 }
 
+static inline unsigned bio_segments(struct bio *bio)
+{
+	return __bio_segments(bio, false);
+}
+
+static inline unsigned bio_segments_mp(struct bio *bio)
+{
+	return __bio_segments(bio, true);
+}
+
 /*
  * get a reference to a bio, so it won't disappear. the intended use is
  * something like:
@@ -419,10 +433,24 @@ extern void bio_put(struct bio *);
 
 extern void __bio_clone_fast(struct bio *, struct bio *);
 extern struct bio *bio_clone_fast(struct bio *, gfp_t, struct bio_set *);
-extern struct bio *bio_clone_bioset(struct bio *, gfp_t, struct bio_set *bs);
+extern struct bio *__bio_clone_bioset(struct bio *, gfp_t,
+				      struct bio_set *bs, bool);
 
 extern struct bio_set *fs_bio_set;
 
+/* at default we clone bio with multipage bvecs */
+static inline struct bio *bio_clone_bioset(struct bio *bio, gfp_t gfp,
+					   struct bio_set *bs)
+{
+	return __bio_clone_bioset(bio, gfp, bs, false);
+}
+
+static inline struct bio *bio_clone_bioset_sp(struct bio *bio, gfp_t gfp,
+					      struct bio_set *bs)
+{
+	return __bio_clone_bioset(bio, gfp, bs, true);
+}
+
 static inline struct bio *bio_alloc(gfp_t gfp_mask, unsigned int nr_iovecs)
 {
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, fs_bio_set);
@@ -433,6 +461,12 @@ static inline struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
 	return bio_clone_bioset(bio, gfp_mask, fs_bio_set);
 }
 
+/* Sometimes we have to clone one bio with singlepage bvec */
+static inline struct bio *bio_clone_sp(struct bio *bio, gfp_t gfp_mask)
+{
+	return __bio_clone_bioset(bio, gfp_mask, fs_bio_set, true);
+}
+
 static inline struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned int nr_iovecs)
 {
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, NULL);
-- 
2.7.4
