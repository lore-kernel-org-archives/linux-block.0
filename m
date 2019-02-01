Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C072DC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C553218AF
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QhvDf6IO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfBAPY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45125 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfBAPY1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:27 -0500
Received: by mail-io1-f66.google.com with SMTP id c2so5924169iom.12
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkb1muQx9x9KnElGaaM03AUkKIKh+AW+Xsb0ZQn8sQk=;
        b=QhvDf6IOVjiUvjPs3XUxnSBJ796Yx9zWrabRw2CXaL85ffVYR8XsK/ILDFyprJXAdM
         0wLAIW9XqAMAU80F5/ZynafWG0ng7BjNPeAxVY/BZSxpf44qJGx25AARnhv4JxYoQO3+
         B/9mj7PhWntvuuMUk2nEMu2tyao0umpyTqJ0Dy+eN182d+gL5+fxscDpStpqkTjzjDGE
         ZlhJkOKj7F+LekNARN9EB5pxmsb1ITEGMKm0BX6hCIBnDuWVRGbrR9X6mSq6j/aosQ5i
         pSwh3YnzkBArLJogaLP2FH47I49JI65zbIjPKqJmoOkt7z2VnKwposIrV5y8T9ca9a0w
         HSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkb1muQx9x9KnElGaaM03AUkKIKh+AW+Xsb0ZQn8sQk=;
        b=BhCVtjGmuIfOp7jfnvWmxuqhrA4oHNgxp+hAU9yfpwNruosC1CK7dwUDtFPpxR2pCk
         Co6qfnXac0rOvp8zVvrohKSqEmNrZA9AgiEOJIQDTjzHwygdILPDUcXNTzb+I+nmSfHW
         qvj9YUwuFtRq7OhUL5jMQWe9RT0uwQNNnbW4VgsFlSoqgo0Wiw62xah4Q5Ytty5p5Yb9
         vsKMMwKRRsqOrpK8M83IX+U3ZQm+pwB2I031ZjlmZEFBN8Epl0jHlK0C4jUOWyqHxGuu
         j+hGk8PdOAtiMJNfEK2vdmUVxnrhEXD5sF2KWfPFivKcNcobWvB5PhjX/fTiPo2kjv9f
         tmvw==
X-Gm-Message-State: AHQUAuYEpHp5vWQIqeTxvWvgjUrgqDL2qD5l90mzMb4efs+kidmYgUif
        aSPzddGTJJ/BUv82FG04xWiiLQ==
X-Google-Smtp-Source: AHgI3IZZ96+ONzYFBKd1Q2n+j2/c9ROmqcINKWy4oS8kAnTEZH8UjaAbmPjRPPSusQRQ+OFSLmyujg==
X-Received: by 2002:a6b:600b:: with SMTP id r11mr25851981iog.259.1549034666691;
        Fri, 01 Feb 2019 07:24:26 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/18] iomap: wire up the iopoll method
Date:   Fri,  1 Feb 2019 08:24:00 -0700
Message-Id: <20190201152414.23296-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
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
index a3088fae567b..4ee50b76b4a1 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1454,6 +1454,28 @@ struct iomap_dio {
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
@@ -1566,7 +1588,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	}
 }
 
-static blk_qc_t
+static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
@@ -1580,15 +1602,10 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
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
@@ -1691,9 +1708,6 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 				bio_set_pages_dirty(bio);
 		}
 
-		if (dio->iocb->ki_flags & IOCB_HIPRI)
-			bio->bi_opf |= REQ_HIPRI;
-
 		iov_iter_advance(dio->submit.iter, n);
 
 		dio->size += n;
@@ -1701,11 +1715,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
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
@@ -1916,6 +1926,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
 
+	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
+	WRITE_ONCE(iocb->private, dio->submit.last_queue);
+
 	if (!atomic_dec_and_test(&dio->ref)) {
 		if (!dio->wait_for_completion)
 			return -EIOCBQUEUED;
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

