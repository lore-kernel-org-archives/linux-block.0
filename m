Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0372E832;
	Sun, 28 Jan 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461133; cv=none; b=c44y9Imn6A3GUUVgxV+zk4Ao7uH3QuB+r2BpdCHjQveAtfdqAHepH6EYZC1INoYzdPuJeZ6k2x4KkRJ7QjmYeBNS9WORKmLhCDkCNO/B12MaCTiMAZhhwM+9QjKIX2fTsdLzxDkhJq7kXUt6VG00HwCFIF61wyTVRCszUOUnKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461133; c=relaxed/simple;
	bh=cTCl2JGW+TFoPFTqRvuoX9sm/vDAcQB7JPcHGhFmVRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uF7XsMUfgEqC9IuBs0BTdzg5Vxn636dyKeCxMG+8xwTVYHZfefm+2IZR+pv2GS5nq++XzudE790lUTfIg/bCy0BnxAt65XipaZiP1mTf+/PMH2KLtXeT6AVei9KKXEd3jCP04+Et+cb85beONhuz+1qGMnHhx4ovSsaLsCE4ubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iIiW3qou; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIiW3qou"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P7lJeX1MV89nvGvN/Kp1ZllbRc7C3W/7Ktl++U1k1BA=; b=iIiW3qouZ05SHMy8nEy2xjoqCo
	JFtpm7pT5UdqQWelEDM0NLe+yFhlJPhcYBM244pSe0Mdy0hf2ehxQFucRZK7qZ4JjgyjCgpTSJT+N
	wReCSl9Jd7Rr9c6YjpK3tnzRFJJdpR6rhegiPNYjf0++rAClkbSsCgHFbig+bZEz+vnZKEe0ZMeh6
	7b2/lEJn8/RYTJtQAXMMfjaA2yXqmy4zE6SRHjVSYD8+FDkzHS7Qi1kplvS3vvfpkW/JvrmCQ2uoJ
	QyuQXnsGkgaOmMxxjPjZpojz05ozS5zVmxym20MrnknqHw+4vCumfNLBLBcHtbyymtHPlL6I+Lqi2
	8QQPog+A==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8UY-0000000A29w-46z7;
	Sun, 28 Jan 2024 16:58:47 +0000
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
Subject: [PATCH 06/14] block: use queue_limits_commit_update in queue_discard_max_store
Date: Sun, 28 Jan 2024 17:58:05 +0100
Message-Id: <20240128165813.3213508-7-hch@lst.de>
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

Convert queue_discard_max_store to use queue_limits_commit_update to
check and update the max_discard_sectors limit and freeze the queue
before doing so to ensure we don't have requests in flight while
changing the limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 54e10604ddb1dd..8c8f69d8ba48ee 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -175,7 +175,9 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 				       const char *page, size_t count)
 {
 	unsigned long max_discard_bytes;
+	struct queue_limits lim;
 	ssize_t ret;
+	int err;
 
 	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
@@ -187,10 +189,14 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	q->limits.max_discard_sectors =
-		min_not_zero(q->limits.max_hw_discard_sectors,
-			     q->limits.max_user_discard_sectors);
+	blk_mq_freeze_queue(q);
+	lim = queue_limits_start_update(q);
+	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+	err = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+
+	if (err)
+		return err;
 	return ret;
 }
 
-- 
2.39.2

