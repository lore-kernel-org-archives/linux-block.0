Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC41DF968
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226563; cv=none; b=Zja0sz0bHtu9+2sI3Q4Zts324WuIygl4InOxRd30eXasJMiLLWxH+mkH7LiGPNLTUjVedzr+lBbeb6IH+xcgWxD4gR+jD4v/98MikCkFnPCfe2fyqEi9sUbczvUtAsx3KCblOW2+dAnMGziMfRvoadkRZ6+NoLKnFwnWug0mxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226563; c=relaxed/simple;
	bh=vD5vpDLLPJphk0Gn0KVtmzZ1vCmSn9yIcccjnqKmUx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiYdfg1VFFk4+UR9g0qZxgYv05aBMEPJ2jdaEAczpkQPyytFC9Wv3zu0R4tWmk0+zT9nshxHZ8KiSdwEd/pBCr600F6y5h2hrmRhDB2xPNAIX2MGpzF/ymP+/8UFOg9daq+7iBkTT5HyMtVEUinBWRj+01jSWKM1Qjl5Yzgolck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evS8lJEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evS8lJEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AD7C4CEEF;
	Wed, 18 Jun 2025 06:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750226563;
	bh=vD5vpDLLPJphk0Gn0KVtmzZ1vCmSn9yIcccjnqKmUx8=;
	h=From:To:Cc:Subject:Date:From;
	b=evS8lJEpQz6ZFBW3DL8/U1QntAAG8fp689OkgoA7YQLIHpfHLOc49N4Zg0z2LzHsd
	 WZuYq3SeOBCMes4tA0aydm2Ct2ufgDwQI2zcyHkDubCT3gG3MyKj9kXyINwMIAbxkB
	 Sgzwl8nm0hDkbrRpHTJ6E0fn/+Osiyl19ynYGu7rwecFp8pHqCeYEx5vySFww8H9ZF
	 k7gGyKfu44NFbKzPqao5NoGB68uru33O6v3zYh2FB4MKgT6N0i+sxNuffVzwOIbNbA
	 ZqGOklngQ1YKw/rdXhDnzHt+a2CtCBrJTkjtDvij5DMIzsMVcjG9t2+4BmYkKpsEV6
	 v4k8w58/JesgQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Date: Wed, 18 Jun 2025 15:00:45 +0900
Message-ID: <20250618060045.37593-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Back in 2015, commit d2be537c3ba3 ("block: bump BLK_DEF_MAX_SECTORS to
2560") increased the default maximum size of a block device I/O to 2560
sectors (1280 KiB) to "accommodate a 10-data-disk stripe write with
chunk size 128k". This choice is rather arbitrary and since then,
improvements to the block layer have software RAID drivers correctly
advertize their stripe width through chunk_sectors and abuses of
BLK_DEF_MAX_SECTORS_CAP by drivers (to set the HW limit rather than the
default user controlled maximum I/O size) have been fixed.

Since many block devices can benefit from a larger value of
BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
be 4MiB, or 8192 sectors.

And given that BLK_DEF_MAX_SECTORS_CAP is only used in the block layer
and should not be used by drivers directly, move this macro definition
to the block layer internal header file block/blk.h.

Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
Changes from v1:
 - Move BLK_DEF_MAX_SECTORS_CAP definition to block/blk.h
 - Define the macro value using SZ_4M to make it more readable
 - Added review tag

 block/blk.h            | 9 +++++++++
 include/linux/blkdev.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..1141b343d0b5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -13,6 +13,15 @@
 
 struct elevator_type;
 
+/*
+ * Default upper limit for the software max_sectors limit used for regular I/Os.
+ * This can be increased through sysfs.
+ *
+ * This should not be confused with the max_hw_sector limit that is entirely
+ * controlled by the block device driver, usually based on hardware limits.
+ */
+#define BLK_DEF_MAX_SECTORS_CAP	(SZ_4M >> SECTOR_SHIFT)
+
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
 #define	BLK_MIN_SEGMENT_SIZE	4096
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 85aab8bc96e7..c2b3ddea8b6d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1231,15 +1231,6 @@ enum blk_default_limits {
 	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
 };
 
-/*
- * Default upper limit for the software max_sectors limit used for
- * regular file system I/O.  This can be increased through sysfs.
- *
- * Not to be confused with the max_hw_sector limit that is entirely
- * controlled by the driver, usually based on hardware limits.
- */
-#define BLK_DEF_MAX_SECTORS_CAP	2560u
-
 static inline struct queue_limits *bdev_limits(struct block_device *bdev)
 {
 	return &bdev_get_queue(bdev)->limits;
-- 
2.49.0

