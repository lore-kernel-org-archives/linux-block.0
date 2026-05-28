Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A63815C2
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957867; cv=none; b=pqRVdvtGQadffgs9+og86i5uzwaQjOcb387j+mEMDiJXqwQpYzDOj/yNnkb8Pfw1PXCB8pLR9x5pfzKfu5ArwAjZWn44KK+NI1Ctf6iai3XaJtDua6ouHFNpXFGpVuAETlCvaWsV2+qltlhne4YrGNdUEFWIAc9zPvgqGd6AHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957867; c=relaxed/simple;
	bh=N0xt4N2XEYVuubIA3PYxZQ3Q4XxjIsK1Fx0b+HR20dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc1Ijq5vgH62zpZDG4UypOyP5NliIg6wGgXxwZxEbjvJWCIakHqO15Lj3OBmB845a1yIGQfzCkQ5eCCmzefbyXVDPMjbMpUf+YsBXGF9G/9uWBSL1y672McrT1tkzYRKS8Ce6oo5HEaER6qqSly/tZ3HQLkuUjayITkjKAwcIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i2BjFBNk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i2BjFBNk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779957861; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+fnQyzy3DCC7JungO4vn6Jej8qkwib6fsILY6+pTSck=;
	b=i2BjFBNk2NMkHGF62RXbj5NO/m74a8wPceHfFUxTdDiNAaLg8c0OjhS1nlKvVlzJX13jhv6niLGnfhSh/0rsI2JiM6gcZ/1xmx2AJ/SXGX6SnHEcZ5Z7HnQyc789BOaFTddc+XOiT0xMN7m4cGvEOvflVyKPh3r/YjZckETtGW4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X3m0kKW_1779957856;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X3m0kKW_1779957856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 16:44:20 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v2] block: rename need_dispatch to piecemeal_dispatch in blk-mq sched
Date: Thu, 28 May 2026 16:44:16 +0800
Message-ID: <20260528084416.2336836-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local boolean in __blk_mq_sched_dispatch_requests() decides whether
to fall back to the per-ctx round-robin path (blk_mq_do_dispatch_ctx())
instead of the batch flush path (blk_mq_flush_busy_ctxs()).  The whole
function is about dispatching anyway, so the name "need_dispatch" is
not particularly informative and can mislead readers into thinking that
a false value means "skip dispatching".

Rename it to "piecemeal_dispatch" to match the comment right above the
check ("dequeue request one by one from sw queue if queue is busy")
and to convey the actual intent: take the piecemeal, fair, one-at-a-time
path either when we just drained hctx->dispatch (so the device has
recently pushed back) or when the dispatch_busy EWMA still indicates
congestion.  The fast batch path is only taken when neither signal
suggests recent backpressure.

No functional change.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
v2 -> v1:
- Change cautious_dispatch to piecemeal_dispatch, the advice from Jens.

 block/blk-mq-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0a00f5a76f5a..14dacf99e148 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -267,7 +267,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 
 static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
-	bool need_dispatch = false;
+	bool piecemeal_dispatch = false;
 	LIST_HEAD(rq_list);
 
 	/*
@@ -298,16 +298,16 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		blk_mq_sched_mark_restart_hctx(hctx);
 		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, true))
 			return 0;
-		need_dispatch = true;
+		piecemeal_dispatch = true;
 	} else {
-		need_dispatch = hctx->dispatch_busy;
+		piecemeal_dispatch = hctx->dispatch_busy;
 	}
 
 	if (hctx->queue->elevator)
 		return blk_mq_do_dispatch_sched(hctx);
 
 	/* dequeue request one by one from sw queue if queue is busy */
-	if (need_dispatch)
+	if (piecemeal_dispatch)
 		return blk_mq_do_dispatch_ctx(hctx);
 	blk_mq_flush_busy_ctxs(hctx, &rq_list);
 	blk_mq_dispatch_rq_list(hctx, &rq_list, true);
-- 
2.43.7

