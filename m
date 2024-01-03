Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE51804F
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y+8Mg6SA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JggMjqUL1KIiFUjYzlsbPsH62f465FDjSHTmnaJzh3o=; b=y+8Mg6SAv+rzeiUUOdCfw9VHVv
	5K+j5GjHYgwy51iGBD4TChZ40WSU5Ift5EHhy7RA3bSGgrzPo+/YKtBNe41Cs0K1uaC4ex0W+EGsx
	wYMRLKw36TifsF8h/gFQJ4/bV2Pf41+5xaaSW6VOKUhondhZw6uTaWL7c9LVqJRGyMxqUHilEzGZU
	tYeStO2fGF+Fzs7553e0AONEDq1PjZO6zF+BqE+8lxTXJOCyVyTGXS4ukbEE6PzI04FlWgpD5GTEN
	t749upKaqWhM8wxfFTD7qqUoMVBcARRKdfg2eINLrjCXGm6iFdQXlSvZwZJupMGvF2ppyf1f6Xm0Q
	xrFZK4Jw==;
Received: from 213-147-165-200.nat.highway.webapn.at ([213.147.165.200] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rKwQQ-00A3oN-1W;
	Wed, 03 Jan 2024 08:16:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] block: floor the discard granularity to the physical block size
Date: Wed,  3 Jan 2024 08:16:22 +0000
Message-Id: <20240103081622.508754-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Discarding less than a physical block doesn't make sense.  This fixes
the existing behavior for zram before the recent changes to default
the discard granularity to the logical block size, and is also a
generally useful sanity check.

Fixes: 3753039def5d ("zram: use the default discard granularity")
Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d993d20dab3c6d..06ea91e51b8b2e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -342,6 +342,9 @@ void blk_queue_physical_block_size(struct request_queue *q, unsigned int size)
 	if (q->limits.physical_block_size < q->limits.logical_block_size)
 		q->limits.physical_block_size = q->limits.logical_block_size;
 
+	if (q->limits.discard_granularity < q->limits.physical_block_size)
+		q->limits.discard_granularity = q->limits.physical_block_size;
+
 	if (q->limits.io_min < q->limits.physical_block_size)
 		q->limits.io_min = q->limits.physical_block_size;
 }
-- 
2.39.2

