Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED07AC282CC
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA67421920
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sL6+ENs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBGT4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:07 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34322 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfBGT4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:06 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so6553313itd.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kBV8dzOOhCbt68ELwObNvYoJE2gQ/QTxNte5p6AS0oA=;
        b=sL6+ENs8/1pkDya3pmUb1Uw4k3X6q+RnOmME3PMuhw/q/Suv3uC2ZPrkT2B2EaQJWc
         Pz5NHCJvX6RaI+vPgbKDm2VPZWeXwuvdAlSNihH0R8LXU6HiI+Ox518F76I2BrBHWS8x
         u7ihbNstOhTvhVck1Yx4Bjv1lYU7rOyEb/3HVePopzXFs1JSl9eAwCvf9Lao8hXDP3Br
         3MM625lR91xBI375V+KiU1aG4GKcyIDBl9PERh1+NEWBkiec+Nppla9AGiOy9twBVYPh
         JjbOv7KI5EQmAyLQDmN5kq4L7QqhE56x0i5qeM7lBMk5EfWw8c0zcGgsjM9kugcDluAI
         2l0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kBV8dzOOhCbt68ELwObNvYoJE2gQ/QTxNte5p6AS0oA=;
        b=Z4l4/xNCiKSVqUoWT6GJFuhY9ZSouT0qRnisH5yeRovjybotu/zofMuBqXII8f8djK
         /skTJoTC00i5sF9Jni2/us1JwxAmFWxw0WLyKNXyFo1PvhH+i7W40foDNTg7fIbMf65L
         R2PjBd6a8atKYIvzbY16HyBGUcVT/ugzXWbzmYjcyGxvX9uhFPhE10O99r8qx5Oxtg22
         MmvRerGnCi5wH1z3jWMIkbho5kzZU6JIkOogJUbh+3t3PKtdfbjEU+OiLWNTk0DU99sg
         YksGrhdMjxYhLcWBlYG8de3Q9jJvhEofH5s4pe6X9EZJVtR2Um2czcUiXxSubWEobYmx
         IATw==
X-Gm-Message-State: AHQUAuZoyYNuCAmCKvrNGfEAB8VjNikLmyZ4YHctv4T1VaiHsR3s+pC7
        GWW+AWblht31BY4Z5N5j2hQsug==
X-Google-Smtp-Source: AHgI3IZlK4FrOJg/DL2AriON/DnHWwlxR7emBF0B0/Zc3TvnhEF26BBMEEnJwN79z65TV6CP/zg7zw==
X-Received: by 2002:a24:3dca:: with SMTP id n193mr7005847itn.48.1549569366161;
        Thu, 07 Feb 2019 11:56:06 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/18] iomap: wire up the iopoll method
Date:   Thu,  7 Feb 2019 12:55:38 -0700
Message-Id: <20190207195552.22770-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Store the request queue the last bio was submitted to in the iocb
private data in addition to the cookie so that we find the right block
device.  Also refactor the common direct I/O bio submission code into a
nice little helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Modified to use bio_set_polled().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/gfs2/file.c        |  2 ++
 fs/iomap.c            | 43 ++++++++++++++++++++++++++++---------------
 fs/xfs/xfs_file.c     |  1 +
 include/linux/iomap.h |  1 +
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index a2dea5bc0427..58a768e59712 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1280,6 +1280,7 @@ const struct file_operations gfs2_file_fops = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
+	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.mmap		= gfs2_mmap,
 	.open		= gfs2_open,
@@ -1310,6 +1311,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
+	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.mmap		= gfs2_mmap,
 	.open		= gfs2_open,
diff --git a/fs/iomap.c b/fs/iomap.c
index 897c60215dd1..2ac9eb746d44 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1463,6 +1463,28 @@ struct iomap_dio {
 	};
 };
 
+int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
+{
+	struct request_queue *q = READ_ONCE(kiocb->private);
+
+	if (!q)
+		return 0;
+	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), spin);
+}
+EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
+
+static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
+		struct bio *bio)
+{
+	atomic_inc(&dio->ref);
+
+	if (dio->iocb->ki_flags & IOCB_HIPRI)
+		bio_set_polled(bio, dio->iocb);
+
+	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
+	dio->submit.cookie = submit_bio(bio);
+}
+
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	struct kiocb *iocb = dio->iocb;
@@ -1575,7 +1597,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	}
 }
 
-static blk_qc_t
+static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
@@ -1589,15 +1611,10 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	if (dio->iocb->ki_flags & IOCB_HIPRI)
-		flags |= REQ_HIPRI;
-
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-
-	atomic_inc(&dio->ref);
-	return submit_bio(bio);
+	iomap_dio_submit_bio(dio, iomap, bio);
 }
 
 static loff_t
@@ -1700,9 +1717,6 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 				bio_set_pages_dirty(bio);
 		}
 
-		if (dio->iocb->ki_flags & IOCB_HIPRI)
-			bio->bi_opf |= REQ_HIPRI;
-
 		iov_iter_advance(dio->submit.iter, n);
 
 		dio->size += n;
@@ -1710,11 +1724,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-
-		atomic_inc(&dio->ref);
-
-		dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-		dio->submit.cookie = submit_bio(bio);
+		iomap_dio_submit_bio(dio, iomap, bio);
 	} while (nr_pages);
 
 	/*
@@ -1925,6 +1935,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
 
+	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
+	WRITE_ONCE(iocb->private, dio->submit.last_queue);
+
 	/*
 	 * We are about to drop our additional submission reference, which
 	 * might be the last reference to the dio.  There are three three
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e47425071e65..60c2da41f0fc 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1203,6 +1203,7 @@ const struct file_operations xfs_file_operations = {
 	.write_iter	= xfs_file_write_iter,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= xfs_file_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= xfs_file_compat_ioctl,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9a4258154b25..0fefb5455bda 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -162,6 +162,7 @@ typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
 		unsigned flags);
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
+int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
 struct file;
-- 
2.17.1

