Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77FCCA480
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 14:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiFXOOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiFXOOl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 10:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10FF052E58
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656080079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XH0aeHCEYN3yiNHfxBjLie8mlj8QLveL4/qHg4O/b2M=;
        b=hKRJ6/5g9Pid1KrN/r+Cw8rZYC90dp86IOS1stzcD7ZinjcB4xVFYgfGEgm3kmd6lx87RB
        cxmsmBaDCDatz49fX2TJE04VSnksLEJhkyrKTez4gfaWQtiAWdOTeqhRwxzVVzSgDozE1Z
        YYRTC8GNhVew32mAtqHAn/4kYJc8GsI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-n30C6PHdMrCcWyKnOefw8w-1; Fri, 24 Jun 2022 10:14:36 -0400
X-MC-Unique: n30C6PHdMrCcWyKnOefw8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E7283802BAD;
        Fri, 24 Jun 2022 14:14:35 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEAA21415111;
        Fri, 24 Jun 2022 14:14:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.20 1/4] block: add bio_rewind() API
Date:   Fri, 24 Jun 2022 22:12:52 +0800
Message-Id: <20220624141255.2461148-2-ming.lei@redhat.com>
In-Reply-To: <20220624141255.2461148-1-ming.lei@redhat.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

However, it isn't easy to restore bio by saving 32 bytes bio->bi_iter, and saving
it only can't restore crypto and integrity info.

Add bio_rewind() back for some use cases which may not be same with
previous generic case:

1) most of bio has fixed end sector since bio split is done from front of the bio,
if driver just records how many sectors between current bio's start sector and
the bio's end sector, the original position can be restored

2) if one bio's end sector won't change, usually bio_trim() isn't called, user can
restore original position by storing sectors from current ->bi_iter.bi_sector to
bio's end sector; together by saving bio size, 8 bytes can restore to
original bio.

3) dm's requeue use case: when BLK_STS_DM_REQUEUE happens, dm core needs to
restore to the original bio which represents current dm io to be requeued.
By storing sectors to the bio's end sector and dm io's size,
bio_rewind() can restore such original bio, then dm core code needn't to
allocate one bio beforehand just for handling BLK_STS_DM_REQUEUE which
is actually one unusual event.

4) Not like original rewind API, this one needn't to add .bi_done, and no any
effect on fast path

Cc: Eric Biggers <ebiggers@google.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio-integrity.c       | 19 +++++++++++++++++++
 block/bio.c                 | 19 +++++++++++++++++++
 block/blk-crypto-internal.h |  7 +++++++
 block/blk-crypto.c          | 23 +++++++++++++++++++++++
 include/linux/bio.h         | 21 +++++++++++++++++++++
 include/linux/bvec.h        | 33 +++++++++++++++++++++++++++++++++
 6 files changed, 122 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 32929c89ba8a..06c2fe81fdf2 100644
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
index 51c99f2c5c90..5318944b7b18 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1360,6 +1360,25 @@ void __bio_advance(struct bio *bio, unsigned bytes)
 }
 EXPORT_SYMBOL(__bio_advance);
 
+/**
+ * bio_rewind - rewind @bio by @bytes
+ * @bio: bio to rewind
+ * @bytes: how many bytes to rewind
+ *
+ * Update ->bi_iter of @bio by rewinding @bytes. Most of bio has fixed end
+ * sector, so it is easy to rewind from end of the bio and restore its
+ * original position. And it is caller's responsibility to restore bio size.
+ */
+void bio_rewind(struct bio *bio, unsigned bytes)
+{
+	if (bio_integrity(bio))
+		bio_integrity_rewind(bio, bytes);
+
+	bio_crypt_rewind(bio, bytes);
+	bio_rewind_iter(bio, &bio->bi_iter, bytes);
+}
+EXPORT_SYMBOL(bio_rewind);
+
 void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			struct bio *src, struct bvec_iter *src_iter)
 {
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index e6818ffaddbf..b723599bbf99 100644
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
index a496aaef85ba..caae2f429fc7 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -134,6 +134,21 @@ void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 	}
 }
 
+/* Decrements @dun by @dec, treating @dun as a multi-limb integer. */
+void bio_crypt_dun_decrement(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+			     unsigned int dec)
+{
+	int i;
+
+	for (i = 0; dec && i < BLK_CRYPTO_DUN_ARRAY_SIZE; i++) {
+		dun[i] -= dec;
+		if (dun[i] > inc)
+			dec = 1;
+		else
+			dec = 0;
+	}
+}
+
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes)
 {
 	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
@@ -142,6 +157,14 @@ void __bio_crypt_advance(struct bio *bio, unsigned int bytes)
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
index 992ee987f273..4e6674f232b4 100644
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
@@ -119,6 +132,7 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 }
 
 void __bio_advance(struct bio *, unsigned bytes);
+void bio_rewind(struct bio *, unsigned bytes);
 
 /**
  * bio_advance - increment/complete a bio by some number of bytes
@@ -699,6 +713,7 @@ extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, un
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
+extern void bio_integrity_rewind(struct bio *, unsigned int);
 extern void bio_integrity_trim(struct bio *);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
 extern int bioset_integrity_create(struct bio_set *, int);
@@ -739,6 +754,12 @@ static inline void bio_integrity_advance(struct bio *bio,
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
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff651a..b56d92e939c1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -122,6 +122,39 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
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
2.31.1

