Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 11/33] block: implement bio_pages_all() via bio_for_each_page_all()
Date: Thu, 24 May 2018 17:01:16 +0800
Message-Id: <20180524090139.2150-12-ming.lei@redhat.com>
In-Reply-To: <20180524090139.2150-1-ming.lei@redhat.com>
References: <20180524090139.2150-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

As multipage bvec will be enabled soon, bio->bi_vcnt isn't same with
page count in the bio any more, so use bio_for_each_page_all() to
compute the number.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3d3795b9a353..08af9272687f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -334,8 +334,14 @@ static inline void bio_get_last_bvec(struct bio *bio, struct bio_vec *bv)
 
 static inline unsigned bio_pages_all(struct bio *bio)
 {
+	unsigned i;
+	struct bio_vec *bv;
+
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-	return bio->bi_vcnt;
+
+	bio_for_each_page_all(bv, bio, i)
+		;
+	return i;
 }
 
 static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
-- 
2.9.5
