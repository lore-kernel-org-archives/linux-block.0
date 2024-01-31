Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E07BAF1;
	Wed, 31 Jan 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706301; cv=none; b=sCCP6WtY5It8I/jwbcr7b4rvr5XXO9sXac5DRXz0D1utnGxUTQ0q/DAqQsmnJtgN448WVqjTCApNx3xlDcsVBenKaeuz5BgbKfwFZ9+ptz2FJ/ZkGmvggIO/vgLBAekblqyDnIBtKk673gtwql5Nl0o3g1COr0qUOoyNV22Gt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706301; c=relaxed/simple;
	bh=pacC1cn/AH9PVWOkaZAi+JoJacdLTHjt978zbzbqJe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZALQR51O00ylAl6Ggyp+Vj3HVsWd3oUj9Y5+sYE5ea6wzVFLrcKZ0nPq3injjLztjX1vXRaaLqULzajAXQz38utpWPfF13P7KAn67gvIWubADHBxchGcaYBQUr5lwkeK1W9EzF74eZDAGA/oBjMybLWVCS1oNV3j0LKMbSEs+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tnf44HR2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tnf44HR2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L873Lxa+31+KXE3rwv/O5G9PEYjkpCTeABnTliJ/uBU=; b=tnf44HR2GmFU6ZSbOhhFCqbyQ7
	7rQapB9L7J/K3qKBrneA43P8S5Xd6RWgxwjjiDHJvWjM+ksq2J3hbiYy4yh302Hlv5iw4bLP1i0u8
	zIT6kJEXaYnMT+rEIcHPstcaJ/HLYJBFVya2pBC9kD9BFHCvKwEZ5nEbR24pgAGKW38vYXcXJZsOs
	OOWOxB4IAMkPAKQJN5/gL0/mHv27+Obapr8r/5uT1Wx1WpbXSwM7aiFHom9gUZynQrSxtVYQA2G53
	lFlwmVqt3jy+zJ+IHDmQ3b119dvcuDl7MKPDAnimw4C6SF2GtlDN10W6Kw+Ilnosb887TgS8BaulC
	YTyTjWNQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAGq-00000003VcL-3QK3;
	Wed, 31 Jan 2024 13:04:53 +0000
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
Subject: [PATCH 13/14] loop: pass queue_limits to blk_mq_alloc_disk
Date: Wed, 31 Jan 2024 14:03:59 +0100
Message-Id: <20240131130400.625836-14-hch@lst.de>
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

Pass the max_hw_sector limit loop sets at initialization time directly to
blk_mq_alloc_disk instead of updating it right after the allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/loop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7abeb586942677..26c8ea79086798 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1971,6 +1971,12 @@ static const struct blk_mq_ops loop_mq_ops = {
 
 static int loop_add(int i)
 {
+	struct queue_limits lim = {
+		/*
+		 * Random number picked from the historic block max_sectors cap.
+		 */
+		.max_hw_sectors		= 2560u,
+	};
 	struct loop_device *lo;
 	struct gendisk *disk;
 	int err;
@@ -2014,16 +2020,13 @@ static int loop_add(int i)
 	if (err)
 		goto out_free_idr;
 
-	disk = lo->lo_disk = blk_mq_alloc_disk(&lo->tag_set, NULL, lo);
+	disk = lo->lo_disk = blk_mq_alloc_disk(&lo->tag_set, &lim, lo);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
 	}
 	lo->lo_queue = lo->lo_disk->queue;
 
-	/* random number picked from the history block max_sectors cap */
-	blk_queue_max_hw_sectors(lo->lo_queue, 2560u);
-
 	/*
 	 * By default, we do buffer IO, so it doesn't make sense to enable
 	 * merge because the I/O submitted to backing file is handled page by
-- 
2.39.2

