Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D611EC43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 01:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiF3BPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiF3BO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 21:14:59 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4127B3C
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 18:14:58 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z1so10251647qvp.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 18:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gl/c8nuC+5QRtDx07zWeNG3YZxONGy7n4nyvGdDLURw=;
        b=Fc5pTI5L4yTIKsDpRlYPc3nDpIEo9zqqvQXEOGJEsP7l7t+BU3G6Q+E6l1XyKQSsKV
         FFXJ07++0ly/M79TeHwbgUh0dpk45zL6OVFM/vFAwpNbnOU7ku9bSjhfKxiCdbvhLIWZ
         kvjBBaI9gZV84QSbERyMetuIR22I7j+cSa2O8NDrr1Q1qRz53L/dX3g8TiBEyMonafBk
         VNASDpFpnhDG5SgxHKzkUW3/PI3N698OtebmojVhQrLZohCdVIbMFe2jDqahLReSmN8e
         gj2VgN6ps1JvH5u8Z9aSFv4qNKx/RLYhMYykpEcJwP61pH0KFNW3TtE7XH5T1wMmmg/H
         s81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gl/c8nuC+5QRtDx07zWeNG3YZxONGy7n4nyvGdDLURw=;
        b=HnSMvkQFEbFQl9bTeYNrNvp32ah/DLOE6pgTYdo+p9VodWMD1gBOxYd/HeqyLlmyd3
         BTfrvIhWoshzhJE7Gd+m1OJ5tx3nnav4NmZcR0SGJ7TSKtAbO4mcJ/ALQK/Rlgitd2+F
         B3uiWmCLfztaS85tqsFeSivWqAODK7F/4rlQIsBamjzZ3ip64a8R9F8xSTrk1MnqZyAU
         DshQi+fju8BxJaEO4DPcq4kAry/C1vtDIX36RhR442QIKRRANl4JYnDDQPLFgWa/zS+8
         eDy8ZGR0EmJ5HuxTyQb4xPmlRMk3bYD5v9yQjJBMy1VzdKGNb+sBHMzF1w19yQV7DVoE
         X4jQ==
X-Gm-Message-State: AJIora/H8acmLjO3+8r9dEdiRoI+b0F7+bTF4+0usKHqia9TF/++8URx
        yk2cTsbEhSWKPHC8kEfgUA==
X-Google-Smtp-Source: AGRyM1sqmU0naLkYdXVNgxW69ymdkkC/CmVnMOdnUw2DWkshZEVWvBZwdnJrML9H8C7sJs1azHg+KA==
X-Received: by 2002:ac8:5e46:0:b0:317:6146:6f05 with SMTP id i6-20020ac85e46000000b0031761466f05mr5456516qtx.490.1656551696440;
        Wed, 29 Jun 2022 18:14:56 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id ci27-20020a05622a261b00b00316dc1ffbb9sm4533576qtb.32.2022.06.29.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 18:14:55 -0700 (PDT)
Date:   Wed, 29 Jun 2022 21:14:54 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220630011454.c6djuzkwsn33x7y6@moria.home.lan>
References: <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042610.wuittagsycyl4uwa@moria.home.lan>
 <YrqyiCcnvPCqsn8F@T590>
 <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
 <Yrs9OLNZ8xUs98OB@redhat.com>
 <20220628175253.s2ghizfucumpot5l@moria.home.lan>
 <YrvsDNltq+h6mphN@redhat.com>
 <20220629181154.eejrlfhj5n4la446@moria.home.lan>
 <YrzykX0jTWpq5DYQ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrzykX0jTWpq5DYQ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 30, 2022 at 08:47:13AM +0800, Ming Lei wrote:
> Or if I misunderstood your point, please cook a patch and I am happy to
> take a close look, and posting one very raw idea with random data
> structure looks not helpful much for this discussion technically.

Based it on your bio_rewind() patch - what do you think of this?

-- >8 --
From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH] block: add bio_(get|set)_pos()

Commit 7759eb23fd98 ("block: remove bio_rewind_iter()") removes
the similar API because the following reasons:

    ```
    It is pointed that bio_rewind_iter() is one very bad API[1]:

    1) bio size may not be restored after rewinding

    2) it causes some bogus change, such as 5151842b9d8732 (block: reset
    bi_iter.bi_done after splitting bio)

    3) rewinding really makes things complicated wrt. bio splitting

    4) unnecessary updating of .bi_done in fast path

    [1] https://marc.info/?t=153549924200005&r=1&w=2

    So this patch takes Kent's suggestion to restore one bio into its original
    state via saving bio iterator(struct bvec_iter) in bio_integrity_prep(),
    given now bio_rewind_iter() is only used by bio integrity code.
    ```

