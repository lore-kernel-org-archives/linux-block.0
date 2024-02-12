Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BCF514;
	Mon, 12 Feb 2024 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720397; cv=none; b=Gjj/irqoHIFEBDnrjV7opow3g7loj+4MFFsea1uIYf1FSC3mACmunUpyY3sQ6fGBoztSmiPGKqvPewxzTVUJQMS1i9/vY24L22hbnugf2M4PYPOF6H+LSpqbfTWXr3GGi6T5zeCH5QUWARPcDGrHIP5fKKfzuAeQu1soi+EcIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720397; c=relaxed/simple;
	bh=Kz/wGhjwA898M4xM8AiUp7jHwoiOpA40vXAi1bOb9ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMiaYE93l00qQDeqtXkFPFvsS38zrGQ+pZIjihHJJ+9hakj2pjbx9FWFaGsUIxbfHXgg6JbOe13cuvnP35fdehm1l3fPpFrqnwFXW5UeWi18cN826HH8tqFWDEUA3QoBVIAMb49KutGDE0PttHmjt7OmwFfTXD4iHDOeWGBz+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nYb4RSNO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nYb4RSNO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dbUUuuh+TiTwmyxcs080LBUsDQdjlLe3kybykALbaaw=; b=nYb4RSNOxEqtl+/HtAWdQ3l/Sq
	Zs/JO3czt0A1Q18cQiX9WuvU1aanozlFYYnGAP0xEko7f+Bm5f2yPjb/tAnfAEFINSA3wKQMfy4uW
	PrkVgRbHE9tGF0QBSjjYFd/9LVxLO7z2ekKYB+rOcHf4f5dbmaM4uVgnic0LrhWTIMvh7xuc9Fzk8
	9lQJgFvEf07ISVNLuGB7DzeCrB4LO7u1O7uUKFLKOYqwTbDwrvP/jVLZGJ+OPwQYcqwQvK0zmgzLb
	01JGHc7SS2A1CtdnkPbCz+kL7BYYrN7IB2+e76LjcHjapcA2NvSu64lS0b81zzunutctEUvDHcMWD
	r5/FQQTA==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5H-00000004PcW-3zZ3;
	Mon, 12 Feb 2024 06:46:32 +0000
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
	John Garry <john.g.garry@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/15] block: use queue_limits_commit_update in queue_max_sectors_store
Date: Mon, 12 Feb 2024 07:45:59 +0100
Message-Id: <20240212064609.1327143-6-hch@lst.de>
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

Convert queue_max_sectors_store to use queue_limits_commit_update to
check and update the max_sectors limit and freeze the queue before
doing so to ensure we don't have requests in flight while changing
the limits.

Note that this removes the previously held queue_lock that doesn't
protect against any other reader or writer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6b2429cad81af1..26607f9825cb05 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -226,35 +226,22 @@ static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 static ssize_t
 queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 {
-	unsigned long var;
-	unsigned int max_sectors_kb,
-		max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1,
-			page_kb = 1 << (PAGE_SHIFT - 10);
-	ssize_t ret = queue_var_store(&var, page, count);
+	unsigned long max_sectors_kb;
+	struct queue_limits lim;
+	ssize_t ret;
+	int err;
 
+	ret = queue_var_store(&max_sectors_kb, page, count);
 	if (ret < 0)
 		return ret;
 
-	max_sectors_kb = (unsigned int)var;
-	max_hw_sectors_kb = min_not_zero(max_hw_sectors_kb,
-					 q->limits.max_dev_sectors >> 1);
-	if (max_sectors_kb == 0) {
-		q->limits.max_user_sectors = 0;
-		max_sectors_kb = min(max_hw_sectors_kb,
-				     BLK_DEF_MAX_SECTORS_CAP >> 1);
-	} else {
-		if (max_sectors_kb > max_hw_sectors_kb ||
-		    max_sectors_kb < page_kb)
-			return -EINVAL;
-		q->limits.max_user_sectors = max_sectors_kb << 1;
-	}
-
-	spin_lock_irq(&q->queue_lock);
-	q->limits.max_sectors = max_sectors_kb << 1;
-	if (q->disk)
-		q->disk->bdi->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
-	spin_unlock_irq(&q->queue_lock);
-
+	blk_mq_freeze_queue(q);
+	lim = queue_limits_start_update(q);
+	lim.max_user_sectors = max_sectors_kb << 1;
+	err = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+	if (err)
+		return err;
 	return ret;
 }
 
-- 
2.39.2

