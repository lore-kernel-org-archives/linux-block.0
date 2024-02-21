Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42969972
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520336; cv=none; b=plcTXbax8Fm7+xpdkEukK79MJscwRYFOeW03KDXs44NWQKgOAQaaLLJ7SkWx5+IHlwZPpfZ5v/7RfxfAedchvxB0ErPhHZQN3I633LqGLf4AAgetZ6jJgxkj9bAwrrH6mZq5vzaJddXA4CBhWEZqOsVe35yk8sCq4nO1gz9S9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520336; c=relaxed/simple;
	bh=GFpqp3zsPm30llTz+sVmdcIdO7fW1GrfFQM+O91McsU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbwIjQJzD1LX6V49zhRFmuOWoCUhopf9hyiCaR4B1AYPZdK+JedgaZYtFNsM/TMkCCDEHV/Sa3DFkI9efqKw1TM64b7R8g55qJMc68rbGlnfUzK7dSEvQ6Oxx1dJd9s+PllUWu1n2RqDwU7rwXQKlFizAEvXhKtvRsTSTKm3hYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dkELOht3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkELOht3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=YF5q7+3VG37xUS7LPqZfsPI94l1e0iY4W/WI3XMTmts=; b=dkELOht3p/0mBMKM01rj7u26/q
	qcbpOHS8c81tO6wKhp3hfJBcoa9XaxFluK9tPHejblLd+YoNybr/5oUbaCH6Rz6uiXfPWnQRhCaCI
	8JvnTbk3uqKcRVo8gGzY4kSYXPC2O9d1ni5VzzUVcyzyvc8B6Z7xGk5dPY1+W6x7wI+hTqhgT6106
	3fsxLlpNBthXWs28REaKn48G5qJyHe2DJluaZaYrWr1D7R3zkPF91U0ZlZoCG2dBNgE3U6bNPOHfB
	q7LUzpc1YJEJS+PLzs6CgoNCN9j/YbATIzIf7LVo1thF4XI+Uwjv1CP8TJge/Xr1yokbgtT25ftf8
	hqSdMJ2g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmBY-00000000wCC-3HMp;
	Wed, 21 Feb 2024 12:58:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] xen-blkfront: set max_discard/secure erase limits to UINT_MAX
Date: Wed, 21 Feb 2024 13:58:42 +0100
Message-Id: <20240221125845.3610668-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221125845.3610668-1-hch@lst.de>
References: <20240221125845.3610668-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently xen-blkfront set the max discard limit to the capacity of
the device, which is suboptimal when the capacity changes.  Just set
it to UINT_MAX, which has the same effect and is simpler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
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

