Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956F69954
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520339; cv=none; b=NQ6G/uHRFm+5jqapG6miB3x7jOaokU/Mbc3/hlTOI5AINe7gwJ6JGgWWnPmrsMQEU1VkeZGIlSZuEnXVcyaBAwNvrSXsbFomRrWdbjAk/3MthnX2w++M9VxBvwiYGLzVuvZ23MaaOu4ohPQsN6ZvnyTaE8yZkIpzE2I5liJAUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520339; c=relaxed/simple;
	bh=4XFEk3nVvCghzXJMY0GVsVrHIYMwBXx0hwRR88dczOc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZq+g2ikfgHz5wugQb+WWknYqkayR0ffjCMBa9F9k4JYNACtg++WyA12W0tSHNl9Pp7iY+h2IZl7i9lpuBas1HySc674d23PNeyd34tKmxOh6LqaDIZEx1MNfYw5cYI7NugAYjEp7YVn4Zim55LWSN5/bkAnLkQyxVWjD1fK/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0UI5+v3R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0UI5+v3R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=AJ2bO5DndZrmPq3Dd1zge+YVJmxcGzOjpW+1dV9o8hU=; b=0UI5+v3RaoEG0RwA7cWThgCcBh
	esLhJcrhMRUggkzC3n/4WDY0UPLEB3eIPfNGc5SfzVyCRwnouge7req2d+k03fvIdw33zXtgsi5N4
	SZGC0hXnZr/F5F7mVsOi7dpCqpk+Mq9cOndOQxcfPMFQ4ASMLkvPk1XrXCqxdTVSraaJ9eTxWDEWs
	EKoQDODwTqxpDQD+A+1HdUu6hSb8QnA+pWAlYPN2+tlhTtdm2dQrPOCI335+Xq60VKFT0y1pGHBZC
	pJh9NMBWck+arfFAIvRkghaw/C0wKXw5g2H2GBmr5DGLBJexBghbC6ZrNWRZOQYDcbqnNl3e2Qlz2
	OUPaQu3g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmBb-00000000wEZ-31In;
	Wed, 21 Feb 2024 12:58:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] xen-blkfront: rely on the default discard granularity
Date: Wed, 21 Feb 2024 13:58:43 +0100
Message-Id: <20240221125845.3610668-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221125845.3610668-1-hch@lst.de>
References: <20240221125845.3610668-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The block layer now sets the discard granularity to the physical
block size default.  Take advantage of that in xen-blkfront and only
set the discard granularity if explicitly specified.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index f78167cd5a6333..1258f24b285500 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -951,8 +951,8 @@ static void blkif_set_queue_limits(struct blkfront_info *info)
 
 	if (info->feature_discard) {
 		blk_queue_max_discard_sectors(rq, UINT_MAX);
-		rq->limits.discard_granularity = info->discard_granularity ?:
-						 info->physical_sector_size;
+		if (info->discard_granularity)
+			rq->limits.discard_granularity = info->discard_granularity;
 		rq->limits.discard_alignment = info->discard_alignment;
 		if (info->feature_secdiscard)
 			blk_queue_max_secure_erase_sectors(rq, UINT_MAX);
-- 
2.39.2