However, saving and restoring bi_iter isn't sufficient anymore, because
of integrity and now per-bio crypt context.

This patch implements the same functionality as bio_rewind(), based on a
patch by Ming, but with a different (safer!) interface.

 - bio_get_pos() gets the current state of a a bio, i.e. how far it has
   been advanced and its current (remaining) size
 - bio_set_pos() restores a bio to a previous state, advancing or
   rewinding it as needed

Co-authored-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio-integrity.c       | 19 +++++++++++++++++++
 block/bio.c                 | 26 ++++++++++++++++++++++++++
 block/blk-crypto-internal.h |  7 +++++++
 block/blk-crypto.c          | 25 +++++++++++++++++++++++++
 include/linux/bio.h         | 22 ++++++++++++++++++++++
 include/linux/blk_types.h   | 19 +++++++++++++++++++
 include/linux/bvec.h        | 36 +++++++++++++++++++++++++++++++++++-
 7 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 32929c89ba..06c2fe81fd 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -378,6 +378,25 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
 	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
 }
 
+/**
+ * bio_integrity_rewind - Rewind integrity vector
+ * @bio:	bio whose integrity vector to update
+ * @bytes_done:	number of data bytes to rewind
+ *
+ * Description: This function calculates how many integrity bytes the
+ * number of completed data bytes correspond to and rewind the
+ * integrity vector accordingly.
+ */
+void bio_integrity_rewind(struct bio *bio, unsigned int bytes_done)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	unsigned bytes = bio_integrity_bytes(bi, bytes_done >> 9);
+
+	bip->bip_iter.bi_sector -= bio_integrity_intervals(bi, bytes_done >> 9);
+	bvec_iter_rewind(bip->bip_vec, &bip->bip_iter, bytes);
+}
+
 /**
  * bio_integrity_trim - Trim integrity vector
  * @bio:	bio whose integrity vector to update
diff --git a/block/bio.c b/block/bio.c
index b2425b8d88..bbf8aa4e62 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1329,6 +1329,32 @@ void __bio_advance(struct bio *bio, unsigned bytes)
 }
 EXPORT_SYMBOL(__bio_advance);
 
+/**
+ * bio_set_pos - restore a bio to a previous state, after having been iterated
+ * or trimmed
+ * @bio: bio to reset
+ * @pos: pos to reset it to, from bio_get_pos()
+ */
+void bio_set_pos(struct bio *bio, struct bio_pos pos)
+{
+	int delta = bio->bi_iter.bi_done - pos.bi_done;
+
+	if (delta > 0) {
+		if (bio_integrity(bio))
+			bio_integrity_rewind(bio, delta);
+		bio_crypt_rewind(bio, delta);
+		bio_rewind_iter(bio, &bio->bi_iter, delta);
+	} else {
+		bio_advance(bio, -delta);
+	}
+
+	bio->bi_iter.bi_size = pos.bi_size;
+
+	if (bio_integrity(bio))
+		bio_integrity_trim(bio);
+}
+EXPORT_SYMBOL(bio_set_pos);
+
 void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			struct bio *src, struct bvec_iter *src_iter)
 {
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index e6818ffadd..b723599bbf 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -114,6 +114,13 @@ static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
 		__bio_crypt_advance(bio, bytes);
 }
 
+void __bio_crypt_rewind(struct bio *bio, unsigned int bytes);
+static inline void bio_crypt_rewind(struct bio *bio, unsigned int bytes)
+{
+	if (bio_has_crypt_ctx(bio))
+		__bio_crypt_rewind(bio, bytes);
+}
+
 void __bio_crypt_free_ctx(struct bio *bio);
 static inline void bio_crypt_free_ctx(struct bio *bio)
 {
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index a496aaef85..e3584b5a68 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -134,6 +134,23 @@ void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 	}
 }
 
+/* Decrements @dun by @dec, treating @dun as a multi-limb integer. */
+void bio_crypt_dun_decrement(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+			     unsigned int dec)
+{
+	int i;
+
+	for (i = 0; dec && i < BLK_CRYPTO_DUN_ARRAY_SIZE; i++) {
+		u64 prev = dun[i];
+
+		dun[i] -= dec;
+		if (dun[i] > prev)
+			dec = 1;
+		else
+			dec = 0;
+	}
+}
+
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes)
 {
 	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
@@ -142,6 +159,14 @@ void __bio_crypt_advance(struct bio *bio, unsigned int bytes)
 				bytes >> bc->bc_key->data_unit_size_bits);
 }
 
