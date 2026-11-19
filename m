Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072658;
	b=zs+9m6RkOy6tArvM+wjjiFRfH4dzLnzVk4TAhMiMOpZW0XrZyLMIXS9uUZZZ1/PddHZw
	 /CihTBR2fDkWS6SsM+nV/vAJXS4xWEFfzXPnZIE5RMCKUWcGwPmW2jdt51z9iPmYxFEJ1
	 rp/7juas/k7iTiuPmnGq8FEsgiz8BRQ3gwb9VvXioDDKi2okF1wYSi93CF8MTcN58D0Ry
	 PVFJUbHrCeKetbYoTL9EM2ZKh8KaxDlglisfdqlgDuYFONJHnDu+jFifd9kK7OYqx7+JT
	 KrwzE8rIWfHt2VESoaMPmlr8xxmVw9exYMKb+6YYf8ILI+Mud4eu8I79W99I2IGn8DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072658;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jsxkjb7jmKjzuYwAweN/g6trsU00rvF3A10hVgJTe/U=;
	b=J6L+R1mOlhcDVuXuyOk7vYE32MG3wZrAtg//SaUyQyekQHJgA+lbWndJqpYfO4TT5vYl
	 +SyR/U7Z+Ls9hOd2inAWiv/T8C3ivpfBCYL3YxrHq0RB1nri96YaPas1ovVv6y5ROKmNs
	 M+PRHa4kL87pDLU8c8DIRQjVEJeO6tSevUT6fdzIss6zO42FM1wbaOMkKcaq2s+/OLA0X
	 5l9okcLSAj2dG21QNP2RI1V6+CrOi/x07ndEMeRIGL9oESB2bFyZ2RMGMMculR1w+s7XK
	 72NGZVzJTjbv7e58wlxRp7S5Q7fSUw0Ol3m/S2LP5AagEyK9uoWq20NyapqUGMegP8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvvLXvHb;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A32606A320
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A32606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvvLXvHb
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795072654; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jsxkjb7jmKjzuYwAweN/g6trsU00rvF3A10hVgJTe/U=;
	b=MvvLXvHbzx7ELfmTQm9hS6jDDaYk7q1IeP6BJJSIPBSVMpn3pOUxPgNjoMox/LC2ABM60gVXJRgCEMpI12o0O013MaDCRsOO+siYUs5TbxEfjMTSb7bWqwTaukOAt1Av9XOZEsAkGrzV0g/a/H4fHTrzclkKeT2Wqed6KVce7+M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2ikeL_1795072653;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2ikeL_1795072653 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:17:33 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH v2 RESEND] block: rename need_dispatch to piecemeal_dispatch in blk-mq sched
Date: Thu, 19 Nov 2026 15:17:28 +0800
Message-ID: <20261119071728.3145752-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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
Resend of v2, which received no comments. The code in the function is
unchanged since then; rebased on top of v7.4-rc1 to refresh the context.

v2: https://lore.kernel.org/linux-block/20260528084416.2336836-1-kanie@linux.alibaba.com
v1: https://lore.kernel.org/linux-block/20260526131103.3105411-1-kanie@linux.alibaba.com
v2 -> v1:
- Change cautious_dispatch to piecemeal_dispatch, the advice from Jens.

 block/blk-mq-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d7b45778732b..e9f2ded56471 100644
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

