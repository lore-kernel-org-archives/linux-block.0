Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609E2C1B1;
	Sun, 28 Jan 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461110; cv=none; b=dtGQHlrlvq0h8kqrI+Ep0AjRD4eySjM9v5N++H02oTeusC1ypGYmMW1UXCryffMsM+XEVDkBYLHhDR3RCy/ZUrZ5pjOik112Pzw43/B5NKuQsP+KDlZ1zEpZzA5cblUceFTAX1nZ7C79D5QAvA1Hd3s7Znyq2ZUSJxnZLi7H1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461110; c=relaxed/simple;
	bh=/qGmjzN5Dd8Ds4J+IbedVX5nel5qninYwHvA3SXwpJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gz6VqFC+SFFX8AD6/om+jbp7550sQs1MVUtCp5sdV120vsQ21y7WIOzzfwjThSSUkhXXqnGRy6cxc6yOI32bxIlqQK7sXxl1tEzubsvE88eEdOYZyaNBSvaitC9i3bWfbKpUliV+CiRb5VWagWTDP6bwwllHWDuWi32gzTR6GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GPLqjsPz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GPLqjsPz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wQSsNqAvg4G5n0hIP3La9wu1nCKagVudXp5ifdAqA9o=; b=GPLqjsPzh/qMt+mRpyhppilkmX
	9gzZQQINdAqeJkR3SR41zeFLY8nGVNnpxHu+59apA0f0LLdlnnaxkhiJip3z2rZfwqgjhTcNexHAk
	vKAfcchxF7u3Hk6ElZETNyURYbuWFwCMboh9PtM5Fp86oL8/F+gF07xIU31xS45uS7PhSTSgBgdY3
	wttbvnPSymHnwccATtdKa38CigxSTXpMAtxJwz/UXrTvxojLR8Hj/PQ5STxoheo1SnzcALGTfLVeK
	CtFQt5vhIqMr5VVtJquL0dDU/lANCl7JgH6YSVVZ614YDEpYV5brg12FwLqn6j1jwQNGLB2Z6TLVv
	OXO7Ywuw==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8UB-0000000A1xh-0Rla;
	Sun, 28 Jan 2024 16:58:23 +0000
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
Date: Sun, 28 Jan 2024 17:58:01 +0100
Message-Id: <20240128165813.3213508-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128165813.3213508-1-hch@lst.de>
References: <20240128165813.3213508-1-hch@lst.de>
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
index 06ea91e51b8b2e..e872b0e168525e 100644
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
+	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
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

