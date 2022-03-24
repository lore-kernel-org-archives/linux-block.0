Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E1C433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 20:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353429AbiCXUhE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353433AbiCXUhD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 16:37:03 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D4B91AC
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:31 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id z19so1695420qtw.2
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dtKGQivDhkGsgWB7I0CubwUBOrK/SvKeob7r58iokR8=;
        b=uRsrRetI0EeVZ0apXvTtPE+/LveNNyK6606oYpOYxXLYmy/lWXjXPmk01IkEf9hQDv
         B0y8EE22IfZ+FVEXMsPN+kjd20bN5fTmq8bgniaiYNPsoDrSFqBsqOnCKSEEkce8XNo7
         U6v5fJaUXHfot3h6BUOKeMh0cr2YQUC9EwapvLc+xFXkYMrqsLNDRD599hhOpMJPBPGo
         eokyPtqv4/QQVfkAgzioP0owre2jh3CMp8gTlS3LBZwuHsp0+GkJx2iZZKMgM6qRJr19
         EyBvVb200WKvxp4rT45AhvwiQh5MX+T7FL/Rp61WQ6Pmr+WmLfjbmeQvLToov59pl10b
         6IKw==
X-Gm-Message-State: AOAM533UQOEUn6kNqaiPPBVAU3j8xZw3qMDHqmYBiUXGX5TD2PlHHpmy
        5yVZKeMFIi6Boit+icXml4Qh
X-Google-Smtp-Source: ABdhPJzQ9W1d7krZRbk35jIeuKkkOV5bjpJV2+501iJSjml1aPEcHX8qWgNTa4kTu18M39ra1BzSXw==
X-Received: by 2002:ac8:5e13:0:b0:2e1:cd7e:a29e with SMTP id h19-20020ac85e13000000b002e1cd7ea29emr6090711qtx.31.1648154130521;
        Thu, 24 Mar 2022 13:35:30 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a16b500b0067b1205878esm2005527qkj.7.2022.03.24.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:35:30 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v3 2/3] block: allow use of per-cpu bio alloc cache by block drivers
Date:   Thu, 24 Mar 2022 16:35:25 -0400
Message-Id: <20220324203526.62306-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220324203526.62306-1-snitzer@kernel.org>
References: <20220324203526.62306-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Refine per-cpu bio alloc cache interfaces so that DM and other block
drivers can properly create and use the cache:

DM uses bioset_init_from_src() to do its final bioset initialization,
so must update bioset_init_from_src() to set BIOSET_PERCPU_CACHE if
%src bioset has a cache.

Also move bio_clear_polled() to include/linux/bio.h to allow users
outside of block core.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/bio.c         | 2 ++
 block/blk.h         | 6 ------
 include/linux/bio.h | 6 ++++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 09b714469b06..859f728e42dc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1769,6 +1769,8 @@ int bioset_init_from_src(struct bio_set *bs, struct bio_set *src)
 		flags |= BIOSET_NEED_BVECS;
 	if (src->rescue_workqueue)
 		flags |= BIOSET_NEED_RESCUER;
+	if (src->cache)
+		flags |= BIOSET_PERCPU_CACHE;
 
 	return bioset_init(bs, src->bio_pool.min_nr, src->front_pad, flags);
 }
diff --git a/block/blk.h b/block/blk.h
index 9cb04f24ba8a..4f6b172c3342 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -451,12 +451,6 @@ extern struct device_attribute dev_attr_events;
 extern struct device_attribute dev_attr_events_async;
 extern struct device_attribute dev_attr_events_poll_msecs;
 
-static inline void bio_clear_polled(struct bio *bio)
-{
-	/* can't support alloc cache if we turn off polling */
-	bio->bi_opf &= ~(REQ_POLLED | REQ_ALLOC_CACHE);
-}
-
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 10406f57d339..a40a4ba2771f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -783,6 +783,12 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline void bio_clear_polled(struct bio *bio)
+{
+	/* can't support alloc cache if we turn off polling */
+	bio->bi_opf &= ~(REQ_POLLED | REQ_ALLOC_CACHE);
+}
+
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, unsigned int opf, gfp_t gfp);
 
-- 
2.15.0

