Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C92C852
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="djJrQQ/j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eMCnfUfwfjnx1cIujAEol9qEJieEAMerBUeT3X9hUNI=; b=djJrQQ/jiHkrHCd4PXqsrnHRHk
	fCDuoTS69KaDey1flB2+piHPQfGAA9k8dmE+9bG4emiCa1mSDP/+m2yRzgxqynIicz4ZTsuVSSoNn
	fZmeVAcyqPCaJ81PdJ8fLB7F+f0R4M6Z6W/AJNSQx/Y3LgpjUoHK9ecjPn0ZcjOpnUQWj+BW6J+oj
	jaEcN0MA3EuzG2kSvLXB2uUGywv7VrxnHi+HwlJJoao7FYMPqXYW1eys++RlWQlWF30fO7TTEVlTa
	oRnqgMB8GZiks/uF/wLatGpDXWvd5boZJMh4babRJMewacFNy+cxmlo8+e3eqNjknjiR2JTXH/8SP
	PACB/RRQ==;
Received: from 128.red-83-57-75.dynamicip.rima-tde.net ([83.57.75.128] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIQ8K-00EI49-2l;
	Wed, 27 Dec 2023 09:23:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] aoe: don't abuse BLK_DEF_MAX_SECTORS
Date: Wed, 27 Dec 2023 09:23:03 +0000
Message-Id: <20231227092305.279567-3-hch@lst.de>
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
 drivers/block/aoe/aoeblk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index cf6883756155a3..d2dbf8aaccb5b1 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -383,7 +383,8 @@ aoeblk_gdalloc(void *vp)
 	WARN_ON(d->flags & DEVFL_TKILL);
 	WARN_ON(d->gd);
 	WARN_ON(d->flags & DEVFL_UP);
-	blk_queue_max_hw_sectors(gd->queue, BLK_DEF_MAX_SECTORS);
+	/* random number picked from the history block max_sectors cap */
+	blk_queue_max_hw_sectors(gd->queue, 2560u);
 	blk_queue_io_opt(gd->queue, SZ_2M);
 	d->bufpool = mp;
 	d->blkq = gd->queue;
-- 
2.39.2

