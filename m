Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF040BE0;
	Mon, 22 Jan 2024 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945025; cv=none; b=T0Wdr2oVUyIkam8Q13WlrzDfp9xOvI9XNxz+fBCHAzRmzEJ5re8S/EZuizBrZvN1qJdld2/SSjVqi8ZYPYo5on9bIBKPl1jowbbYPA+EcYKqjKEKQS8AgSCjJDhNUdMXwDxnzIlWuSXS8+rHjnMrVvu3iQrPi5sz/ExtRVbcAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945025; c=relaxed/simple;
	bh=RJs4YxX6kCRmyXptX+t3TFOYgiOOzkSa9jA+/UA/uYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trRExJA46P2ScDLRw40EEbhXFQxDT73lx5qfHN8QbDLhmgYkva4hGwmG6CefmbZdimiKv6zLT1GSgO8bnndkl6TrCSMjDHqjiUnHI+6Z/LD/Ow/P1+qv1n1QAYRuu0GGZO6fSY6oERgfbyoh0z5+VwL233d6SmOQjnnbRdYuelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LlxwvkJv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlxwvkJv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tZcEfv9gUZ3mQuTNTJl9xBP6PsfRKXrR/Gr+QyIS+/M=; b=LlxwvkJvfYMjp0IfDn8bgPKMyC
	WW6QYd5OeC6jtQP/GNqE/QTlkWG8qRBtRHL03LPNEpZGbiUdaQ1AFS00tsMXpqzJd/ZWQjoNJMMgL
	hxm6QRGy3K3IbtDGs7BleavviiIbQxaAK5tFPA1KMgVkt0k+qRyBN8vPb3353ScVn7LeHgFUJXizX
	KnNj7AJmX5JEe0M94BZ0I9QpqbE0vlPJtqapWRpr6VFWulAYEo7gNUtudtbxOpCuaOzwu2RndUARM
	e8ytR5AWVLNUnAkD5ofppTDJkAxlSwr7jLe+ZRYzgyxp1QIEXzmPHQMZkZtIL+aTVVXp/KeIlMKhF
	9w5fpkZQ==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyE9-00DGcQ-2v;
	Mon, 22 Jan 2024 17:36:54 +0000
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
	virtualization@lists.linux.dev
Subject: [PATCH 02/15] block: refactor disk_update_readahead
Date: Mon, 22 Jan 2024 18:36:32 +0100
Message-Id: <20240122173645.1686078-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122173645.1686078-1-hch@lst.de>
References: <20240122173645.1686078-1-hch@lst.de>
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

