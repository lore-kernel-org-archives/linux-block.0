Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EADC43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 21:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiGRVMu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiGRVMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 17:12:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD3326F3
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 14:12:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s27so11708247pga.13
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+Ekq4aMZsA7lk0T9dcKTAYWzF70Jpe39/DElz1Owf0=;
        b=sPz+CmKPb1k9YWe94vounnqPlV59e7klT85lYTj3aif7GgL8Ls90wmqNj8h9vbAVuJ
         +4lCwks44sDlW8h7Z5fsoOk7BFTE6QLMW3oNNw51erxXZ4GMaUvGhdE3Me65a0gbOZ+3
         2jGnNVVAh5W2c8NrPjvnEkrUs6Xsxt5htdN45UVWzvdVqYzznjuX9dUGcXAnxHZm/p2n
         bRF9sZ1r2qEfAIGGYIfdgKMSYA0fYtEmWdZfBRz8FMw8ZKCAtd3NCYhok8qINhP/PEoM
         SCEcS9BdNQqLbnq2zGBGuvtv6ETo78MhUM+Auv/AlrIVioeZdbBnra39ug8B+VbR/aYH
         7S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+Ekq4aMZsA7lk0T9dcKTAYWzF70Jpe39/DElz1Owf0=;
        b=kfmYnwJBJTGY5xqr0iitEmnCZBzHS5IjOGUIXDzlNoEHHCgpx3fxbbPH4f6hy2t9Zo
         kWMhacUIPuiQ6RlFM5wd+zRX9bkT8Bvbg43tO7NeWyEyicLDDlidQkFBYJDRYMpg9Uyv
         efv1vsCRZ8xcWVjTTiJJvkNbads2XATErFe773NxVV9joFm0F0xKaVBtu1yUcukyqF3F
         ViiJqHMrziLZCcrOWseNBVYS7zcFxChxeNWoOFAyGCPw5/jJJCxdPpCE5XRMWTfAdnPT
         XAJALVWI2/NgggHTaQED1FH7AQEux1Dd2I4s9Z4dief/npM8z2QMIWG+spMLKl9S3hbK
         aLVQ==
X-Gm-Message-State: AJIora9MAhIrqOmpoj7P4kMmgVWY8KSRE1LUp+iDP6FyRnzxrHuxljvN
        g70L5b7j/sd9hIC+ZmQLw0u4ow==
X-Google-Smtp-Source: AGRyM1sm/1kKfs+hChxoiSVol4qFnasMNjDLWM8AjG6nnSbvAA6/Ui4TihAW5bSrPtwLc1/Qv//erw==
X-Received: by 2002:aa7:8d03:0:b0:52b:5792:e304 with SMTP id j3-20020aa78d03000000b0052b5792e304mr12579737pfe.36.1658178767496;
        Mon, 18 Jul 2022 14:12:47 -0700 (PDT)
Received: from desktop.hsd1.or.comcast.net ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b001ef59378951sm11918134pjc.13.2022.07.18.14.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:12:47 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        syzbot+4f441e6ca0fcad141421@syzkaller.appspotmail.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH 5.10 1/2] block: split bio_kmalloc from bio_alloc_bioset
Date:   Mon, 18 Jul 2022 14:12:25 -0700
Message-Id: <20220718211226.506362-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

From: Christoph Hellwig <hch@lst.de>

Upstream commit: 3175199ab0ac ("block: split bio_kmalloc from bio_alloc_bioset")

This is backport to stable 5.10. It fixes an issue reported by syzbot.
Link: https://syzkaller.appspot.com/bug?id=a3416231e37024a75f2b95bd95db0d8ce8132a84

bio_kmalloc shares almost no logic with the bio_set based fast path
in bio_alloc_bioset.  Split it into an entirely separate implementation.

Reported-by: syzbot+4f441e6ca0fcad141421@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 block/bio.c         | 166 +++++++++++++++++++++++---------------------
 include/linux/bio.h |   6 +-
 2 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f8d26ce7b61b..be59276e462e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -405,122 +405,101 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
  * @nr_iovecs:	number of iovecs to pre-allocate
  * @bs:		the bio_set to allocate from.
  *
- * Description:
- *   If @bs is NULL, uses kmalloc() to allocate the bio; else the allocation is
- *   backed by the @bs's mempool.
+ * Allocate a bio from the mempools in @bs.
  *
