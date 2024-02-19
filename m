Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9FF1CD38
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324190; cv=none; b=XoIyNhjM2Ej4rUcG5fucahwsFzjODC3angwNVhYOMr9t2Zdhe7uNQpJtI3rXHJIkpQKuw5dD/t4rZWoftwRdA6E7kAnOgJGf+nOIogJXqVqC2oFTPaF5tBq6+fai637tjbPQbpjnpkW51htC4z1sh556iOR5hNnTv+jhT3fsSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324190; c=relaxed/simple;
	bh=xvZKAksMigMqWvsV+H2KFs6WFAZSW4/I0ytEUs5Zm5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTn/H4CrKEJaxMZfi3CRvNRVEVolKWpwMB/pFtMfoO55/zHgNElJegMdTEmwkg2owjE+aQ8pkLrawFfZrDZ/C5gTK+TRXgxgmpFSm86CXvMyk6ilacPh5WEfTtD/Vqh8VlP3fVdywLxROSHhF2GlYIfMA/hlNuTNGVRxZ/xL0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qmyICita; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qmyICita"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CYDxGPxPSSU9sL6oYUiEj7u7bboSIS/e4xaTFOXdinA=; b=qmyICitaJQorIGs9a1m2C/MJfN
	yd1clQtghkuO1NZ+mzrW02KiON1+6EVOiydSMTlbGQXLeBgK4AVlaPtXp/0rM0D1bNE+mn0uXK8Q2
	QnpIe0L4Om8eb+yFpqy2oPvqdHpWXNT53oM9np+g8lhHBAvAgVVFVSqLrdfMoDMT1TKEjIYRps9Mq
	/bTcG9V/At51kQLec+ASfINg8zRI1fE3Ccw2kWbYW2gckPBwQqSPxayuYzYOVpPh8cbmPqABh3jC5
	gSZkMviddtzwXjwnrjl/KA8fyMOgP1ve+Ok2JO36cCxB3Fh7WklI3yS247cKkflX0lD5PvG63Of8O
	NLSVzEZg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbx9w-00000009FcG-3ahl;
	Mon, 19 Feb 2024 06:29:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/5] null_blk: initialize the tag_set timeout in null_init_tag_set
Date: Mon, 19 Feb 2024 07:29:46 +0100
Message-Id: <20240219062949.3031759-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219062949.3031759-1-hch@lst.de>
References: <20240219062949.3031759-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise it will be reset to the always same value when initializing a
device using the shared tag_set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6836327eefb42..89e63d1c610362 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1797,6 +1797,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->nr_hw_queues = hw_queues;
 	set->queue_depth = queue_depth;
 	set->numa_node = numa_node;
+	set->timeout = 5 * HZ;
 	if (poll_queues) {
 		set->nr_hw_queues += poll_queues;
 		set->nr_maps = 3;
@@ -1921,7 +1922,6 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_cleanup_queues;
 
-	nullb->tag_set->timeout = 5 * HZ;
 	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
 	if (IS_ERR(nullb->disk)) {
 		rv = PTR_ERR(nullb->disk);
-- 
2.39.2

