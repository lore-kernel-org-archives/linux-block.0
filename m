Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56E22084
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811088; cv=none; b=ii+9UqGOSYtPL1YxRA0gDAg0BdDalg10x7SJA1G7PtvAK9qmAZGXU7yxybJPq8Xb3Ln4d+dsVG2atc+ZkERFZo7MxHZByO8ck3vvycaadpKwC/iQ3ALIyGHjHe3bZC7Ze4d3wp31NCkPKDHA3MuY3IR4ljzLk0T2UGIqwdGXXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811088; c=relaxed/simple;
	bh=MT0ZcDryw2IN+GsdJuqwZgr3IrPsv8PFZoN/X/bjEOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZxGBBE+Dzpf4H7m2jfyR5xLMMo+gj2tekZMvKwODYggMfityS7edSBtWHj1X/QagnRK+N+C4PgMNPe44uKgPpTS8S4Q41OgPiRG9clfVWHzSL+Yiwu9jKuzZtxnmvSrlNO21ek4Z36fE8sYgP9xD3S2sM0rGlSYgVtOJqgdh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PcB9EvGY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PcB9EvGY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=U0Knn9m9suWr0HwuV6YXzPRah7+Yr1TuKS4G5vkqDZc=; b=PcB9EvGYRRtOu+zh9CDxxcfG1k
	L6swJ+7Zp0aNHxiRKireoKVAELs6BIb1khu+IYP7SKg10wL+8AE/t1geGFQh4rR76nVqAqd4VwEIK
	5VZTziSNICHCdkddBhtaSpvpjTuTAEBK8f9pCQfNiSZf40EZCRhVBXbtZGbQBFAC5UFPup3iCWaoR
	bUe03pVo/fgjywTY5oBE67QcGiVhyOax9nUm2sys2pn3pI+KkojlkBfJQ9whCBe8zumWweKfV6tYr
	5GCAVyb3rVlULejVLcYIO+Tx2iQpBbUEzczpyIxuhtO+Go+8D14yWZa7jfhJoq3Jucfm4UzG3Nj8x
	uHIaD6Hg==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QS-00000001ivY-3aHR;
	Mon, 01 Jul 2024 05:18:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] block: remove a duplicate io_min check in blk_validate_limits
Date: Mon,  1 Jul 2024 07:17:50 +0200
Message-ID: <20240701051800.1245240-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
References: <20240701051800.1245240-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

If io_min is larger than the cap, it must by definition be non-zero.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2e559cf97cc834..ff8bbc101fedaa 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -279,8 +279,7 @@ static int blk_validate_limits(struct queue_limits *lim)
 	} else if (lim->io_opt) {
 		lim->max_sectors =
 			min(max_hw_sectors, lim->io_opt >> SECTOR_SHIFT);
-	} else if (lim->io_min &&
-		   lim->io_min > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
+	} else if (lim->io_min > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
 		lim->max_sectors =
 			min(max_hw_sectors, lim->io_min >> SECTOR_SHIFT);
 	} else {
-- 
2.43.0

