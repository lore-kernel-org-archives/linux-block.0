Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B606C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 20:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbiCXUhE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353429AbiCXUhD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 16:37:03 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED5B82C7
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:30 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id i65so4510123qkd.7
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6h21K3Ky29VFE3mJvKyCbaa9it+HvvCtx+rdJYmSmQ=;
        b=YR6kAshJuRnG4g+9coFaf2GLjAQT9umrltozlxzTqQwlprleVtvWEcsnJNI/5hWkDL
         rKYIEeK/NOpEEji5Vx6roJ+G3Tp4iCpa5k0IsgDptdoYg1s2Bm7wApW517xuh2i8Fppl
         GxCwuN2bZC+0uck1EVZuGBkVeejVJL6sLCHV2BEbzHgBhdicqd0a/Jb5EeIH0IGtE40K
         TUaoAETJSPqZTxRhMJbnhgsfMWATi+14X3hHMw58HlhPVpngwi9nfPv1O/NqFQ6rfVXL
         zyMMtdUK1kcxPqn+sK8LTOgh7/qpGYva1A7XvcYlSaVn6wty99P0zeYLpUBk+fz1wUG+
         TAZQ==
X-Gm-Message-State: AOAM532FT97Z2Ymsyv9aZ3SBrRuSzUuOjRE+l6Wsk3aidquR/WvHxOzn
        7QaURL4yJms6gv3558/Es2fBzkn2be2D
X-Google-Smtp-Source: ABdhPJw7KfeQ1+LTdcr0w85VNwHWcJi0T5xCLbC7duGcefjDUjMLc3QnPfSkHnE3ib+VNOCB5JU5DQ==
X-Received: by 2002:a05:620a:2546:b0:680:a53b:63c with SMTP id s6-20020a05620a254600b00680a53b063cmr2294772qko.287.1648154129176;
        Thu, 24 Mar 2022 13:35:29 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm2068371qkm.66.2022.03.24.13.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:35:28 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v3 1/3] block: allow using the per-cpu bio cache from bio_alloc_bioset
Date:   Thu, 24 Mar 2022 16:35:24 -0400
Message-Id: <20220324203526.62306-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220324203526.62306-1-snitzer@kernel.org>
References: <20220324203526.62306-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the BIO_PERCPU_CACHE bio-internal flag with a REQ_ALLOC_CACHE
one that can be passed to bio_alloc / bio_alloc_bioset, and implement
the percpu cache allocation logic in a helper called from
bio_alloc_bioset.  This allows any bio_alloc_bioset user to use the
percpu caches instead of having the functionality tied to struct kiocb.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
[hch: refactored a bit]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c               | 86 ++++++++++++++++++++++-------------------------
 block/blk.h               |  3 +-
 block/fops.c              | 11 ++++--
 include/linux/bio.h       |  2 --
 include/linux/blk_types.h |  3 +-
 5 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 33979f306e9e..09b714469b06 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -420,6 +420,28 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
 	queue_work(bs->rescue_workqueue, &bs->rescue_work);
 }
 
