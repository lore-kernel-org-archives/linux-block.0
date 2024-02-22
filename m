Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AAD17988
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586680; cv=none; b=GiPMEjx1Pi/92aBhgWegecbHnDHjU8lEIUQxVtxDLJRp/CXFVRUjMJnRDRv6BdtMtJwVqPGcvELszUm7snGmO++DqZjhLg8xEAdWghWEnyMrhU0b0yTnCyirrCaJHnkWnos3aVWPoEauSS5wDV0I8aLMz/djVzsurPjcalEu8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586680; c=relaxed/simple;
	bh=P5RAyGVnbnwb7D7D4vkKFGL+E50ZuLdaNaJ7mUqDac0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMK/odSwzVhPe0LVVzLy1FwGxQ04cjrMePllEABaCsEhVQHHfS+hMfWg2GN3RV284LmIGiXaWLA81e86Vk8svcFi6dVApwJeoUHI6Xsdd5kVCgFDtCnQ7iwnChxNNAF2wlvRA+6e9EYSYihhLhc8BHK3SJre2Q6XZ7CZEB3pYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nNnqEWHG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNnqEWHG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Fn+HB6bbM1pjLkNl/fg3PCRANt5VA3yO0I85pvryFgs=; b=nNnqEWHGHrf+MdshFlnRUY/mud
	9cAXYnw5EQJe+lx4tYJe4gDW5vAUsAMDATd4hK7VfbU28ood6ydouUL4hYriiz2tY34cQdxUpMIJo
	nQ7OTUGTPc0cspu0OtxdT2MjqcekznW2sOc+xp7zdRoZQPdgqfLUv8JCHKGmKt+4L0emMov9XKdnY
	yU/nwayCNs4yZwFUlxNmQa+SdoXr0HKsJhPSCkGG0Eltk2rGC8wKDov0ANCbEwS3IFAs7BRsS92I+
	wcwKZlmcgfR557yCH8C4K6JeDp6eXRribGyAzgwBGVmPXa3OfO3A1eyrwBSET78FhEn3WBcIAooKK
	anfq/0Cg==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3Rd-00000003njL-0p4J;
	Thu, 22 Feb 2024 07:24:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 7/7] ubd: open the backing files in ubd_add
Date: Thu, 22 Feb 2024 08:24:17 +0100
Message-Id: <20240222072417.3773131-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222072417.3773131-1-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Opening the backing device only when the block device is opened is
a bit weird as no one configures block devices to not use them.
Opend them at add time, close them at remove time and remove the
now superflous opened counter as remove can simply check for
disk_openers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 58 +++++++++++---------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 9bf1d6a88bae59..63fc062add708c 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -108,8 +108,6 @@ static inline void ubd_set_bit(__u64 bit, unsigned char *data)
 static DEFINE_MUTEX(ubd_lock);
 static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
 
-static int ubd_open(struct gendisk *disk, blk_mode_t mode);
-static void ubd_release(struct gendisk *disk);
 static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg);
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
@@ -118,8 +116,6 @@ static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 static const struct block_device_operations ubd_blops = {
         .owner		= THIS_MODULE,
-        .open		= ubd_open,
-        .release	= ubd_release,
         .ioctl		= ubd_ioctl,
         .compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.getgeo		= ubd_getgeo,
@@ -152,7 +148,6 @@ struct ubd {
 	 * backing or the cow file. */
 	char *file;
 	char *serial;
-	int count;
 	int fd;
 	__u64 size;
 	struct openflags boot_openflags;
@@ -178,7 +173,6 @@ struct ubd {
 #define DEFAULT_UBD { \
 	.file = 		NULL, \
 	.serial =		NULL, \
-	.count =		0, \
 	.fd =			-1, \
 	.size =			-1, \
 	.boot_openflags =	OPEN_FLAGS, \
@@ -873,6 +867,13 @@ static int ubd_add(int n, char **error_out)
 		goto out;
 	}
 
+	err = ubd_open_dev(ubd_dev);
+	if (err) {
+		pr_err("ubd%c: Can't open \"%s\": errno = %d\n",
+			'a' + n, ubd_dev->file, -err);
+		goto out;
+	}
+
 	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
 
 	ubd_dev->tag_set.ops = &ubd_mq_ops;
@@ -884,7 +885,7 @@ static int ubd_add(int n, char **error_out)
 
 	err = blk_mq_alloc_tag_set(&ubd_dev->tag_set);
 	if (err)
-		goto out;
+		goto out_close;
 
 	disk = blk_mq_alloc_disk(&ubd_dev->tag_set, &lim, ubd_dev);
 	if (IS_ERR(disk)) {
@@ -919,6 +920,8 @@ static int ubd_add(int n, char **error_out)
 	put_disk(disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
+out_close:
+	ubd_close_dev(ubd_dev);
 out:
 	return err;
 }
@@ -1014,13 +1017,14 @@ static int ubd_remove(int n, char **error_out)
 	if(ubd_dev->file == NULL)
 		goto out;
 
-	/* you cannot remove a open disk */
-	err = -EBUSY;
-	if(ubd_dev->count > 0)
-		goto out;
-
 	if (ubd_dev->disk) {
+		/* you cannot remove a open disk */
+		err = -EBUSY;
+		if (disk_openers(ubd_dev->disk))
+			goto out;
+
 		del_gendisk(ubd_dev->disk);
+		ubd_close_dev(ubd_dev);
 		put_disk(ubd_dev->disk);
 	}
 
@@ -1143,36 +1147,6 @@ static int __init ubd_driver_init(void){
 
 device_initcall(ubd_driver_init);
 
-static int ubd_open(struct gendisk *disk, blk_mode_t mode)
-{
-	struct ubd *ubd_dev = disk->private_data;
-	int err = 0;
-
-	mutex_lock(&ubd_mutex);
-	if(ubd_dev->count == 0){
-		err = ubd_open_dev(ubd_dev);
-		if(err){
-			printk(KERN_ERR "%s: Can't open \"%s\": errno = %d\n",
-			       disk->disk_name, ubd_dev->file, -err);
-			goto out;
-		}
-	}
-	ubd_dev->count++;
-out:
-	mutex_unlock(&ubd_mutex);
-	return err;
-}
-
-static void ubd_release(struct gendisk *disk)
-{
-	struct ubd *ubd_dev = disk->private_data;
-
-	mutex_lock(&ubd_mutex);
-	if(--ubd_dev->count == 0)
-		ubd_close_dev(ubd_dev);
-	mutex_unlock(&ubd_mutex);
-}
-
 static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow_mask,
 			  __u64 *cow_offset, unsigned long *bitmap,
 			  __u64 bitmap_offset, unsigned long *bitmap_words,
-- 
2.39.2

