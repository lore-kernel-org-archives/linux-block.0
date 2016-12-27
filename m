Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35422 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbcL0QKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:10:35 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH v1 31/54] block: introduce bio_segments_all()
Date: Tue, 27 Dec 2016 23:56:20 +0800
Message-Id: <1482854250-13481-32-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There are still several direct access to .bi_vcnt, so
introduce this helper to replace that usage for supporting
multipage bvec.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index efa0b3627735..b0929cf8c7fe 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -391,6 +391,27 @@ static inline void bio_get_last_bvec(struct bio *bio, struct bio_vec *bv)
 		bv->bv_len = iter.bi_bvec_done;
 }
 
+/*
+ * Return how many singlepage bvecs included in this bio,
+ * and this helper is only used for some fs to replace
+ * bio->bi_vcnt.
+ */
+static inline unsigned bio_segments_all(struct bio *bio)
+{
+	unsigned segs = 0;
+	int i;
+	struct bio_vec *bv;
+	struct bvec_iter_all bia;
+
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
+
+	bio_for_each_segment_all_sp(bv, bio, i, bia)
+		segs++;
+
+	return segs;
+}
+
+
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
 	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-- 
2.7.4

