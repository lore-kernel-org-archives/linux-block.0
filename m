Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B53AC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113582145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VR0kTYq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113582145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeLAEHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:23 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46929 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeLAEHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:22 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so5044942ios.13
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3J/GNZhTTiMRCQpvsWNuMxThlxd8tYG73UBMrgizEig=;
        b=VR0kTYq8AB4J8Vn1toh385cB7/dnykpeeOFuWJlgk2cWwC2J1lkJUm9AdJEUUGFtYs
         jS3UIJO0NYz9T49YSm/R78I+D1VBHmH/Rw8d5Ui7agg09qH9coxpNEj8Mfk9vf4W5XU3
         siUhQpq/UmrFCP7rqGx93aBCw8sWrMGessPkYn5HwpLPUFHl58+KQ8sUFrZlH0QLgLW9
         kAREjTLcDBlqeDPFSDLCJng3YiFEeafoIL8nmuVTN5INCMjYCaAUwOTGngNyOB3EQigb
         rgxdWUAuaG6V8pJR7IcQkWvNoJaxJMZ2f0NuzncNptm9Ku4Ewh9T6xeQcdFQQ1vimJKV
         enzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3J/GNZhTTiMRCQpvsWNuMxThlxd8tYG73UBMrgizEig=;
        b=PbSNpksrTNueoGzyesMT/R/p0+v8WDkWeONao+rNR0JntToQ88K6QJqXfZAiKFdFN+
         IWnG5aoR+2OLdDPzR47aAXE5HUhDmLx6A/y+yA5DIxyhggpiXmOBYO1S8tT6vrOlawgd
         leD7wcMPpIEGFJ1IV8aCaZ333NY4JaN1RX167+7qfzEq2TGhPMINlQgDckx0PDCE/rXJ
         vWmzkEUDAFJW4nNDLXZcLFmJ980cj1avZ6EVNR0HVe+rijfSDTcnSl3Tig7vDNI3kaqV
         I7tqsKLnJ+gCIEUB+CO9YSj8pZUaWaX2zEhqSUxiHi1o/EfVfh4hxHE5Ye8lGZgbfP+f
         lkng==
X-Gm-Message-State: AA+aEWb0W6Q/ko1SiytyMLRoQDQ1GppprSFJn2qB2B5VFJmA+hlcSFKL
        PRCd1oF31U7/WnPicxiX5vyYhcp3I14=
X-Google-Smtp-Source: AFSGD/WLH/s6hywjLCCKYbDrK7uQ++Y1OerH8wZc5uolx/bKLmJFpmLBVami+8jdnIJzzhFP+ILF4A==
X-Received: by 2002:a6b:e802:: with SMTP id f2mr5209829ioh.296.1543597046133;
        Fri, 30 Nov 2018 08:57:26 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/27] block: add BIO_HOLD_PAGES flag
Date:   Fri, 30 Nov 2018 09:56:42 -0700
Message-Id: <20181130165646.27341-24-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For user mapped IO, we do get_user_pages() upfront, and then do a
put_page() on each page at end_io time to release the page reference. In
preparation for having permanently mapped pages, add a BIO_HOLD_PAGES
flag that tells us not to release the pages, the caller will do that.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c               | 6 ++++--
 include/linux/blk_types.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 03895cc0d74a..ab174bce5436 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1635,7 +1635,8 @@ static void bio_dirty_fn(struct work_struct *work)
 		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
-		bio_release_pages(bio);
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1651,7 +1652,8 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio);
+	if (!bio_flagged(bio, BIO_HOLD_PAGES))
+		bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c0ba1a038ff3..78aaf7442688 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -227,6 +227,7 @@ struct bio {
 #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
 				 * of this bio. */
 #define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
+#define BIO_HOLD_PAGES	12	/* don't put O_DIRECT pages */
 
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
-- 
2.17.1

