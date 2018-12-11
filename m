Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8BBC04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F9C2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zBHrEEKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F9C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeLKAQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45917 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbeLKAQn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so5741575pgc.12
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gMJi2AsGfGxIdSynZ2zLkJEEU4daS8+d5LPI8e4PgHk=;
        b=zBHrEEKH+8ZZViH+5PUT9h0v7nbnR336qSs6EzwYtZcCls7wVjXTIzW+qGGV03hyNE
         1ROPeuMX1PIfbFAoAZciJ1/LhW+i9s6FHhd9O4lg8ZkgJ8mwc8LA3mX9fnLw6xF9tHBM
         hkdT8ZwkQyAJbt6MkimZRoB5XDyC55h7V5Asj1dMwzjzHNhsR3lBJ1avKVbL7j7V6HKx
         qLDvCO/k4Gwp9hzYg54DWUprWlrh4/8XtxqrW53rPSr5TQe9/ZL26I4XkdtZa63/Bbo8
         Y14OroU27xo0StqsRMykrL7EUMAeSzyFMpmksZUbul2IZgOEfu53bHfWPebvN2zR3h5h
         FpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gMJi2AsGfGxIdSynZ2zLkJEEU4daS8+d5LPI8e4PgHk=;
        b=Ql6RNlsfmkK7KVylnmjdE0Inqbqj1btcv6MvG2NxXI/DMJAjvQNG0O5nJl+aLuZMWR
         baysoT8oXliHd/B/HAjG00hKXTPNhua3l8iKAsZPHCY68wISE4MdGM3WpCdyUk6Zn8dd
         NjoiM+lLvJXW2vbnlCXpOKmJTXgUBg+WeoxqVxutAwdRSfGD56EywZ+oxO+EFly9Mego
         auhfLnfY1eCJEnIo7ooA+MsXeDYfO+XY3J+mIUe6naZmjfaJV6U1g3sK8Itxu3mdskKQ
         h3o4TXjSmVSEa9RnzXQ6EHfMzRKG8h4tDyuX+mwdk7Gtukj0Ut7jKhEIuHDZtNym4g5O
         SLeg==
X-Gm-Message-State: AA+aEWaZZaZ7WUh8g+hSpfEBcgaaBv3KSrt2DaHoyKYSMLJ4S0A9hgRu
        paONdVvbj9jEFTmEcl53dSMDnQFmcBqBrQ==
X-Google-Smtp-Source: AFSGD/V64yN2Yp00oP/+OplAPM/JrecWaapZzKVWJu06XGwtDHV9RKTzBhekSIUWWRB267uXD/vdLA==
X-Received: by 2002:a63:a30a:: with SMTP id s10mr11793187pge.234.1544487401738;
        Mon, 10 Dec 2018 16:16:41 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/27] fs: add support for mapping an ITER_BVEC for O_DIRECT
Date:   Mon, 10 Dec 2018 17:15:45 -0700
Message-Id: <20181211001549.30085-24-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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

