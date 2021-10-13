Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A44CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E90060C4B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbhJMJAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJMJAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:00:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5619DC061714;
        Wed, 13 Oct 2021 01:58:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m22so5994829wrb.0;
        Wed, 13 Oct 2021 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9Ex5CnexhrA+65j7ahm0iD45c9iTQJ0i/r9QhTU/B8=;
        b=D+GmuBdOm3blAYl4rRY+0O/BMwo5xOUMCUXX+BQ+0KLOoTXlpAZ5onDD/WI3EDPHn0
         8Qkb1jYnmzBU7H3qcxEyQ78FGriDRX+N0j0nJOikyqhS46ET5Yt3Y5h6k/nzuJBkaIvV
         WWgaE7et8yMZNVuuu8QNBYMDhXowVxq/aeHWEDTxNa//hZjpV7n7jCE0fH6DXEE56/9D
         t2c+oCUwbbjJnMjZdmj8XVk2U/MiIntgkbGIjmURwXRebLjWJAcHV0FiUt1+SZoef5s4
         tbUmR5M75ImmMRgW4WqPXY3ogNlfnNE4POV1fCTPggmckDmJ9rUl4ln44WZI7cYB/PML
         6Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9Ex5CnexhrA+65j7ahm0iD45c9iTQJ0i/r9QhTU/B8=;
        b=LrKhsFNgLdsuKIog+JtgMzz1BK1mQyTbyEcTl/53+OQ7o1AMDFjK69lTdNNrIT5hgP
         Vowi/zBTp8dA4jclIljYypbVaXJ1rpZcBJqxGu1BoD8tcvpML0iCvPvTsZ9zqj0QFEmr
         QMIGto6CV2W2Ugjoep/zgjCc3TqM7qc6y/FiX/bGkH8ufkm2n1NCPb7MSjDaezKJPdwu
         SzyQ77+1I34UMf486CcbTC2q21Gco7G68TtWDp2x580/QD35D7tr/aeMk7Z4HJjZ02Tq
         PUUDKny7EDwliZmwrJZfUzXkAQKE1UBdWX8heJFkOJeTm+WaMrFzvEVaARpQ0oT99O3m
         zG9w==
X-Gm-Message-State: AOAM532hgsNm325Vkt7H4sc9ndRKiEI4hxa0ykmFBNm/g2F80iEo/qxn
        EjPnweXMvnZ30gyJZmEaxXU=
X-Google-Smtp-Source: ABdhPJyau3IxoedXXrVhs5mzIiGQHk1gfFgpJzBpFduAoyzZ0WPU+JDwgTqrmUlM5wcUf4UzQM1Mkg==
X-Received: by 2002:a05:600c:3223:: with SMTP id r35mr11513295wmp.32.1634115481418;
        Wed, 13 Oct 2021 01:58:01 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.208])
        by smtp.gmail.com with ESMTPSA id v1sm13187283wro.54.2021.10.13.01.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 01:58:01 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH v2 1/3] block: cache bdev in struct file for raw bdev IO
Date:   Wed, 13 Oct 2021 09:57:11 +0100
Message-Id: <8415f9fe12e544b9da89593dfbca8de2b52efe03.1634115360.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634115360.git.asml.silence@gmail.com>
References: <cover.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdev = &BDEV_I(file->f_mapping->host)->bdev

Getting struct block_device from a file requires 2 memory dereferences
as illustrated above, that takes a toll on performance, so cache it in
yet unused file->private_data. That gives a noticeable peak performance
improvement.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 7bb9581a146c..c71e91cd6bcb 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -17,7 +17,7 @@
 #include <linux/fs.h>
 #include "blk.h"
 
-static struct inode *bdev_file_inode(struct file *file)
+static inline struct inode *bdev_file_inode(struct file *file)
 {
 	return file->f_mapping->host;
 }
@@ -54,8 +54,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		struct iov_iter *iter, unsigned int nr_pages)
 {
-	struct file *file = iocb->ki_filp;
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	struct block_device *bdev = iocb->ki_filp->private_data;
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
@@ -143,7 +142,7 @@ static struct bio_set blkdev_dio_pool;
 
 static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
 {
-	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
+	struct block_device *bdev = kiocb->ki_filp->private_data;
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
@@ -191,9 +190,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		unsigned int nr_pages)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = bdev_file_inode(file);
-	struct block_device *bdev = I_BDEV(inode);
+	struct block_device *bdev = iocb->ki_filp->private_data;
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
@@ -405,8 +402,7 @@ static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
 static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 		int datasync)
 {
-	struct inode *bd_inode = bdev_file_inode(filp);
-	struct block_device *bdev = I_BDEV(bd_inode);
+	struct block_device *bdev = filp->private_data;
 	int error;
 
 	error = file_write_and_wait_range(filp, start, end);
@@ -448,6 +444,8 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
+
+	filp->private_data = bdev;
 	filp->f_mapping = bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	return 0;
@@ -455,7 +453,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 
 static int blkdev_close(struct inode *inode, struct file *filp)
 {
-	struct block_device *bdev = I_BDEV(bdev_file_inode(filp));
+	struct block_device *bdev = filp->private_data;
 
 	blkdev_put(bdev, filp->f_mode);
 	return 0;
@@ -470,14 +468,14 @@ static int blkdev_close(struct inode *inode, struct file *filp)
  */
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *bd_inode = bdev_file_inode(file);
+	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = i_size_read(bd_inode);
 	struct blk_plug plug;
 	size_t shorted = 0;
 	ssize_t ret;
 
-	if (bdev_read_only(I_BDEV(bd_inode)))
+	if (bdev_read_only(bdev))
 		return -EPERM;
 
 	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
@@ -509,9 +507,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *bd_inode = bdev_file_inode(file);
-	loff_t size = i_size_read(bd_inode);
+	struct block_device *bdev = iocb->ki_filp->private_data;
+	loff_t size = i_size_read(bdev->bd_inode);
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
 	ssize_t ret;
-- 
2.33.0

