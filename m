Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C23C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 19:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiCVTvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiCVTvD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 15:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5485550469
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647978574;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:in-reply-to:in-reply-to:
         references:references; bh=1NTHYZkzBmaMh1ItKjSkJntcIn8iIb3p4X2tzJvZIko=;
        b=VZzS77FxDjqEVD9cckUmdpzJm6zgdOIkiiQZbJyIhr4ylM0TpFQ9cZIFmcScvy7JKIGxNe
        Hm9ehvj66X3iI56xWu3b7AATJg7Xal+QVLevBNTi/u1Y4mDQUGJRprw1adVAxY0u9pThvc
        5jlw9NUmoUE+bknawkL7y82UuI8kK9o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-lDnC8VkEP16kkEQTd803uQ-1; Tue, 22 Mar 2022 15:49:31 -0400
X-MC-Unique: lDnC8VkEP16kkEQTd803uQ-1
Received: by mail-qt1-f198.google.com with SMTP id p6-20020a05622a00c600b002e1cb9508e8so12336253qtw.20
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1NTHYZkzBmaMh1ItKjSkJntcIn8iIb3p4X2tzJvZIko=;
        b=BqbupsSBPqPWP/rmLuTRwY0JKN+SxFmcGqxLq6cNGAEdJz550UJJxZAeNfwwmeHBlQ
         BJPr1MFQm4lwWCtEQ9jMGEkDtVv9luws0UWWKgb/Wig/075QQ5zdcht8BC41/u7A40t3
         rCGyZY1TaL4R4EngKh/a5hyt0L/PKk7MkrdtG+AQdV+21MMmTGd6FyYwKaXvtSwBEUFk
         Oq2J6P1TuV3rezx56GL5rFqJsFHMCnyWKRFwFyEi507ltI61kawNvbqJxGdd6xSrf8BS
         7zgUhHuHmq5lg48IOSw1LOxjd/SAz8Lm4fyAQd6WTXdR2Hxqo/Og6FjOhzwbSs9ImbZU
         Obzg==
X-Gm-Message-State: AOAM530h+RSGK7z+MgTVpkWe8QXsjfc+nvQe4iiHaWc58280xme+R6GG
        +IeEaq7dTxdzKPzPL06XGeowf0j5pcW6tadxOn1QntN6kRse5/EwTUFMUX86CBA7c5jRyn7r8zV
        ClkZlXlejjhFlYZbkznt0fw==
X-Received: by 2002:a37:a842:0:b0:67b:305c:6c8a with SMTP id r63-20020a37a842000000b0067b305c6c8amr16313062qke.225.1647978570440;
        Tue, 22 Mar 2022 12:49:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvYHkXfWn6Fvg9HfMKpOQHdAfRhM9jz9XzPB3xppVu7owmXOq3fC0UGbNmng59cIfiD90P1A==
X-Received: by 2002:a37:a842:0:b0:67b:305c:6c8a with SMTP id r63-20020a37a842000000b0067b305c6c8amr16313048qke.225.1647978570122;
        Tue, 22 Mar 2022 12:49:30 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a030800b002e1c9304db8sm14480140qtw.38.2022.03.22.12.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:49:29 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: allow BIOSET_PERCPU_CACHE use from bio_alloc_clone
Date:   Tue, 22 Mar 2022 15:49:25 -0400
Message-Id: <20220322194927.42778-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220322194927.42778-1-snitzer@kernel.org>
References: <20220322194927.42778-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These changes allow DM core to make full use of BIOSET_PERCPU_CACHE:

Factor out bio_alloc_percpu_cache() from bio_alloc_kiocb() to allow
use by bio_alloc_clone() too.

Update bioset_init_from_src() to set BIOSET_PERCPU_CACHE if
bio_src->cache is not NULL.

Move bio_clear_polled() to include/linux/bio.h to allow users outside
of block core.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/bio.c         | 56 +++++++++++++++++++++++++++++++++--------------------
 block/blk.h         |  7 -------
 include/linux/bio.h |  7 +++++++
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b15f5466ce08..2c3a1f678461 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -728,6 +728,33 @@ void bio_put(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_put);
 
