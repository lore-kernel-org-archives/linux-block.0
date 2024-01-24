Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE718026
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088431; cv=none; b=mUh2sKam6wB/y5j7i6788EPlZv0+Nba+SWGXpx58tdTn4NcSmbBEZCanhq4QyCvjEeVqzosMo+tRDrv0EY7bKoinRjJInoIbgkOPk03BOITdwtpqDefuC7RpdfvXisAsy8j0sm2Bpx8cBMJG63IlNjXzcDgcZWYr5PCHKA2gHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088431; c=relaxed/simple;
	bh=oGXuR/XrRQ6z8ykCey1Iw1zmK1QlfTre5+gJ5p3jgjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqssQqbSEIsbGK53QmOTS38dg6bLkngi7NsBrYKP+2kfc5kVpw3lNr+ySGxraqBLZT4XqsCiiRMYAj0d3TRNaKym+5tzXR8zdsr6+Z2R6DYuZeVlnafC+H+1igTz4Q5+hU/Cxr8vaSu9qwcsY55sIMdMCvTcoTeHprS6bGrq9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B2svcMv6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2svcMv6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Yc7ORvUT5JtJWNwYCTgMUQDPXKdNSd0wpNiRNWn/55s=; b=B2svcMv6/JBKPg06/+ypB1JFP4
	ox+ERSMellrscF5BGH5aqA2FhypsK13KhDLq2896KSH7Bd3Grag8OW15ClRqJqxnmGbIRILLqYdzb
	l7ElGTGfCwHbAbUsIEGFvxfraUtM4jlUWCcIeROsvJZQNzQ9kSsiJATJ3wK3tMeu9zvueoCWWdO/V
	dKzMBW2Gtu+bh3CJddgXaqcfgdqdUfxjQ254YDF5C467eAsDXXt0GiTCGycGPPFcMlfjcq17gMpPB
	D+LLSAI4YhiGf1+578SdVXHyz0LjcQbZmcC/b0fAGvHJpsFyLkCKjOyxcOKC3ijUTmwvV62Uc89wS
	+VZcCQEw==;
Received: from [2001:4bb8:188:3f09:9c13:25f:1e5b:57f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZXI-002EFY-1d;
	Wed, 24 Jan 2024 09:27:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/3] blk-mq: move blk_mq_attempt_bio_merge out blk_mq_get_new_requests
Date: Wed, 24 Jan 2024 10:26:56 +0100
Message-Id: <20240124092658.2258309-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124092658.2258309-1-hch@lst.de>
References: <20240124092658.2258309-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_mq_attempt_bio_merge has nothing to do with allocating a new
request, it avoids allocating a new request.  Move the call out of
blk_mq_get_new_requests and into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ecfc..fbd1ec56acea4d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2892,9 +2892,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
-		return NULL;
-
 	rq_qos_throttle(q, bio);
 
 	if (plug) {
@@ -3002,18 +2999,18 @@ void blk_mq_submit_bio(struct bio *bio)
 		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
 			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 			if (!bio)
-				goto fail;
+				goto queue_exit;
 		}
 		if (!bio_integrity_prep(bio))
-			goto fail;
+			goto queue_exit;
 	}
 
+	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
+		goto queue_exit;
+
 	rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-	if (unlikely(!rq)) {
-fail:
-		blk_queue_exit(q);
-		return;
-	}
+	if (unlikely(!rq))
+		goto queue_exit;
 
 done:
 	trace_block_getrq(bio);
@@ -3046,6 +3043,10 @@ void blk_mq_submit_bio(struct bio *bio)
 	} else {
 		blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
 	}
+	return;
+
+queue_exit:
+	blk_queue_exit(q);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
-- 
2.39.2

