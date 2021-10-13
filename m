Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F8C433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F079610C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbhJMJAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbhJMJAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:00:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E519FC061746;
        Wed, 13 Oct 2021 01:58:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so5851369wro.3;
        Wed, 13 Oct 2021 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8H5Xv2qDNrUZQBRNCggQmvny18tVHGX+5jJO9ZvgXFM=;
        b=iw+rNa1qt2gBYrQxmTTMiCbZcvTfyKq4EkfJtL5Ri5YC4UoDSPJumIsf2u/f2F8lJd
         0CCZVYBM2tWiT2C2ucqCWDq1XJd0EVN+IUc1190p1kxDA+zLdRpBbP1IdoeNtyBLbZ5K
         QLW4Pu8s05NOat/aSr0fMO2T5mGlGgauWt72gADN4ksGpHhujpXHM29jOZ6G3WedceR7
         D9gK0gjeuzTY73cCEQ1wYhtJQQhCymcLs5kUYlcy8eXsmkOubu8+h0FSUqFBQBWaw0ja
         kWQz8JP7aPEKzUnZohsiE95cHukM3n3zFlfERdoh3TOuwvNvBLxaDo+1xDHsIlqd243G
         rCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8H5Xv2qDNrUZQBRNCggQmvny18tVHGX+5jJO9ZvgXFM=;
        b=rZcdngfceau/lSzZEqTzq4XESfgVUUe0SHfqGnyg4+fN4QLp98oPrwGXH154PeUUyF
         JNKQ6iKTpfxK7Q9bAKoGfX/McsoIcyBXFjpJUVLS2AMZV4JZUM74VwVvRYUfTEXg3d8S
         ZbGiA2gn4h6d6Efo4/RFG/wU1WccnS6+XpNuXkK9nwrkDF8Nndwr2XCZLajF8iEXnKye
         hrxTZyFBpnaGtP8BPqR32V17GKc0hjd4Vtu9giHnXlUVJwLzOQ2SoKoObWMQiXzPm5wN
         VJav0gP6nSvqI7n8ZunOJTUM1NxzADUPc095F6uYov8x2ZPQxx20RnMwh4x09PxyWhO9
         /5ng==
X-Gm-Message-State: AOAM532dIkFEhJrIZJxHCF9cskd8/9Mj/MWVbovte5MFkHTOcak9iOIn
        BmH9dl8CCZ1ptV6GoReXgRQGRMAWDo4=
X-Google-Smtp-Source: ABdhPJxuv8+b2OIqnHlHXY6MpWPX/6PZUGV77xZKnxuD6uNsjR7n+I0rtgQYQl5eAW+4aMafy8iaxg==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr21081534wro.102.1634115482300;
        Wed, 13 Oct 2021 01:58:02 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.208])
        by smtp.gmail.com with ESMTPSA id v1sm13187283wro.54.2021.10.13.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 01:58:01 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH v2 2/3] block: don't hide inode from block_device users
Date:   Wed, 13 Oct 2021 09:57:12 +0100
Message-Id: <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634115360.git.asml.silence@gmail.com>
References: <cover.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of tricks with struct bdev_inode, just openly place the inode
inside struct block_device. First, it allows us to inline I_BDEV, which
is simple but non-inline nature of it impacts performance. Also, make it
possible to get rid of ->bd_inode pointer and hooping with extra
indirection, the amount of which became a noticeable problem for the
block layer.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bdev.c              | 44 ++++++++++-----------------------------
 block/fops.c              | 20 +++++++-----------
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  8 +++++--
 4 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 567534c63f3d..541e24d240d1 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -30,22 +30,6 @@
 #include "../fs/internal.h"
 #include "blk.h"
 
-struct bdev_inode {
-	struct block_device bdev;
-	struct inode vfs_inode;
-};
-
-static inline struct bdev_inode *BDEV_I(struct inode *inode)
-{
-	return container_of(inode, struct bdev_inode, vfs_inode);
-}
-
-struct block_device *I_BDEV(struct inode *inode)
-{
-	return &BDEV_I(inode)->bdev;
-}
-EXPORT_SYMBOL(I_BDEV);
-
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = bdev->bd_inode;
@@ -389,12 +373,13 @@ static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
-	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
+	struct block_device *bdev = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
 
-	if (!ei)
+	if (!bdev)
 		return NULL;
