Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31256B91
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407185; cv=none; b=AWP07mt4K08uCEbrGEJOB0PTnvjPDMyxOuK0KqEhAcU+a/aBv6vbfc/PDgjKTzQJgLWVeaEneAGpF9zk4bLvmoHqPkqGzPRYUqwWXzXnbdxU1SiK39+l52rBNXne3eZzEVXnBYhrWWm42KxepSIfhZi+DIkf9wj7nVx08CUZ+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407185; c=relaxed/simple;
	bh=w7V/vx8Y4PxCxt3vX7pYBrBZ7sxT62N5It7as/6vRbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4zzCEoOgtyBszWo2uYH7QppIquN5WIwEkB21PolSupvbQIoIVrlPzzyBFtvvLvYTEh8ZCmH1qy8PwjhOYPv0W8nZxxDREcxsgAWa1PrbF4UEMeCR73/u1WZqMtnwebjGbz36DEZJcDTH9GkrdjM7By2WoU746GjQMQTzbAPsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y9IH0sGx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9IH0sGx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=whmr3pqpnuRDC9gxH+k8VUx4QEuDDCHp75ck4AyJaf8=; b=Y9IH0sGxwHuxeW58qtmHWKW713
	snyOF6VMspxzv1/FZztPsQDcFZutxePS0s2omDqf8kwF2C8aBylak9Zj+ZYV7DGYN/sSY0rdXfdo6
	WkmMzpSoLBOCdh2F//8t3hG2QRuWx6NPd7efhOhoyXbcmRm/IosdPHHi4r7+E7LFikrvxTzvAAzc9
	Z42KmRba9B2G4xOcBjFSQkb3SmD/voQ1uZhf/IHsqkzPePC12WDoanyMO1u/hp5LfP3NVj7husnOQ
	xoE6GpzYEQZ9FkMqi0Uojsyz8Kcd77IPujydOS28DD8+tyhDZZ0dYuBzDXkNoGFL8agz5z2AyHaFe
	NVjyDbSQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcIkY-0000000DDrQ-3sIO;
	Tue, 20 Feb 2024 05:33:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/5] null_blk: initialize the tag_set timeout in null_init_tag_set
Date: Tue, 20 Feb 2024 06:33:00 +0100
Message-Id: <20240220053303.3211004-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220053303.3211004-1-hch@lst.de>
References: <20240220053303.3211004-1-hch@lst.de>
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
Tested-by: Damien Le Moal <dlemoal@kernel.org>
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

