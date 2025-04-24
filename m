Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072E1F2BB5
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483277; cv=none; b=qyZoyWemuj0W/ECn6BZ84v3VUIouOEi7ipMqPxVzAfDegoDVHUVZMKiu7LgQbC0XNrI6Rng8/tVNpuLcu4Yy+t5qtmQ9ldInL+ElegM5Up2iTQkeC+0peFIFgvVxWy7OoiajpYIrmc1mxsD6PoL/3gZixGGZOKNWR5vTqHIxe9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483277; c=relaxed/simple;
	bh=n36yaEG5Ro4mv98Z2qH5jINmH1R6umwVMUiSkiskgUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1Mro1FzXgu4u9Hi3+/+/nIJVZrodSajfPUknLtqMnA9X8wzWTyPW+aNKJ0Mr7ST0fRMcmiHGUG0XGePf/B3k8hvyUmZwx0yt1O3/7Qrq8/3/UdoHwWyaGL5TZBMt+SxEHiEpmDXBVw514uXYmATv75g70PsrjvjSkzkX3d/FCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uwhmjxuv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uwhmjxuv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xmxXBUBVlM1ZTpBsIaWVAWml6wigWmXpNQI86+EdB4k=; b=UwhmjxuvUTvgmUweYrqN08dGwP
	oeoCsX4+MpOK+V4I5369/c5yAdT4tUcMhsfT9f1pUMr/UVvVBq1ZdbZUSDmM0lo9/K4DM0D2NA5kj
	ZHe21Ea1wfP84ANehgJGMXQniaYyvnFXjuzCkyZfiGWOcFVRo92VShgUMGbuSWI7S2pIQs1ucnWot
	u066qGVa4PRR2j37hYFowopWLUsRq7yXGlcN6VfSuBAVZc45twRZ3YF2Sg7IFWDtpF/eN2E+68wVp
	KuQlx8ncNWdiY0q4u3Gb6JeB/S+Z9S/rBZvTGlfCRrEJ3jYNe49z1veJwqd1oEJMdWz+jTV5Zbjd8
	v8807pgQ==;
Received: from [213.208.157.40] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rw2-0000000DK8z-0Mpx;
	Thu, 24 Apr 2025 08:27:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: use writeback_iter
Date: Thu, 24 Apr 2025 10:27:52 +0200
Message-ID: <20250424082752.1967679-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use writeback_iter instead of the deprecated write_cache_pages wrapper
in blkdev_writepages.  This removes an indirect call per folio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index be9f1dbea9ce..f073ef6d3f27 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -451,12 +451,13 @@ static int blkdev_get_block(struct inode *inode, sector_t iblock,
 static int blkdev_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	struct folio *folio = NULL;
 	struct blk_plug plug;
 	int err;
 
 	blk_start_plug(&plug);
-	err = write_cache_pages(mapping, wbc, block_write_full_folio,
-			blkdev_get_block);
+	while ((folio = writeback_iter(mapping, wbc, folio, &err)))
+		err = block_write_full_folio(folio, wbc, blkdev_get_block);
 	blk_finish_plug(&plug);
 
 	return err;
-- 
2.47.2

