Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53817C4332F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA961212
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTTDS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhJTTDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 15:03:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DD4C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:01:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so48929940wrc.10
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLbr8nqrxe7GMXyMsxBZMG6F+lFCHgeEq7CQH0nvGuo=;
        b=MyS2zW3YvFTffdTZHUxGd5TazZaMSMJ/NyQ0+YtF3cwfb+c0ESfE+p97Zsh0ldt1qj
         tsBEpZxT0t6coBM48pJXn9UWTQrT3ELRBCSYqnAvL5NyYM3XSMM8kbtjnlyu6PLI3JCD
         Y2zfBrMS+qhIXnG4w9oOoaDcHDFJJ9pwBlbDHnWCW/gwqT2P33J6dHwLULcMLhyr63dV
         HJCJlxGeYYD/QfcgvIwhjH/MfqRiAW84ffeW2uYgNo8w87jxzOIumqLjQMNMgYn4WTKU
         Zc4VC2CEXaCs9ZgpHIh/btkm4oG8/EKili1in6S6Aqmtx/xrZeNHdhM5u+bUm3NHapBC
         bQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLbr8nqrxe7GMXyMsxBZMG6F+lFCHgeEq7CQH0nvGuo=;
        b=Y+5exMcrV366lorAZJs0NIux+3ZkhfeixGdYjhSomSgoCy6M8hbIrZqyTUWK/yKXcr
         U+4FjxSEkOCOYYXBvRJjlCKMqY8L6W2G3qYG1OIIZjVgyWJq7gWTvviqz5n85AJzbXK2
         1FfrKcKiZItsOFRxQ0PDU7BYS5+Bkdb6AlR8qYZsRzmUFiXmWUUb4KzjDaJ9GIhJ6RAK
         ft/rXQvfHqHVdaW0OtxJQTj8RtaaltUsKuu21HU90qrFOIcewxtrPB+YMIaT12eryZ8M
         jk69LJFvFw9YP1m0YnNgmShzcMf6GfY077A03B9IaDxwW1NAoUyNN0Sz+ZUT5HyphWX5
         kf9g==
X-Gm-Message-State: AOAM532cmEBp7iBRKjJlJmOGr8Pxtr8HCxNIrYsmH6AnYqrE1f7DfEh3
        1tODPDcqeA+YRBFn32HPjvtyN4CDh//7rQ==
X-Google-Smtp-Source: ABdhPJwsQYh04RtNriOn4mY8Buojnyb+2DzI3Riszt3HR2k8ll/PbLu/WBqkRUD50QVE3wfnJHlDaQ==
X-Received: by 2002:a5d:69cc:: with SMTP id s12mr1305768wrw.108.1634756461168;
        Wed, 20 Oct 2021 12:01:01 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id j11sm2743880wmi.24.2021.10.20.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:01:00 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 3/3] block: convert fops.c magic constants to SHIFT_SECTOR
Date:   Wed, 20 Oct 2021 20:00:50 +0100
Message-Id: <068782b9f7e97569fb59a99529b23bb17ea4c5e2.1634755800.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634755800.git.asml.silence@gmail.com>
References: <cover.1634755800.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't use shifting by a magic number 9 but replace with a more
descriptive SHIFT_SECTOR.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 8f733c919ed1..396537598e3e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -76,7 +76,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 
 	bio_init(&bio, vecs, nr_pages);
 	bio_set_dev(&bio, bdev);
-	bio.bi_iter.bi_sector = pos >> 9;
+	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_write_hint = iocb->ki_hint;
 	bio.bi_private = current;
 	bio.bi_end_io = blkdev_bio_end_io_simple;
@@ -225,7 +225,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 	for (;;) {
 		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector = pos >> 9;
+		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
@@ -565,16 +565,18 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
-					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
+		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					     len >> SECTOR_SHIFT, GFP_KERNEL,
+					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
-					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
+		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					     len >> SECTOR_SHIFT, GFP_KERNEL,
+					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
-					     GFP_KERNEL, 0);
+		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
+					     len >> SECTOR_SHIFT, GFP_KERNEL, 0);
 		break;
 	default:
 		error = -EOPNOTSUPP;
-- 
2.33.1

