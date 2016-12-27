Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34638 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933116AbcL0QJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:09:45 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
        Shaun Tancheff <shaun.tancheff@seagate.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH v1 30/54] block: bio: introduce single/multi page version of bio_for_each_segment_all()
Date: Tue, 27 Dec 2016 23:56:19 +0800
Message-Id: <1482854250-13481-31-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patches introduce bio_for_each_segment_all_sp() and
bio_for_each_segment_all_mp().

bio_for_each_segment_all_sp() is for replacing bio_for_each_segment_all()
in case that the returned bvec has to be single page bvec.

bio_for_each_segment_all_mp() is for replacing bio_for_each_segment_all()
in case that user wants to update the returned bvec via the pointer.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h       | 24 ++++++++++++++++++++++++
 include/linux/blk_types.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 79079bc5a1be..efa0b3627735 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -217,6 +217,30 @@ static inline void bio_advance_iter_mp(struct bio *bio, struct bvec_iter *iter,
 #define bio_for_each_segment_mp(bvl, bio, iter)				\
 	__bio_for_each_segment_mp(bvl, bio, iter, (bio)->bi_iter)
 
+/*
+ * This helper returns each bvec stored in bvec table directly,
+ * so the returned bvec points to one multipage bvec in the table
+ * and caller can update the bvec via the returnd pointer.
+ */
+#define bio_for_each_segment_all_mp(bvl, bio, i)                       \
+	bio_for_each_segment_all((bvl), (bio), (i))
+
+/*
+ * This helper returns singlepage bvec to caller, and the sp bvec
+ * is generated in-flight from multipage bvec stored in bvec table.
+ * So we can _not_ change the bvec stored in bio->bi_io_vec[] via
+ * this helper.
+ *
+ * If someone need to update bvec in the table, please use
+ * bio_for_each_segment_all_mp() and make sure it is correctly used
+ * since the bvec points to one multipage bvec.
+ */
+#define bio_for_each_segment_all_sp(bvl, bio, i, bi)			\
+	for ((bi).iter = BVEC_ITER_ALL_INIT, i = 0, bvl = &(bi).bv;	\
+	     (bi).iter.bi_idx < (bio)->bi_vcnt &&			\
+		(((bi).bv = bio_iter_iovec((bio), (bi).iter)), 1);	\
+	     bio_advance_iter((bio), &(bi).iter, (bi).bv.bv_len), i++)
+
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
 static inline unsigned __bio_segments(struct bio *bio, bool mp)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 519ea2c9df61..ef8e30abb099 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -89,6 +89,12 @@ struct bio {
 
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

