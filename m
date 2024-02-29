Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4679137777
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217552; cv=none; b=uupi/2BHTb+JkD0okLBnT9GYaUn2Vvwax2qrKo/9QxCAYxvkWQWEc2Cm9zVfYLARzLw6YNt7nHOoirrJRV5ePQ/HKLjegWvQ6U9XQ8hx5Dq3VZgkaWDakreDjHKb7jZpVOld22Miffua/a9NEX5EkJjgZhl/KjynIpjLckH1oCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217552; c=relaxed/simple;
	bh=DkT0j0H2VmgzgLbTRvsMmGG+ouZTICRX2K7NfTnL5dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYWnPcjWTzE+sKjueU0tPQmHU2/7RY8Hwil/WmElGqoiYImQGFi/bO3W2GZmQB7eUixa5sGi2zqGUf6CCVwNqtEKjRcP2Do8YSp77uO1byEtVwO1PxzLaXebVz5CCF+X6fPOaoWDQXEt6ZTs/jxsJXYuK7XcYl6OeMlcKZeS5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hz0RKqmH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hz0RKqmH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eB65jZCI4DOhsIeR75tX3uMn80Bbo9GI/LSxj/PB/hc=; b=Hz0RKqmHaQcPC1bWJZrMZ0IH9L
	jGz9W3302SATyFWmY9zDUymlrGRx2pjU+veA0ikAa4OeFRb3pw91WrEzaTr/XdXXApYOifmRcIxqH
	iadVD2ZiKk2xOvzLSj+JTTG/O/osBkPKWRCNRj5MK4ehWoYeFfbqj1AcvkPM3K5jhq5nQJ222kr5r
	BbQPpLuLD4/9wNBS4O4J41+wRkkLBrIV3YAoT12dwRnORB54LUJH/V7yP2cuN9XX8B0YG07MqFuA7
	kiC+UajH28x91CDk7+/Qrl2kczCBpQETGyapGOmFx8CKEXSV46tZSuEK7+sYTqeiU3cRWJOeC0d/z
	7Q985ZUQ==;
Received: from [216.9.110.7] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfhZ0-0000000DtlP-1JXi;
	Thu, 29 Feb 2024 14:39:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH 3/3] nbd: use the atomic queue limits API in nbd_set_size
Date: Thu, 29 Feb 2024 06:38:46 -0800
Message-Id: <20240229143846.1047223-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229143846.1047223-1-hch@lst.de>
References: <20240229143846.1047223-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use queue_limits_start_update / queue_limits_commit_update to update
all the limits in one go and with proper sanity checking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 22ee0ed9aa6db0..9d4ec9273bf954 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -319,6 +319,9 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		loff_t blksize)
 {
+	struct queue_limits lim;
+	int error;
+
 	if (!blksize)
 		blksize = 1u << NBD_DEF_BLKSIZE_BITS;
 
@@ -334,12 +337,16 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	if (!nbd->pid)
 		return 0;
 
+	lim = queue_limits_start_update(nbd->disk->queue);
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
-		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
+		lim.max_hw_discard_sectors = UINT_MAX;
 	else
-		blk_queue_max_discard_sectors(nbd->disk->queue, 0);
-	blk_queue_logical_block_size(nbd->disk->queue, blksize);
-	blk_queue_physical_block_size(nbd->disk->queue, blksize);
+		lim.max_hw_discard_sectors = 0;
+	lim.logical_block_size = blksize;
+	lim.physical_block_size = blksize;
+	error = queue_limits_commit_update(nbd->disk->queue, &lim);
+	if (error)
+		return error;
 
 	if (max_part)
 		set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
-- 
2.39.2

