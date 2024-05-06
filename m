Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198343ABC
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969234; cv=none; b=k/f/sG8X4c6rpo3clCIlyDcawEtNwall0nMfVDy+H790WskVRxI2Y+ztpfoX+77kJOYjNgk/IYn3EiStda4Lqn4NIXa2pG9xVixRlJPa/6xg9WVmB20fXCLKHT4zp6Oriv5aVRDPOxd8lJhQBw4IcJc4HYpiraRtfo66+siU0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969234; c=relaxed/simple;
	bh=N6P/wm3g0Yu0jltiR1vPEFbEyZaGCar5+1H0lFL0rGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1/JliCXUu+j9HLTLePwIABjNPMbA+4ua0OGHox9/4UlEdzVxLtREv/xzZk+pBaRhZamnaE2w6XAhS+LTEkhVEbXVs+9J/iP0cYtCKLzinqUNzlDA/jE6C5tvbqENF2gvt6ond/H+ts1+2UmRktULNS5LLQWsco8vnsPrd1Lf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a263W0XM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a263W0XM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=D3pqLzp++9XFe0fVDALJJy2muOH3yk6YApG4Yk4oZio=; b=a263W0XM1itMweZB1pF/S0dgz3
	18zEfXSlRc00uqn8q6VruU0jVwW4h4Ca/T5T5BQht1t2JIals9wnCOPXY8lXs1yRIVW/csY9AIyik
	Bzj4rGXqQn5AlGO41V/fHg1EapVjgGX1DYHIM5Ed4ZGWxJ+O1npfx9mlN4vufePFYkDU7vLbF7C1q
	N/Z6k6+ZVclKI81O+FKo9P4qp51mXTHD32eXWLtCqLtUzjEPYm4/klCLGJsQ98xPpbIbPb8nMnB7y
	Zy2lYrLyUfdJJe2qu4SwMu3plsf+GrvKw7n6kn4inHuDd1OBNlbxxhGNV37RZH02HSNfXKfGrVz8k
	gA6hRWRg==;
Received: from [2001:4bb8:188:7ba8:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pq3-000000060KE-3rgc;
	Mon, 06 May 2024 04:20:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: remove the discard_granularity check in __blkdev_issue_discard
Date: Mon,  6 May 2024 06:20:22 +0200
Message-Id: <20240506042027.2289826-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506042027.2289826-1-hch@lst.de>
References: <20240506042027.2289826-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

We now set a default granularity in the queue limits API, so don't
bother with this extra check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index a6954eafb8c8af..7ec3e170e7f629 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -46,13 +46,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (!bdev_max_discard_sectors(bdev))
 		return -EOPNOTSUPP;
 
-	/* In case the discard granularity isn't set by buggy device driver */
-	if (WARN_ON_ONCE(!bdev_discard_granularity(bdev))) {
-		pr_err_ratelimited("%pg: Error: discard_granularity is 0.\n",
-				   bdev);
-		return -EOPNOTSUPP;
-	}
-
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
-- 
2.39.2

