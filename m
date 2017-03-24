Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41801 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753960AbdCXRzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 13:55:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2OHqur5026919
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 10:55:16 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 29d7g5r81u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 10:55:15 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.222.219.45) with ESMTP id
 083313ac10bb11e78ffb24be05904660-54af09a0 for <linux-block@vger.kernel.org>;
        Fri, 24 Mar 2017 10:55:14 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] block: remove bio_clone_bioset_partial()
Date: Fri, 24 Mar 2017 10:55:13 -0700
Message-ID: <99da2cea22d37790b5ca93f07da3b16f890d16c2.1490377861.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

commit c18a1e0(block: introduce bio_clone_bioset_partial()) introduced
bio_clone_bioset_partial() for raid1 write behind IO. Now the write behind is
rewritten by Ming. We don't need the API any more, so revert the commit.

Jens,
this depends on Ming's patches, so it would be great I put this to md branch.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c         | 61 ++++++++++++-----------------------------------------
 include/linux/bio.h | 11 ++--------
 2 files changed, 15 insertions(+), 57 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1ccff0d..0364359 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -631,20 +631,21 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
-static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
-				      struct bio_set *bs, int offset,
-				      int size)
+/**
+ * 	bio_clone_bioset - clone a bio
+ * 	@bio_src: bio to clone
+ *	@gfp_mask: allocation priority
+ *	@bs: bio_set to allocate from
+ *
+ *	Clone bio. Caller will own the returned bio, but not the actual data it
+ *	points to. Reference count of returned bio will be one.
+ */
+struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
+			     struct bio_set *bs)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	struct bio *bio;
-	struct bvec_iter iter_src = bio_src->bi_iter;
-
-	/* for supporting partial clone */
-	if (offset || size != bio_src->bi_iter.bi_size) {
-		bio_advance_iter(bio_src, &iter_src, offset);
-		iter_src.bi_size = size;
-	}
 
 	/*
 	 * Pre immutable biovecs, __bio_clone() used to just do a memcpy from
@@ -668,8 +669,7 @@ static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	 *    __bio_clone_fast() anyways.
 	 */
 
-	bio = bio_alloc_bioset(gfp_mask, __bio_segments(bio_src,
-			       &iter_src), bs);
+	bio = bio_alloc_bioset(gfp_mask, bio_segments(bio_src), bs);
 	if (!bio)
 		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
@@ -686,7 +686,7 @@ static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
 		break;
 	default:
-		__bio_for_each_segment(bv, bio_src, iter, iter_src)
+		bio_for_each_segment(bv, bio_src, iter)
 			bio->bi_io_vec[bio->bi_vcnt++] = bv;
 		break;
 	}
@@ -705,44 +705,9 @@ static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 
 	return bio;
 }
-
-/**
- * 	bio_clone_bioset - clone a bio
- * 	@bio_src: bio to clone
- *	@gfp_mask: allocation priority
- *	@bs: bio_set to allocate from
- *
- *	Clone bio. Caller will own the returned bio, but not the actual data it
- *	points to. Reference count of returned bio will be one.
- */
-struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
-			     struct bio_set *bs)
-{
-	return __bio_clone_bioset(bio_src, gfp_mask, bs, 0,
-				  bio_src->bi_iter.bi_size);
-}
 EXPORT_SYMBOL(bio_clone_bioset);
 
 /**
- * 	bio_clone_bioset_partial - clone a partial bio
- * 	@bio_src: bio to clone
- *	@gfp_mask: allocation priority
- *	@bs: bio_set to allocate from
- *	@offset: cloned starting from the offset
- *	@size: size for the cloned bio
- *
- *	Clone bio. Caller will own the returned bio, but not the actual data it
- *	points to. Reference count of returned bio will be one.
- */
-struct bio *bio_clone_bioset_partial(struct bio *bio_src, gfp_t gfp_mask,
-				     struct bio_set *bs, int offset,
-				     int size)
-{
-	return __bio_clone_bioset(bio_src, gfp_mask, bs, offset, size);
-}
-EXPORT_SYMBOL(bio_clone_bioset_partial);
-
-/**
  *	bio_add_pc_page	-	attempt to add page to bio
  *	@q: the target queue
  *	@bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 42b62a0..fafef63 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -183,7 +183,7 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
-static inline unsigned __bio_segments(struct bio *bio, struct bvec_iter *bvec)
+static inline unsigned bio_segments(struct bio *bio)
 {
 	unsigned segs = 0;
 	struct bio_vec bv;
@@ -205,17 +205,12 @@ static inline unsigned __bio_segments(struct bio *bio, struct bvec_iter *bvec)
 		break;
 	}
 
-	__bio_for_each_segment(bv, bio, iter, *bvec)
+	bio_for_each_segment(bv, bio, iter)
 		segs++;
 
 	return segs;
 }
 
-static inline unsigned bio_segments(struct bio *bio)
-{
-	return __bio_segments(bio, &bio->bi_iter);
-}
-
 /*
  * get a reference to a bio, so it won't disappear. the intended use is
  * something like:
@@ -389,8 +384,6 @@ extern void bio_put(struct bio *);
 extern void __bio_clone_fast(struct bio *, struct bio *);
 extern struct bio *bio_clone_fast(struct bio *, gfp_t, struct bio_set *);
 extern struct bio *bio_clone_bioset(struct bio *, gfp_t, struct bio_set *bs);
-extern struct bio *bio_clone_bioset_partial(struct bio *, gfp_t,
-					    struct bio_set *, int, int);
 
 extern struct bio_set *fs_bio_set;
 
-- 
2.9.3