+static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
+		unsigned short nr_vecs, unsigned int opf, gfp_t gfp,
+		struct bio_set *bs)
+{
+	struct bio_alloc_cache *cache;
+	struct bio *bio;
+
+	cache = per_cpu_ptr(bs->cache, get_cpu());
+	if (!cache->free_list) {
+		put_cpu();
+		return NULL;
+	}
+	bio = cache->free_list;
+	cache->free_list = bio->bi_next;
+	cache->nr--;
+	put_cpu();
+
+	bio_init(bio, bdev, nr_vecs ? bio->bi_inline_vecs : NULL, nr_vecs, opf);
+	bio->bi_pool = bs;
+	return bio;
+}
+
 /**
  * bio_alloc_bioset - allocate a bio for I/O
  * @bdev:	block device to allocate the bio for (can be %NULL)
@@ -452,6 +474,9 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
  * submit_bio_noacct() should be avoided - instead, use bio_set's front_pad
  * for per bio allocations.
  *
+ * If REQ_ALLOC_CACHE is set, the final put of the bio MUST be done from process
+ * context, not hard/soft IRQ.
+ *
  * Returns: Pointer to new bio on success, NULL on failure.
  */
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
@@ -466,6 +491,21 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
+	if (opf & REQ_ALLOC_CACHE) {
+		if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
+			bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
+						     gfp_mask, bs);
+			if (bio)
+				return bio;
+			/*
+			 * No cached bio available, bio returned below marked with
+			 * REQ_ALLOC_CACHE to particpate in per-cpu alloc cache.
+			 */
+		} else {
+			opf &= ~REQ_ALLOC_CACHE;
+		}
+	}
+
 	/*
 	 * submit_bio_noacct() converts recursion to iteration; this means if
 	 * we're running beneath it, any bios we allocate and submit will not be
@@ -712,7 +752,7 @@ void bio_put(struct bio *bio)
 			return;
 	}
 
-	if (bio_flagged(bio, BIO_PERCPU_CACHE)) {
+	if (bio->bi_opf & REQ_ALLOC_CACHE) {
 		struct bio_alloc_cache *cache;
 
 		bio_uninit(bio);
@@ -1734,50 +1774,6 @@ int bioset_init_from_src(struct bio_set *bs, struct bio_set *src)
 }
 EXPORT_SYMBOL(bioset_init_from_src);
 
-/**
- * bio_alloc_kiocb - Allocate a bio from bio_set based on kiocb
- * @kiocb:	kiocb describing the IO
- * @bdev:	block device to allocate the bio for (can be %NULL)
- * @nr_vecs:	number of iovecs to pre-allocate
- * @opf:	operation and flags for bio
- * @bs:		bio_set to allocate from
- *
- * Description:
- *    Like @bio_alloc_bioset, but pass in the kiocb. The kiocb is only
- *    used to check if we should dip into the per-cpu bio_set allocation
- *    cache. The allocation uses GFP_KERNEL internally. On return, the
- *    bio is marked BIO_PERCPU_CACHEABLE, and the final put of the bio
- *    MUST be done from process context, not hard/soft IRQ.
- *
- */
-struct bio *bio_alloc_kiocb(struct kiocb *kiocb, struct block_device *bdev,
-		unsigned short nr_vecs, unsigned int opf, struct bio_set *bs)
-{
-	struct bio_alloc_cache *cache;
-	struct bio *bio;
-
-	if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE) || nr_vecs > BIO_INLINE_VECS)
-		return bio_alloc_bioset(bdev, nr_vecs, opf, GFP_KERNEL, bs);
-
-	cache = per_cpu_ptr(bs->cache, get_cpu());
-	if (cache->free_list) {
-		bio = cache->free_list;
-		cache->free_list = bio->bi_next;
-		cache->nr--;
-		put_cpu();
-		bio_init(bio, bdev, nr_vecs ? bio->bi_inline_vecs : NULL,
-			 nr_vecs, opf);
-		bio->bi_pool = bs;
-		bio_set_flag(bio, BIO_PERCPU_CACHE);
-		return bio;
-	}
-	put_cpu();
-	bio = bio_alloc_bioset(bdev, nr_vecs, opf, GFP_KERNEL, bs);
-	bio_set_flag(bio, BIO_PERCPU_CACHE);
-	return bio;
-}
-EXPORT_SYMBOL_GPL(bio_alloc_kiocb);
-
 static int __init init_bio(void)
 {
 	int i;
diff --git a/block/blk.h b/block/blk.h
index 6f21859c7f0f..9cb04f24ba8a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -454,8 +454,7 @@ extern struct device_attribute dev_attr_events_poll_msecs;
 static inline void bio_clear_polled(struct bio *bio)
 {
 	/* can't support alloc cache if we turn off polling */
-	bio_clear_flag(bio, BIO_PERCPU_CACHE);
-	bio->bi_opf &= ~REQ_POLLED;
+	bio->bi_opf &= ~(REQ_POLLED | REQ_ALLOC_CACHE);
 }
 
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
diff --git a/block/fops.c b/block/fops.c
index 3696665e586a..f8227ef0719f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -198,8 +198,10 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
-
+	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
+		opf |= REQ_ALLOC_CACHE;
+	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
+			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
 	atomic_set(&dio->ref, 1);
 	/*
@@ -320,7 +322,10 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
+	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
+		opf |= REQ_ALLOC_CACHE;
+	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
+			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->flags = 0;
 	dio->iocb = iocb;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4c21f6e69e18..10406f57d339 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -408,8 +408,6 @@ extern int bioset_init_from_src(struct bio_set *bs, struct bio_set *src);
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 			     unsigned int opf, gfp_t gfp_mask,
 			     struct bio_set *bs);
-struct bio *bio_alloc_kiocb(struct kiocb *kiocb, struct block_device *bdev,
-		unsigned short nr_vecs, unsigned int opf, struct bio_set *bs);
 struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned short nr_iovecs);
 extern void bio_put(struct bio *);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0c3563b45fe9..d4ba5251a3a0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -328,7 +328,6 @@ enum {
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
-	BIO_PERCPU_CACHE,	/* can participate in per-cpu alloc cache */
 	BIO_FLAG_LAST
 };
 
@@ -415,6 +414,7 @@ enum req_flag_bits {
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
 	__REQ_POLLED,		/* caller polls for completion using bio_poll */
+	__REQ_ALLOC_CACHE,	/* allocate IO from cache if available */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -440,6 +440,7 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_POLLED		(1ULL << __REQ_POLLED)
+#define REQ_ALLOC_CACHE		(1ULL << __REQ_ALLOC_CACHE)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
-- 
2.15.0

