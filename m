Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752884AbdLHNOk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Dec 2017 08:14:40 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 01/10] block: introduce bio helpers for converting to multipage bvec
Date: Fri,  8 Dec 2017 21:14:00 +0800
Message-Id: <20171208131409.11889-2-ming.lei@redhat.com>
In-Reply-To: <20171208131409.11889-1-ming.lei@redhat.com>
References: <20171208131409.11889-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

These helpers are introduced for converting current users of direct
access to bvec table, and prepares for supporting multipage bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 82f0c8fd7be8..3f314e17364a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -300,6 +300,30 @@ static inline void bio_get_last_bvec(struct bio *bio, struct bio_vec *bv)
 		bv->bv_len = iter.bi_bvec_done;
 }
 
+static inline unsigned bio_nr_pages(struct bio *bio)
+{
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
+
+	return bio->bi_vcnt;
+}
+
+static inline struct bio_vec *bio_first_bvec(struct bio *bio)
+{
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
+	return bio->bi_io_vec;
+}
+
+static inline struct page *bio_first_page(struct bio *bio)
+{
+	return bio_first_bvec(bio)->bv_page;
+}
+
+static inline struct bio_vec *bio_last_bvec(struct bio *bio)
+{
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
+	return &bio->bi_io_vec[bio->bi_vcnt - 1];
+}
+
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
 	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-- 
2.9.5
