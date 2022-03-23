Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD1C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 19:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiCWTrE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiCWTrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 15:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C05B98BE14
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648064730;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:in-reply-to:in-reply-to:
         references:references; bh=ewXCoGrLUptePB/yghi1giztCZDIQfZAZPwz3EjuzAI=;
        b=A72SVye+5smXu3u2GXErBjMTSPwPE/wlCwg15HAXXQORxE52KUjSbOTpEHz6Gth+H0F45c
        ko5VeSVDxPt1OmHpMAITR/aALIaMKk6OocC4tgLEXhZHkX2dFMUkiIK93u/6PgseiDtPqq
        k4ez3cGNCPC4T+INFhFmValmA5B9JyE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-RHqboVzQN_izJlGrlOHejg-1; Wed, 23 Mar 2022 15:45:29 -0400
X-MC-Unique: RHqboVzQN_izJlGrlOHejg-1
Received: by mail-qt1-f198.google.com with SMTP id f22-20020ac840d6000000b002dd4d87de21so1978277qtm.23
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ewXCoGrLUptePB/yghi1giztCZDIQfZAZPwz3EjuzAI=;
        b=7DKmCCPEP1M2iu6K3eBrpaq79m2p/CBp44pDDnZJaQCEp0QQubJjpkTVoVKJWT5Ws0
         Y6oRydnes3W+A+jfhuCOhdml0u6oaNyyKG0B60ZRD3uRzE4/AvOw046heNQiI6U9C+7K
         6+fpau4pyuZM2qJyGq+5k4gGSVW3CAdyT1B/mrWU4vgGazhKECB9D/7U3iKxtzuj29W8
         VysR+NqCD0PwN6K6JzlbLhKGC0t+Ih+JDNr843SQg5qIP7S13jk9gI0QDlqYwBpuy5oi
         CokDi77FyJCzfp+1sj+FS6H5A0snyg3KHWCN/L3S4HkRZDkPSWgB//6DTCk/OH6sCJGq
         7gVQ==
X-Gm-Message-State: AOAM531d7X6EaTm1vFvIYeUCrM4r5cNdhLZUk+wkOjXYEcaJOKTfXmhm
        TiGEdQl/UnZd8qSHegoC6m7UJ0JduT6wbi2fpelPeTDAe3FVLtQIrtRI+qo2pKO1dBy35DQBfXd
        A5cVLj8A1KWbkcLFkgcJOvw==
X-Received: by 2002:ac8:7fcc:0:b0:2e0:684e:42cc with SMTP id b12-20020ac87fcc000000b002e0684e42ccmr1353713qtk.35.1648064729117;
        Wed, 23 Mar 2022 12:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRo/E6Via9iAEdkuG26l/B0IpzCO611anBQnTlTq6VFsvjqWDfBgpNUyUNJkJuIgGuIsZXHA==
X-Received: by 2002:ac8:7fcc:0:b0:2e0:684e:42cc with SMTP id b12-20020ac87fcc000000b002e0684e42ccmr1353698qtk.35.1648064728862;
        Wed, 23 Mar 2022 12:45:28 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h62-20020a37b741000000b0067da4164f8fsm425972qkf.126.2022.03.23.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:45:28 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 2/4] block: allow BIOSET_PERCPU_CACHE use from bio_alloc_bioset
Date:   Wed, 23 Mar 2022 15:45:22 -0400
Message-Id: <20220323194524.5900-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220323194524.5900-1-snitzer@kernel.org>
References: <20220323194524.5900-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add REQ_ALLOC_CACHE and set it in %opf passed to bio_alloc_bioset to
inform bio_alloc_bioset (and any stacked block drivers) that bio should
be allocated from respective bioset's per-cpu alloc cache if possible.

This decouples access control to the alloc cache (via REQ_ALLOC_CACHE)
from actual participation in a specific alloc cache (BIO_PERCPU_CACHE).
Otherwise an upper layer's bioset may not have an alloc cache, in which
case the bio issued to underlying device(s) wouldn't reflect that
allocating from an alloc cache warranted (if possible).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/bio.c               | 33 ++++++++++++++++++++-------------
 include/linux/bio.h       |  4 +++-
 include/linux/blk_types.h |  4 +++-
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a7633aa82d7d..0b65ea241f54 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -440,11 +440,7 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
 		return bio;
 	}
 	put_cpu();
