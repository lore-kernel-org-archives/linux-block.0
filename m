Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAD79DD0;
	Wed, 31 Jan 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706297; cv=none; b=IOjyEnRH4BwythALn9Y7yE4FgrwAMBEajgaqeyge1NOWsFNquYDDF8kia1qYEfHR7RIQKU6rswdH+0FzfxzoyxHN3fZRvvsSD+lb0zoFUh3zsak6lMobc4IxgfhCFS23RBfhZLcfNYpPw4itpxuZa+7wFgzNlNkzxQTxV1Zk8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706297; c=relaxed/simple;
	bh=kKkmUAIzWynZl6gg5EVHCqhu9UkAK9DuWAVUhCwdWQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uupFQWMQ42Cr5cN8krwuAEbhpzXD1Pi+JNcXylYg8qJ/pd3IddyT4G4M6xYUj4RzXU4K/+10lG1ZsuXzlWymAa9kClcmPsg+a0bNqgKG2+LOOmOz2Rw7lOZPhu+Cr9klM5554xvFFkBevdW+D5jBLdQvw9iirPXtKbp4GwrI0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bDHt2eGZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bDHt2eGZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9brywd7uZhFzDL2uuR9GnUHObVr/2hXCOV/mhgORu+s=; b=bDHt2eGZT2jqkP3udjavLe8Ij6
	vv4fFaiVifMW16Uy68/ggdNgdQ0bDFs4BCDpOj7z3q5Xu4+T5P0tdJvx/NyCoJXkR3CCEkAO5IFj3
	ewaBYkOzYLurHQed6QBM4WDx3S3Z/jOnZNNy2+HPfiqybsUSWAwfhMQAjiWLlVOgnBfE9Zo5YIDkM
	LHgvY6482HhbbtBrcfbw19uIBqBiIRTlbmoFYjd0CTslwaX+pAWUbcDTG2WmKCrq6a+9gZjMfbzXI
	SvptZ/aZvmxVlXN2tj0Yep3uC2F7SX+tL6/4/7d2YDg/st+17ih6DnY2+FjowGNNV51tI0ASOJifh
	Oxo2sAhQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAGn-00000003VYY-0KkE;
	Wed, 31 Jan 2024 13:04:49 +0000
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
Date: Wed, 31 Jan 2024 14:03:58 +0100
Message-Id: <20240131130400.625836-13-hch@lst.de>
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

