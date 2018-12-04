Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EB1C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFE220850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H2XVBgwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFE220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeLDXic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38364 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeLDXib (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so9008959pfi.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Qnfg7ArnbxEsp5GZEYhER2UYK3J+cRrwNMf1dzAyQ0=;
        b=H2XVBgwRHjr6Ehm4bnnka/pSmHF+rIr+wILFasDdk55Ci0hqMMbvbWZcrM/Q+UuHcP
         gJUkq1fBec+MXVM6D88qG27wlQY3nL76o8ukrBBLe4nJ/hBLCpn/BxQOrrvaODwM+Q+z
         MB+NFbXt2+YMahU91/Ibf0cq8rJr1jYNRug7/ld2zDvKk+7ty+n4A3ZAhsSQSv/QJZIZ
         h44v9sy2L9pjLtnB+z749DVtxZumtRtoWeHLD/UpRLoqzE0+hc78ib6M4+ONWyZGyYqt
         VaOnIravjvCAhQ7Sva/dIeCOEp2yr5wagkKLaXgdonxy2M2CGhFVGVp4NotXPihP/bi+
         AB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Qnfg7ArnbxEsp5GZEYhER2UYK3J+cRrwNMf1dzAyQ0=;
        b=Ui+3P3cyp+h1XI61Kh3NarxM33wS+Te+rf5Y3nIJAuzsTFVVcQfOqwlR+qoMFF9GEB
         v1/wiOHR/H3GDu5sPH3uOy73eHWbWIBVZ7X4sbFhBNHl8nkjZCJllfj8MOYqgylQjsJ7
         CmJJTe6wLA6nsXntY/G3K9liiDABbf1mfbymbn9ipVv5d7tRlMdKIESYfAqzAnRjJTeo
         IW2xSWnZjIiB77nimbTvTod2dyezbHgCMij/5fHAvGWMVKpi35uxpMVkibBnvCbrijpT
         8YsucY1vhum3ZziUjCeYLrTJfXeB6+TlFm5RmWkzXlwt31lKOx9iYKssT06wjlq1zLdL
         U6Dw==
X-Gm-Message-State: AA+aEWbmfZnQ6CT2ECLKbB81l/K8+YRvQrhNMiXt+m2IGqZGunYGVfQ7
        /vZzSUzmqwqA8v83KROhDK2BcDvWeXc=
X-Google-Smtp-Source: AFSGD/XcIKOV2dNKYz9y9us37EgWU7MGz/qCYP/MLpKr3ukNe0a7xn2RhnvzOs+m1239O3l2F3WpKQ==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr17751656pgm.88.1543966710125;
        Tue, 04 Dec 2018 15:38:30 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/26] fs: add support for mapping an ITER_BVEC for O_DIRECT
Date:   Tue,  4 Dec 2018 16:37:26 -0700
Message-Id: <20181204233729.26776-24-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds support for sync/async O_DIRECT to make a bvec type iter
for bdev access, as well as iomap.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 16 ++++++++++++----
 fs/iomap.c     |  5 ++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

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
index bd483fcb7b5a..f00e5e198c57 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1673,7 +1673,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
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

