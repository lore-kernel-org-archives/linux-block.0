Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A899C433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3689960F6F
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhJIM23 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhJIM22 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 08:28:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6207C061570;
        Sat,  9 Oct 2021 05:26:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e3so4661283wrc.11;
        Sat, 09 Oct 2021 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EP4Uspv4eyXqaJfsMkfjA4mFgZjpvK/F6u+Tfp4MRZM=;
        b=GfoSajW3KfmbqZ9hbaFuYwnH5kz1L5BBebRy2dqjnFJrbu0uxb5AHSzIIFlLYpVLAb
         7LqxIkvJdbQ2wnNTuSS0W2tZFd2Q/aBPSWwfOy+elCK1fCNlZsKGE7cIazu4nLaTYwZV
         KUPCdAIeKp9jnmAPYJiwMEjllQq26511C0EoJjhYDwb+/UwrgSlMaDuUeyqJ7PLzRmJe
         C8YRlbpErBegg4rEbCqILoM0bkt7NnfL1v355NOasFGsyUE24aw5/zCxZl053w0GrtIM
         AvcVnh7ZFfrhqt5gyjv4Be2vVZXNqHpJzg7shDyKcBjpYBxyfJm7XU7mcQ2hINBBNqKG
         rbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EP4Uspv4eyXqaJfsMkfjA4mFgZjpvK/F6u+Tfp4MRZM=;
        b=368f43f7r29Zz2X5tVYn8G8Ew0UJxskkPyDalkFJZWHEcCivB1zJJrnvjBc/hTVOOh
         jYuMhMDVTmSTUFC9KA5S5JIoKhOGu0XdNMExCCWhcPck3U+BdKoe/FJFipo/TbYBoVH1
         s6iquI2B1fl49NbHp2V4wc2/sqtFZqGgNn2+ykSt86NqHPYhmZ6we/V/knNIqdMSTr6f
         TnhnoQQaMCmGROhgJfYYVZYqWQpfqwCrcPz06O+eeUxYayY84UvxqVnG3N6mbG98dpxy
         aXr5NRR3z5RuhhO3VqAMd7fbf+U320UkkTRi5dsRIVR3HgXn7oH/Qi4A6H5Auy8fkoGO
         epzg==
X-Gm-Message-State: AOAM532yBoD9EKVh4IM6mRY3hATLjxREtRwyyE/eWaKGzx6BbjkqcFSc
        Qkupevf0hByYmh4rc/LeN34=
X-Google-Smtp-Source: ABdhPJxoa7HmQfNXeCmsXazUJW91f3ij8RPe/t1G7c+AsEU1OrWe6wGeWwPxJ21Y7JkmyALUkluzIw==
X-Received: by 2002:adf:fb50:: with SMTP id c16mr11226446wrs.120.1633782390335;
        Sat, 09 Oct 2021 05:26:30 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.155])
        by smtp.gmail.com with ESMTPSA id o12sm2157468wrv.78.2021.10.09.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:26:30 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCH 1/6] block: cache bdev in struct file for raw bdev IO
Date:   Sat,  9 Oct 2021 13:25:38 +0100
Message-Id: <cfc66d9946422fa1778504f976621c91be2befb5.1633781740.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633781740.git.asml.silence@gmail.com>
References: <cover.1633781740.git.asml.silence@gmail.com>
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
 block/fops.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 765086d51f8b..99e699427f31 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -17,11 +17,16 @@
 #include <linux/fs.h>
 #include "blk.h"
 
-static struct inode *bdev_file_inode(struct file *file)
+static inline struct inode *bdev_file_inode(struct file *file)
 {
 	return file->f_mapping->host;
 }
 
+static inline struct block_device *blkdev_get_bdev(struct file *file)
+{
+	return file->private_data;
+}
+
 static int blkdev_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh, int create)
 {
@@ -54,8 +59,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		struct iov_iter *iter, unsigned int nr_pages)
 {
-	struct file *file = iocb->ki_filp;
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	struct block_device *bdev = blkdev_get_bdev(iocb->ki_filp);
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
@@ -143,7 +147,7 @@ static struct bio_set blkdev_dio_pool;
 
 static int blkdev_iopoll(struct kiocb *kiocb, struct io_batch *ib, bool wait)
 {
-	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
+	struct block_device *bdev = blkdev_get_bdev(kiocb->ki_filp);
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), ib, wait);
@@ -191,9 +195,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		unsigned int nr_pages)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = bdev_file_inode(file);
-	struct block_device *bdev = I_BDEV(inode);
+	struct block_device *bdev = blkdev_get_bdev(iocb->ki_filp);
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
@@ -405,8 +407,7 @@ static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
 static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 		int datasync)
 {
-	struct inode *bd_inode = bdev_file_inode(filp);
-	struct block_device *bdev = I_BDEV(bd_inode);
+	struct block_device *bdev = blkdev_get_bdev(filp);
 	int error;
 
 	error = file_write_and_wait_range(filp, start, end);
@@ -448,6 +449,8 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
+
+	filp->private_data = bdev;
 	filp->f_mapping = bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	return 0;
@@ -455,7 +458,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 
 static int blkdev_close(struct inode *inode, struct file *filp)
 {
-	struct block_device *bdev = I_BDEV(bdev_file_inode(filp));
+	struct block_device *bdev = blkdev_get_bdev(filp);
 
 	blkdev_put(bdev, filp->f_mode);
 	return 0;
@@ -463,7 +466,7 @@ static int blkdev_close(struct inode *inode, struct file *filp)
 
 static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	struct block_device *bdev = blkdev_get_bdev(file);
 	fmode_t mode = file->f_mode;
 
 	/*
@@ -487,14 +490,14 @@ static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
  */
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *bd_inode = bdev_file_inode(file);
+	struct block_device *bdev = blkdev_get_bdev(iocb->ki_filp);
+	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = i_size_read(bd_inode);
 	struct blk_plug plug;
 	size_t shorted = 0;
 	ssize_t ret;
 
-	if (bdev_read_only(I_BDEV(bd_inode)))
+	if (bdev_read_only(bdev))
 		return -EPERM;
 
 	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
@@ -526,9 +529,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *bd_inode = bdev_file_inode(file);
-	loff_t size = i_size_read(bd_inode);
+	struct block_device *bdev = blkdev_get_bdev(iocb->ki_filp);
+	loff_t size = (loff_t)bdev->bd_nr_sectors << SECTOR_SHIFT;
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
 	ssize_t ret;
-- 
2.33.0

