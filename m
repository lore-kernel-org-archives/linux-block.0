Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AF199FD0
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706002; cv=none; b=TshEDUcUbK239lQfuCWVNUL1xoLhSwZaVIFsn9R5CG3Df1n0kB3EcA9iqDPN/1G2QWEkdwZmZfjG0+eqln9wFI+hHp5I9gz//95a98OoQEICsqLfw8mBsTkb8pJ3DhAJuRQW3lphF1XUdXNg7/Y6smZfgnKIUphp6VsSiVxjAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706002; c=relaxed/simple;
	bh=R2JxHeAUFojJ8YyQbXdkc13os2BGlCBKZUa14UbgnYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH3GRpmmQAkB/R6dQ4/LD+3a71lDp182PLP/hw+raJYijNq21X76k9LnpH2anLdTe5CEwLUA/FIZ7DIeUgqN8xGbxRNPKyKFvYRrF1wZGJVi4CWhuizj0gcwdGXjKRvN9aqGt1+3yxbQ5su87MTweMZQVbznLDQxRFY8Ozww7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bgbXiFp7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bgbXiFp7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WIxHjrsRyYFb90dnMv5N8SVx6Sm7Q8kike9mtWebYqU=; b=bgbXiFp71uIWvEZNLiS/c1MWEX
	lUZXziN6uiXYadCNJW1ICRb4EgZC6nozy/t28QtMfQolewEroA1ezRszINA2V/QMoRvsmn2ylnW5I
	y4x7Y3/5CoHET5tbqx345iOsxiDLML4O44Csiv7HHDZMsgO1giPdaqPK6LLFAX9h9e6MZvFAhsI9x
	ZPrFf80vHvZKuoLMPsKvz2cJ/ugKwtjUaYYaY9e9bcvCwHHCH2uktCjwZABWFImdaB/TE6TshW82l
	aKcKRhpTjz5lcp3sbbAZik6UTYq/eRZhxMt9IYWZiXYDEhMQsWIvFneIPK8j9zOZgURBT5Xm1RH1c
	QBnOQsvg==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7rgu-0000000Cs9X-1YKA;
	Mon, 04 Nov 2024 07:40:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove the max_zone_append_sectors check in blk_revalidate_disk_zones
Date: Mon,  4 Nov 2024 08:39:31 +0100
Message-ID: <20241104073955.112324-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104073955.112324-1-hch@lst.de>
References: <20241104073955.112324-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

With the lock layer zone append emulation, we are now always setting a
max_zone_append_sectors value for zoned devices and this check can't
ever trigger.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index af19296fa50d..a287577d1ad6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1774,12 +1774,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		return -ENODEV;
 	}
 
-	if (!queue_max_zone_append_sectors(q)) {
-		pr_warn("%s: Invalid 0 maximum zone append limit\n",
-			disk->disk_name);
-		return -ENODEV;
-	}
-
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
-- 
2.45.2

