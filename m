Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867965D759
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418975; cv=none; b=N567YEnpLEAlZdXsuTyuRnhtMcPceUiGja2zh+0Q5jL0y0g4yaMZwcioYkNbUpFIYawyg3ag54i/DsWaIMncZiOpeaVR4DjiWuYPms9mqP4xP15JHGkGRSdu1jN+S5fWLvLlam66FPtPg+JSvXDiriJJWdH3u6bW/9hhWpXosco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418975; c=relaxed/simple;
	bh=lscqWJ4rwKbM7MIaAjdAJiORm7nfNfPsXu/xGMsW0r0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xa5PYOa87Irj94gsiE/vHhK4eeO0efuzD/PpgwHRdlAuohxPmuFebvpdlaUTUVwYqgfwYAsSarbLFfS2GfBtIVHUIeu4Upy+m8reE945XtnU+OSfPhthSUYPYM7X48fj1AK1WGZsfpcq1crHwhX04ZM2CvIYvKvEz/OMPaDpqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iO3gbqYx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iO3gbqYx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-Type:Content-ID:Content-Description;
	bh=XB8sWvj2sJzz3ZYwbZ8ds+HCirTtw0TSEkRcDSm3wbM=; b=iO3gbqYxXIpxTuUV2zaHjet/E4
	qbRGnvwyzQ2MW6HWb7TOiCVxrGrniN76RG6Cl55RBk38TaWUCAYMDpI/oeiP1WafJ0NibOt9drWiS
	7ZdgZcXtPdA2Nv5UfZZ82AaCGhzZMs5bT+DrnYzh2t8nPzlZx3RNZgEHD4Skvr16yHW60kTGQvrUm
	rdViw5WORq44kHbU2jAlPEjFqyPhJn4KkyylSRCTXiAnGT7FuAYLnmIAiCZ2W/eQs4RDeXNPb1xNh
	WpCctydJ0Fd8j/ehtsJjIwS0eu0OEcf0MxtmI5pe7nswvRbBJzctzU98Tn9aRR3/NZNrYZiVnOFM+
	IJF+6Vqg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLoi-0000000DnTu-1kAA;
	Tue, 20 Feb 2024 08:49:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] xen-blkfront: set max_discard/secure erase limits to UINT_MAX
Date: Tue, 20 Feb 2024 09:49:32 +0100
Message-Id: <20240220084935.3282351-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220084935.3282351-1-hch@lst.de>
References: <20240220084935.3282351-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently xen-blkfront set the max discard limit to the capacity of
the device, which is suboptimal when the capacity changes.  Just set
it to UINT_MAX, which has the same effect except and is simpler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 4cc2884e748463..f78167cd5a6333 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -944,20 +944,18 @@ static const struct blk_mq_ops blkfront_mq_ops = {
 static void blkif_set_queue_limits(struct blkfront_info *info)
 {
 	struct request_queue *rq = info->rq;
-	struct gendisk *gd = info->gd;
 	unsigned int segments = info->max_indirect_segments ? :
 				BLKIF_MAX_SEGMENTS_PER_REQUEST;
 
 	blk_queue_flag_set(QUEUE_FLAG_VIRT, rq);
 
 	if (info->feature_discard) {
-		blk_queue_max_discard_sectors(rq, get_capacity(gd));
+		blk_queue_max_discard_sectors(rq, UINT_MAX);
 		rq->limits.discard_granularity = info->discard_granularity ?:
 						 info->physical_sector_size;
 		rq->limits.discard_alignment = info->discard_alignment;
 		if (info->feature_secdiscard)
-			blk_queue_max_secure_erase_sectors(rq,
-							   get_capacity(gd));
+			blk_queue_max_secure_erase_sectors(rq, UINT_MAX);
 	}
 
 	/* Hard sector size and max sectors impersonate the equiv. hardware. */
-- 
2.39.2

