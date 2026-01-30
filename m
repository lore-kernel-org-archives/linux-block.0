Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D532DE200
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769754825; cv=none; b=uHEbskafkcLQqqs8c1s8tAWGe3CbCkc5O8zU9op6ad9j9eKgZknQUgM88YqAQYvkEkm7Rie2wIDWbqE/OnGCK4FfoogP88YhAG3gSrbF0+yeqRYO3ZOcPshR4XjVi5ACRaj4DmAlTu23JUzUb89+E1V2Pdzd+m0j5KYaFCPzud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769754825; c=relaxed/simple;
	bh=DzwJacrbW0NKaAl0vW6ZNZqxjAaQ75w5C0v/Xf+57To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a4Wh+fMtc11Vz/GPCuUgHkN5LyGbrc89qIAD9kCoO85kOgZGCs/ZX4SAaE7l/69x0v9udoYZg+k2j0K8a2td0TZQjVXf966JWMjgDSCfxCDpP8E0Zf/Wjeyo8cyMMXj5EqacJ/7DmOWlee11xY7lb0KwgUvumoZ/bTHs5gL63Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/YMLSee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/YMLSee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89244C4CEF7;
	Fri, 30 Jan 2026 06:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769754824;
	bh=DzwJacrbW0NKaAl0vW6ZNZqxjAaQ75w5C0v/Xf+57To=;
	h=From:To:Subject:Date:From;
	b=Y/YMLSeeVvIDYGwde5eEZBAd528DJ+AN+ZT2mWJSCa371FExSGxDZjEun04nTN0E3
	 AknMKSXpaUXbtQiQpg0aw+AyWzFXriE3MUrcCZjLOYhtnXSaeS0UtxFhp7ka57mCMv
	 r6kk66gSBGdVFI6ehx+uPdaBQClzFJptA8FiPEuPaeg+K8iurk+qu9m0vdGTx+/o3F
	 UIwAOHe5wsw8jaxpbZPDgGUcgpMg1Kw/v+560BQhBnZNKhl4MZyQa7//ivCCLcU7Il
	 weLuMSAsfAgIAgAbrqjZ/vxmDp0g4O6S55PIbGhUzUAZB+O1Xy6jxOnSlxq0mJyzRf
	 3gdbAspT4SZ4w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: introduce bdev_rot()
Date: Fri, 30 Jan 2026 15:28:45 +0900
Message-ID: <20260130062846.1227392-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the helper function bdev_rot() to test if a block device is a
rotational one. The existing function bdev_nonrot() which tests for the
opposite condition is redefined using this new helper.
This avoids the double negation (operator and name) that appears when
testing if a block device is a rotational device, thus making the code a
little easier to read.

Call sites of bdev_nonrot() in the block layer are updated to use this
new helper.  Remaining users in other subsystems are left unchanged for
now.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/ioctl.c                   | 2 +-
 drivers/block/loop.c            | 2 +-
 drivers/nvme/target/admin-cmd.c | 4 ++--
 include/linux/blkdev.h          | 7 ++++++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 344478348a54..fd48f82f9f03 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -692,7 +692,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 				    queue_max_sectors(bdev_get_queue(bdev)));
 		return put_ushort(argp, max_sectors);
 	case BLKROTATIONAL:
-		return put_ushort(argp, !bdev_nonrot(bdev));
+		return put_ushort(argp, bdev_rot(bdev));
 	case BLKRASET:
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bd59c0e9508b..ae3039584045 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -969,7 +969,7 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
 	lim->features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
 	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		lim->features |= BLK_FEAT_WRITE_CACHE;
-	if (backing_bdev && !bdev_nonrot(backing_bdev))
+	if (backing_bdev && bdev_rot(backing_bdev))
 		lim->features |= BLK_FEAT_ROTATIONAL;
 	lim->max_hw_discard_sectors = max_discard_sectors;
 	lim->max_write_zeroes_sectors = max_discard_sectors;
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3da31bb1183e..5e366502fb75 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -298,7 +298,7 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	if (!req->ns->bdev || bdev_nonrot(req->ns->bdev)) {
+	if (!req->ns->bdev || !bdev_rot(req->ns->bdev)) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
@@ -1084,7 +1084,7 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 	id->nmic = NVME_NS_NMIC_SHARED;
 	if (req->ns->readonly)
 		id->nsattr |= NVME_NS_ATTR_RO;
-	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
+	if (req->ns->bdev && bdev_rot(req->ns->bdev))
 		id->nsfeat |= NVME_NS_ROTATIONAL;
 	/*
 	 * We need flush command to flush the file's metadata,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1e5b5547929f..2ae4c45e4959 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1461,9 +1461,14 @@ bdev_write_zeroes_unmap_sectors(struct block_device *bdev)
 	return bdev_limits(bdev)->max_wzeroes_unmap_sectors;
 }
 
+static inline bool bdev_rot(struct block_device *bdev)
+{
+	return blk_queue_rot(bdev_get_queue(bdev));
+}
+
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
-	return !blk_queue_rot(bdev_get_queue(bdev));
+	return !bdev_rot(bdev);
 }
 
 static inline bool bdev_synchronous(struct block_device *bdev)
-- 
2.52.0

