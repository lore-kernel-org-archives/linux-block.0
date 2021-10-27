Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF76C4332F
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B89610A6
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhJ0MYB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbhJ0MYB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 08:24:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A18C061570
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 82-20020a1c0055000000b0032ccc3ad5c1so4158848wma.2
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1POAIRR4spiafMLsX1khFGBr5yXWQ77ysbzkKIjVLc=;
        b=fdp73yMe3kw33V8U8vrulbIl30IAPFHtJSD4v7QH1MvjeoqOgFsuXyildrUhBXYoCu
         uTuR1tdFRpqO+osaZq1Y9ZXnSpBHQvwdF8ji2hiyJ5ESeuyt3GTEYoB6DifUGbXO0so3
         Gh3W4k4Dv4KOM21BZfuap225WxnX0VJpf2noXYSbzKukFHzRJqTUqdYCLdjk5jyyDi/7
         HehRdTQR3OC6Q0eAYMXAdgCURJLWQUHkpxnIS1KDZ47pAMrlMbYc/oW6KAmjnx5sjwle
         XIp2va8aSqa0dZB0h3yxVYLTgoA6uiG6yTo25U2YrmbayiBEmeet9mJwMv0vWEzE+eGz
         zWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1POAIRR4spiafMLsX1khFGBr5yXWQ77ysbzkKIjVLc=;
        b=YPvNrxFgiqHal7G4dKJcT2sg5lHEEiLn+K3JOUxfB9hm1aLi+JMbVzcnc5MZ179MO0
         xp1BE/6YsM+N+GVtCUtHXdxOb6CCyA0la0JyGoK0fwyGCpsHbRjT6alCKSl2yJQRh6CF
         6emhTY1z7vWy+ol4vWYqhhhPRFitzLQBrlc9VpacwzoDSvp6VTHAnLeyJHFkNmpwDL3c
         qPJf6r28zr7BeyOCZ9UHyJcjsToXn2eUdGLti1DgBVsQeEiLBsGXhhxcH26mzKbIfTzl
         /9BQptKmVjESQxqSOvMU5lEmUIt2u6LldIGTQJtEqOGmeKAktt4uDwUTRBrrDIQo0cch
         p7+g==
X-Gm-Message-State: AOAM531NBmYgCOKzl6lislBfzKidJFn+6a1SrYL1yLFY06kiO0Lh2tGy
        1UdIshNvLmOSxm7gy0AnkT6L5SDD/oM=
X-Google-Smtp-Source: ABdhPJy/OZXpPcRhwE0eECTSZ8Ec8xZzqh3S1vnp4MjPUjtHm3z9i8Dp4IHUyGEJroF9E/sxvZxPxA==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr5335703wmk.2.1635337294366;
        Wed, 27 Oct 2021 05:21:34 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.100])
        by smtp.gmail.com with ESMTPSA id d8sm22738807wrv.80.2021.10.27.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:21:34 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 3/4] block: kill DIO_MULTI_BIO
Date:   Wed, 27 Oct 2021 13:21:09 +0100
Message-Id: <88eb488aae9ed4852a30f3a7132f296f56e43b80.1635337135.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635337135.git.asml.silence@gmail.com>
References: <cover.1635337135.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now __blkdev_direct_IO() serves only multi-bio I/O, thus remove
not used anymore single bio refcounting optimisations.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 983e993c9a4b..8594852bd344 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -124,9 +124,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 }
 
 enum {
-	DIO_MULTI_BIO		= 1,
-	DIO_SHOULD_DIRTY	= 2,
-	DIO_IS_SYNC		= 4,
+	DIO_SHOULD_DIRTY	= 1,
+	DIO_IS_SYNC		= 2,
 };
 
 struct blkdev_dio {
@@ -150,7 +149,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 	if (bio->bi_status && !dio->bio.bi_status)
 		dio->bio.bi_status = bio->bi_status;
 
-	if (!(dio->flags & DIO_MULTI_BIO) || atomic_dec_and_test(&dio->ref)) {
+	if (atomic_dec_and_test(&dio->ref)) {
 		if (!(dio->flags & DIO_IS_SYNC)) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
@@ -165,8 +164,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			}
 
 			dio->iocb->ki_complete(iocb, ret, 0);
-			if (dio->flags & DIO_MULTI_BIO)
-				bio_put(&dio->bio);
+			bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
 
@@ -201,11 +199,17 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
+	atomic_set(&dio->ref, 1);
+	/*
+	 * Grab an extra reference to ensure the dio structure which is embedded
+	 * into the first bio stays around.
+	 */
+	bio_get(bio);
+
 	is_sync = is_sync_kiocb(iocb);
 	if (is_sync) {
 		dio->flags = DIO_IS_SYNC;
 		dio->waiter = current;
-		bio_get(bio);
 	} else {
 		dio->flags = 0;
 		dio->iocb = iocb;
@@ -251,20 +255,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			submit_bio(bio);
 			break;
 		}
-		if (!(dio->flags & DIO_MULTI_BIO)) {
-			/*
-			 * AIO needs an extra reference to ensure the dio
-			 * structure which is embedded into the first bio
-			 * stays around.
-			 */
-			if (!is_sync)
-				bio_get(bio);
-			dio->flags |= DIO_MULTI_BIO;
-			atomic_set(&dio->ref, 2);
-		} else {
-			atomic_inc(&dio->ref);
-		}
-
+		atomic_inc(&dio->ref);
 		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
-- 
2.33.1