-	memset(&ei->bdev, 0, sizeof(ei->bdev));
-	return &ei->vfs_inode;
+	memset(bdev, 0, sizeof(*bdev));
+	inode_init_once(&bdev->inode);
+	return &bdev->inode;
 }
 
 static void bdev_free_inode(struct inode *inode)
@@ -413,14 +398,7 @@ static void bdev_free_inode(struct inode *inode)
 	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(bdev->bd_dev));
 
-	kmem_cache_free(bdev_cachep, BDEV_I(inode));
-}
-
-static void init_once(void *data)
-{
-	struct bdev_inode *ei = data;
-
-	inode_init_once(&ei->vfs_inode);
+	kmem_cache_free(bdev_cachep, bdev);
 }
 
 static void bdev_evict_inode(struct inode *inode)
@@ -462,10 +440,10 @@ void __init bdev_cache_init(void)
 	int err;
 	static struct vfsmount *bd_mnt;
 
-	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
-			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-				SLAB_MEM_SPREAD|SLAB_ACCOUNT|SLAB_PANIC),
-			init_once);
+	bdev_cachep = kmem_cache_create("bdev_cache",
+			sizeof(struct block_device), 0,
+			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
+				SLAB_MEM_SPREAD|SLAB_ACCOUNT|SLAB_PANIC), NULL);
 	err = register_filesystem(&bd_type);
 	if (err)
 		panic("Cannot register bdev pseudo-fs");
@@ -744,7 +722,7 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	}
 
 	/* switch from the inode reference to a device mode one: */
-	bdev = &BDEV_I(inode)->bdev;
+	bdev = I_BDEV(inode);
 	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
 		bdev = NULL;
 	iput(inode);
diff --git a/block/fops.c b/block/fops.c
index c71e91cd6bcb..9ae795f27f74 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -17,11 +17,6 @@
 #include <linux/fs.h>
 #include "blk.h"
 
-static inline struct inode *bdev_file_inode(struct file *file)
-{
-	return file->f_mapping->host;
-}
-
 static int blkdev_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh, int create)
 {
@@ -390,7 +385,8 @@ const struct address_space_operations def_blk_aops = {
  */
 static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct inode *bd_inode = bdev_file_inode(file);
+	struct block_device *bdev = file->private_data;
+	struct inode *bd_inode = &bdev->inode;
 	loff_t retval;
 
 	inode_lock(bd_inode);
@@ -446,7 +442,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 		return PTR_ERR(bdev);
 
 	filp->private_data = bdev;
-	filp->f_mapping = bdev->bd_inode->i_mapping;
+	filp->f_mapping = bdev->inode.i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	return 0;
 }
@@ -469,7 +465,7 @@ static int blkdev_close(struct inode *inode, struct file *filp)
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = &bdev->inode;
 	loff_t size = i_size_read(bd_inode);
 	struct blk_plug plug;
 	size_t shorted = 0;
@@ -508,7 +504,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
-	loff_t size = i_size_read(bdev->bd_inode);
+	loff_t size = i_size_read(&bdev->inode);
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
 	ssize_t ret;
@@ -534,8 +530,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
 {
-	struct inode *inode = bdev_file_inode(file);
-	struct block_device *bdev = I_BDEV(inode);
+	struct block_device *bdev = file->private_data;
+	struct inode *inode = &bdev->inode;
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
@@ -545,7 +541,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		return -EOPNOTSUPP;
 
 	/* Don't go off the end of the device. */
-	isize = i_size_read(bdev->bd_inode);
+	isize = i_size_read(inode);
 	if (start >= isize)
 		return -EINVAL;
 	if (end >= isize) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3b967053e9f5..e94d08eb4fa9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -49,6 +49,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+	struct inode		inode;
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17705c970d7e..75d2682a8a55 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1141,7 +1141,7 @@ static inline unsigned int blksize_bits(unsigned int size)
 
 static inline unsigned int block_size(struct block_device *bdev)
 {
-	return 1 << bdev->bd_inode->i_blkbits;
+	return 1 << bdev->inode.i_blkbits;
 }
 
 int kblockd_schedule_work(struct work_struct *work);
@@ -1271,10 +1271,14 @@ void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
-struct block_device *I_BDEV(struct inode *inode);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
 		loff_t lend);
 
+static inline struct block_device *I_BDEV(struct inode *inode)
+{
+	return container_of(inode, struct block_device, inode);
+}
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
-- 
2.33.0

