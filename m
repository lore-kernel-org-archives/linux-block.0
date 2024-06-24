Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029FFC08
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250722; cv=none; b=bSuktwntFgJDt0O/qHj4JzgIuaLank0buJ9qJbzlCv9JCDDP4cogFItABsV/GQ1d7JmiFXw2PQnlfHqyYXXxa5Bb087eDWNx++dg9KrVOCH8UULMPOFtipE6bB3DZuWH3bkrMssIORKxFT+W5wNYOO6pPXCyveX1xtFG8nIhLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250722; c=relaxed/simple;
	bh=ja3lbskbMX69ee7DjkMeWdMY/LCV1xUVssCbyxegFpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSYYqvvwJblg9M6Xf1Buoiubt5iWWg7VfeNkW9ys25ebzGP8PJoBICY8Kd926lfRz2M4FLWLZ33O6daX4+L2wLeeSBcuX3gwvQSsJeyVEVWuAQZ+TmpXnhNqGmvSw1Di6O3xsdY8CUqkCfTn6e2KnMt4prgQLTr5c1uHx2GB7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VYzBkdql; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VYzBkdql"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=u0wvp8CT6W2pNaFyPogCYlgyFTqdlihrKBJUgaTY5nE=; b=VYzBkdqlh3mMmuZ5ysw5BruSaC
	gXyKIWyEB/7+oKB9yYTvbiEx2jSvQLd7H2Mwp1D6TqaijKGlCXNn7cR4EhBYAORJSzVAcOnH/esHZ
	pIm1xR99PVPFLPRmgddOb0wkPCmIJd3JZD1j0CTMmHmlUML1qS7EqNlShC4X+0LQAp61QZpTxcATb
	+W3d1AcO7FnjoP/g5jsCPaqGqADx1kkdntN5eWUpyQGRnUtGs7LxopI0T2Q9GcLjnFitgzLy5dNTm
	yuQOjWrF3TgDdHJfDCQWfhJhp6NmpM53KpZRZPi6+euBmbkBLWhSDj3rA9yOe2pfGv1oSZsacHfY1
	dUtssM7A==;
Received: from ip-185-104-138-44.ptr.icomera.net ([185.104.138.44] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLneI-000000007UC-3VH1;
	Mon, 24 Jun 2024 17:38:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: fix the blk_queue_nonrot polarity
Date: Mon, 24 Jun 2024 19:38:35 +0200
Message-ID: <20240624173835.76753-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Take care of the inverse polarity of the BLK_FEAT_ROTATIONAL flag
vs the old nonrot helper.

Fixes: bd4a633b6f7c ("block: move the nonrot flag to queue_limits")
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 69b108a98b84c1..4a56ebf28da6ed 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -617,7 +617,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_noxmerges(q)	\
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
-#define blk_queue_nonrot(q)	((q)->limits.features & BLK_FEAT_ROTATIONAL)
+#define blk_queue_nonrot(q)	(!((q)->limits.features & BLK_FEAT_ROTATIONAL))
 #define blk_queue_io_stat(q)	((q)->limits.features & BLK_FEAT_IO_STAT)
 #define blk_queue_zone_resetall(q)	\
 	((q)->limits.features & BLK_FEAT_ZONE_RESETALL)
-- 
2.43.0