- *   When @bs is not NULL, if %__GFP_DIRECT_RECLAIM is set then bio_alloc will
- *   always be able to allocate a bio. This is due to the mempool guarantees.
- *   To make this work, callers must never allocate more than 1 bio at a time
- *   from this pool. Callers that need to allocate more than 1 bio must always
- *   submit the previously allocated bio for IO before attempting to allocate
- *   a new one. Failure to do so can cause deadlocks under memory pressure.
+ * If %__GFP_DIRECT_RECLAIM is set then bio_alloc will always be able to
+ * allocate a bio.  This is due to the mempool guarantees.  To make this work,
+ * callers must never allocate more than 1 bio at a time from the general pool.
+ * Callers that need to allocate more than 1 bio must always submit the
+ * previously allocated bio for IO before attempting to allocate a new one.
+ * Failure to do so can cause deadlocks under memory pressure.
  *
- *   Note that when running under submit_bio_noacct() (i.e. any block
- *   driver), bios are not submitted until after you return - see the code in
- *   submit_bio_noacct() that converts recursion into iteration, to prevent
- *   stack overflows.
+ * Note that when running under submit_bio_noacct() (i.e. any block driver),
+ * bios are not submitted until after you return - see the code in
+ * submit_bio_noacct() that converts recursion into iteration, to prevent
+ * stack overflows.
  *
- *   This would normally mean allocating multiple bios under
- *   submit_bio_noacct() would be susceptible to deadlocks, but we have
- *   deadlock avoidance code that resubmits any blocked bios from a rescuer
- *   thread.
+ * This would normally mean allocating multiple bios under submit_bio_noacct()
+ * would be susceptible to deadlocks, but we have
+ * deadlock avoidance code that resubmits any blocked bios from a rescuer
+ * thread.
  *
- *   However, we do not guarantee forward progress for allocations from other
- *   mempools. Doing multiple allocations from the same mempool under
- *   submit_bio_noacct() should be avoided - instead, use bio_set's front_pad
- *   for per bio allocations.
+ * However, we do not guarantee forward progress for allocations from other
+ * mempools. Doing multiple allocations from the same mempool under
+ * submit_bio_noacct() should be avoided - instead, use bio_set's front_pad
+ * for per bio allocations.
  *
- *   RETURNS:
- *   Pointer to new bio on success, NULL on failure.
+ * Returns: Pointer to new bio on success, NULL on failure.
  */
 struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 			     struct bio_set *bs)
 {
 	gfp_t saved_gfp = gfp_mask;
-	unsigned front_pad;
-	unsigned inline_vecs;
-	struct bio_vec *bvl = NULL;
 	struct bio *bio;
 	void *p;
 
-	if (!bs) {
-		if (nr_iovecs > UIO_MAXIOV)
-			return NULL;
-
-		p = kmalloc(struct_size(bio, bi_inline_vecs, nr_iovecs), gfp_mask);
-		front_pad = 0;
-		inline_vecs = nr_iovecs;
-	} else {
-		/* should not use nobvec bioset for nr_iovecs > 0 */
-		if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) &&
-				 nr_iovecs > 0))
-			return NULL;
-		/*
-		 * submit_bio_noacct() converts recursion to iteration; this
-		 * means if we're running beneath it, any bios we allocate and
-		 * submit will not be submitted (and thus freed) until after we
-		 * return.
-		 *
-		 * This exposes us to a potential deadlock if we allocate
-		 * multiple bios from the same bio_set() while running
-		 * underneath submit_bio_noacct(). If we were to allocate
-		 * multiple bios (say a stacking block driver that was splitting
-		 * bios), we would deadlock if we exhausted the mempool's
-		 * reserve.
-		 *
-		 * We solve this, and guarantee forward progress, with a rescuer
-		 * workqueue per bio_set. If we go to allocate and there are
-		 * bios on current->bio_list, we first try the allocation
-		 * without __GFP_DIRECT_RECLAIM; if that fails, we punt those
-		 * bios we would be blocking to the rescuer workqueue before
-		 * we retry with the original gfp_flags.
-		 */
-
-		if (current->bio_list &&
-		    (!bio_list_empty(&current->bio_list[0]) ||
-		     !bio_list_empty(&current->bio_list[1])) &&
-		    bs->rescue_workqueue)
-			gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+	/* should not use nobvec bioset for nr_iovecs > 0 */
+	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_iovecs > 0))
+		return NULL;
 
