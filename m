Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC13C65BAE
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B47C20867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EfcQOIoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B47C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAEH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35513 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeLAEH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:26 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so10253627itp.0
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g46PYTbAjyIcxDqCKCRd2T5v8MCWa71J81SsLDN3oOo=;
        b=EfcQOIoULyEeMdNtFqUGblTKvD4RYYzQLQUU34/06yRNt+Xahpv12wPlX0X2xgkFXh
         OTbzHOE5HiWZgeJiAuAQD+6e8bB1UwKSe4mHSmIVHFWkm5VkjLf4KBuiqdkt9DQTE1Hn
         e36Y/xgvavR8b2FeAjgUADEWnD7Q1lZ0ziPnX5goup4285SAkeb3U6CRfLZPN2UGRrQC
         U27gi+HNd23Usf/6GvXoe8nAALoDLXtGx46lElqUB8i/ahApkhrWd7Q9dzRw7rahUeQ0
         W2Ix9Rw3bCXYWc1ZheeR70ZG1c+j4bidU7hBbqLlPfZDGLbNGx2Mw1SXksORTuFHDlH/
         IGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g46PYTbAjyIcxDqCKCRd2T5v8MCWa71J81SsLDN3oOo=;
        b=fgKLHN4Uu44l++j+VuaYWPBjuXw8Gbvrg4n52gQl0p+Q9Z1UoxoDuFthHblUmow0wz
         H+zQrHTOcGmeQh21pyO2EzFIGkGXidercvHx7R0aH45vJKCY7cCMBktOEoY0l9MjeuwO
         O3ReCcSMVpY7Sw4PMuGFuxsQJDABJqzAgaKJShrV1elzvD2i57NPMXyzJSwEc7gHSQj2
         ki1IwJWvgSCXpXrnL1Z7NUvWyRYPlaJbShMuW7bOQnWSdGklOWvs4df96GMxSfHeC3r7
         eMyCS5cCE8JSqL2yodrV59WAoc/hXMgSwZ8+QiWKa1QzK46HVTBReliPREdUcoqFkTgs
         JhAg==
X-Gm-Message-State: AA+aEWbULbEHChXcqHmTUHDwRDyBr8Tny3mpwVBHxt+4Xm6rcOD5t9ko
        VBX27kTdduZeu2MCZQqx5DptlGeHovs=
X-Google-Smtp-Source: AFSGD/VustQw5HVZWLmhppIjvJibhAVyzP6F1VYZU8kliZqR1wrNqFEz2nrCQ6WiVVRTUoKpcbvLGA==
X-Received: by 2002:a24:a08a:: with SMTP id o132mr6004259ite.1.1543597049680;
        Fri, 30 Nov 2018 08:57:29 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/27] fs: add support for mapping an ITER_KVEC for O_DIRECT
Date:   Fri, 30 Nov 2018 09:56:44 -0700
Message-Id: <20181130165646.27341-26-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds support for sync/async O_DIRECT to make a kvec type iter
for bdev access, as well as iomap.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 16 ++++++++++++----
 fs/iomap.c     |  5 ++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ebc3d5a0f424..b926f03de55e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -219,7 +219,10 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_end_io = blkdev_bio_end_io_simple;
 	bio.bi_ioprio = iocb->ki_ioprio;
 
-	ret = bio_iov_iter_get_pages(&bio, iter);
+	if (iov_iter_is_kvec(iter))
+		ret = bio_iov_kvec_add_pages(&bio, iter);
+	else
+		ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
 		goto out;
 	ret = bio.bi_iter.bi_size;
@@ -326,8 +329,9 @@ static void blkdev_bio_end_io(struct bio *bio)
 		struct bio_vec *bvec;
 		int i;
 
-		bio_for_each_segment_all(bvec, bio, i)
-			put_page(bvec->bv_page);
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_for_each_segment_all(bvec, bio, i)
+				put_page(bvec->bv_page);
 		bio_put(bio);
 	}
 }
@@ -381,7 +385,11 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
 
-		ret = bio_iov_iter_get_pages(bio, iter);
+		if (iov_iter_is_kvec(iter))
+			ret = bio_iov_kvec_add_pages(bio, iter);
+		else
+			ret = bio_iov_iter_get_pages(bio, iter);
+
 		if (unlikely(ret)) {
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
diff --git a/fs/iomap.c b/fs/iomap.c
index 96d60b9b2bea..72f58d604fab 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1671,7 +1671,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-		ret = bio_iov_iter_get_pages(bio, &iter);
+		if (iov_iter_is_kvec(&iter))
+			ret = bio_iov_kvec_add_pages(bio, &iter);
+		else
+			ret = bio_iov_iter_get_pages(bio, &iter);
 		if (unlikely(ret)) {
 			bio_put(bio);
 			return copied ? copied : ret;
-- 
2.17.1

