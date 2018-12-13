Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8623FC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537792087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nywuE5PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537792087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeLMR5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:36 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55383 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeLMR5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:36 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so4961487itg.5
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gMJi2AsGfGxIdSynZ2zLkJEEU4daS8+d5LPI8e4PgHk=;
        b=nywuE5PT4UNHctjoo8xM9pNVqkIq8XW9nKeO4JcDQ0LgFRyCuFaYSNSN/4/vCPK1sk
         N9MXyAZvn+/QdVIHYv2wbRjl5VUhF3VkNPF3nJcvR+ApYdP/r3v8kt4pu4vpytsQ+l5X
         r+t8czqg4FYpnulnPoaif1wbwSIH70o9zPKGmdzfIEWt8Mvhw3WmwQbjZJbfaOYFHCBg
         Bzf4dj4JYqfRw7AViVNnjlJUJA1pWClBxjVGuY1NAi0PNpDpg79D2+vfeQZV6W4MFZmI
         7dOqyc3jrabXS8dVQ9Q1D4WSzW0ATFMwhJeLCCZ1QvJ1BOo4PDCg9Otxk+fFZ9yJ/Y6Y
         nRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gMJi2AsGfGxIdSynZ2zLkJEEU4daS8+d5LPI8e4PgHk=;
        b=gLleBKPif1RrdkbzNDcCXHeP42MP1Hgz5oR43psOo6OvoLmuZREXPZw/TQ9lWRGGDm
         Er28ezTsIno6BKm5kvIggdZB7J4iB+ssRhmpPhtH1IZWkFfEt0f7FLiOaTNkcEUt6Fa2
         XVlniFIShbr0pYuaCWF8drG7G/zeedEi+yuSUkYExVs70q3LEh0KLwiEYCQfOqetgYvp
         D4XZgnec+s1EQqICfULja/1bh736b1qqc89kUuGW34N5ROmFs/T0WgA59Z/h1tnxMLi8
         Sl6OnouAtn2YDVT+tugMoe66wamsuBzQoLMqwkFSiyouzTTKuHjudh8dfEBnfbhhlRYG
         3gfQ==
X-Gm-Message-State: AA+aEWaCjifpUyiwbXEhEeD7pBqOrN4Ql+Uw4K5I15Nbyptpb8OFo/PU
        Ylfo742nv0hycgBrA0wThSyfl6ffC20dIw==
X-Google-Smtp-Source: AFSGD/WKZh0o9VrzM3ilyxmGo2jC5gCIoToW324zXOlQev09aT+IoLWUBMl14i0nw93Xbq1VUdZndg==
X-Received: by 2002:a24:be06:: with SMTP id i6mr270364itf.168.1544723855015;
        Thu, 13 Dec 2018 09:57:35 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 24/26] fs: add support for mapping an ITER_BVEC for O_DIRECT
Date:   Thu, 13 Dec 2018 10:56:43 -0700
Message-Id: <20181213175645.22181-25-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds support for sync/async O_DIRECT to make a bvec type iter
for bdev access, as well as iomap.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 16 ++++++++++++----
 fs/iomap.c     | 10 +++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8f574615792..236c6abe649d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -219,7 +219,10 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_end_io = blkdev_bio_end_io_simple;
 	bio.bi_ioprio = iocb->ki_ioprio;
 
-	ret = bio_iov_iter_get_pages(&bio, iter);
+	if (iov_iter_is_bvec(iter))
+		ret = bio_iov_bvec_add_pages(&bio, iter);
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
+		if (iov_iter_is_bvec(iter))
+			ret = bio_iov_bvec_add_pages(bio, iter);
+		else
+			ret = bio_iov_iter_get_pages(bio, iter);
+
 		if (unlikely(ret)) {
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
diff --git a/fs/iomap.c b/fs/iomap.c
index f3039989de73..2bb309a320a3 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1573,8 +1573,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
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
@@ -1673,7 +1674,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-		ret = bio_iov_iter_get_pages(bio, &iter);
+		if (iov_iter_is_bvec(&iter))
+			ret = bio_iov_bvec_add_pages(bio, &iter);
+		else
+			ret = bio_iov_iter_get_pages(bio, &iter);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
-- 
2.17.1

