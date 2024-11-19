Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0B1D0143
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032724; cv=none; b=prhwQRQupo0IShvT7zmYBacANZ9TS3wi8FHkIfXL94sLiJbefbMsFoQsv2xWFXQBSzPE7qRSmleYN15C07SxCVhH/U1oj58IwZlKPI6OQfstGH/xTFDbjfs31MRfjT7NuLQJYgiioowIiINQU2vJiUKboRD4sCIzTFrc9bRn0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032724; c=relaxed/simple;
	bh=vh3ZDsX1PAGo8R4dyemIuOJQPsP5FnOgULIbkZHlY14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKP9uGUqBSvyCYvVJAOTrXvYlwj/zxGYtLfqcHTzGQ7ILHqjP3beI31xw+jilvLMu7G+BIDmsCPIfebHbUPCGRuWkAIcL55ZqqRMxcLM1BnmprycNOP0UINeVXKOwZNffEvJBb7KigTa55KNO/9rxRk6LBGyT20yHkZi8O/PqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bMGpVAaX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bMGpVAaX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QST484Rjm0qjanP7JHElr8kCM2HEOEq9yFeGtbndeP0=; b=bMGpVAaXRWyyp+5E5abaJWauNy
	/rruNCbBOZGvQcXjXF4vk2OR9tyRwwNZ9DhV2pd2QBZWkzd1gYwArksLWR6t7Lk3380lJjzb8bWQL
	W564DPpF5NSrkUW+XJbJn80fvkPKgbo7ILOz8vyldgM9TWAlhApjcVUjeVCO1OeGTJ/l8yuH81VSe
	O3TLsg5pCGVNbSTIsAxnkYLEif1t8BPDps7TrocYoAaz7DKaWUMokykrPM0mR7f7XrdD5lN+JyWcK
	X1dJeK6mNvnUIaR0xKGA8pvATehZ5oRrUwlmZOSGXp0aAjpuTV2GnAiVAadhzPdrBsgaeIJNjz74+
	tffq2U1A==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQpe-0000000Cz2t-1zHL;
	Tue, 19 Nov 2024 16:12:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: don't bother checking the data direction for merges
Date: Tue, 19 Nov 2024 17:11:50 +0100
Message-ID: <20241119161157.1328171-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119161157.1328171-1-hch@lst.de>
References: <20241119161157.1328171-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Because it already is encoded in the opcode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e0b28e9298c9..64860cbd5e27 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -864,9 +864,6 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req_op(req) != req_op(next))
 		return NULL;
 
-	if (rq_data_dir(req) != rq_data_dir(next))
-		return NULL;
-
 	if (req->bio && next->bio) {
 		/* Don't merge requests with different write hints. */
 		if (req->bio->bi_write_hint != next->bio->bi_write_hint)
@@ -986,10 +983,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
-	/* different data direction or already started, don't merge */
-	if (bio_data_dir(bio) != rq_data_dir(rq))
-		return false;
-
 	/* don't merge across cgroup boundaries */
 	if (!blk_cgroup_mergeable(rq, bio))
 		return false;
-- 
2.45.2

