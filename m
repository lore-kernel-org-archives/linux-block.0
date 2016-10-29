Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35364 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934345AbcJ2IP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:15:29 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 45/60] block: bio: introduce bio_for_each_segment_all_rd() and its write pair
Date: Sat, 29 Oct 2016 16:08:44 +0800
Message-Id: <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patches introduce bio_for_each_segment_all_rd() and
bio_for_each_segment_all_wt().

bio_for_each_segment_all_rd() is for replacing
bio_for_each_segment_all() in case the bvec from bio->bi_io_vec
is accessed as readonly.

bio_for_each_segment_all_wt() is for replacing
bio_for_each_segment_all() in case the bvec from bio->bi_io_vec
need to be updated.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h       | 15 +++++++++++++++
 include/linux/blk_types.h |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ec1c0f2aaa19..f8a025ffaa9c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -215,6 +215,21 @@ static inline void bio_advance_iter_mp(struct bio *bio, struct bvec_iter *iter,
 #define bio_for_each_segment_mp(bvl, bio, iter)				\
 	__bio_for_each_segment_mp(bvl, bio, iter, (bio)->bi_iter)
 
+/* the bio has to be singlepage bvecs based */
+#define bio_for_each_segment_all_wt(bvl, bio, i)                       \
+	bio_for_each_segment_all((bvl), (bio), (i))
+
+/*
+ * This helper returns singlepage bvec to caller for readonly
+ * purpose, and the caller can _not_ change the bvec stored in
+ * bio->bi_io_vec[] via this helper.
+ */
+#define bio_for_each_segment_all_rd(bvl, bio, i, bi)			\
+	for ((bi).iter = BVEC_ITER_ALL_INIT, i = 0, bvl = &(bi).bv;	\
+	     (bi).iter.bi_idx < (bio)->bi_vcnt &&			\
+		(((bi).bv = bio_iter_iovec((bio), (bi).iter)), 1);	\
+	     bio_advance_iter((bio), &(bi).iter, (bi).bv.bv_len), i++)
+
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
 static inline unsigned __bio_segments(struct bio *bio, bool mp)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cd395ecec99d..b4a202e98016 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -108,6 +108,12 @@ struct bio {
 
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
 
+/* this iter is only for implementing bio_for_each_segment_rd() */
+struct bvec_iter_all {
+	struct bvec_iter	iter;
+	struct bio_vec		bv;      /* in-flight singlepage bvec */
+};
+
 /*
  * bio flags
  */
-- 
2.7.4

