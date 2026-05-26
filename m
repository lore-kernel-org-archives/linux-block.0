Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FB3E0747
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801081; cv=none; b=Y3Y/OQGOrlD9lGUw6hGBqPG6dRnuKgPLkFeAjdAheozzKcyEi8agvXPwCWCgAZzgXufj/zxeU94ZvFS5+Pr4Ec1p/W9He1Pkb9neGiNEmTpPEO1joZke7d+Cy04rWSMbXxlXfFMyPzJuRut8lmPvpZ4mMJWIVShcwuNfMCiHn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801081; c=relaxed/simple;
	bh=XCeoaUkFge6IGa3vO112vCnnzp7hpy4S+aNAFh1W180=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6MtLfoYlXO2fUQGbi2+Ue0b1XCvfE3stmNHSaBSyBretbetrs68U8Jzh8CrnhAlIvF50HIY0p2UY5O16uhKaiLdPu1+Iqjz4xyQPNmD3760IAzL/D5JeMsnJ6URdgVGFC+GatbUUoyQ8FoSVmEIOorpZifHbDyaru3rDXWwr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CXFCAEWR; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CXFCAEWR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779801068; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Y/wtYfMdB2LaTcdnM2/cLMLDT6gN7K8qkrYEj25Wj8g=;
	b=CXFCAEWR0W7VW6SvSdbg0CuR/SUsmtyNziKdHUsrGKGDz7btZKwc8o1zd4mJ/gmtgetpC4rEaSZ7hpwogKnWs8Pz27txguaNNeu581y1dx5YIb+gcEfnOA3U+B7yKekHpJ7dDzLD42HJ/mc8AWlvCW4jc2wodT8rLsutJsKCiFA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3gDr-2_1779801064;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X3gDr-2_1779801064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 21:11:08 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH] block: rename need_dispatch to cautious_dispatch in blk-mq sched
Date: Tue, 26 May 2026 21:11:03 +0800
Message-ID: <20260526131103.3105411-1-kanie@linux.alibaba.com>
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

Rename it to "cautious_dispatch" to match the comment right above the
check ("dequeue request one by one from sw queue if queue is busy")
and to convey the actual intent: take the cautious, fair, one-at-a-time
path either when we just drained hctx->dispatch (so the device has
recently pushed back) or when the dispatch_busy EWMA still indicates
congestion.  The fast batch path is only taken when neither signal
suggests recent backpressure.

No functional change.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-mq-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0a00f5a76f5a..ef28c3dd95a3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -267,7 +267,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 
 static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
-	bool need_dispatch = false;
+	bool cautious_dispatch = false;
 	LIST_HEAD(rq_list);
 
 	/*
@@ -298,16 +298,16 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		blk_mq_sched_mark_restart_hctx(hctx);
 		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, true))
 			return 0;
-		need_dispatch = true;
+		cautious_dispatch = true;
 	} else {
-		need_dispatch = hctx->dispatch_busy;
+		cautious_dispatch = hctx->dispatch_busy;
 	}
 
 	if (hctx->queue->elevator)
 		return blk_mq_do_dispatch_sched(hctx);
 
 	/* dequeue request one by one from sw queue if queue is busy */
-	if (need_dispatch)
+	if (cautious_dispatch)
 		return blk_mq_do_dispatch_ctx(hctx);
 	blk_mq_flush_busy_ctxs(hctx, &rq_list);
 	blk_mq_dispatch_rq_list(hctx, &rq_list, true);
-- 
2.43.7

