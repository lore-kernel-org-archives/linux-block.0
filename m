Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E86C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B859920892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gt+cLwFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B859920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLGWVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36545 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLGWVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:21:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2304856pgm.3
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZOhdIxDv845Z5UGbqrPoX9bgWw6pO6TACmobM92btU=;
        b=Gt+cLwFNRr/dysEZCzTM6TPJiwZNvTwtB4Xh018YTEXkxA+2F37y7wHOwmDUtZX5gP
         gwiRDSwHdBtePJzEw1g+k8yQvh3RyCCe2NeM84P8EsuAz3ZIyYNXN3sB8HGGJ8fI8cAT
         R0/8J6ZPIVOJG5O49OA7mhFHnhr98Csic4Z0oVg6vtQftvflCZfxBysP0yot44n918tW
         aZyUVKqI2gVygxqNK+7AHh+AZ5eQj3Vbpcd8p/ohcCbB81fml2oq0eEBN5CU9Wx5ldOa
         3Shdcf9iTgvhd269kQH004joXIGhejhRWESViADsX06dpGvg6bij2O4QUdN96ZVRXbi7
         7xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZOhdIxDv845Z5UGbqrPoX9bgWw6pO6TACmobM92btU=;
        b=HTJqFVVPcCozojPkVF+nxwcEsjZidENu8G0mvQIa2tApUoa7xcNzZNczUTKpQS7dfY
         paP/TBwJooLuxpNPEGnosCmwkZRNOxwW2YKzVuD+BnYyX12jsKyAAQhFXL3DvTTm13NP
         Zk32rS8oX/QOIfyqgixi3DoX0BbTzhGiX7CV/jFAXETnRB3Kf9kkbMGF7V7IEda4DvX8
         zbRSEHH3I3UDwl6iCHgUdoG89xJkqgH+Yx7tLMjSNKhWitDmqJ/qZ+QcELjQN2s3K0Uu
         a0VKqiCzmC2mQinIxBS8i5opr0/H1egfrqLIpxTJ7Nnk+cANvkvNScFbKEHGdGq9eOuO
         COSA==
X-Gm-Message-State: AA+aEWYT2VPUXQcT4A8OsF7wSxB1AQWxqcRb1pzTZoCL6dyJPihQkW3X
        gIM7HUQsb4WVZhIl0cvLXoC+8mREgOk=
X-Google-Smtp-Source: AFSGD/XQyaNZ+KKTfKQw11gP0/tK020TnPXRjvGY3CuEn3DK8mPYCRZTusMLG6nOHrj372wK6sU0yA==
X-Received: by 2002:a62:1a44:: with SMTP id a65mr4074933pfa.30.1544221266362;
        Fri, 07 Dec 2018 14:21:06 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:21:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/26] fs: add support for mapping an ITER_BVEC for O_DIRECT
Date:   Fri,  7 Dec 2018 15:20:13 -0700
Message-Id: <20181207222016.29387-24-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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
index bd483fcb7b5a..e36ad0be03f5 100644
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