+void __bio_crypt_rewind(struct bio *bio, unsigned int bytes)
+{
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+
+	bio_crypt_dun_decrement(bc->bc_dun,
+				bytes >> bc->bc_key->data_unit_size_bits);
+}
+
 /*
  * Returns true if @bc->bc_dun plus @bytes converted to data units is equal to
  * @next_dun, treating the DUNs as multi-limb integers.
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c11103a872..5fff008913 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -105,6 +105,19 @@ static inline void bio_advance_iter(const struct bio *bio,
 		/* TODO: It is reasonable to complete bio with error here. */
 }
 
+static inline void bio_rewind_iter(const struct bio *bio,
+				    struct bvec_iter *iter, unsigned int bytes)
+{
+	iter->bi_sector -= bytes >> 9;
+
+	/* No advance means no rewind */
+	if (bio_no_advance_iter(bio))
+		iter->bi_size += bytes;
+	else
+		bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+		/* TODO: It is reasonable to complete bio with error here. */
+}
+
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
 static inline void bio_advance_iter_single(const struct bio *bio,
 					   struct bvec_iter *iter,
@@ -133,6 +146,8 @@ void __bio_advance(struct bio *, unsigned bytes);
  */
 static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 {
+	bio->bi_iter.bi_done += nbytes;
+
 	if (nbytes == bio->bi_iter.bi_size) {
 		bio->bi_iter.bi_size = 0;
 		return;
@@ -707,6 +722,7 @@ extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, un
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
+extern void bio_integrity_rewind(struct bio *, unsigned int);
 extern void bio_integrity_trim(struct bio *);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
 extern int bioset_integrity_create(struct bio_set *, int);
@@ -747,6 +763,12 @@ static inline void bio_integrity_advance(struct bio *bio,
 	return;
 }
 
+static inline void bio_integrity_rewind(struct bio *bio,
+					 unsigned int bytes_done)
+{
+	return;
+}
+
 static inline void bio_integrity_trim(struct bio *bio)
 {
 	return;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1973ef9bd4..eff756a96f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -306,6 +306,25 @@ struct bio {
 	struct bio_vec		bi_inline_vecs[];
 };
 
+/*
+ * These are for saving & restoring all the iterators within a bio to a previous
+ * state
+ */
+struct bio_pos {
+	unsigned int	bi_done;
+	unsigned int	bi_size;
+};
+
+static inline struct bio_pos bio_get_pos(struct bio *bio)
+{
+	return (struct bio_pos) {
+		.bi_done	= bio->bi_iter.bi_done,
+		.bi_size	= bio->bi_iter.bi_size,
+	};
+}
+
+extern void bio_set_pos(struct bio *bio, struct bio_pos pos);
+
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
 #define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff65..1606ebe1da 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -44,7 +44,8 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-} __packed;
+	unsigned int		bi_done;	/* number of bytes completed, total */
+};
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
@@ -122,6 +123,39 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	return true;
 }
 
+static inline bool bvec_iter_rewind(const struct bio_vec *bv,
+				     struct bvec_iter *iter,
+				     unsigned int bytes)
+{
+	int idx;
+
+	iter->bi_size += bytes;
+	if (bytes <= iter->bi_bvec_done) {
+		iter->bi_bvec_done -= bytes;
+		return true;
+	}
+
+	bytes -= iter->bi_bvec_done;
+	idx = iter->bi_idx - 1;
+
+	while (idx >= 0 && bytes && bytes > bv[idx].bv_len) {
+		bytes -= bv[idx].bv_len;
+		idx--;
+	}
+
+	if (WARN_ONCE(idx < 0 && bytes,
+		      "Attempted to rewind iter beyond bvec's boundaries\n")) {
+		iter->bi_size -= bytes;
+		iter->bi_bvec_done = 0;
+		iter->bi_idx = 0;
+		return false;
+	}
+
+	iter->bi_idx = idx;
+	iter->bi_bvec_done = bv[idx].bv_len - bytes;
+	return true;
+}
+
 /*
  * A simpler version of bvec_iter_advance(), @bytes should not span
  * across multiple bvec entries, i.e. bytes <= bv[i->bi_idx].bv_len
-- 
2.36.1

