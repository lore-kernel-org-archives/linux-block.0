Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA47B3CB;
	Wed, 31 Jan 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706304; cv=none; b=ITxdF9ARqMoIi3AA1KdzgO1wPsnkq+jXCP9n6lmHtWurVRZLHEB2OERcHnHuynxs5CrwU0XUyv0dmVrC5QWbEKX+PDvBCcNeSqGjSZB1vJ92XPPYkvmx7GeDpxiRcoRn8PmJeE931AX72E5IlE4cu9n+3dYkFVKn+SbqW6A8jRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706304; c=relaxed/simple;
	bh=90MAXVsU8DQ5/M8oaifdXchTuoBp/LMtV7PkBl3c3Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rs9SMhCoYexZB2TfeylObSTDXIni48L4oevGZtce7NZWj7fN6iu16gIsUhVqcoyaOe3/NVUy94pNUR5CKhjiRjOn/s82kkOu95RTWetRQAsuxYk86kY1IV/osHXPcwBjA9GVL84gneCeWHyTPjqe35slPcipoJ+GtOSOY0Cqz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rMiY+rFa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMiY+rFa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4QAQ97DCZjYDip+hpd7eamuJUudqymA8R+j6qvEpqqY=; b=rMiY+rFaUbr/mKljzGWjOtTtkg
	LCXGqq74mkL6lbwH3D6Ds26m1j+SIvTCsgEOs51iu9xt2jk3eMsxxHZu2vHxie26ByMFo5SX3hMPH
	5nUs41PnCJxY3Z3FHlb6FLvE7UDZBzmbwo/1tvMvBh9QhifjD+X1j/JAvC7JPNPDafc4CB/2t1KWt
	WY0iyReQgBpFymaAvqZkCHB2QDix8ZycqYzfB3Zl6wQvn7vjUuR3i5M+tBeQnALt3oxUVWR6R62ZC
	WYpujIvaXL9nvb/WnavlCTpuXuuN/8qxgtrrDH3tE4AoBBe6x2KsQrp0utf+q1BegshwcIlcaFVFA
	BqF0tCCw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAGu-00000003VgV-2CEI;
	Wed, 31 Jan 2024 13:04:57 +0000
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
Subject: [PATCH 14/14] loop: use the atomic queue limits update API
Date: Wed, 31 Jan 2024 14:04:00 +0100
Message-Id: <20240131130400.625836-15-hch@lst.de>
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

Pass the default limits to blk_mq_alloc_disk and then use the
queue_limits_{start,commit}_update API to change the limits in an
atomic way on existing loop gendisks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/loop.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 26c8ea79086798..28a95fd366fea5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -750,11 +750,11 @@ static void loop_sysfs_exit(struct loop_device *lo)
 				   &loop_attribute_group);
 }
 
-static void loop_config_discard(struct loop_device *lo)
+static void loop_config_discard(struct loop_device *lo,
+		struct queue_limits *lim)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
-	struct request_queue *q = lo->lo_queue;
 	u32 granularity = 0, max_discard_sectors = 0;
 	struct kstatfs sbuf;
 
@@ -781,12 +781,12 @@ static void loop_config_discard(struct loop_device *lo)
 		granularity = sbuf.f_bsize;
 	}
 
-	blk_queue_max_discard_sectors(q, max_discard_sectors);
-	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->max_write_zeroes_sectors = max_discard_sectors;
 	if (max_discard_sectors)
-		q->limits.discard_granularity = granularity;
+		lim->discard_granularity = granularity;
 	else
-		q->limits.discard_granularity = 0;
+		lim->discard_granularity = 0;
 }
 
 struct loop_worker {
@@ -975,6 +975,20 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
+static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize,
+		bool update_discard_settings)
+{
+	struct queue_limits lim;
+
+	lim = queue_limits_start_update(lo->lo_queue);
+	lim.logical_block_size = bsize;
+	lim.physical_block_size = bsize;
+	lim.io_min = bsize;
+	if (update_discard_settings)
+		loop_config_discard(lo, &lim);
+	return queue_limits_commit_update(lo->lo_queue, &lim);
+}
+
 static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 			  struct block_device *bdev,
 			  const struct loop_config *config)
@@ -1072,11 +1086,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	else
 		bsize = 512;
 
-	blk_queue_logical_block_size(lo->lo_queue, bsize);
-	blk_queue_physical_block_size(lo->lo_queue, bsize);
-	blk_queue_io_min(lo->lo_queue, bsize);
+	error = loop_reconfigure_limits(lo, bsize, true);
+	if (WARN_ON_ONCE(error))
+		goto out_unlock;
 
-	loop_config_discard(lo);
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
@@ -1143,9 +1156,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
-	blk_queue_logical_block_size(lo->lo_queue, 512);
-	blk_queue_physical_block_size(lo->lo_queue, 512);
-	blk_queue_io_min(lo->lo_queue, 512);
+	loop_reconfigure_limits(lo, 512, false);
 	invalidate_disk(lo->lo_disk);
 	loop_sysfs_exit(lo);
 	/* let user-space know about this change */
@@ -1477,9 +1488,7 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	invalidate_bdev(lo->lo_device);
 
 	blk_mq_freeze_queue(lo->lo_queue);
-	blk_queue_logical_block_size(lo->lo_queue, arg);
-	blk_queue_physical_block_size(lo->lo_queue, arg);
-	blk_queue_io_min(lo->lo_queue, arg);
+	err = loop_reconfigure_limits(lo, arg, false);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-- 
2.39.2

