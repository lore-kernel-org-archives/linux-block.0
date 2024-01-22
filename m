Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0ED66B53;
	Mon, 22 Jan 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945055; cv=none; b=E9MLJSZiiEiVseqAds/V6suIi2X8D5iUEOPZ3MyfK8532eeQ4x8G/UJa2wvzNo+caqTpT6RVwieZpk40744g4055hnEgqUJGilY70fSJu11qgznFGd0njoN3zZ80/SrByM+sxZ/AIgEqAEdNMNk0E4fhBGW1fwI7P7Zcwta5ymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945055; c=relaxed/simple;
	bh=jCJ361lypUvneSKe0h62iFknbin8JQxXZJbY8uxaJmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPCdf7U/mfZdaRtwrQkVp/tA2J7/JUW/bYADsCAv+KaJzl9B1GIY9nuJLOLjWHVayMR4VdSE939/5jDxUGtui2apsmCKRxO2nkuPyjbQcn7UzAufbyeTFwCs8PeIxa4hRgkskz2HWBhfygoX987b77b3bKENIOyN4pU8s1+i82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uH/CLtIg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uH/CLtIg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J3QqLW6uzCJydrFlgvYGM4oYu1xKxHEklRD1Od4noxs=; b=uH/CLtIgJffOo0iX328H0R4TLa
	hgc0qo6p/T430euKjCSlRYcbIpdvQPztqvSKApCo2HH1iIBLlipcA315u0CYkdd6NaHxqO6SpYLV3
	816TGjhC3OzDBlMTUmnzKebgv4MMJQtY/wa1dYBwFz+QHOr5g2ZzZv3MtBW9YcTWFWnqTbjkk/TlK
	qZqvJ7VyqdF32clHZYnwuuBabrlonmlyQHyQ0K1pAVKRc86RoKLiD62AUPisLjcZln1wt33cKpS0U
	NpMb+lRPqRnIOriV8CA3xyvG4mbHx6v17n2t5lvw6MldKF+xhqi+8STrNoQVCfoKy4TDUE1D4qF9H
	uLgYeQNQ==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEf-00DGzD-0A;
	Mon, 22 Jan 2024 17:37:25 +0000
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
Subject: [PATCH 13/15] loop: cleanup loop_config_discard
Date: Mon, 22 Jan 2024 18:36:43 +0100
Message-Id: <20240122173645.1686078-14-hch@lst.de>
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

Initialize the local variables for the discard max sectors and
granularity to zero as a sensible default, and then merge the
calls assigning them to the queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

