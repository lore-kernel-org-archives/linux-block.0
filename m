Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F497AE68;
	Wed, 31 Jan 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706272; cv=none; b=Tp8wTlSP3KrICHNhPrdpLCgUk7A9KJBjl3ac4xv6HhidG4JYMGuMBZzIvGsuloSTblKO9YD7aPqgSZBDjUdreclV8O8Fkr7ShHW5NMiyIbMaytfVBKCAz5AhNthAAgn0Zg7kIyFjBpSugJcncI+RePeldR5g0p82Y9f1mAC/mSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706272; c=relaxed/simple;
	bh=cTCl2JGW+TFoPFTqRvuoX9sm/vDAcQB7JPcHGhFmVRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TU/GBBBHQcOWY5BdEGNLOssCB+OsbFOHTk+XtalyB4PwpopE9l7Rl5hPFBjWLhHG50wwXz1/GiKHjLC/aKWEz6zSnVh5w5jYzBcJT+4KR31buj1QbkOwg9ewLQdhzWzYwIcpymfGltFKuPL7BMEpc9qcoDXR4Ee61UY4n3GTvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2Vr20Ukn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Vr20Ukn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P7lJeX1MV89nvGvN/Kp1ZllbRc7C3W/7Ktl++U1k1BA=; b=2Vr20Uknrg7FC5tMjPnC6XJ/GK
	ZSlIlqALAqHgyr0NBJjnGH3H8uT5Of+ELyJgtYUj9o90auD95HS3A7+mbJpo30lpBZ+TrN0V+hta2
	XIQnLFqQvsmZixcPXoBD6Fem6oB4UZjlouEscsaILyATdwG5Drn63pMxHWLT1KJXEn5ktabtKzP7M
	b7tbFMN/0zjc9ZjNC1AKESJ20mzkzmn/HBLOcDh14f5+lt83OJC7NfBwA+CQYWcXxOiGJhy/nRd6T
	3vQop9Bx81Zl2OOfBwsN4gHdmYfCzBnTOzjwhbkjcVx2tlsLTu7AsBn81OkncvKBbdq67Zhx49iAF
	4hL3nFJw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAGQ-00000003VCv-1pry;
	Wed, 31 Jan 2024 13:04:27 +0000
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
Date: Wed, 31 Jan 2024 14:03:52 +0100
Message-Id: <20240131130400.625836-7-hch@lst.de>
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

