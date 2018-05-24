Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 28/33] block: kill bio_for_each_page_all()
Date: Thu, 24 May 2018 17:01:33 +0800
Message-Id: <20180524090139.2150-29-ming.lei@redhat.com>
In-Reply-To: <20180524090139.2150-1-ming.lei@redhat.com>
References: <20180524090139.2150-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

No one uses it any more, so kill it and we can reuse this helper
name.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5ae2bc876295..c5e692d43f23 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -159,8 +159,10 @@ static inline void *bio_data(struct bio *bio)
 /*
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
+ *
+ * This helper iterates bio segment by segment.
  */
-#define bio_for_each_page_all(bvl, bio, i)				\
+#define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
 static inline void __bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
@@ -225,9 +227,6 @@ static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 #define bio_for_each_segment(bvl, bio, iter)			\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
-#define bio_for_each_segment_all(bvl, bio, i) \
-	bio_for_each_page_all((bvl), (bio), (i))
-
 /*
  * This helper returns singlepage bvec to caller, and the sp bvec is
  * generated in-flight from multipage bvec stored in bvec table. So we
-- 
2.9.5
