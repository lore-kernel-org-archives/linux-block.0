Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C122DDCFD;
	Tue, 29 Apr 2025 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970748; cv=none; b=KH9eeGfNW3V3ojCfkoi/dDWHaTdqwx4leMoHZabbMvCbfBy83V9awm5t/N3TTY87QNFJnqQcKVCaIeXEkBOf6AlBfDBdIsHs0/byEbI8YXs/hWi79x6cPSygXHJBHrShWzcYFOk2eBCTeirzjJoisb+v1Av70sSbnMIDheXxRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970748; c=relaxed/simple;
	bh=6gn5xHXVJM5z/QfQEmL4yn0FdBBtunL2zWcyJq1EO78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIpXyJZREnZwk9BF58fScW9EqJTS20xpY/LBI8TB/7YZNyPogx+PQkON66iPq8cqcQQqNJ2dfbSu/euq3N9kvRZfBQsFFKWWoORlRs60UrUsNmL50esxygvd0TMOJQ/3GrxHaziYAx/LLW42MTe9MdYDqM1GB4qel3zRtYz/69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgEf+oSv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgEf+oSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120BDC4CEED;
	Tue, 29 Apr 2025 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970748;
	bh=6gn5xHXVJM5z/QfQEmL4yn0FdBBtunL2zWcyJq1EO78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgEf+oSvMX3cHU6oRzTlVKQgxhE4beX4oRavnelBHTh5mF3LpoFIUuJMTzNjj8PWE
	 Lmd7QOjyaOjUkwLc1F1P9lgbn5AkpFqHdZ2msPrSyQoBqG14rOCo2qT3yoHedrbcxh
	 ibRJnfrjaDWkTBXDbTplLy12mqInd3c6fD0fNspxA5i0zob0E4+HQtzAyBAMeydokF
	 TGY8C3y8o8bNVV+AxkqNP4rgNYhGLH+a0Mrcdb08fDCGckcBAX4gQxChefJdUCRk9Q
	 TPwHtf6Pk6Wlif6czyc+ROC7fXwg40ZiBrZS+mh1SOB3rn7IK8XvOb2QzWJCZ89Lvg
	 7dCbqqTzPAYOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 34/37] block: fix race between set_blocksize and read paths
Date: Tue, 29 Apr 2025 19:51:19 -0400
Message-Id: <20250429235122.537321-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit c0e473a0d226479e8e925d5ba93f751d8df628e9 ]

With the new large sector size support, it's now the case that
set_blocksize can change i_blksize and the folio order in a manner that
conflicts with a concurrent reader and causes a kernel crash.

Specifically, let's say that udev-worker calls libblkid to detect the
labels on a block device.  The read call can create an order-0 folio to
read the first 4096 bytes from the disk.  But then udev is preempted.

Next, someone tries to mount an 8k-sectorsize filesystem from the same
block device.  The filesystem calls set_blksize, which sets i_blksize to
8192 and the minimum folio order to 1.

Now udev resumes, still holding the order-0 folio it allocated.  It then
tries to schedule a read bio and do_mpage_readahead tries to create
bufferheads for the folio.  Unfortunately, blocks_per_folio == 0 because
the page size is 4096 but the blocksize is 8192 so no bufferheads are
attached and the bh walk never sets bdev.  We then submit the bio with a
NULL block device and crash.

Therefore, truncate the page cache after flushing but before updating
i_blksize.  However, that's not enough -- we also need to lock out file
IO and page faults during the update.  Take both the i_rwsem and the
invalidate_lock in exclusive mode for invalidations, and in shared mode
for read/write operations.

I don't know if this is the correct fix, but xfs/259 found it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/174543795699.4139148.2086129139322431423.stgit@frogsfrogsfrogs
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bdev.c      | 17 +++++++++++++++++
 block/blk-zoned.c |  5 ++++-
 block/fops.c      | 16 ++++++++++++++++
 block/ioctl.c     |  6 ++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7f..e7daca6565ea6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -168,9 +168,26 @@ int set_blocksize(struct file *file, int size)
 
 	/* Don't change the size if it is same as current */
 	if (inode->i_blkbits != blksize_bits(size)) {
+		/*
+		 * Flush and truncate the pagecache before we reconfigure the
+		 * mapping geometry because folio sizes are variable now.  If a
+		 * reader has already allocated a folio whose size is smaller
+		 * than the new min_order but invokes readahead after the new
+		 * min_order becomes visible, readahead will think there are
+		 * "zero" blocks per folio and crash.  Take the inode and
+		 * invalidation locks to avoid racing with
+		 * read/write/fallocate.
+		 */
+		inode_lock(inode);
+		filemap_invalidate_lock(inode->i_mapping);
+
 		sync_blockdev(bdev);
+		kill_bdev(bdev);
+
 		inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
+		filemap_invalidate_unlock(inode->i_mapping);
+		inode_unlock(inode);
 	}
 	return 0;
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c11db5be25324..414118435240a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -347,6 +347,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
+		inode_lock(bdev->bd_mapping->host);
 		filemap_invalidate_lock(bdev->bd_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
@@ -368,8 +369,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
 
 fail:
-	if (cmd == BLKRESETZONE)
+	if (cmd == BLKRESETZONE) {
 		filemap_invalidate_unlock(bdev->bd_mapping);
+		inode_unlock(bdev->bd_mapping->host);
+	}
 
 	return ret;
 }
diff --git a/block/fops.c b/block/fops.c
index 43983be5a2b3b..d4b1d942f2700 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -721,7 +721,14 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		/*
+		 * Take i_rwsem and invalidate_lock to avoid racing with
+		 * set_blocksize changing i_blkbits/folio order and punching
+		 * out the pagecache.
+		 */
+		inode_lock_shared(bd_inode);
 		ret = blkdev_buffered_write(iocb, from);
+		inode_unlock_shared(bd_inode);
 	}
 
 	if (ret > 0)
@@ -732,6 +739,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct inode *bd_inode = bdev_file_inode(iocb->ki_filp);
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	loff_t size = bdev_nr_bytes(bdev);
 	loff_t pos = iocb->ki_pos;
@@ -768,7 +776,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			goto reexpand;
 	}
 
+	/*
+	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
+	 * changing i_blkbits/folio order and punching out the pagecache.
+	 */
+	inode_lock_shared(bd_inode);
 	ret = filemap_read(iocb, to, ret);
+	inode_unlock_shared(bd_inode);
 
 reexpand:
 	if (unlikely(shorted))
@@ -811,6 +825,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
+	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
@@ -843,6 +858,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
  fail:
 	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	return error;
 }
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 6554b728bae6a..919066b4bb49c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -141,6 +141,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	if (err)
 		return err;
 
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
@@ -173,6 +174,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	blk_finish_plug(&plug);
 fail:
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 
@@ -198,12 +200,14 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 
@@ -235,6 +239,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
@@ -245,6 +250,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 
-- 
2.39.5

