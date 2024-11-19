Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E031D0786
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032727; cv=none; b=q6c9zEIIBHZ2/F8+dGQ8VaF5OEfrHY1tzhyi8zvEEOFA3Tb93WDKAt9Vf9dCVlMlPHD6CWaxvMiM1BhhNu/jNm91fAxbFQwB41AjHr0TLZP05Dc6AXSCAGRC6F9MK8deD7yTewbzwxwWbBB9gYdHN5uoaSZjUuh3i3rTdayaBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032727; c=relaxed/simple;
	bh=dLdNBF4zfIru8AAjimD/fY61DLdpN6M7CqjtOUNFGUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvOPR7/ioCfAqw4RaLqYuQ34vDH7yq3mp/eQ/R+vNkN1NyXPonJvvIcb7GNgi5M/Fn1o/avHaRqL/ELtqYxUnUG2D67ihXYRS1dA0G/JBYKd4JqSUESCh8PBmj0agdxxYdoURGvv62edWNKI0atIHQFGghz2nx3xIop5M5UvVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1nks0gNq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1nks0gNq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UMJbKREIuMD5uCy3FOcLgHhasA9Umujy7x7rg1JjQ9g=; b=1nks0gNqUic6RygduRWNynTTP+
	++kjZ6+FzWngHc778HyqFbKJ9Q6W/QrExuvOY7xHv4U6kGFvXtuUd6FP7uaHq/pBMpwpTXF6qlJoG
	Azos+qp34NboLJ9jqZTtTMsoFOHLX9TgleGjwbjU97tK6XuDsKuHGt1wYU4VqcYmWlTnop8ic5Cqj
	FEpXZTZsnd1V6jVYejZdsinc9iwlJnu2YHcqSgEIbqH/uBb/rxr+2OEj4hboaz0b7hOZiia9wCu44
	3Y4X2Rc30zvymouwiMljFB5I1x8vOOmN/s/ItEsGLiTl80NPqMnK8nl8FoLAed0V2laz9kU0yMYO/
	4J9jDUgA==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQph-0000000Cz38-1nw2;
	Tue, 19 Nov 2024 16:12:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 2/2] block: req->bio is always set in the merge code
Date: Tue, 19 Nov 2024 17:11:51 +0100
Message-ID: <20241119161157.1328171-3-hch@lst.de>
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

As smatch, which is a lot smarter than me noticed.  So remove the checks
for it, and condense these checks a bit including the comments stating
the obvious.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 64860cbd5e27..e01383c6e534 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -864,14 +864,10 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req_op(req) != req_op(next))
 		return NULL;
 
-	if (req->bio && next->bio) {
-		/* Don't merge requests with different write hints. */
-		if (req->bio->bi_write_hint != next->bio->bi_write_hint)
-			return NULL;
-		if (req->bio->bi_ioprio != next->bio->bi_ioprio)
-			return NULL;
-	}
-
+	if (req->bio->bi_write_hint != next->bio->bi_write_hint)
+		return NULL;
+	if (req->bio->bi_ioprio != next->bio->bi_ioprio)
+		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
 		return NULL;
 
@@ -983,26 +979,16 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
-	/* don't merge across cgroup boundaries */
 	if (!blk_cgroup_mergeable(rq, bio))
 		return false;
-
-	/* only merge integrity protected bio into ditto rq */
 	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
 		return false;
-
-	/* Only merge if the crypt contexts are compatible */
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
-
-	if (rq->bio) {
-		/* Don't merge requests with different write hints. */
-		if (rq->bio->bi_write_hint != bio->bi_write_hint)
-			return false;
-		if (rq->bio->bi_ioprio != bio->bi_ioprio)
-			return false;
-	}
-
+	if (rq->bio->bi_write_hint != bio->bi_write_hint)
+		return false;
+	if (rq->bio->bi_ioprio != bio->bi_ioprio)
+		return false;
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
 		return false;
 
-- 
2.45.2

