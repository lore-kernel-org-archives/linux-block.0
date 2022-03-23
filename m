Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F9FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiCWTrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiCWTrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 15:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 618048B6D1
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648064729;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:in-reply-to:in-reply-to:
         references:references; bh=AKeDBg4ZdHttOQXh6zOoYZL7eiQ4d/9ADfn1bk7vgsI=;
        b=byzL/NHCLkvlB9Nx0CdlubxkvubUaP20nZTCwFqeaXeul0jcLkXux6lIW+AZ+IDxeXvkUd
        Rdkfne0KFmIfT0Fx3wxhdvW/LpvuzNbrUzKijLNURTos/stA4bwlsKC9KjkMp4qNrsR/kl
        2ZuOfsJYbZiMgD4G9/o0X7q1qyoAo98=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-e-Yo4T29MEaU_GA9ETfJyg-1; Wed, 23 Mar 2022 15:45:28 -0400
X-MC-Unique: e-Yo4T29MEaU_GA9ETfJyg-1
Received: by mail-qt1-f199.google.com with SMTP id cb11-20020a05622a1f8b00b002e06f729debso2018986qtb.4
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AKeDBg4ZdHttOQXh6zOoYZL7eiQ4d/9ADfn1bk7vgsI=;
        b=MIeA4GmMkR315o37WuJdP3mUpAmOizL424cRcqyEcYEm4VB6Spv3MRX4QpKYLNSwr4
         NEuQc8G7JbR6i+cf+w7q7Vq1YbzJ78HfETJkiIY2TZKANW8E8tyQSJGy3lrBX1kU99nt
         bLD4Y/sWpK2IAPgh0YOqif/RKRcG5I1uPqZSX/c+ezbTOjDbu7jziXPspRcV7J8BHVQz
         A4oMSmO6Qguc7KGm9fwv2xkmIqgyvRtfCxqpAkdowPt+7tqOiG9eanP4sJFNDlmv/rHC
         YixErbFyahO06r5cmhjUZyGZwmgqcI5uvInwnfY2uCQuMsysoPh0HhCSUIVv48hynlQd
         ERnw==
X-Gm-Message-State: AOAM530Fsl5kdENL+LUubb6mKVlDpBnUMuxHoY277bdKGd8K4mpsybBz
        C2/dQEHD6i2DIfYQy09/nL6NFjpwIu7YgU6re81YpepbtDl/u5nhUa9wKULh6XZKieDGS2d8rMG
        fwbb6DmMPMEqdKhd8pAk9Ng==
X-Received: by 2002:ad4:5aa9:0:b0:441:3a0a:1aba with SMTP id u9-20020ad45aa9000000b004413a0a1abamr1463210qvg.20.1648064727288;
        Wed, 23 Mar 2022 12:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx14W12RoUy94PnscHvKvwxWAan+U2UFinhkJZ0fo2szicnnDf5lrhasgjpruR6xvmPU2ZYlw==
X-Received: by 2002:ad4:5aa9:0:b0:441:3a0a:1aba with SMTP id u9-20020ad45aa9000000b004413a0a1abamr1463195qvg.20.1648064727094;
        Wed, 23 Mar 2022 12:45:27 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u129-20020a376087000000b0067e401d7177sm512410qkb.3.2022.03.23.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:45:26 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 1/4] block: allow BIOSET_PERCPU_CACHE use from bio_alloc_clone
Date:   Wed, 23 Mar 2022 15:45:21 -0400
Message-Id: <20220323194524.5900-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220323194524.5900-1-snitzer@kernel.org>
References: <20220323194524.5900-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These changes allow DM core to make full use of BIOSET_PERCPU_CACHE for
REQ_POLLED bios:

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
index b15f5466ce08..a7633aa82d7d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -420,6 +420,33 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
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
 /**
  * bio_alloc_bioset - allocate a bio for I/O
  * @bdev:	block device to allocate the bio for (can be %NULL)
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

