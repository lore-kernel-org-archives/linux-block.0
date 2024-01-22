Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53965915C;
	Mon, 22 Jan 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945029; cv=none; b=Idz6Y7DB7kL4bqyNIbE2RGu91/r2FRt0v9yw+QTBkv1mmzkz98GqBLfND7mIcNkkVjnOWEsi9XO8TNwzQruLsu+Qpk89TJ0qHaidp5hwCzHFGZC8kmwqDeH+ITND0HxhWprPOhqsX6C+lyFP345Msx36oxcb+DMeq+dpKBKjZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945029; c=relaxed/simple;
	bh=59kUl3PJxRJe3oAFzt5NuI7ENnXPO/9IdI6BailKrwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmTd7wi6Iabr7jkJhCX274/O50hw3kVO760QQTjD6rJ+3QHPkJRb7bHK3x6utmGOKOTabct/oMm2Da/TCQrKHesbYUbJlnVuxo9zb8PlRuqqoPKUfFQQ/m10XoMjcZWk2AJWKnUjI54U758GX4F5CMxQ+HRsmF+mbQe3ss4s2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k8VvyF5N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k8VvyF5N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TcYS7GPXBrbgGRHIvaRXUh3JjADs1zBmNnPO1Al9yIo=; b=k8VvyF5NNO2KbbOsiQg9aa9wwS
	jYMlHR17GRdiHLVKke3WYX5Rk8I4cw12uJ6c8EsxYsrsnymqFKscb0z3KftMYP1JYwnuzCaUxL16n
	69Thj21y+v9oc9qyKfyaqL5oVunHCsKUpX0+f/QaPMoS/+WUvv2djL8WOLI3xzf8fe1A7ps1s8EvU
	OCFcACaZHL+qOs+GV2BX1cX6oKFuE0mbmmGTPWSYWXY/8Nez/UpBV7nJ0vmque3WSDxQZ4n0h+Hyb
	1rfvyIWyp7ynpfvsYrIPjxy+ihrfDagKH7e1XeDn4an9ewgTeHoWJACibgvQSxBtlaOMpTRzooEj9
	VRnAWzQw==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEH-00DGhM-31;
	Mon, 22 Jan 2024 17:37:02 +0000
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
Subject: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Date: Mon, 22 Jan 2024 18:36:35 +0100
Message-Id: <20240122173645.1686078-6-hch@lst.de>
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

Add a new max_user_discard_sectors limit that mirrors max_user_sectors
and stores the value that the user manually set.  This now allows
updates of the max_hw_discard_sectors to not worry about the user
limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 13 ++++++++++---
 block/blk-sysfs.c      | 18 +++++++++---------
 include/linux/blkdev.h |  1 +
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b6692143ccf034..f58da0810a00f2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -47,6 +47,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_zone_append_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
+	lim->max_user_discard_sectors = 0;
 	lim->max_secure_erase_sectors = 0;
 	lim->discard_granularity = 512;
 	lim->discard_alignment = 0;
@@ -167,7 +168,10 @@ int blk_validate_limits(struct queue_limits *lim)
 	if (!lim->max_segments)
 		lim->max_segments = BLK_MAX_SEGMENTS;
 
-	lim->max_discard_sectors = lim->max_hw_discard_sectors;
+	lim->max_discard_sectors =
+		min_not_zero(lim->max_hw_discard_sectors,
+			lim->max_user_discard_sectors);
+
 	if (!lim->max_discard_segments)
 		lim->max_discard_segments = 1;
 
@@ -328,8 +332,11 @@ EXPORT_SYMBOL(blk_queue_chunk_sectors);
 void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors)
 {
-	q->limits.max_hw_discard_sectors = max_discard_sectors;
-	q->limits.max_discard_sectors = max_discard_sectors;
+	struct queue_limits *lim = &q->limits;
+
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->max_discard_sectors = min_not_zero(max_discard_sectors,
+			lim->max_user_discard_sectors);
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

