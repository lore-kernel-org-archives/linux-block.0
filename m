Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BA2137E;
	Tue, 13 Feb 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809780; cv=none; b=nNouZmHdvdOUbUkDsON3IzA53x5jgLW6wXg6YddDO5G2NwFtQD5pJfg6FV79Wa1x3ZrEwQSDUmkLRijv1I66N6t54JkerwhpRZKxJxlo9P4DgZkNukUkLliQTjII3jP9jJ2fiNYOb6vcXG5OEzjs75r2M+8VDiNSjebFb8bLKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809780; c=relaxed/simple;
	bh=xdkwlvQpTV/CV6uqbotx5NJMzhUp+gdubnT+BphgbMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwlVEgE7/I0hiftOlsrSANDmyu8IyCEJJMUPBypgoTo1UUeL8DNUa5Nzbp6FF0EjiPxKU9raSXTSNXtTAl9lbCEXdkTB+VXRdefxVJDbSujPSipF7LET5FyU98dpbhaf0eMi56cC2oADviGSn8OaJKunz33kfm9ol2bR5QWJaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJhIcNs9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJhIcNs9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pvR4YMlI58JJSNlUq2cwBYj9o0FsTZy6GKdNPIYVtlA=; b=NJhIcNs9uh7P36djKdd3Qtwq3S
	9F/Vsfs2qO15KkbEIp3rXyafOSF28Zez/WObpqmjmH2mMYG5kjT38tB0cOMwbxEvzo05gprR/tqr9
	Kdi3AYKoU8siU8fsVsqB+set9weM3J5wJ+rpf/1qjLxYm8HEx8ZQFoKZPT/62EIuoDmo8uVwVO48E
	wM59vz2pk9VLcB37aFbXjJH67T3m5762n6Bjnq7UGIvtCEG/QER/UZPw2rw2TxG6/FwINT3nZKXxm
	7p42jf5LjH/tkHrBOpeElUO6Lc+8x3VsVcyWPUGgkhjPrDqpk+2aCXc7ltn2EloihMl+zGtxTxNS0
	nzR2R+VQ==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnKu-00000008HD2-390A;
	Tue, 13 Feb 2024 07:36:14 +0000
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
Subject: [PATCH 15/15] loop: use the atomic queue limits update API
Date: Tue, 13 Feb 2024 08:34:25 +0100
Message-Id: <20240213073425.1621680-16-hch@lst.de>
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

Pass the default limits to blk_mq_alloc_disk and then use the
queue_limits_{start,commit}_update API to change the limits in an
atomic way on existing loop gendisks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

