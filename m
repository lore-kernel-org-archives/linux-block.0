Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D425696C;
	Tue, 29 Apr 2025 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970677; cv=none; b=Q99BAc8G9Kuo1JsQVcIkAu97kQ9rQwEmr2srx86ZCijvWyNII+YkHb8b+VWFiSA3ZC1d+pFhT2NITsWr9QTq88oaLK9NqJuOESJslkUWja0eIeOM7BjbRV2BhTt+tAixSZiSZuYTVzUSq1jZGMK6Ut81hZH8i0lq3c3oUxXPLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970677; c=relaxed/simple;
	bh=2gvr+tfeQlHcRGJ8gH3wuldebmB4K931xOHT8FRYLmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pUXVUvTNi402UDt/xgwP41ZW2IKTgQxyxZuRTWijbsXAunJGwp+3DRF0q9wV9cgE35ftkM+ahlcmeJEnikpsvANzl9Zh1u+FK/GC3rlbvqwNW8L4GpNXnHvtz1N8qiOvhjR6IvXA5mb0SXaRlqIWaLz+SAQ9wLP/dACqBX6J69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUhNe/vy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUhNe/vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DC9C4CEEE;
	Tue, 29 Apr 2025 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970677;
	bh=2gvr+tfeQlHcRGJ8gH3wuldebmB4K931xOHT8FRYLmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUhNe/vyjSfqZzaul6H81bvbh7yrnF3KcdfxDb5Wu9HfcbuOEI3OEoGQ8fyWSEsyU
	 1UKul/jUuk3qlq+I1l6HWU3kWDz57Qvrj56vKDau5SzaVQp3n7QbCNn09ntSD0N2Qz
	 UXYtn3OhkhMorJQmhSiJED9Nk76PTMwD/iwGbafx8BD7s0yRZ5iQ3JRF9bCmiPyi64
	 LdGLUDwOLqSjHljhefS0QSBLW3bLvU5mQWQRhhfz7rb5t+kOZYtI38T1c/ZcrOX8Hy
	 ULsurxf1LJixtWdw10uVkjQTMJ7IVo1jFxpvlPfpwgMiVLEJqV83wqXU+NWY/XRAjO
	 h+InWE/LXLYLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 36/39] block: hoist block size validation code to a separate function
Date: Tue, 29 Apr 2025 19:50:03 -0400
Message-Id: <20250429235006.536648-36-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit e03463d247ddac66e71143468373df3d74a3a6bd ]

Hoist the block size validation code to bdev_validate_blocksize so that
we can call it from filesystems that don't care about the bdev pagecache
manipulations of set_blocksize.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/174543795720.4139148.840349813093799165.stgit@frogsfrogsfrogs
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bdev.c           | 33 +++++++++++++++++++++++++++------
 include/linux/blkdev.h |  1 +
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 06b8cab31d759..e5af18bc43082 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -150,18 +150,39 @@ static void set_init_blocksize(struct block_device *bdev)
 	BD_INODE(bdev)->i_blkbits = blksize_bits(bsize);
 }
 
-int set_blocksize(struct file *file, int size)
+/**
+ * bdev_validate_blocksize - check that this block size is acceptable
+ * @bdev:	blockdevice to check
+ * @block_size:	block size to check
+ *
+ * For block device users that do not use buffer heads or the block device
+ * page cache, make sure that this block size can be used with the device.
+ *
+ * Return: On success zero is returned, negative error code on failure.
+ */
+int bdev_validate_blocksize(struct block_device *bdev, int block_size)
 {
-	struct inode *inode = file->f_mapping->host;
-	struct block_device *bdev = I_BDEV(inode);
-
-	if (blk_validate_block_size(size))
+	if (blk_validate_block_size(block_size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
-	if (size < bdev_logical_block_size(bdev))
+	if (block_size < bdev_logical_block_size(bdev))
 		return -EINVAL;
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bdev_validate_blocksize);
+
+int set_blocksize(struct file *file, int size)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *bdev = I_BDEV(inode);
+	int ret;
+
+	ret = bdev_validate_blocksize(bdev, size);
+	if (ret)
+		return ret;
+
 	if (!file->private_data)
 		return -EINVAL;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d37751789bf58..ef98bcca7f5f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1593,6 +1593,7 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
 
+int bdev_validate_blocksize(struct block_device *bdev, int block_size);
 int set_blocksize(struct file *file, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
-- 
2.39.5

