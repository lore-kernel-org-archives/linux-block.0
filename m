Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999503207
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142187; cv=none; b=hT2l8fquOa7ERuxCvZ3wKcupe7K7X6zu83XSPS6JPSLqtkEk9ZmkOQstFxOBacxSbLK6zdp5S+UUNwdpmdU1CO80cnKTUOiNT/0ceOjQ1eHPFZHVPCS7fB7gHKhrF4XNxZArXf1zv+LOaoJI1uLwIenWg7C4LQ2Dm+OANopmb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142187; c=relaxed/simple;
	bh=+55o7fEoGvGmCACyVj4WGdgf1jWVC+YpR1zhfQgZfbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rK6EG8cszB1N8ijSLbufQbkOp4YX0u/1KyGDCdtffbz5cZYYZ/Bz7IsRPKBRuPtZarDPyYcsAvJpDi4tML2r4IOjd6P0k9C9xl2TaOr1zB8MkAa4RcPKjQCQcWXqY+KAm9AWXFNaC+sc5gFq7Gifl7wyTVff889ZZte9NLkRjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrxZ89m5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrxZ89m5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8888BC4CEE3;
	Tue, 17 Jun 2025 06:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750142187;
	bh=+55o7fEoGvGmCACyVj4WGdgf1jWVC+YpR1zhfQgZfbI=;
	h=From:To:Cc:Subject:Date:From;
	b=WrxZ89m5hwHABxOWQNsB4Vnw0PSDfAlA+h0b4kZxmInTKbOk0i6jPWQ6qpRlBRQD3
	 DegrQXb0Zizqtnwis5hTUgfkr03kR3i6/s72v6NwGH8TzJxdoTlhJe5Dxp+W+TXPr8
	 gB9TfBu3EFTXlKXp2Nxx3ok9HX4yXIcnmTTxCwrNeSoD2qWMJdpv0EiI5V/fkZSWg1
	 /JZNT68LuWenX/PVmIS2AKMHow0P7ROtWf+QI07e6S/897uudoU8WlNpkxaa0uuNAO
	 39ZL1p0uYJIttmbnZ5rX5zEDUpLSNoYW/y8VUTglLruQHu4NNvg/1TuE36V3+fbc4s
	 WDrL9DM3ClEkw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] block: Increase BLK_DEF_MAX_SECTORS_CAP
Date: Tue, 17 Jun 2025 15:34:30 +0900
Message-ID: <20250617063430.668899-1-dlemoal@kernel.org>
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

Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 85aab8bc96e7..7c35b2462048 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1238,7 +1238,7 @@ enum blk_default_limits {
  * Not to be confused with the max_hw_sector limit that is entirely
  * controlled by the driver, usually based on hardware limits.
  */
-#define BLK_DEF_MAX_SECTORS_CAP	2560u
+#define BLK_DEF_MAX_SECTORS_CAP	8192u
 
 static inline struct queue_limits *bdev_limits(struct block_device *bdev)
 {
-- 
2.49.0

