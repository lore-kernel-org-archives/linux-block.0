Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450617;
	b=E/7NvToe8Op33z14awGwTTlTjhqWD8LSd/OZu1z7TdWSXqJ401sKfcv3Q4YaqSpbrzlx
	 HFumH9pc2nxBx07tUfZ9ERPQHL7zO6XCsHYsQK+4g7dZ++uko/j/p1L1DEXDa+3VvtkJj
	 Ae256w644eSvhwhhrQSEC8Y1x7GU1mKEPlwlgRE2CHdIdRklBfHM5cGrRiJp3pjejoL5n
	 2nXEsypG187q+PfVEBYbxEwpsp4ptBuRkEbvfasui/W0E++K/6moqRwB7Zq4aFChOTuj/
	 M4ywbiIpFGwDXG85UIVzhlhf+SB9EGi6ZwljnQnkZ//Hoqdt8odJS9v9ZwPVcmQ9vKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450617;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oAKsCevx3uX25D7nBgvsehpj1Do0NWR5rPVL5dcze5M=;
	b=Sqv0cbXJFifdD6GNWHLFk49jTYlzoT6ohdx995Yce+lTwV0H8l3Azqj8FH+zTZQEy3Vx
	 fLWLLIsCVbWARuUSCJRPpQYGWhGnKIp6K7QstgOcMok5HWaHiPgw3Zz6TKx0v1WuOETQ3
	 UtqgoRCo8JJOaKgGh0wePKHJ2/8t0mJ7ileh8t5dpesem5LJgjHdhhqq6YsHtxuqMKOM+
	 1xO7ya40VuhA8vJolaxb+IOuOFLz/jLcpQRVDZwUnaAcKsnlWoPQXnYZC2CfCMvZMHy1B
	 DxPOktYEmXhSQvaKcgXdPmV7zVXRazBXT37twg67gzoVbT0HyjtNIY5FxawThbpEtig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=naVsIZeS;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0F606A31C;
	Thu, 12 Nov 2026 02:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=naVsIZeS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=naVsIZeSE9U3e65WdrwP6bK5b/8aqj1JQOrDKfcu1i/hT0X9e0iQg0RlIuer/fRi7rW9sAkJU7tCg
	 ibybtsPqdGh31odb9rAOFJPH3lDsECEWI/nCCq5gdnS9q/nn+kFfEyMkonjn01lzD6YA+I+J95isA7
	 n3RJhbKtYYNXrUPs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af524b7092-b8611;
	Thu, 12 Nov 2026 10:30:15 +0800 (CST)
X-RM-TRANSID:2ee16af524b7092-b8611
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af524b6e2d-ef184;
	Thu, 12 Nov 2026 10:30:15 +0800 (CST)
X-RM-TRANSID:2ee76af524b6e2d-ef184
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] blk-mq: Mark concurrent accesses to dispatch_busy
Date: Thu, 12 Nov 2026 10:30:13 +0800
Message-ID: <20261112023014.118106-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dispatching on different CPUs updates the same hardware context's
dispatch_busy estimate without a common lock. Scheduling and debugfs also
read it concurrently, as reported by KCSAN.

Use READ_ONCE() and WRITE_ONCE() for the shared estimate. The EWMA remains
an approximate dispatch hint; concurrent updates do not need to preserve
every observation.

OpenAI Codex assisted with analysis and patch preparation.

Fixes: 6e768717304b ("blk-mq: dequeue request one by one from sw queue if hctx is busy")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 block/blk-mq-debugfs.c | 2 +-
 block/blk-mq-sched.c   | 4 ++--
 block/blk-mq.c         | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6754d8f9449c..d8b4e3b606e6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -488,7 +488,7 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
-	seq_printf(m, "%u\n", hctx->dispatch_busy);
+	seq_printf(m, "%u\n", READ_ONCE(hctx->dispatch_busy));
 	return 0;
 }
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d7b45778732b..66e03b676838 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -92,7 +92,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	LIST_HEAD(rq_list);
 	int count = 0;
 
-	if (hctx->dispatch_busy)
+	if (READ_ONCE(hctx->dispatch_busy))
 		max_dispatch = 1;
 	else
 		max_dispatch = hctx->queue->nr_requests;
@@ -300,7 +300,7 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 			return 0;
 		need_dispatch = true;
 	} else {
-		need_dispatch = hctx->dispatch_busy;
+		need_dispatch = READ_ONCE(hctx->dispatch_busy);
 	}
 
 	if (hctx->queue->elevator)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556540..322bad6896d4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2007,7 +2007,7 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 {
 	unsigned int ewma;
 
-	ewma = hctx->dispatch_busy;
+	ewma = READ_ONCE(hctx->dispatch_busy);
 
 	if (!ewma && !busy)
 		return;
@@ -2017,7 +2017,7 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 		ewma += 1 << BLK_MQ_DISPATCH_BUSY_EWMA_FACTOR;
 	ewma /= BLK_MQ_DISPATCH_BUSY_EWMA_WEIGHT;
 
-	hctx->dispatch_busy = ewma;
+	WRITE_ONCE(hctx->dispatch_busy, ewma);
 }
 
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
@@ -2587,7 +2587,7 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	 * Try to issue requests directly if the hw queue isn't busy to save an
 	 * extra enqueue & dequeue to the sw queue.
 	 */
-	if (!hctx->dispatch_busy && !run_queue_async) {
+	if (!READ_ONCE(hctx->dispatch_busy) && !run_queue_async) {
 		blk_mq_run_dispatch_ops(hctx->queue,
 			blk_mq_try_issue_list_directly(hctx, list));
 		if (list_empty(list))
@@ -3235,7 +3235,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	hctx = rq->mq_hctx;
 	if ((rq->rq_flags & RQF_USE_SCHED) ||
-	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
+	    (READ_ONCE(hctx->dispatch_busy) && (q->nr_hw_queues == 1 || !is_sync))) {
 		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, true);
 	} else {
-- 
2.51.0



