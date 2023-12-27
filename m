Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2932C852
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CDgzcfKo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1emDS7V1lza113/w0hXx2Nd3dNmQOBpt+EiNB49VMmU=; b=CDgzcfKoDH55W218iLD9Q2TG4X
	OKPlHwxq7/R9Nln5+jClSGZ0wzDlTueH9Toh/bTOeYMT4KOEBiXzQYdRVUnV3jfhFFeTnCu8l+RFE
	8kjAGfnLkrK3BKHNyj4IsfREZerF5wiPS+JvYDDSg647h8pUpUtQ2MM1ykf9sbqDSXD5Id9ILeQbU
	cGasLupjKB2iq+cBZNHT6CZGoy2g9d+q3Mq6nAMTJr9wJ2krzcUgjNdKNOgakcLQzq8qFxeUC4h72
	44wo2ysmubll/zOCKTsiiOrG6bbpWNNoEbEpazhCWmHsRlh7lVUHAdDaMLaKgm8T427b+SKqKRzx/
	mTIfsfaA==;
Received: from 128.red-83-57-75.dynamicip.rima-tde.net ([83.57.75.128] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIQ8Q-00EI4k-2U;
	Wed, 27 Dec 2023 09:23:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] loop: don't abuse BLK_DEF_MAX_SECTORS
Date: Wed, 27 Dec 2023 09:23:04 +0000
Message-Id: <20231227092305.279567-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231227092305.279567-1-hch@lst.de>
References: <20231227092305.279567-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

BLK_DEF_MAX_SECTORS despite the confusing name is the default cap for
the max_sectors limits.  Don't use it to initialize max_hw_setors, which
is a hardware / driver capacility.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560e1..6106303fcc4677 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2038,7 +2038,8 @@ static int loop_add(int i)
 	}
 	lo->lo_queue = lo->lo_disk->queue;
 
-	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
+	/* random number picked from the history block max_sectors cap */
+	blk_queue_max_hw_sectors(lo->lo_queue, 2560u);
 
 	/*
 	 * By default, we do buffer IO, so it doesn't make sense to enable
-- 
2.39.2

