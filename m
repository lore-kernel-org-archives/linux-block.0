Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1016DC35;
	Mon,  1 Jul 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852770; cv=none; b=hIpA3VSKINa9p/iOn+F9DkIKWMMgKi1IkvWx4cPFAVgFWEqfSFav1dMrRZsfCkTa8oH255GvQees+F9vkCE3+ZF+JfdQ5vTG99CbTHxyLT3vYFUEWzC3w7orGa2lyR/w1Op7l1cWk+4CI7VBxVPSfMbyDhnxfizX8G2F299QEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852770; c=relaxed/simple;
	bh=ipWjdzhaQE8AssR1q9AdvcIZYcDG1LAVcn0PJv0gqvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt9Fq67J/4WeuxJPBzx2ZO3jGoSRI+RfqBV1chp3V2qFQ1E3LFgk+U239TpARpXLIIlkBQwIj6KKyk5DCf+NnDxUONGyU8Kw9u4jGBRKtChjmqJ9pjifKbOXn3icTEWpL+GTfsOZqsjS90vEZyhRveJ/DmQwy1h0dyBJ7UVoGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pQAoqqsF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pQAoqqsF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PIu8KyjAUoNEI4L8PTKltbTBRaScqHgTEFpyfpYBJ08=; b=pQAoqqsFGlb0P9W6doctrDUG1e
	Ddjf2OhKa03bTFYSkQL2UVLiv+tM8F3OauRhHrDS32bF0d6AAhQIKoroCh+55C4yBcsWAOF6YSRKA
	AB0zYQJbRBPzZTpkqYKIE/FkaZ2/xWGjLUPap8dyYL22x2X0iGVsgOBjW98rfDQxabqcs35aEkDWv
	7cwjZ7GI4MD6Fw0fQSo2phEvQC9rC5LSrQPNsp1Yf8P8YoE20GrY/TH2ywy5ABuXm39h+mAIU1icP
	+5yqVIz38Azy7wYU8ZZuIbphgoERdgVE5muKtpXOFP3lHxsF5LFwZ5qqcjT0Ns6ZKHFqs6p4vukFg
	BCfTVIUw==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGl-00000004BhX-0OxI;
	Mon, 01 Jul 2024 16:52:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 06/10] block: remove the LBA alignment check in __blkdev_issue_zeroout
Date: Mon,  1 Jul 2024 18:51:16 +0200
Message-ID: <20240701165219.1571322-7-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701165219.1571322-1-hch@lst.de>
References: <20240701165219.1571322-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

__blkdev_issue_zeroout is a purely kernel internal API and thus can rely
on the block layer sector alignment checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index f338709aef0c30..7aa7937c34201d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -209,11 +209,6 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		unsigned flags)
 {
 	int ret;
-	sector_t bs_mask;
-
-	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
 
 	ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
 			biop, flags);
-- 
2.43.0

