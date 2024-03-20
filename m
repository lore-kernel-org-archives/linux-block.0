Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FE9AD49
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710899507; cv=none; b=ktICiymz6bc1jLTH+v7WHUetArlayTsZcBOOrVF+l6IKeUAS6xFIS0tDCrs1+hfLGrXvpg+exrv4JpxT0gwITl+V1kCNXkXS1m9vzD10prq3v0qRm/073UxMIP6mdJjR+Gf0NHewoHumlfE6ZKKE2wotPJ3aXWc6tuuwgwU3WOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710899507; c=relaxed/simple;
	bh=pdoMV+NYV4RLTkm21ZTmF5yBq4W8CjgbLQ19i7GSruA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP8UykdpeVyTvL/kFLy0TnYMYLBVKuz7USIVKU/DnKRUJVngEO5vb3FfpV/XJfA9kfuuQRQl0UEJ8LCm8KPmsuYNhUn43gG7xHdKm6YAclDbX79XYwFTGWIKDqutxpkTLV3x2FJl4U8HE6G9YqPAaqb2t9BjYsa9fFKWsQ4ZtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C21D68B05; Wed, 20 Mar 2024 02:51:34 +0100 (CET)
Date: Wed, 20 Mar 2024 02:51:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saranya Muruganandam <saranyamohan@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	sashal@kernel.org, Ming Lei <ming.lei@redhat.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
Message-ID: <20240320015134.GA14267@lst.de>
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com> <20240212154411.GA28927@lst.de> <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com> <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com> <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com> <27bff287-049d-5bbb-2392-fd5f099bed3c@huaweicloud.com> <CAP9s-SrXvm5MfhXCMBYfsEv9xKWqvkkLp2ZjndYrJ65m5x8M_w@mail.gmail.com> <20240308163237.GA17159@lst.de> <CAP9s-Sq7YHbcbUBMV==d+cz0yK-zB9zKzFJhVMkPWJKfV1gLpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9s-Sq7YHbcbUBMV==d+cz0yK-zB9zKzFJhVMkPWJKfV1gLpA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Please try the patch below:

I would also relly help to have a blktsts test case to show your
issue and verify that it is fixed.

diff --git a/block/bdev.c b/block/bdev.c
index e7adaaf1c21927..51071d371863e0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -645,6 +645,14 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 	bdev_write_inode(bdev);
 }
 
+static void blkdev_put_whole(struct block_device *bdev)
+{
+	if (atomic_dec_and_test(&bdev->bd_openers))
+		blkdev_flush_mapping(bdev);
+	if (bdev->bd_disk->fops->release)
+		bdev->bd_disk->fops->release(bdev->bd_disk);
+}
+
 static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -663,20 +671,21 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 
 	if (!atomic_read(&bdev->bd_openers))
 		set_init_blocksize(bdev);
-	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
-		bdev_disk_changed(disk, false);
 	atomic_inc(&bdev->bd_openers);
+	if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
+		/*
+		 * Only return scanning errors if we are called from conexts
+		 * that explicitly want them, e.g. the BLKRRPART ioctl.
+		 */
+		ret = bdev_disk_changed(disk, false);
+		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
+			blkdev_put_whole(bdev);
+			return ret;
+		}
+	}
 	return 0;
 }
 
-static void blkdev_put_whole(struct block_device *bdev)
-{
-	if (atomic_dec_and_test(&bdev->bd_openers))
-		blkdev_flush_mapping(bdev);
-	if (bdev->bd_disk->fops->release)
-		bdev->bd_disk->fops->release(bdev->bd_disk);
-}
-
 static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
 {
 	struct gendisk *disk = part->bd_disk;
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaaa5..128f503828cee7 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -562,7 +562,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 			return -EACCES;
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
-		return disk_scan_partitions(bdev->bd_disk, mode);
+		return disk_scan_partitions(bdev->bd_disk,
+				mode | BLK_OPEN_STRICT_SCAN);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f9b87c39cab047..272ce42f297cfe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -128,6 +128,8 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
 /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
 #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 5))
 
 struct gendisk {
 	/*
