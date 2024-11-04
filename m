Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE051779BD
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698945; cv=none; b=bQ2sw5gqjo7Ad5fWF8TSvnipHZzFMbaRVrZkwFEVFtg3Xkujzw80nxtqWjA48jYPk0w1s0dWZHfF6VMdPbYHES4IRFpxi4+O/6hbM5wZVK39WIymu4FgIG3zwQshF6cXk6TvJZp7NT8ey5dgXO0e4yondBRffZqdRUq5SQVmjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698945; c=relaxed/simple;
	bh=PBCP0b88xmLJjaCaqMQF1GYDxJycxuObNcyMLWGXUjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHRuI2Vh/0YUcqSn6xho/k2hlZPnR2nmr/lYrYTi1cwZvLBSjFdEDMx74t7SdXUmrCv0KY2Rrr442zuBc7zgRl+Nwn+3lfRMO0m3WeSiAvsqAEkrugfi+1n+EQ+ZnLGuGGrLulzYfHregQAYaf5qi9+ZWceSZQxBw0cCPle8PBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GjeJRynt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GjeJRynt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=q5WxpSV0COpMUs5rb9YhxAje/mfiA+IQ6jsRXp40OfQ=; b=GjeJRynt7INRXOkDUqFg94fpA3
	gDUHYc9fJ68/kw2bLDRq0a89xMVQPLcgIMPdf81Cq4EpzgwX8rbRL/A0d8lLBWQDIL8ScsXQP5b39
	cGHcw1pcicQL4OwevhN/BvfG4nIKH9M9ENnVe5BRrZ0OdDXZ1zCiKE2iKo2llv5JHhzcp7DTcsXz+
	bCfLdaYs+wRi9bj072FUZ7IrrAhBoehwm5cO4wQChulAUDWP4mOgZvjRT7DVC/PO6ygIBii00UvM9
	HIPHAFV1AJMZMEGFVqZSqQYshmLGZzauY/4NPgueOP4z4Rl0BfBtq7LLJ3qKopQEwtjWIZ1DHUZXo
	slViulyA==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7pr2-0000000ChO0-1cBo;
	Mon, 04 Nov 2024 05:42:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: update blk_stack_limits documentation
Date: Mon,  4 Nov 2024 06:42:18 +0100
Message-ID: <20241104054218.45596-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Listing every single features that needs to be pre-set by stacking
drivers does not scale.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 95fc39d09872..5ee3d6d1448d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -508,10 +508,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
 
 	/*
-	 * BLK_FEAT_NOWAIT and BLK_FEAT_POLL need to be supported both by the
-	 * stacking driver and all underlying devices.  The stacking driver sets
-	 * the flags before stacking the limits, and this will clear the flags
-	 * if any of the underlying devices does not support it.
+	 * Some feaures need to be supported both by the stacking driver and all
+	 * underlying devices.  The stacking driver sets these flags before
+	 * stacking the limits, and this will clear the flags if any of the
+	 * underlying devices does not support it.
 	 */
 	if (!(b->features & BLK_FEAT_NOWAIT))
 		t->features &= ~BLK_FEAT_NOWAIT;
-- 
2.45.2

