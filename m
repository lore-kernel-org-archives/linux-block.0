Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A538F9E4;
	Mon, 12 Feb 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720405; cv=none; b=Cs6EJV8atNzccBemt82EAauyl/Zn9LgscYEiydYEpegKxHsYW0HoaXv0AR2wv5cjz2vSmDExUP1BaQQa/tcyCqQ9y5WdROLvKu1GBSyxUaKi512oydsdBMrSLfnMSssvBpR/oAPNk8Mr2pAjJdvusRn5DdGwhUhzKcjBgpEh0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720405; c=relaxed/simple;
	bh=DqJ3yVhotqdem3USWpogfOXHwacQDgTajoI9rbiMBP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNp5p9IEj0ziqxLZNqG/i4rxPhr86CXbum1aERTMAGGpJlMODt1S82wXvG5nuigEVOz9pK9FuQTq0+YTi4lqSEutEghLY8XGx+9Wq1WSjGA0rpHy4vRVvDsywMXU5skBS817C3vFxlq3OQBdVMiobMZDNhdt0M7Ek9flOYnfAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i2Fl3KZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i2Fl3KZW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2ar7uAc1G22jWGawzjqLyxqJbQTxTABlLoYNg1HeWes=; b=i2Fl3KZWnb5MayME+31iqpZM8p
	wuioofufxYN6hpR8O+GiCoZX2cypxdq2fiK0zfjSCb5kqvzmSh/Jw1rzSAkg+BWvh3nSvRV1/nLdJ
	mVJvcLt1HxcXBjwU5IDSvdlA7xCUYXA+0NjmzGiaInrqycZui8+AGwqcZZ3GPLg8fOTJKGN4klBNS
	+C4ku4v9BxCtsS9nV7gszGB2RY0J9NCkYm8o1OOBXaXv7WFx/8i7dUrncFv6jQ7YeRVc9SLsAM2s+
	2wP40PCuBg6h1PKiA5aS7kUE+gn9dANLw8EbWUrwaFcHh31ZsQrgKdLjU6c59IhWyj/AsoBYuaPVR
	tSakIwOw==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5N-00000004PgR-2njn;
	Mon, 12 Feb 2024 06:46:38 +0000
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
Subject: [PATCH 07/15] block: use queue_limits_commit_update in queue_discard_max_store
Date: Mon, 12 Feb 2024 07:46:01 +0100
Message-Id: <20240212064609.1327143-8-hch@lst.de>
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

Convert queue_discard_max_store to use queue_limits_commit_update to
check and update the max_discard_sectors limit and freeze the queue
before doing so to ensure we don't have requests in flight while
changing the limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a1ec27f0ba4150..8c8f69d8ba48ee 100644
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
@@ -187,9 +189,14 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	q->limits.max_discard_sectors = min(q->limits.max_hw_discard_sectors,
-					    q->limits.max_user_discard_sectors);
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