+static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
+		unsigned short nr_vecs, unsigned int opf, gfp_t gfp,
+		struct bio_set *bs)
+{
+	struct bio_alloc_cache *cache;
+	struct bio *bio;
+
+	cache = per_cpu_ptr(bs->cache, get_cpu());
+	if (cache->free_list) {
+		bio = cache->free_list;
+		cache->free_list = bio->bi_next;
+		cache->nr--;
+		put_cpu();
+		bio_init(bio, bdev, nr_vecs ? bio->bi_inline_vecs : NULL,
+			 nr_vecs, opf);
+		bio->bi_pool = bs;
+		bio_set_flag(bio, BIO_PERCPU_CACHE);
+		return bio;
+	}
+	put_cpu();
+	bio = bio_alloc_bioset(bdev, nr_vecs, opf, gfp, bs);
+	if (!bio)
+		return NULL;
+	bio_set_flag(bio, BIO_PERCPU_CACHE);
+	return bio;
+}
+
 static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
 	bio_set_flag(bio, BIO_CLONED);
@@ -768,7 +795,10 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 {
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(bdev, 0, bio_src->bi_opf, gfp, bs);
+	if (bs->cache && bio_src->bi_opf & REQ_POLLED)
+		bio = bio_alloc_percpu_cache(bdev, 0, bio_src->bi_opf, gfp, bs);
+	else
+		bio = bio_alloc_bioset(bdev, 0, bio_src->bi_opf, gfp, bs);
 	if (!bio)
 		return NULL;
 
@@ -1736,6 +1766,8 @@ int bioset_init_from_src(struct bio_set *bs, struct bio_set *src)
 		flags |= BIOSET_NEED_BVECS;
 	if (src->rescue_workqueue)
 		flags |= BIOSET_NEED_RESCUER;
+	if (src->cache)
+		flags |= BIOSET_PERCPU_CACHE;
 
 	return bioset_init(bs, src->bio_pool.min_nr, src->front_pad, flags);
 }
@@ -1753,35 +1785,17 @@ EXPORT_SYMBOL(bioset_init_from_src);
  *    Like @bio_alloc_bioset, but pass in the kiocb. The kiocb is only
  *    used to check if we should dip into the per-cpu bio_set allocation
  *    cache. The allocation uses GFP_KERNEL internally. On return, the
- *    bio is marked BIO_PERCPU_CACHEABLE, and the final put of the bio
+ *    bio is marked BIO_PERCPU_CACHE, and the final put of the bio
  *    MUST be done from process context, not hard/soft IRQ.
  *
  */
 struct bio *bio_alloc_kiocb(struct kiocb *kiocb, struct block_device *bdev,
 		unsigned short nr_vecs, unsigned int opf, struct bio_set *bs)
 {
-	struct bio_alloc_cache *cache;
-	struct bio *bio;
-
 	if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE) || nr_vecs > BIO_INLINE_VECS)
 		return bio_alloc_bioset(bdev, nr_vecs, opf, GFP_KERNEL, bs);
 
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
+	return bio_alloc_percpu_cache(bdev, nr_vecs, opf, GFP_KERNEL, bs);
 }
 EXPORT_SYMBOL_GPL(bio_alloc_kiocb);
 
diff --git a/block/blk.h b/block/blk.h
index ebaa59ca46ca..8e338e76d303 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -451,13 +451,6 @@ extern struct device_attribute dev_attr_events;
 extern struct device_attribute dev_attr_events_async;
 extern struct device_attribute dev_attr_events_poll_msecs;
 
-static inline void bio_clear_polled(struct bio *bio)
-{
-	/* can't support alloc cache if we turn off polling */
-	bio_clear_flag(bio, BIO_PERCPU_CACHE);
-	bio->bi_opf &= ~REQ_POLLED;
-}
-
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7523aba4ddf7..709663ae757a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -787,6 +787,13 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline void bio_clear_polled(struct bio *bio)
+{
+	/* can't support alloc cache if we turn off polling */
+	bio_clear_flag(bio, BIO_PERCPU_CACHE);
+	bio->bi_opf &= ~REQ_POLLED;
+}
+
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, unsigned int opf, gfp_t gfp);
 
-- 
2.15.0

