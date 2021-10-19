Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B278C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852A66135E
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhJSV1E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhJSV1B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:27:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86916C06176D
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so5646990wma.4
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EgGdcRessLiI1FhX2RaNc12KdVxW/zeIH1xYRNQfwU=;
        b=XH5xoa5wD9VRDzEjzmk2g+2N0zkPJThsMygbKK77vzMjOMGOCiUEEldIbKSEjEvtWG
         V8WLjxJJoQTCHWsdAJd9f7iJSfpRQo3MWHxkOhOdq5MBkdSiiuufDsVsr+rbtjvmDFhL
         SvEvNNdMhJs10mCdKRPtpdtXPrt8ie2rebLXNsQxD2TTw0Bd5itpgxYQTU6UPwxBW6mr
         6EhydPnQBmDpaNpH0dpAeCU0J2nNPnr86/yxWK0ROs0+60I7sHSIxheAwSwlpEfVgcOm
         4Zs2c1Xebb2ICVB+1FAe4S0NMM4hCUF0sB2hJ1qJjsGk4PNzAkloN66r64Ow2WlBWl24
         mOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EgGdcRessLiI1FhX2RaNc12KdVxW/zeIH1xYRNQfwU=;
        b=Mv3EtpFN7s0K4C+e8aVydEN702Y6cGgTdbueCbQ2EKyQeO44g1xchLqjFYsvdUY4EC
         F409iIeqAxu8237ogJz7sZBz2uLi9KmwovLQkHlGrYLInfXwGZI9KoQF9Kq0RSbcZzwY
         nslRR49ih8NGZ+r091UptzWrPRAfe1VrhiJY4sDcbdpl/Nk1RcEkI2Vbl+G+0fDLDTfo
         1KCmIbc8b4IrxDypW8h6U7wFHuJPrXN+aDBiWA6hsa0CdUhazAtFFdkfKVSZjqprFCeb
         AQ1U/N3bDaodNbJ6ORhjoqW90O8j1z4IWxBvnDY1eG4zgikH670mz2obiIkGDrPupwtY
         ZklA==
X-Gm-Message-State: AOAM5308JThlE4mdRtUwfR6RqcvpopBUKYT8w+wdx6u/OcCy54ZpwysY
        EtVqAMTB3lC5Ykk7cmjumZkBRtrQ9VGlgw==
X-Google-Smtp-Source: ABdhPJyTAwlnxG+msw3uUQnKbsSzM6FifGXac6J07zBoq0xL1pdzh7GGtlG6zSjYcyE6PihvEpKHfQ==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr9312837wmg.195.1634678685981;
        Tue, 19 Oct 2021 14:24:45 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:45 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 16/16] block: optimise submit_bio_checks for normal rw
Date:   Tue, 19 Oct 2021 22:24:25 +0100
Message-Id: <c53849108e8c2b831e78cd58b44244b27df43ab6.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Optimise the switch in submit_bio_checks() for reads, writes and
flushes. REQ_OP_READ/WRITE/FLUSH take numbers from 0 to 2, so the added
checks are compiled into a single condition:

if (op <= REQ_OP_FLUSH) {} else { switch() ... };

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c | 74 +++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 52019b8a1487..7ba8f53a8340 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -776,6 +776,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	struct request_queue *q = bdev_get_queue(bdev);
 	blk_status_t status = BLK_STS_IOERR;
 	struct blk_plug *plug;
+	unsigned op;
 
 	might_sleep();
 
@@ -817,41 +818,44 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		bio_clear_polled(bio);
 
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-		if (!blk_queue_discard(q))
-			goto not_supported;
-		break;
-	case REQ_OP_SECURE_ERASE:
-		if (!blk_queue_secure_erase(q))
-			goto not_supported;
-		break;
-	case REQ_OP_WRITE_SAME:
-		if (!q->limits.max_write_same_sectors)
-			goto not_supported;
-		break;
-	case REQ_OP_ZONE_APPEND:
-		status = blk_check_zone_append(q, bio);
-		if (status != BLK_STS_OK)
-			goto end_io;
-		break;
-	case REQ_OP_ZONE_RESET:
-	case REQ_OP_ZONE_OPEN:
-	case REQ_OP_ZONE_CLOSE:
-	case REQ_OP_ZONE_FINISH:
-		if (!blk_queue_is_zoned(q))
-			goto not_supported;
-		break;
-	case REQ_OP_ZONE_RESET_ALL:
-		if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))
-			goto not_supported;
-		break;
-	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
-			goto not_supported;
-		break;
-	default:
-		break;
+	op = bio_op(bio);
+	if (op != REQ_OP_READ && op != REQ_OP_WRITE && op != REQ_OP_FLUSH) {
+		switch (op) {
+		case REQ_OP_DISCARD:
+			if (!blk_queue_discard(q))
+				goto not_supported;
+			break;
+		case REQ_OP_SECURE_ERASE:
+			if (!blk_queue_secure_erase(q))
+				goto not_supported;
+			break;
+		case REQ_OP_WRITE_SAME:
+			if (!q->limits.max_write_same_sectors)
+				goto not_supported;
+			break;
+		case REQ_OP_ZONE_APPEND:
+			status = blk_check_zone_append(q, bio);
+			if (status != BLK_STS_OK)
+				goto end_io;
+			break;
+		case REQ_OP_ZONE_RESET:
+		case REQ_OP_ZONE_OPEN:
+		case REQ_OP_ZONE_CLOSE:
+		case REQ_OP_ZONE_FINISH:
+			if (!blk_queue_is_zoned(q))
+				goto not_supported;
+			break;
+		case REQ_OP_ZONE_RESET_ALL:
+			if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))
+				goto not_supported;
+			break;
+		case REQ_OP_WRITE_ZEROES:
+			if (!q->limits.max_write_zeroes_sectors)
+				goto not_supported;
+			break;
+		default:
+			break;
+		}
 	}
 
 	/*
-- 
2.33.1

