Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855979DD0;
	Wed, 31 Jan 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706270; cv=none; b=A4EOwLXEBYkdfCVeAvFEf1KoTnKU4KQBmB4zabuj5E2QmNx3x8oGeH9yg3UIMhJiak86UlHRuTeFgcIk/VvIpLX0i1h9H+33O5qA5HqedH39BfayBAQXBh9uEzqBCc73FYlAryqr9zw7HDcNlxVqNwdq08SVaUEJBlN1qJFllyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706270; c=relaxed/simple;
	bh=c9fNlqQ7tOvbpzyVsMaQxh0IJYSSH9Drtqeu1uiIrtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgUdoX4szwgwhmwGioM3Y3PfGVPsflqw0xf+dkT/8G0yL5ypaEXptVnB62ELFdJKmkQ1f+tNiTSZJUgEFPh4JtWXmdhv4Looff0blsQEMBoC6VYvEeDIu6o5LElKDm+SLlj/7S76DpwAaiyhh1ulT8Wi8bFTz2h6Ei8TU9Ujhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gImixnwt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gImixnwt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JWR/Cni6aRqx+hqSnSPYRfx3wBcmjrsmufMb+Gi/s1E=; b=gImixnwtwqDZ7KorO7rND21tsF
	TYqr74SuQMoaWK0uc5j5I7J9F+4xrofvSYPjlOVzZhAS+4aj4TDJncU3+fLmquLlBVq+MgqQuXWZT
	GyEBDdk8c4IvoCpMuCzQjprOG3GZXbSQ7lKEYQ1S+ldFPoLyKR0v2jdptGzxXynMbpLWHAq9AHmjy
	eg+dFheVPU6ljj9Xolewwff4djkpnUs4EQR4ofHCMdZ9iSFuTTIks7LG69ArZSJ5KYGOCgwO/SIAL
	VSPP/xYSN5OBhb68G+KGak7473voPxGD6amllgIzqzDYNLoFQKdBxKrSvgpEWDF/cnNpjnAXlOENj
	lxKpkxGQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAGN-00000003V9w-06zo;
	Wed, 31 Jan 2024 13:04:23 +0000
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
Subject: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Date: Wed, 31 Jan 2024 14:03:51 +0100
Message-Id: <20240131130400.625836-6-hch@lst.de>
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

Add a new max_user_discard_sectors limit that mirrors max_user_sectors
and stores the value that the user manually set.  This now allows
updates of the max_hw_discard_sectors to not worry about the user
limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-settings.c   | 12 +++++++++---
 block/blk-sysfs.c      | 18 +++++++++---------
 include/linux/blkdev.h |  1 +
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0706367f6f014f..50d4a88b80161d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -47,6 +47,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_zone_append_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
+	lim->max_user_discard_sectors = UINT_MAX;
 	lim->max_secure_erase_sectors = 0;
 	lim->discard_granularity = 512;
 	lim->discard_alignment = 0;
@@ -193,7 +194,9 @@ int blk_validate_limits(struct queue_limits *lim)
 	if (!lim->max_segments)
 		lim->max_segments = BLK_MAX_SEGMENTS;
 
-	lim->max_discard_sectors = lim->max_hw_discard_sectors;
+	lim->max_discard_sectors =
+		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
+
 	if (!lim->max_discard_segments)
 		lim->max_discard_segments = 1;
 
@@ -370,8 +373,11 @@ EXPORT_SYMBOL(blk_queue_chunk_sectors);
 void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors)
 {
-	q->limits.max_hw_discard_sectors = max_discard_sectors;
-	q->limits.max_discard_sectors = max_discard_sectors;
+	struct queue_limits *lim = &q->limits;
+
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->max_discard_sectors =
+		min(max_discard_sectors, lim->max_user_discard_sectors);
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 26607f9825cb05..54e10604ddb1dd 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -174,23 +174,23 @@ static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
 static ssize_t queue_discard_max_store(struct request_queue *q,
 				       const char *page, size_t count)
 {
-	unsigned long max_discard;
-	ssize_t ret = queue_var_store(&max_discard, page, count);
+	unsigned long max_discard_bytes;
+	ssize_t ret;
 
+	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
 		return ret;
 
-	if (max_discard & (q->limits.discard_granularity - 1))
+	if (max_discard_bytes & (q->limits.discard_granularity - 1))
 		return -EINVAL;
 
-	max_discard >>= 9;
-	if (max_discard > UINT_MAX)
+	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	if (max_discard > q->limits.max_hw_discard_sectors)
-		max_discard = q->limits.max_hw_discard_sectors;
-
-	q->limits.max_discard_sectors = max_discard;
+	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+	q->limits.max_discard_sectors =
+		min_not_zero(q->limits.max_hw_discard_sectors,
+			     q->limits.max_user_discard_sectors);
 	return ret;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5b5d3b238de1e7..700ec5055b668d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -290,6 +290,7 @@ struct queue_limits {
 	unsigned int		io_opt;
 	unsigned int		max_discard_sectors;
 	unsigned int		max_hw_discard_sectors;
+	unsigned int		max_user_discard_sectors;
 	unsigned int		max_secure_erase_sectors;
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		max_zone_append_sectors;
-- 
2.39.2

