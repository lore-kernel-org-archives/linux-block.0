Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1E170A13
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616502; cv=none; b=WCAy6SACMBBN7VJbVUa+aCxqcsoFzQYN3dbqkhUqUp59hvG5WyizfmeOJ5WspGWpSrUlZh/YEbaWSJGb56pqrqWT01jwf3+0q2iweXifipAWeDk5xxVZmOB4RTdG4O5Uc9s8D9YB0PS7IHMFWb38jdb1kXtay35DtegmNShxM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616502; c=relaxed/simple;
	bh=6a/rfLQuckyYIU4ivt4WtifTO9mosALSeoXJYCtxOdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwU0SmnNzkU8iolb8lPmbVioSP3Rk9l7F3IMhqy/ozTYkmf2b2qsWCrT2WllCDc7/aD++6YaT4M1ztJEGaqz8LkElVaNBoWLkMF58c8fGqtE1q9lDnZX7j1a9tBSjF4v00xiCDTlMxj3YdeVX3BSkZYzUvHPm/4v6S5IXUhBEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cKN5n0qn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cKN5n0qn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0UGuM0fnQEMdFLRy3A2+iCQC/bkEAxkZjxc0Sriq5po=; b=cKN5n0qn+plzc3+gqg3RaxxW4p
	mlQPamZPNo8jpwNR3C8DM/sCuZgHciXsf90DX6ME4lmF1LXC6pxp5LS2s/cYBpn2Piz+9EsyoTTgM
	pcqbxAy+yS6izEsF4y033CX+aPTVo/e3XvPJZd0rcTuiVSd34jv4h+SCFwqAZgNgM++Z2FR7xdfZX
	zIz7vljbSyZfjVKEvchkPRz/p9XNUH81FZ9ljxoOEwEKbbWsLVrT5lRb1qhOP8N5kkItOW41C+2mA
	xgCuOZqoLI0BdEqMm32nCBT+BocIDVM4/W5M/Re07jj2FHiJdFDpXBZURTscdIwDpstZBM7cPq71w
	3Tq3EqUg==;
Received: from 2a02-8389-2341-5b80-8f90-0002-7d3f-174e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8f90:2:7d3f:174e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFshO-0000000AIBA-4Agl;
	Tue, 26 Nov 2024 10:21:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH] mq-deadline: don't call req_get_ioprio from the I/O completion handler
Date: Tue, 26 Nov 2024 11:21:36 +0100
Message-ID: <20241126102136.619067-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

req_get_ioprio looks at req->bio to find the I/O priority, which is not
set when completing bios that the driver fully iterated through.

Stash away the dd_per_prio in the elevator private data instead of looking
it up again to optimize the code a bit while fixing the regression from
removing the per-request ioprio value.

Fixes: 6975c1a486a4 ("block: remove the ioprio field from struct request")
Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Reported-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 block/mq-deadline.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index acdc28756d9d..91b3789f710e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -685,10 +685,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
-	if (!rq->elv.priv[0]) {
+	if (!rq->elv.priv[0])
 		per_prio->stats.inserted++;
-		rq->elv.priv[0] = (void *)(uintptr_t)1;
-	}
+	rq->elv.priv[0] = per_prio;
 
 	if (blk_mq_sched_try_insert_merge(q, rq, free))
 		return;
@@ -753,18 +752,14 @@ static void dd_prepare_request(struct request *rq)
  */
 static void dd_finish_request(struct request *rq)
 {
-	struct request_queue *q = rq->q;
-	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(rq);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+	struct dd_per_prio *per_prio = rq->elv.priv[0];
 
 	/*
 	 * The block layer core may call dd_finish_request() without having
 	 * called dd_insert_requests(). Skip requests that bypassed I/O
 	 * scheduling. See also blk_mq_request_bypass_insert().
 	 */
-	if (rq->elv.priv[0])
+	if (per_prio)
 		atomic_inc(&per_prio->stats.completed);
 }
 
-- 
2.45.2

