Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73011118E;
	Mon, 12 Feb 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720425; cv=none; b=nbplGhMkfFnMGCOVJ9VC2qs0sZ5Uu92/5BbP4EsPQET0teHI8daPJt+fA5jV9b0F9+rWBcHhuTV3U+onWOPq1IGUsyNOxpV11wzoYpDE9OJggluoPga5D3UBSL4IN5H4fo1w2uTYlzvyxqvNgUGJOeL5UEt+LRpl/SPzJjI145s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720425; c=relaxed/simple;
	bh=eCRgyNeo2QlLey7ig1/ZK35VjYuL0BTonWNbJio9510=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtobVT2cMICZeb7GHsdiplncjxGzZKncYdHx/edK4NiSYt7endEZInePPiWBixKPz/OUUd3gkG5Zk7r9oThsItlgVSrYHHOTQfNQiHG93fsNkFILNTAQkQflSMc3sLvrrMcjmSuTS9AfIL0ZgDjAzE3yHvbEYDcQQAm5bG2kAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lkl1QTB+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lkl1QTB+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7L7vdo9JmKQrRr+oi/wGFF1pvcQ4YeAjt0DgbHMcHqA=; b=Lkl1QTB+nGJrJfWYp3QJBA3DLN
	s+sua3LGyoc+KCeKBzLTEZ7nUkGAWayK1wpmYFgp9sDmZNvRj4v7F2UaXGGhrHukczIGCRIY/7keF
	ecmc1Xmbm09dxaGBuSQZDzHb6X/MbSEsLKt6klDGF846BMwslCcvm49v1zncErVnmlixhA2+jmp0m
	+9rMeXG7z0WMyli7R40uN/hbEXh1ePEMguGC52L4hwIi/SIQDa0ndSS6Jdg5vxFYS5QSCIvA/OyU7
	1U/BFr3lHX3p6P1HZEfsK/UDx8DPCFce+qBtt7H+9CP9d85L1E1RkOIbad2DesDTrXym6+4bigttq
	t42F24XQ==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5g-00000004Pyq-1qgU;
	Mon, 12 Feb 2024 06:46:57 +0000
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
Subject: [PATCH 13/15] loop: cleanup loop_config_discard
Date: Mon, 12 Feb 2024 07:46:07 +0100
Message-Id: <20240212064609.1327143-14-hch@lst.de>
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

Initialize the local variables for the discard max sectors and
granularity to zero as a sensible default, and then merge the
calls assigning them to the queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/loop.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3f855cc79c29f5..7abeb586942677 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -755,7 +755,8 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
-	u32 granularity, max_discard_sectors;
+	u32 granularity = 0, max_discard_sectors = 0;
+	struct kstatfs sbuf;
 
 	/*
 	 * If the backing device is a block device, mirror its zeroing
@@ -775,29 +776,17 @@ static void loop_config_discard(struct loop_device *lo)
 	 * We use punch hole to reclaim the free space used by the
 	 * image a.k.a. discard.
 	 */
-	} else if (!file->f_op->fallocate) {
-		max_discard_sectors = 0;
-		granularity = 0;
-
-	} else {
-		struct kstatfs sbuf;
-
+	} else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &sbuf)) {
 		max_discard_sectors = UINT_MAX >> 9;
-		if (!vfs_statfs(&file->f_path, &sbuf))
-			granularity = sbuf.f_bsize;
-		else
-			max_discard_sectors = 0;
+		granularity = sbuf.f_bsize;
 	}
 
-	if (max_discard_sectors) {
+	blk_queue_max_discard_sectors(q, max_discard_sectors);
+	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+	if (max_discard_sectors)
 		q->limits.discard_granularity = granularity;
-		blk_queue_max_discard_sectors(q, max_discard_sectors);
-		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
-	} else {
+	else
 		q->limits.discard_granularity = 0;
-		blk_queue_max_discard_sectors(q, 0);
-		blk_queue_max_write_zeroes_sectors(q, 0);
-	}
 }
 
 struct loop_worker {
-- 
2.39.2

