Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB34C63C
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbJIMTaz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=16a1QMLCSLeNkLrTYtgXf5Aexq2eFrQIG1M6WMeKF2c=; b=hbJIMTazqlhI08nE7RYCJC2dH+
	06/fHfK6xrHsrDfhzY/l8U+b2r8PCgHXq6aYugm92N+QxDdch1YHZGIInkl0EQoHPqmHupi3nAlWT
	5Zn6wtgakLyP3ouMmgVf45cIvWkdhygrzn+SNutzLzjHzLSL0yKi5lp7+0vbQ4lnq8/IM/6i+YenI
	2h/VfVBtfa/BgY8ILWxgA1C2VJC4rkd2OdMm6nMNwYuob6HAsVUU5QwC1f1EC5ogLA6EARYpQ0SSu
	mxD1kXWR4BFGmFaIbbNsEKtWafhUg9m6ennSG9xxzB4Ht9VYsa6sdQtxprYOfv9d1x0Kk7viopExo
	wyuJm20w==;
Received: from 213-147-167-40.nat.highway.webapn.at ([213.147.167.40] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI2b3-00BtJ4-2I;
	Tue, 26 Dec 2023 08:15:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: renumber QUEUE_FLAG_HW_WC
Date: Tue, 26 Dec 2023 08:15:24 +0000
Message-Id: <20231226081524.180289-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

For the QUEUE_FLAG_HW_WC to actually work, it needs to have a separate
number from QUEUE_FLAG_FUA, doh.

Fixes: ebed8639d51b ("block: don't allow enabling a cache on devices that don't support it")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc236e77d85e1c..ce1ab712552e3c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -521,7 +521,7 @@ struct request_queue {
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
-#define QUEUE_FLAG_HW_WC	18	/* Write back caching supported */
+#define QUEUE_FLAG_HW_WC	13	/* Write back caching supported */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
 #define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
 #define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
-- 
2.39.2

