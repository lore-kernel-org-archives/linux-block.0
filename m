Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6E22084
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811090; cv=none; b=Lj3CFeWFErrPztcPCikkuWBZoXq99TeehkQL83tTaZ8Sm3NhCyOExRhntC9PGe9QsNRZgBXmBShhU3G/Tgn1Sgxa6SDqKkBxg7YWMlaGfpihDCJgRG5RDl7mXzQ28XsxNm6TZGclKx/Lcl9GfYp/b/gdx72+vmc/1K0BNCgstzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811090; c=relaxed/simple;
	bh=JWaKP1eF2Rp7cFPg+XpJbJbakaAy6t1BVUdjV4CYq+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pINK0HRpu1JRU/AMhZKu4hyaVBmc9EaSX/T2wQIBVDuAvayNrrIqxlbVchevXAGScxDeSzuLOPzjHvG5BCdtXfRjgq20fOeBIW097PmLwXtW+e2MTO+ApKwDDSxfd9qnSQDLAuSjbBrVquojxh3LoC3uQ8VicE1RsXzTYWKHjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2U1CdAtI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2U1CdAtI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lKV4FlE+MDVTwx+RZft9uF3aE5eOzhTGFxSym4mL4q0=; b=2U1CdAtIHw7yYurNR1awM4rwHh
	MZSlGnX42fTUthSy3aR5c3qVJ1YOb8mjdeSWGubrQbyCCzwUCOqBinSFx1eKXHjW13yFIO3g0jWvo
	VlB5GJdTNoFatih/CXkKIjbfLyoYxCdYMLXcPwZfF46QLvomvG19gYLElXVOR8PJrJ/If7AsQwW3W
	L8xyZeWVmLkMhznKh2hjUATpWu8CxsGAB9y3L99hIvi1uAc/6tN/uZilJhWK16/zrQxAaVOHynuoc
	MZ2xCdhbNp16w/GBFoS45bBcIFqQ8csbfqzGh4dgkjE6ckVk2vGRhIltBbbOONnxBKwiOi+2LiF/z
	Ud6nqINg==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QV-00000001iwA-2Gnq;
	Mon, 01 Jul 2024 05:18:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] block: don't reduce max_sectors based on io_opt
Date: Mon,  1 Jul 2024 07:17:51 +0200
Message-ID: <20240701051800.1245240-3-hch@lst.de>
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

Don't reduce the max_sectors value below the normal cap when the driver
advertsizes a very low io_opt.  This restores the behavior we had before
the recent changes to the max_sectors calculation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index ff8bbc101fedaa..9fa4eed4df06b0 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -276,7 +276,7 @@ static int blk_validate_limits(struct queue_limits *lim)
 		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
-	} else if (lim->io_opt) {
+	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
 		lim->max_sectors =
 			min(max_hw_sectors, lim->io_opt >> SECTOR_SHIFT);
 	} else if (lim->io_min > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
-- 
2.43.0

