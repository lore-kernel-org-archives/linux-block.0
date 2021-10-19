Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06861C4332F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B7960F46
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJSV06 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhJSV05 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5FDC061765
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v127so14528363wme.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vie2hOMzoHrUFDMkHnt8EnTGZllVCb0xIPYnVaf/naE=;
        b=i3/a1ktXlvw55dUOyFaY/u7NnHi4/+QvRBHaEzXnaqhRuJKyVvTHReCOkEB1aBVKm2
         yg3AvlQPibQVv49cZSgljLKjf40T9cXXv/B2GBQu140R4iYrR6QLr8UMAUjoebHo35M0
         lx4gsV9iygWSO7nPoySrOHD1Nlzq4vUTn/gZAop/bTa8zHG2QqKd0Nr3kOE9hYqggsH6
         07qZsM0h0X20Ht3uob0cIGmWmBozzfZ2Djr/N6HC9i3NyGV4AyvQsnyiic8UzkEOKBNp
         f+iuAu64R0m+VZZ+lN8c52B+VnjkkVzZfTSPZjbYtEdEbNnLme61qmiHdEXYY9aXVZ+K
         QBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vie2hOMzoHrUFDMkHnt8EnTGZllVCb0xIPYnVaf/naE=;
        b=LHtLOL409voHEu9SNBLjdCzB9yvTcdGOTEzu4hVENKq7kgQ584zUG71t2GjMmLrFZI
         5vo1a7Ls3v2VhoO+X7/TVEFnluccrPCvEPB3i6suEWUaTHFBI7P7adb9jp02EOsaYRpY
         6S/jhONqVuNzhoabmm+Ny0wRDUKZoMWJ29I4BEVEVPhwNVMw7AjHqB0CrsyPmPJkv8ck
         ogyZR8heU73ddn2cf5h2jo6PrBtt91xwq3blpCLFoAuMm1+6zw0vp9McBLcLX3DJQvYR
         zU9fjudBHyshtfxqgt2NBJhzK8TT4pOuhtDwI+MBGOtDO2sudfPyFOg3krfE1aaGiHMc
         AWIQ==
X-Gm-Message-State: AOAM533mNPpT6wH0PlzWxhgSLoWkOzuVks+wcymxb/lqO0mU5ifz8I1O
        C4J+ALFAXk9UE/fIGl80wrFZU52dhP1c+g==
X-Google-Smtp-Source: ABdhPJxkKlaQYf001wojZduWXNhNowYiUAA8WR6L2haNf+030WwY1ziKT/SQiULrWsr+Ns/VBvt82Q==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr8708473wme.137.1634678682629;
        Tue, 19 Oct 2021 14:24:42 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:42 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 12/16] block: add single bio async direct IO helper
Date:   Tue, 19 Oct 2021 22:24:21 +0100
Message-Id: <c8d2d919894fd0112f21723a9cb50b6c7cbd9613.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As with __blkdev_direct_IO_simple(), we can implement direct IO more
efficiently if there is only one bio. Add __blkdev_direct_IO_async() and
blkdev_bio_end_io_async(). This patch brings me from 4.45-4.5 MIOPS with
nullblk to 4.7+.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 7cf98db0595a..0f1332374756 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -305,6 +305,88 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	return ret;
 }
 
+static void blkdev_bio_end_io_async(struct bio *bio)
+{
+	struct blkdev_dio *dio = container_of(bio, struct blkdev_dio, bio);
+	struct kiocb *iocb = dio->iocb;
+	ssize_t ret;
+
+	if (likely(!bio->bi_status)) {
+		ret = dio->size;
+		iocb->ki_pos += ret;
+	} else {
+		ret = blk_status_to_errno(bio->bi_status);
+	}
+
+	iocb->ki_complete(iocb, ret, 0);
+
+	if (dio->flags & DIO_SHOULD_DIRTY) {
+		bio_check_pages_dirty(bio);
+	} else {
+		bio_release_pages(bio, false);
+		bio_put(bio);
+	}
+}
+
+static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
+					struct iov_iter *iter,
+					unsigned int nr_pages)
+{
+	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct blkdev_dio *dio;
+	struct bio *bio;
+	loff_t pos = iocb->ki_pos;
+	int ret = 0;
+
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
+	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
+	dio = container_of(bio, struct blkdev_dio, bio);
+	__bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = pos >> 9;
+	bio->bi_write_hint = iocb->ki_hint;
+	bio->bi_end_io = blkdev_bio_end_io_async;
+	bio->bi_ioprio = iocb->ki_ioprio;
+	dio->flags = 0;
+	dio->iocb = iocb;
+
+	ret = bio_iov_iter_get_pages(bio, iter);
+	if (unlikely(ret)) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return BLK_STS_IOERR;
+	}
+	dio->size = bio->bi_iter.bi_size;
+
+	if (iov_iter_rw(iter) == READ) {
+		bio->bi_opf = REQ_OP_READ;
+		if (iter_is_iovec(iter)) {
+			dio->flags |= DIO_SHOULD_DIRTY;
+			bio_set_pages_dirty(bio);
+		}
+	} else {
+		bio->bi_opf = dio_bio_write_op(iocb);
+		task_io_account_write(bio->bi_iter.bi_size);
+	}
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
+	/*
+	 * Don't plug for HIPRI/polled IO, as those should go straight
+	 * to issue
+	 */
+	if (iocb->ki_flags & IOCB_HIPRI) {
+		bio_set_polled(bio, iocb);
+		submit_bio(bio);
+		WRITE_ONCE(iocb->private, bio);
+	} else {
+		submit_bio(bio);
+	}
+	return -EIOCBQUEUED;
+}
+
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	unsigned int nr_pages;
@@ -313,9 +395,11 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		return 0;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
-	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_VECS)
-		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-
+	if (likely(nr_pages <= BIO_MAX_VECS)) {
+		if (is_sync_kiocb(iocb))
+			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
+		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
+	}
 	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
 }
 
-- 
2.33.1

