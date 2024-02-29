Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCA12F58C
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217551; cv=none; b=LX1FSCN9SN69NQi4QYStUIqeBcqtqSSqRHo+St2IWZ9VWQ7ttpL60wfXBgfe8FNL6aH6C/9KeDqzn2jh6ZEVEVdDTRT8FMppwy1lXlJZoUaIDmfZWMNHuIyQaDcOIU25ibms8IZ/8Q/2Q6rcuAPdbjvqSj7rKkGhGZqYfXjsXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217551; c=relaxed/simple;
	bh=I9L4J92cSF5Fll/q8oAuU+969JtLRTHzwO050h4DyBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AftvCkEsxCDOVPGXgQZ7LqXx2Em0uMmdncnPVgnfwKgA7zWvadNMAn0hcWOuWX/hz3UTLJDhBfP65WUFrWZc/Tobhs7xpjjg85ka+AlZPjc0/vZWcVGtb8FDpFG75ApIWqPtjExPJDFlL2Djznsv439+0NzWwXPFdLO9/BnZaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=obrk09l8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="obrk09l8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QJzXdMVMj/zE5xp/XtEAbR9lvP5zyixzjCOJuZCm9tw=; b=obrk09l8xvSV6j+flbBYIB7XlT
	i4xB9MHcbN8j4lLUXt1LR/34QC3KaQJsLTrLTI1DivYjtouc+mKFNNh5qXvmCGt/d+nnXRNs8wJCr
	9R+V0D8RluGAbT5JY0vgA8LgTnJ62orH4N+xjqbYWXiiMyQtuUar47pS7QTD4vg3DaWMMlQbBHarO
	4b8lzctbvqz8LVUFeBVpFgAYvFp2e61Q9Wk8tUkJ3BUrz/hXCoadNsgqlI7xp/M2cKezGaw9poJ33
	fqka59rEGKAZuyC298Elw64k2zBzM+wbBPa+QN9aOBM1bj0uGrlZoV8mAgK1cMkpFZivY59anmwFT
	1LlORHPw==;
Received: from [216.9.110.7] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfhYz-0000000Dtl9-1IUO;
	Thu, 29 Feb 2024 14:39:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH 2/3] nbd: freeze the queue for queue limits updates
Date: Thu, 29 Feb 2024 06:38:45 -0800
Message-Id: <20240229143846.1047223-3-hch@lst.de>
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

nbd currently updates the logical and physical block sizes as well
as the discard_sectors on a live queue.  Freeze the queue first to
make sure there are not commands in flight that can see torn or
inconsistent limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 384750d5259fb8..22ee0ed9aa6db0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -316,7 +316,7 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	nsock->sent = 0;
 }
 
-static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
+static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		loff_t blksize)
 {
 	if (!blksize)
@@ -348,6 +348,18 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	return 0;
 }
 
+static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
+		loff_t blksize)
+{
+	int error;
+
+	blk_mq_freeze_queue(nbd->disk->queue);
+	error = __nbd_set_size(nbd, bytesize, blksize);
+	blk_mq_unfreeze_queue(nbd->disk->queue);
+
+	return error;
+}
+
 static void nbd_complete_rq(struct request *req)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
-- 
2.39.2

