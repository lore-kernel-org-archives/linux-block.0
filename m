Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FF882E;
	Mon, 12 Feb 2024 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720388; cv=none; b=XST1gEAxryUSP/AlK8JFFeyoeuTHXJJWyPHhUAwisz0/Kw0bFu/1khuG7yMYHdYE3dpONPY35eugZtTGDtlgvD6EgYvH0DrTyvEW6Z4IOACSpTPgR4AWglm/6fyOBQ+V+hjl/K5WWYg7eNJq0ohpmP6WklaOtAO6K6w4RYzXp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720388; c=relaxed/simple;
	bh=eO2PLTqZJFLMgRmRGZ2al0YjEjClo+ry2KNvmaSM1Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlHTOfBY+H0arcZEpgWBlkDlRl8iFSdCojwXOpwf72dAzF4LzX2QcGoy0YZoXGKsPb7uBYvsI0xcsQRq5CRUSOKf5eSUvRIqQzulPGkVH2Wlv0c/1PXmX+Rp8VPNAgDDwcZrA6DWZBxRJQY5rrjXt3ZSOndRiFEZukwOPkaGio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Et26V4ar; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Et26V4ar"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FdBZZfIe4Gg0+XVL+ZZDzEMtykzHbZrexnu46bVVgBY=; b=Et26V4ar0/4t3FTXGbyyW16wfH
	NRjtUB8W+Gf3VNmigQTdiYoTWVEOM/+r2Rs7sRu9Rrl3eUuduHSgIbRtLAGQokitzRyeG2W1eJ6RE
	EPJcelSptFRwH00Y/MIKcm7KsDsnpvs0jCt6vBy3URcACkMjmJw155/0IDERRCdyvSuIh6hIWTrxe
	/0EwyP46AxWSpBySh3Hl3hvpJFnx8mq3kjAx5fFX6uBKIMES5zH9B4CMRE4iNBx4zRIglo/4mQFSF
	CKNhLo/3fKNuWhwa1R13EtvVUb9R+AuCB8kYRt5SOh0xbROvb7csBq83vl5tOS0DdaenLj1ViZ/nE
	P2aGcq7g==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ59-00000004PZd-37UC;
	Mon, 12 Feb 2024 06:46:24 +0000
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/15] block: refactor disk_update_readahead
Date: Mon, 12 Feb 2024 07:45:56 +0100
Message-Id: <20240212064609.1327143-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