+	/*
+	 * submit_bio_noacct() converts recursion to iteration; this means if
+	 * we're running beneath it, any bios we allocate and submit will not be
+	 * submitted (and thus freed) until after we return.
+	 *
+	 * This exposes us to a potential deadlock if we allocate multiple bios
+	 * from the same bio_set() while running underneath submit_bio_noacct().
+	 * If we were to allocate multiple bios (say a stacking block driver
+	 * that was splitting bios), we would deadlock if we exhausted the
+	 * mempool's reserve.
+	 *
+	 * We solve this, and guarantee forward progress, with a rescuer
+	 * workqueue per bio_set. If we go to allocate and there are bios on
+	 * current->bio_list, we first try the allocation without
+	 * __GFP_DIRECT_RECLAIM; if that fails, we punt those bios we would be
+	 * blocking to the rescuer workqueue before we retry with the original
+	 * gfp_flags.
+	 */
+	if (current->bio_list &&
+	    (!bio_list_empty(&current->bio_list[0]) ||
+	     !bio_list_empty(&current->bio_list[1])) &&
+	    bs->rescue_workqueue)
+		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+
+	p = mempool_alloc(&bs->bio_pool, gfp_mask);
+	if (!p && gfp_mask != saved_gfp) {
+		punt_bios_to_rescuer(bs);
+		gfp_mask = saved_gfp;
 		p = mempool_alloc(&bs->bio_pool, gfp_mask);
-		if (!p && gfp_mask != saved_gfp) {
-			punt_bios_to_rescuer(bs);
-			gfp_mask = saved_gfp;
-			p = mempool_alloc(&bs->bio_pool, gfp_mask);
-		}
-
-		front_pad = bs->front_pad;
-		inline_vecs = BIO_INLINE_VECS;
 	}
-
 	if (unlikely(!p))
 		return NULL;
 
-	bio = p + front_pad;
-	bio_init(bio, NULL, 0);
-
-	if (nr_iovecs > inline_vecs) {
+	bio = p + bs->front_pad;
+	if (nr_iovecs > BIO_INLINE_VECS) {
 		unsigned long idx = 0;
+		struct bio_vec *bvl = NULL;
 
 		bvl = bvec_alloc(gfp_mask, nr_iovecs, &idx, &bs->bvec_pool);
 		if (!bvl && gfp_mask != saved_gfp) {
 			punt_bios_to_rescuer(bs);
 			gfp_mask = saved_gfp;
-			bvl = bvec_alloc(gfp_mask, nr_iovecs, &idx, &bs->bvec_pool);
+			bvl = bvec_alloc(gfp_mask, nr_iovecs, &idx,
+					 &bs->bvec_pool);
 		}
 
 		if (unlikely(!bvl))
 			goto err_free;
 
 		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
+		bio_init(bio, bvl, bvec_nr_vecs(idx));
 	} else if (nr_iovecs) {
-		bvl = bio->bi_inline_vecs;
+		bio_init(bio, bio->bi_inline_vecs, BIO_INLINE_VECS);
+	} else {
+		bio_init(bio, NULL, 0);
 	}
 
 	bio->bi_pool = bs;
-	bio->bi_max_vecs = nr_iovecs;
-	bio->bi_io_vec = bvl;
 	return bio;
 
 err_free:
@@ -529,6 +508,31 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 }
 EXPORT_SYMBOL(bio_alloc_bioset);
 
+/**
+ * bio_kmalloc - kmalloc a bio for I/O
+ * @gfp_mask:   the GFP_* mask given to the slab allocator
+ * @nr_iovecs:	number of iovecs to pre-allocate
+ *
+ * Use kmalloc to allocate and initialize a bio.
+ *
+ * Returns: Pointer to new bio on success, NULL on failure.
+ */
+struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned int nr_iovecs)
+{
+	struct bio *bio;
+
+	if (nr_iovecs > UIO_MAXIOV)
+		return NULL;
+
+	bio = kmalloc(struct_size(bio, bi_inline_vecs, nr_iovecs), gfp_mask);
+	if (unlikely(!bio))
+		return NULL;
+	bio_init(bio, nr_iovecs ? bio->bi_inline_vecs : NULL, nr_iovecs);
+	bio->bi_pool = NULL;
+	return bio;
+}
+EXPORT_SYMBOL(bio_kmalloc);
+
 void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
 {
 	unsigned long flags;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 23b7a73cd757..1c790e48dcef 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -390,6 +390,7 @@ extern int biovec_init_pool(mempool_t *pool, int pool_entries);
 extern int bioset_init_from_src(struct bio_set *bs, struct bio_set *src);
 
 extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_set *);
+struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned int nr_iovecs);
 extern void bio_put(struct bio *);
 
 extern void __bio_clone_fast(struct bio *, struct bio *);
@@ -402,11 +403,6 @@ static inline struct bio *bio_alloc(gfp_t gfp_mask, unsigned int nr_iovecs)
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, &fs_bio_set);
 }
 
-static inline struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned int nr_iovecs)
-{
-	return bio_alloc_bioset(gfp_mask, nr_iovecs, NULL);
-}
-
 extern blk_qc_t submit_bio(struct bio *);
 
 extern void bio_endio(struct bio *);
-- 
2.36.1

