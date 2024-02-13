Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96E18659;
	Tue, 13 Feb 2024 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809719; cv=none; b=BkvdsK+eUZRZaDkIeYbVvmKowICutUkLTY9IxJTBMUm+e3oBtPCFX/WHP3/M22MJSjECeSljA8GJe2iUQSl9kqKaOj9DjxIietAPUFzmmoA7z6O+pGfeedraFaXsGN3euU+HXlfWolZEXNtHce09v98n9G5uFgqRwaJRit2dTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809719; c=relaxed/simple;
	bh=ZUoW1qqmKF3UaGUqmdCznnMuVhR/JnCKqB1URws0QNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/xyTwPfuE3RdJJI1+qryN5EuT+SvuI/+QKLzApYGGeKWgY5cduZ26iyZC+RHNmvdVLwFyoVSFhWcKIbUEjVWvpa4qRZQXWTsDAw3kTY6Zv7SiykSCtXvNrg2h/mzYOHGBk9Exv5qwpW+cfPUqpxgt35LSvDzNMu64IphtwYE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aIcH0hxw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIcH0hxw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Mcl0LVNpiTKxwwXHqbQ/85KhR6H0ZWI4rYBvCbl1fLA=; b=aIcH0hxwFgBxASsEue6ldgqMo7
	dC1uE7le/5WbHde7pwoaxPh2xR9AIW/aSeb8qqLZ2Eegye4Y7QDx5j7Gkx58h5woq592HQq7B727v
	JiLD480ouC+mbDEPbGZJgB0uYigzbXRAiLdYmn2wQTjkxx0VAha/+0XOV0R1Qp7TJKMwYIoYDVqUi
	8iWK/3i7XIGr2csMLEt7EJiODSwM6I3BOQw04r4b3Gt+yQORX0aOL6FPaSo1R+REiYBOEY9eRYUzx
	YITLi3YBYQM9NYm65D4G8g72e/wecj6mmc2Xikf/+k4QlXzhQq4sBhwnDIwCT4zhIviQmtsLVbnO7
	TOATmcDw==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnJv-00000008GMA-1Jka;
	Tue, 13 Feb 2024 07:35:12 +0000
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
Subject: [PATCH 06/15] block: add a max_user_discard_sectors queue limit
Date: Tue, 13 Feb 2024 08:34:16 +0100
Message-Id: <20240213073425.1621680-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-settings.c   | 18 +++++++++++++++---
 block/blk-sysfs.c      | 17 ++++++++---------
 include/linux/blkdev.h |  1 +
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 786b369ca59995..c4406aacc0efc6 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -51,6 +51,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_user_discard_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -162,7 +163,9 @@ static int blk_validate_limits(struct queue_limits *lim)
 	if (!lim->max_segments)
 		lim->max_segments = BLK_MAX_SEGMENTS;
 
-	lim->max_discard_sectors = lim->max_hw_discard_sectors;
+	lim->max_discard_sectors =
+		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
+
 	if (!lim->max_discard_segments)
 		lim->max_discard_segments = 1;
 
@@ -228,6 +231,12 @@ static int blk_validate_limits(struct queue_limits *lim)
  */
 int blk_set_default_limits(struct queue_limits *lim)
 {
+	/*
+	 * Most defaults are set by capping the bounds in blk_validate_limits,
+	 * but max_user_discard_sectors is special and needs an explicit
+	 * initialization to the max value here.
+	 */
+	lim->max_user_discard_sectors = UINT_MAX;
 	return blk_validate_limits(lim);
 }
 
@@ -349,8 +358,11 @@ EXPORT_SYMBOL(blk_queue_chunk_sectors);
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
index 26607f9825cb05..a1ec27f0ba4150 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -174,23 +174,22 @@ static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
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
+	q->limits.max_discard_sectors = min(q->limits.max_hw_discard_sectors,
+					    q->limits.max_user_discard_sectors);
 	return ret;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d41d7fe934578f..45746ba73670e8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -291,6 +291,7 @@ struct queue_limits {
 	unsigned int		io_opt;
 	unsigned int		max_discard_sectors;
 	unsigned int		max_hw_discard_sectors;
+	unsigned int		max_user_discard_sectors;
 	unsigned int		max_secure_erase_sectors;
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		max_zone_append_sectors;
-- 
2.39.2

