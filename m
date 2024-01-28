Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0843C481;
	Sun, 28 Jan 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461155; cv=none; b=pmb+RaQZmZYG9gNHS1Lxqi1qk6C0RVXrJrRgfucpuUxpckdmzigGIqDeIN01TeHPDrL5islCgm0+GQOkCaYdr8jBvxS94D2/rEWJQyS7R6txUPt1hx2udOo/UiIpE1xlIM7i6X0JGBpEJR1xdlLxOChTGwffVAtqiIcMOwU85dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461155; c=relaxed/simple;
	bh=kKkmUAIzWynZl6gg5EVHCqhu9UkAK9DuWAVUhCwdWQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/BrPS6TE6kWpS6VOYrdeyMB1xfPshxO2eeF01ls2cwd8p2chcEKN3t1tOXP8CPesPCaeDl9zEFezBHeVJuSIbE9otuUzY67mybMx6lX+J/eU46CICT2w+4fIxQKwKAhW9KIYDe8l/LHDc0mirHjJ42+ew8xQKgCtiCzO2e3+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xyRex5OF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xyRex5OF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9brywd7uZhFzDL2uuR9GnUHObVr/2hXCOV/mhgORu+s=; b=xyRex5OFWo3ToUaw5oprmaf0Wj
	IDtrdkAwSy6Z8QmK5ED95aFqdXF7eb5C07N8r48/X3nYImEOsv8DU1lx959NW4zIqMstbhJ65JpRW
	tpFmaMm13/V/5cqDIIkx7elgdI8Y+RTOWviGBPH7u0U+aAPsCLDA5GI8ul6NGms1eVyuOddEQ9yQ0
	lMiM7dnVyM7/dd2I0sxyrslAI8jsKQanncXXdfFpyE+58igPH0LRuHBAZZWjwgYnO3fUKqW3yJ8d/
	uNuiHSkYbZhctW1uxtNxUGnh0iQ3Wavr5WH+b5y5lDxOschrezgUY5NfEJxFozYhXN4ZbFbfXRyOb
	3QIcNmTA==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Ut-0000000A2Sb-3rno;
	Sun, 28 Jan 2024 16:59:08 +0000
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
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/14] loop: cleanup loop_config_discard
Date: Sun, 28 Jan 2024 17:58:11 +0100
Message-Id: <20240128165813.3213508-13-hch@lst.de>
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

Initialize the local variables for the discard max sectors and
granularity to zero as a sensible default, and then merge the
calls assigning them to the queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