-	bio = bio_alloc_bioset(bdev, nr_vecs, opf, gfp, bs);
-	if (!bio)
-		return NULL;
-	bio_set_flag(bio, BIO_PERCPU_CACHE);
-	return bio;
+	return NULL;
 }
 
 /**
@@ -488,11 +484,24 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	gfp_t saved_gfp = gfp_mask;
 	struct bio *bio;
 	void *p;
+	bool use_alloc_cache;
 
 	/* should not use nobvec bioset for nr_vecs > 0 */
 	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
+	use_alloc_cache = (bs->cache && (opf & REQ_ALLOC_CACHE) &&
+			   nr_vecs <= BIO_INLINE_VECS);
+	if (use_alloc_cache) {
+		bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf, gfp_mask, bs);
+		if (bio)
+			return bio;
+		/*
+		 * No cached bio available, mark bio returned below to
+		 * particpate in per-cpu alloc cache.
+		 */
+	}
+
 	/*
 	 * submit_bio_noacct() converts recursion to iteration; this means if
 	 * we're running beneath it, any bios we allocate and submit will not be
@@ -546,6 +555,8 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		bio_init(bio, bdev, NULL, 0, opf);
 	}
 
+	if (use_alloc_cache)
+		bio_set_flag(bio, BIO_PERCPU_CACHE);
 	bio->bi_pool = bs;
 	return bio;
 
@@ -795,10 +806,7 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 {
 	struct bio *bio;
 
-	if (bs->cache && bio_src->bi_opf & REQ_POLLED)
-		bio = bio_alloc_percpu_cache(bdev, 0, bio_src->bi_opf, gfp, bs);
-	else
-		bio = bio_alloc_bioset(bdev, 0, bio_src->bi_opf, gfp, bs);
+	bio = bio_alloc_bioset(bdev, 0, bio_src->bi_opf, gfp, bs);
 	if (!bio)
 		return NULL;
 
@@ -1792,10 +1800,9 @@ EXPORT_SYMBOL(bioset_init_from_src);
 struct bio *bio_alloc_kiocb(struct kiocb *kiocb, struct block_device *bdev,
 		unsigned short nr_vecs, unsigned int opf, struct bio_set *bs)
 {
-	if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE) || nr_vecs > BIO_INLINE_VECS)
-		return bio_alloc_bioset(bdev, nr_vecs, opf, GFP_KERNEL, bs);
-
-	return bio_alloc_percpu_cache(bdev, nr_vecs, opf, GFP_KERNEL, bs);
+	if (kiocb->ki_flags & IOCB_ALLOC_CACHE)
+		opf |= REQ_ALLOC_CACHE;
+	return bio_alloc_bioset(bdev, nr_vecs, opf, GFP_KERNEL, bs);
 }
 EXPORT_SYMBOL_GPL(bio_alloc_kiocb);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 709663ae757a..1be27e87a1f4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -783,6 +783,8 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 {
 	bio->bi_opf |= REQ_POLLED;
+	if (kiocb->ki_flags & IOCB_ALLOC_CACHE)
+		bio->bi_opf |= REQ_ALLOC_CACHE;
 	if (!is_sync_kiocb(kiocb))
 		bio->bi_opf |= REQ_NOWAIT;
 }
@@ -791,7 +793,7 @@ static inline void bio_clear_polled(struct bio *bio)
 {
 	/* can't support alloc cache if we turn off polling */
 	bio_clear_flag(bio, BIO_PERCPU_CACHE);
-	bio->bi_opf &= ~REQ_POLLED;
+	bio->bi_opf &= ~(REQ_POLLED | REQ_ALLOC_CACHE);
 }
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5561e58d158a..5f9a0c39d4c5 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -327,7 +327,7 @@ enum {
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
-	BIO_PERCPU_CACHE,	/* can participate in per-cpu alloc cache */
+	BIO_PERCPU_CACHE,	/* participates in per-cpu alloc cache */
 	BIO_FLAG_LAST
 };
 
@@ -414,6 +414,7 @@ enum req_flag_bits {
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
 	__REQ_POLLED,		/* caller polls for completion using bio_poll */
+	__REQ_ALLOC_CACHE,	/* allocate IO from cache if available */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -439,6 +440,7 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_POLLED		(1ULL << __REQ_POLLED)
+#define REQ_ALLOC_CACHE		(1ULL << __REQ_ALLOC_CACHE)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
-- 
2.15.0

