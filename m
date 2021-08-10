Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB09C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2343D60F41
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 16:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhHJQiG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbhHJQiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 12:38:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B801EC06179E
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 09:37:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso5124216pjb.2
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7r1F9vOtNA7gYTE+jSGPmDArFssk1xI7N32wgdj6+8=;
        b=GwCrf047j4kbvvLKjiAntlmCRY44W2sNGD7pLc4JiNYISQOiiI77bmOf9CNtXJ61ED
         0hJHSBLVd2epEJ1Lc3knTsqhKLraTIlsbnUIFs70qaE9W4X75Wvq3OwHhWL7AoLcRcWf
         8YJFjNxM2FmEPttjxIMGIzbwd66AOnC1bn4PVktzm+U1dnM8oM9Y9uoMuzPoBsh/uv19
         KEhk/Tb5q+E5bOUTfY0wsTAUUCfy16s2hEA64twM1KYEASk8NdTt9QiQ1WzmFkmERM0a
         FvjNea0Gicg9wiGsnCT71qn/SNN6rcm2jaSpR8Hw/oI+im0tMgnVqZEVfqdzx5WqiERF
         jR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7r1F9vOtNA7gYTE+jSGPmDArFssk1xI7N32wgdj6+8=;
        b=noQUNdizYWrvbI6VzuwQ+01UAqihKZYURxqZtlYON6iM16bQQ1VuI0BaQYU1fGnKg8
         1IEFl9lsfkUshs8obPOHfPcZw18HNQYffFBw5MATE0H+MLYRYU00ctqLaFwH8nDJU1sI
         O7RdduavEz+grUJO3A7BMtMe5f29wNBl/M36UqD3GhhY4diFSiRb1pdG62yJ2VHCI9Vc
         rJrkVnHsIBfVR1BM6TTq7fjsoV8piINf32FdX9ymTjfQnjCiFeICj8E3kti9TpFQLCzq
         9BDywmUG/0JXmXeNk07xzhjVwyEXGJp30g7qCZgRqZ94lHH6H2M+FPUz2SqkMsS3TfUA
         /X8Q==
X-Gm-Message-State: AOAM532lO69hpKYPnIzGdSZCMOxU8vImw6G74c1Bt4pfTZ7nq52/OePJ
        EcHnzL9ZLYfaGITMr6c95DnRi+syQfTSDjJ8
X-Google-Smtp-Source: ABdhPJxW3/lA4GueiXY++TcCbBxQ/Uis2plWiIvuUvPxsFVdjSQ3D72rT0KzrTt7P1KybCiaTKDTGg==
X-Received: by 2002:a05:6a00:1715:b029:3cd:85ef:7e88 with SMTP id h21-20020a056a001715b02903cd85ef7e88mr6806224pfc.66.1628613459228;
        Tue, 10 Aug 2021 09:37:39 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id pi14sm3517744pjb.38.2021.08.10.09.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 09:37:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] block: enable use of bio allocation cache
Date:   Tue, 10 Aug 2021 10:37:28 -0600
Message-Id: <20210810163728.265939-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810163728.265939-1-axboe@kernel.dk>
References: <20210810163728.265939-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the kiocb passed in has a bio cache specified, then use that to
allocate a (and free) new bio if possible.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9ef4f1fc2cb0..a192c5672430 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -327,6 +327,14 @@ static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
 	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
 }
 
+static void dio_bio_put(struct blkdev_dio *dio)
+{
+	if (dio->iocb->ki_flags & IOCB_ALLOC_CACHE)
+		bio_cache_put(dio->iocb->ki_bio_cache, &dio->bio);
+	else
+		bio_put(&dio->bio);
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -362,7 +370,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
-		bio_put(bio);
+		dio_bio_put(dio);
 	}
 }
 
@@ -385,7 +393,15 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	bio = NULL;
+	if (iocb->ki_flags & IOCB_ALLOC_CACHE) {
+		bio = bio_cache_get(iocb->ki_bio_cache, GFP_KERNEL, nr_pages,
+					&blkdev_dio_pool);
+		if (!bio)
+			iocb->ki_flags &= ~IOCB_ALLOC_CACHE;
+	}
+	if (!bio)
+		bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
@@ -467,7 +483,15 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		submit_bio(bio);
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		bio = NULL;
+		if (iocb->ki_flags & IOCB_ALLOC_CACHE) {
+			bio = bio_cache_get(iocb->ki_bio_cache, GFP_KERNEL,
+						nr_pages, &fs_bio_set);
+			if (!bio)
+				iocb->ki_flags &= ~IOCB_ALLOC_CACHE;
+		}
+		if (!bio)
+			bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
 	if (!is_poll)
@@ -492,7 +516,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	if (likely(!ret))
 		ret = dio->size;
 
-	bio_put(&dio->bio);
+	dio_bio_put(dio);
 	return ret;
 }
 
-- 
2.32.0

