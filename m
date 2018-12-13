Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC5C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3D920851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HeKZzp01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3D920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeLMR5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39306 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeLMR5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:02 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so5190596itl.4
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FqB1mIdreafBDC4QK5wLFzs2LJgUqvwh0ZGlyUoGytk=;
        b=HeKZzp01opH6GPgrEJF9Tzh/gCN23ff4cTIHGAMblmialpa4tv0ObX7gPzX/0LO/pn
         mOSoEqrJHeQ7MysLtPmTswp+qPy9Yh0pVSxow6co2dgE3kmunbsM8nAACwUIiW78KwRA
         a8AhAeozPfae+d/afJRXs3XfOeTFr0dBVhiyy+2AzrGH5ORt+PQp4x3DbnY/eGiW8EJ0
         BW+Y558LnFry5axiYr5t/sudUcVhYBLSr0ciGzApU/6UbxYAwtYtTBNAPGCqSa6zsLPJ
         gy/n4VDGHuS2mQyKN/ESs+Yxm+0p7VYFHPdy8EsbJB7rSP6NnpOhiaHFGvlOvo305+uz
         C8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FqB1mIdreafBDC4QK5wLFzs2LJgUqvwh0ZGlyUoGytk=;
        b=Ah+iXzb5/7Jez1hQYcnoZsn4E8Y7JrtotCLpPRTLexcOjUbat4lkPNnKMO0n1Lz8hs
         XZZX4zsw3WXWq8wQk+TR2Ib7bnNHHtgk+zRKAmoxGYhtxXkmRk8tE9PtLvpNXmNqHIIP
         l1VEsfdtn7rZA4hAe28B4DqragBQT9e5Yev4ESDeS9jkuSDXPq+NfpIFgQUXt91CKLEG
         RTLrzZHDHCp0XbT9nRaAzK8b3G1jCoPB3otkqPHbrBMeRvTX9ra8j8Bayn45Mq2pW2tv
         qcRpf+ig++Nl1Fa6+uxXRCNjlyrXVKaOFId3p6cFjZZ9fe93B41AVglsvl8RlJpcgQ99
         DyfQ==
X-Gm-Message-State: AA+aEWbdoWBdAbQx9K1gTZVecwgZ9nBIqDsGSj/Brc1uRmyKrhbt3Lfe
        k2MvjZzdkNj30xGLelYcrHtq7YatpkcUnA==
X-Google-Smtp-Source: AFSGD/XyQsYTO0x1oylRZByFdA7k6rRZ2jiekAUzMAk7cAW2bm3hpT6U8pp4ywBka5y4Vyo+CJYyvQ==
X-Received: by 2002:a24:1a90:: with SMTP id 138mr255838iti.171.1544723820701;
        Thu, 13 Dec 2018 09:57:00 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:56:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/26] iomap: wire up the iopoll method
Date:   Thu, 13 Dec 2018 10:56:24 -0700
Message-Id: <20181213175645.22181-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

Modified to use REQ_HIPRI_ASYNC for async polled IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/gfs2/file.c        |  2 ++
 fs/iomap.c            | 47 +++++++++++++++++++++++++++++--------------
 fs/xfs/xfs_file.c     |  1 +
 include/linux/iomap.h |  1 +
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 45a17b770d97..358157efc5b7 100644
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
index 9a5bf1e8925b..f3039989de73 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1441,6 +1441,32 @@ struct iomap_dio {
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
+	if (dio->iocb->ki_flags & IOCB_HIPRI) {
+		if (!dio->wait_for_completion)
+			bio->bi_opf |= REQ_HIPRI_ASYNC;
+		else
+			bio->bi_opf |= REQ_HIPRI;
+	}
+
+	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
+	dio->submit.cookie = submit_bio(bio);
+}
+
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	struct kiocb *iocb = dio->iocb;
@@ -1553,7 +1579,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	}
 }
 
-static blk_qc_t
+static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
@@ -1567,15 +1593,10 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
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
@@ -1678,9 +1699,6 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 				bio_set_pages_dirty(bio);
 		}
 
-		if (dio->iocb->ki_flags & IOCB_HIPRI)
-			bio->bi_opf |= REQ_HIPRI;
-
 		iov_iter_advance(dio->submit.iter, n);
 
 		dio->size += n;
@@ -1688,11 +1706,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
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
@@ -1903,6 +1917,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
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

