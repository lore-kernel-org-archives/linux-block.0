Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1ECC04EB9
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390F32146F
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="et+KHCIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390F32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeK3KCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:02:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55987 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeK3KCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 05:02:48 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so6358932itg.5
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gxo4TyNc7iO+Dp6T0YhlBuNWFZ65rKoZke/uE/QmWz8=;
        b=et+KHCIpO3SJ8lS3wL6UFNZNS9bjepBKdfyS08cyZHnppbFgxJUPPLGij6bZiKsLoA
         BH2aNw98ittsmc4Nch+dtS9cjnvr7YoGSJ4LG0U47fZRZWhD3KpwYqjwkdZ2Hxa9gqgy
         JPT3CRxQHG/QGQSBHk/AIDDenJWXAxGQjeLesXLUNZ6sQXCJ2+ZjAsBoC3ynHMUFjatZ
         PxjikrG+X4S7w/w2TV8C1BGCxo2L8kim132amZpLoRgOjA7E7dNtM0dOHJpKo/YL8PCc
         LAqFetiFMZGtWmS4lThwp83c4z+qUtX4NMDHBBF6NTwkYNcP1CxC70+aPscTewP62OR4
         tfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gxo4TyNc7iO+Dp6T0YhlBuNWFZ65rKoZke/uE/QmWz8=;
        b=kTLcH0HUBbYlBCceVnnxPBZnJeH7aXAfoqkBJgF8tsiqJlPazloq79Uze/1OPX3Dvc
         a3IggPSYaeJ5IwvkXF4bUibEKoIcezh8UtPYv43cI5Z+pflMxbjw61WSB6EeGp2eNLg9
         htQ1LNdv/rWQIRBEP26sEibrsvvIN0tupigJ89y0yua7Vt2hLFIAEhj87wMl8M1TDzAF
         9GcEYo82oqVeIpTMe+CK45mkR5NxaGuduWC0IX6XeiJa3UFBALfAa78iZjRM6p+9zAhd
         HlkpaUt8KXKqUM4jtArYumWuJahDNeIn6JBqR/ndTE+yG7DSPIRGjDx/rlrcoqazcRgF
         z8ag==
X-Gm-Message-State: AA+aEWYD5v5AAC7C5J0LtasiCWReb1hTSNBXOrL1xvyHVSbCbCWzrc4O
        TTKAu+cKJY4kva6NQZEUzkDJFClpVsI=
X-Google-Smtp-Source: AFSGD/VJDIHGUmYUrbLTs7usKXhB/oaFPGEjUJcVcpKUFig9FCP5CR1UoEm0VLZP73c3n9Jwudu/CQ==
X-Received: by 2002:a05:660c:648:: with SMTP id y8mr3250527itk.48.1543532142051;
        Thu, 29 Nov 2018 14:55:42 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r21sm1463721ita.27.2018.11.29.14.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:55:41 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: avoid extra bio reference for async O_DIRECT
Message-ID: <b890e540-fc63-13c1-bef0-1e6a39d1850e@kernel.dk>
Date:   Thu, 29 Nov 2018 15:55:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio referencing has a trick that doesn't do any actual atomic
inc/dec on the reference count until we have to elevator to > 1. For the
async IO O_DIRECT case, we can't use the simple DIO variants, so we use
__blkdev_direct_IO(). It always grabs an extra reference to the bio
after allocation, which means we then enter the slower path of actually
having to do atomic_inc/dec on the count.

We don't need to do that for the async case, unless we end up going
multi-bio, in which case we're already doing huge amounts of IO. For the
smaller IO case (< BIO_MAX_PAGES), we can do without the extra ref.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/block_dev.c b/fs/block_dev.c
index f3bd41f80421..44fc9da13f68 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -292,10 +292,26 @@ static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
 	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
 }
 
+static void blkdev_bio_dirty_release(struct bio *bio, bool should_dirty)
+{
+	if (should_dirty) {
+		bio_check_pages_dirty(bio);
+	} else {
+		struct bio_vec *bvec;
+		int i;
+
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_for_each_segment_all(bvec, bio, i)
+				put_page(bvec->bv_page);
+		bio_put(bio);
+	}
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
 	bool should_dirty = dio->should_dirty;
+	bool should_free = false;
 
 	if (dio->multi_bio && !atomic_dec_and_test(&dio->ref)) {
 		if (bio->bi_status && !dio->bio.bi_status)
@@ -313,26 +329,20 @@ static void blkdev_bio_end_io(struct bio *bio)
 			}
 
 			dio->iocb->ki_complete(iocb, ret, 0);
-			bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
 
 			WRITE_ONCE(dio->waiter, NULL);
 			blk_wake_io_task(waiter);
 		}
+		/* last bio is done, now we can free the parent holding dio */
+		should_free = dio->multi_bio;
 	}
 
-	if (should_dirty) {
-		bio_check_pages_dirty(bio);
-	} else {
-		struct bio_vec *bvec;
-		int i;
-
-		if (!bio_flagged(bio, BIO_HOLD_PAGES))
-			bio_for_each_segment_all(bvec, bio, i)
-				put_page(bvec->bv_page);
-		bio_put(bio);
-	}
+	if (!dio->is_sync)
+		blkdev_bio_dirty_release(bio, should_dirty);
+	if (should_free)
+		bio_put(&dio->bio);
 }
 
 static ssize_t
@@ -355,14 +365,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EINVAL;
 
 	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
-	bio_get(bio); /* extra ref for the completion handler */
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
-	if (dio->is_sync)
+	if (dio->is_sync) {
 		dio->waiter = current;
-	else
+		bio_get(bio);
+	} else {
 		dio->iocb = iocb;
+	}
 
 	dio->size = 0;
 	dio->multi_bio = false;
@@ -425,6 +436,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		}
 
 		if (!dio->multi_bio) {
+			/*
+			 * async needs an extra reference if we are goign
+			 * multi-bio only, so we can ensure that 'dio'
+			 * sticks around.
+			 */
+			if (!is_sync)
+				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
 		} else {
@@ -458,6 +476,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	if (likely(!ret))
 		ret = dio->size;
 
+	blkdev_bio_dirty_release(bio, dio->should_dirty);
 	bio_put(&dio->bio);
 	return ret;
 }

-- 
Jens Axboe

