Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF077F2C;
	Wed, 31 Jan 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706261; cv=none; b=QEguQ7jyEB4TOAQQvVBMXDuoczx4n0zWdkGye68+5mFhpRZwQgaCFFOOT8ECj7NdT1Z/fCxDqn+TUWxZXsl/L/PlEfKoKucVpoX4GRzDvKHO98Vnz1AR0Cj0I8EV17llw7ZLpcOYhEepciLqn3OKYxqlepng18RH6SVtMBnNfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706261; c=relaxed/simple;
	bh=HWmRzX+MS2ao2YLzjFNMmWBJOxmtor3o2sM3jKtZFUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cg2cZ/9XK/wV2tAJaxh4nM3K8jCuHGq54oXzN2jdhFUougV0LepK+WA0sy/IqKpRRF8V3Ua+qmPXDkAfllE3j1/wZ2pD4Jwb3va97QwFy5RIGmWMJ9BOBqRVJuzIvdQQd5lzqjQaEEQe7XoHy6C7aB/iAjrw3P9b3wnrNjENTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=klzjcug2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="klzjcug2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Vy2dtmCCFHWeGg2pgvyCIiNfo0aIeUt8gxcpNzBja74=; b=klzjcug2JniM+jCovxmj0Vfd2Q
	tmHAtUHkHfFNzMZjjKJ0erv8UsB0FaA1eOKqHiyn3VlUUxYEVvZUSb6bEGO+7o5j9sOzXd6PlAtsp
	5rbxtLKgUd3HAkueJLWzZQnI+6PSpu8lOoGT0urK6b+yIDQ4pJxkRbTWMR3VRtuIRAr99ENTw6JsI
	zxLR65fEN9/iAyNDV8d+WQacU3auUXB67IckQKBa7/VPLFnPu2cxmMtEH6TW7QEIVbiRS09AaxxM3
	Ygt1Mr+qOLo2SlQOBu/8cCAyZtROSrP8Kqkk0fN5Mf7Myi9lg9kvfSN0zRIxTZZU41OXUig7+tYGk
	6VhEKunQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAGC-00000003V3Y-2ojc;
	Wed, 31 Jan 2024 13:04:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/14] block: refactor disk_update_readahead
Date: Wed, 31 Jan 2024 14:03:48 +0100
Message-Id: <20240131130400.625836-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131130400.625836-1-hch@lst.de>
References: <20240131130400.625836-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Factor out a blk_apply_bdi_limits limits helper that can be used with
an explicit queue_limits argument, which will be useful later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-settings.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 06ea91e51b8b2e..f16d3fec6658e5 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -85,6 +85,17 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
+static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
+		struct queue_limits *lim)
+{
+	/*
+	 * For read-ahead of large files to be effective, we need to read ahead
+	 * at least twice the optimal I/O size.
+	 */
+	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
+	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
+}
+
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q: the request queue for the device
@@ -393,15 +404,7 @@ EXPORT_SYMBOL(blk_queue_alignment_offset);
 
 void disk_update_readahead(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
-
-	/*
-	 * For read-ahead of large files to be effective, we need to read ahead
-	 * at least twice the optimal I/O size.
-	 */
-	disk->bdi->ra_pages =
-		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
-	disk->bdi->io_pages = queue_max_sectors(q) >> (PAGE_SHIFT - 9);
+	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
 }
 EXPORT_SYMBOL_GPL(disk_update_readahead);
 
-- 
2.39.2

