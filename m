Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D106931B
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519817; cv=none; b=jmwXV+p9vqVWK5q77C70w4I+WB2mIyIC/evvsCJ8mXdGtLGcxZj41ScKqs/tK3pFEVHIZIS9I1YHAVHpxOXvfapTRHDZH1dIeUGYjJ/u5gOC3TlIC+S234qI+qDxDZxq8c/DAqfmw9EWsF9zPhl3+oje+LDK/phEBLv23c1MHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519817; c=relaxed/simple;
	bh=+mw43wvP18h4tQDqso9DGo2IcTbsB8Y9cat8OOURM0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GutsYHXEDzc0fLKLkTiAgo06JZJfibYZCxs6tj/U4OzcJCnxubi3YQ43uz3AHtybQ+OUiLEcoC7CXvT30ia7QxftAmfH6sQnEx/qnaNun40SvnEXxx3wV158IVDzNcsgG+NDpBMemXuv9QiY7RZWQ7o7QsyMhML6R4vgXkOAfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E3YKM6e5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E3YKM6e5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=v9zTfqNUYDSEMWIrBKMHTVCSs9YzUjp/nmn73LOv/zE=; b=E3YKM6e5evcCDNm5DpwGUekVJE
	Ez1IXHSz1iBHvwInn9jJ6by6W7sjZaVLkqeOLbecw9Nfe/pctc2bT9Cd7+2wtEKFMdahG8jJp2jCV
	pFokvHGmJ5KF0//lrOqHP4qBE5JBVm9PfTQP23gp59EUo7+pzwWQJZZrXC9LR5Swiwj7OET+6nzQX
	et3s7ZJiGu64bPn/o3uPyFxLFGpPhqdGaYfXP+peaE3geYYki7VVCXJfMYM90v7tP+HMN0f61HtPu
	ciI4L28vm7vtpR3xd2GVqKkbj/Ie+XMrAv1PSA1qml7PiXL2K3NMq2RQqAivFSmHwNXnL+HLM7AYP
	S40VtdDQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcm3B-00000000u75-0yba;
	Wed, 21 Feb 2024 12:50:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] block: fix virt_boundary handling in blk_validate_limits
Date: Wed, 21 Feb 2024 13:50:10 +0100
Message-Id: <20240221125010.3609444-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Don't set the default max_segment_size value when a virt_boundary is
used.

Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 block/blk-settings.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c4406aacc0efc6..2120b6f9fef8ea 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -182,16 +182,6 @@ static int blk_validate_limits(struct queue_limits *lim)
 	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
 		return -EINVAL;
 
-	/*
-	 * The maximum segment size has an odd historic 64k default that
-	 * drivers probably should override.  Just like the I/O size we
-	 * require drivers to at least handle a full page per segment.
-	 */
-	if (!lim->max_segment_size)
-		lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
-		return -EINVAL;
-
 	/*
 	 * Devices that require a virtual boundary do not support scatter/gather
 	 * I/O natively, but instead require a descriptor list entry for each
@@ -203,6 +193,16 @@ static int blk_validate_limits(struct queue_limits *lim)
 				 lim->max_segment_size != UINT_MAX))
 			return -EINVAL;
 		lim->max_segment_size = UINT_MAX;
+	} else {
+		/*
+		 * The maximum segment size has an odd historic 64k default that
+		 * drivers probably should override.  Just like the I/O size we
+		 * require drivers to at least handle a full page per segment.
+		 */
+		if (!lim->max_segment_size)
+			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+			return -EINVAL;
 	}
 
 	/*
-- 
2.39.2

