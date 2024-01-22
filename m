Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6CD59B5F;
	Mon, 22 Jan 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945040; cv=none; b=VEKbNBZmkZMnYHkRnok18oITSvun11OoJhyPR/kintzrUgGS8OXqnkrpAXFVnuv7Rglh9aHgZTblfVLA6zpFr0Ho57u7lNkuwZ2kGBotNdGJBPG0eAooeBDCaYl0SlYAXGP2yJmVyqf4ZnIAN/ClSCoGmK4IDWPDOsYRbIKaxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945040; c=relaxed/simple;
	bh=Gx7ge95K0X5swpjXLnkohydYiBMOE5wBS9q4XMuD3CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dt22Z/dFAtiqZuh08NpeLrpr21hkVJ2XzuZjRdp5L/Qeqv52iKKiqo5D5tZyZaku8EBH6a1p0rlpyTK3tpiz82lDPCZKyF0EoS22hP2uqusaEQxTSBrUdKEtO44aM/97a645y9ufi0Ub93/rr0Vy7u+Yqi0XkCLvCSzmd4qH1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mjR38lmH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mjR38lmH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6xt03nH75W2N6Ede/oekBYFRh3OyvqFO38yVWBgIHLg=; b=mjR38lmH2i/2wTYwmqOuSWrJqD
	B+o8m/kqhpHlQnZt/T+ts7PY8wiVDpE+u6eQIE3HzKMnaglHn2RWrvZIiHevaQknNt0MhCtQ7VP0d
	dVwTx7zV3B/WVX3pyLvxvIwmVYvsCen3cLPSrdDlDM7yeEXrNqGECcd4YgNF9SrDZjAGmiiDsxYre
	29Wgp/+mrl/qJLjRAc3cZGUY4JfjLkNevlJIAp/9XHx9HUcbNIv5GrQ6sar6/eaRXy4x2expeMvuJ
	cDL6BQ+O6VNYj9IHLnBFSwCKlC7ZLuIQjFluOq0A+f/8l6Fv7TqWtLc/DcOeE6lwqa6rVkjOQFSCK
	ys01vF0A==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEN-00DGkp-2b;
	Mon, 22 Jan 2024 17:37:08 +0000
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
Subject: [PATCH 07/15] block: use queue_limits_commit_update in queue_discard_max_store
Date: Mon, 22 Jan 2024 18:36:37 +0100
Message-Id: <20240122173645.1686078-8-hch@lst.de>
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

Convert queue_discard_max_store to use queue_limits_commit_update to
check and updated the max_sectors limit and freeze the queue before
doing so to ensure we don't have request in flight while changing
the limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

