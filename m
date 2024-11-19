Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB01C68BE
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032589; cv=none; b=RwN4HzqsaXfyywYswulDm1RY3RC+5xYzy1fp7TLmtCxfdDCxW+7IymikM98AZ+STCkBXNBXTdaDph7S0GHvMz6BMhdggnxCBKqJzejwDcPu8QzpQ8sRn7XUXySXqqrr81moJENl34KD2EoXaiMjWvB6k2RsioYXDxWNlmU3Tz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032589; c=relaxed/simple;
	bh=mRLAukieIpgYj5W6lg8XEj9Nth42gb/5vA0OU3awmS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqLCk7hJ5PRvNIs0S4XhIDHMAetwGAg7diMBSJ45ZkFv7CuvF4rdsAhdqi0dkb/x034uRdtMa09dR/EKzygv8fqsWHUqlVKimXt3vLilrQk55Pbaq+M+h4w3WL+oq8AWOFJnGrwOlkI5g9McTmd09ofWMAiwIEpSfkW/5PXWkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bpSKjkV9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bpSKjkV9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rE40UIvqEqxjwpkjyUCp11WR+Qlrti4zWWwusGbQMjM=; b=bpSKjkV95L+g6XMQKoCgFGN8z7
	SWRp85SLUeAp1cIDOS2tuEsjluTAl55qGZJj8qrxHVrFtsWi00wLfT5AqEE2GPOYPtzvpeCcLIRS4
	zVghqeGv+YjwI7gNOjfZR6bdMN1cnR9WS0/y6osg7lYrwjSC5CEfX68THOgAS1AVaSmzGrYP3prsO
	z4VEfiRFkBH9AfhgJNBcUwY+ycosOLdJLKRF6q34SWT5DahuMlZ41H3E5nN4zcMxubb6IwWJT2pRL
	7CLG/y0u0ePpqkg7BcFqPYamdF7atLu389jNpQp5dJOhti9ZPm8QDAs1aqthMixUMxOb7+O3X0g/m
	zK+OkosQ==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQnS-0000000Cylu-3mYF;
	Tue, 19 Nov 2024 16:09:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: return bool from blk_rq_aligned
Date: Tue, 19 Nov 2024 17:09:21 +0100
Message-ID: <20241119160932.1327864-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119160932.1327864-1-hch@lst.de>
References: <20241119160932.1327864-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_rq_aligned returns a boolean condition, don't mascquerade it as int.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 74e3c611a4f7..e4fc967e8cb9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1464,7 +1464,7 @@ blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 	return lim->dma_alignment | lim->dma_pad_mask;
 }
 
-static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
+static inline bool blk_rq_aligned(struct request_queue *q, unsigned long addr,
 				 unsigned int len)
 {
 	unsigned int alignment = blk_lim_dma_alignment_and_pad(&q->limits);
-- 
2.45.2

