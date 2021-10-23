Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD1C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30986108B
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJWQYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWQYK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 12:24:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC79C061714
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso7492063wmd.3
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgYgX1V6iC19ADVcmUcsDZUvqPBrKkuru1MqVCti3TU=;
        b=X7ATy8fS+Tk+24i7UD8yvviCV+fAyagdrDlTwyPi1kzq7pXIwLp4GeQUodSVVuz+Fa
         /PBE+0oF7W+QIhsy7/ySAnrBia9/Hs3BNA0Fw4bPXih0BgERu722axHHLIYXrSyKfY4P
         xMVdugntHEKiKGolg/MAhs6BsZjQngVMXNArY/BpeudXcROIiEpsSthQdjHE5LBN1JAz
         Mt3htajwYy9F0oeePCB7WEA6PUkZJZF6Z19i2Nq87U+8ct1SmyIQ5KXVIgj2xqiM4yOQ
         Dz4PGaMocY6+HYv5lltbDpdaCJvOKWMTiW1vc0kvLB3Rv0+kGbtrYp+Woo2mjKQziCtG
         lNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgYgX1V6iC19ADVcmUcsDZUvqPBrKkuru1MqVCti3TU=;
        b=qYVQLRkJZ/U/UrD4WpyexAoo510SVph+sOGnzyl4f/vfijscpYeNp62seNlOoWY1iC
         h9CanQL8LcMs0yPIu5vACLnnLiABIFMFpZk3bJYoXXjPzTdSVfVJNX/sZBDvVEzI8GI0
         83yhH4S5BMlrXuIf7MhMchF2BDkaQA9fqq27bjxnOToDCWC8+nPsLmVIyvwkcRj0omU7
         x88w58/xy3D81vRaDnF0up1g4YlKDdHLZ7ai/3UNAuOVesf43zlVBHlSroBY+uXTEqne
         4Hv5yiK5h7kBVFiawxPJkOUNraGmgK2ZyGcAQjISg9/hYTPDer5baevXfXlEpGnBMGQO
         txDg==
X-Gm-Message-State: AOAM53134BAiosJFYWu4CH4QaOsLSrhKMc80KnTeyhMASOoGAhcK6CpH
        xcw/nWjkhL/HWS4JNPxQfX6s4aA/X6k=
X-Google-Smtp-Source: ABdhPJx/tQbRK/dvkmbE1iCqTCL17aIHSRaW4PmJ0Q8PP2mfidkQFKXG0CHruItDU72q+D71Ecs3lg==
X-Received: by 2002:a1c:4e18:: with SMTP id g24mr2904290wmh.180.1635006109555;
        Sat, 23 Oct 2021 09:21:49 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id c16sm2174799wrt.43.2021.10.23.09.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:21:49 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 4/5] block: kill unused polling bits in __blkdev_direct_IO()
Date:   Sat, 23 Oct 2021 17:21:35 +0100
Message-Id: <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635006010.git.asml.silence@gmail.com>
References: <cover.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
serves only multio-bio I/O, which we don't poll. Now we can remove
anything related to I/O polling from it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 8800b0ad5c29..997904963a9d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -190,7 +190,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
@@ -216,12 +215,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	if (is_read && iter_is_iovec(iter))
 		dio->flags |= DIO_SHOULD_DIRTY;
 
-	/*
-	 * Don't plug for HIPRI/polled IO, as those should go straight
-	 * to issue
-	 */
-	if (!(iocb->ki_flags & IOCB_HIPRI))
-		blk_start_plug(&plug);
+	blk_start_plug(&plug);
 
 	for (;;) {
 		bio_set_dev(bio, bdev);
@@ -254,11 +248,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
-			if (do_poll)
-				bio_set_polled(bio, iocb);
 			submit_bio(bio);
-			if (do_poll)
-				WRITE_ONCE(iocb->private, bio);
 			break;
 		}
 		if (!(dio->flags & DIO_MULTI_BIO)) {
@@ -271,7 +261,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->flags |= DIO_MULTI_BIO;
 			atomic_set(&dio->ref, 2);
-			do_poll = false;
 		} else {
 			atomic_inc(&dio->ref);
 		}
@@ -280,8 +269,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
-	if (!(iocb->ki_flags & IOCB_HIPRI))
-		blk_finish_plug(&plug);
+	blk_finish_plug(&plug);
 
 	if (!is_sync)
 		return -EIOCBQUEUED;
@@ -290,9 +278,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(dio->waiter))
 			break;
-
-		if (!do_poll || !bio_poll(bio, NULL, 0))
-			blk_io_schedule();
+		blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 
-- 
2.33.1

