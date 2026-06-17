Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA94ADDA0
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712342; cv=none; b=hY7OyoJZHFLrmFd2oYEhXR5HtVDIj/sautBWjM1MogAzxNmFv0LQoX/D3/N424lsBjWrfqd+WS+aoDEXr5jV2QgAbMLJGzZ58rAvuIzAo6wk7Bxs4ag2oH0tdBqMmlpJA80AUUip/tOhEM+oc43qcofB3xXeYo+6KezjbdDnS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712342; c=relaxed/simple;
	bh=s3csMKSjUAc+VjLMFsugWQ7x2ZIK8YGthsMjuEQ4gUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=LlFmux/GwXC1AMRbDzy1RDPJSmypfrtCI6ibdigDqgYkuxeDNwgCUWUB6qzPGRAHLbOTjJxnZ4EetjvfYAWPn3qgZTpbpMTlpGvORwN8yFjmAjLCbEuF6N/eOPrBBBQpVH+gKZCROaqYufMdo+eoUva5goqWzlev+36JOE+3SQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gh4kw65g; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gh4kw65g"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260617155737epoutp04637e3ef674b95ac9cfea335a1e3f693d~56X6MnYBE1318113181epoutp04U
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 15:57:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260617155737epoutp04637e3ef674b95ac9cfea335a1e3f693d~56X6MnYBE1318113181epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781711857;
	bh=/mVh7gHXtH2RM5xaYLrPuCDVi/xnU27PHu58wniYoCk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gh4kw65gAsd28K5zQr/wMdjIVHlvHmnZw8Xf1mheiN//rGOkb1YIMA/xH4Nk4lq98
	 xKHldJP27PlLxXCG+yunCVIDjdzoEgSiTmDM9b8rTbLbqQjIHX+Zdj6AGzUanXCbiq
	 +c92hzApVHqNbrsRIGlqA0saofUCxV/v7jAI1Mxw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260617155735epcas5p10b2e646907c9c0aacbcd57ecf02a97fb~56X4zNXNo1238412384epcas5p1g;
	Wed, 17 Jun 2026 15:57:35 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ggT5V6d3xz6B9m6; Wed, 17 Jun
	2026 15:57:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260617155734epcas5p128e015bf4a1653f386c1ad75b32b86bc~56X3brOBe2524025240epcas5p1n;
	Wed, 17 Jun 2026 15:57:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260617155732epsmtip2ca05c345689235dfa582911b4216479c~56X1t7xWt3034830348epsmtip2C;
	Wed, 17 Jun 2026 15:57:32 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	lidiangang@bytedance.com, changfengnan@bytedance.com, tom.leiming@gmail.com,
	nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com
Cc: linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Alok
	Rathore <alok.rathore@samsung.com>
Subject: [PATCH v3] blk-mq: bound blk_hctx_poll() to one jiffy
Date: Wed, 17 Jun 2026 21:20:51 +0530
Message-Id: <20260617155051.1266079-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260617155734epcas5p128e015bf4a1653f386c1ad75b32b86bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260617155734epcas5p128e015bf4a1653f386c1ad75b32b86bc
References: <CGME20260617155734epcas5p128e015bf4a1653f386c1ad75b32b86bc@epcas5p1.samsung.com>

blk_hctx_poll() can busy-poll until a completion is found or
need_resched() becomes true. On preemptible kernels, the scheduler can
set TIF_NEED_RESCHED on the timer tick and preempt the task at IRQ
return before the loop condition re-evaluates it. After the context
switch, the flag is cleared, so the poller can continue spinning instead
of returning to its caller.

This can happen with io_uring IOPOLL reads inside iocb_bio_iopoll(),
which holds the rcu_read_lock() while calling bio_poll(). If another
poller on the same polled queue drains the available completions, this
poller may repeatedly find no completions and remain inside the RCU
read-side critical section long enough to trigger RCU stall reports:

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     Tasks blocked on level-1 rcu_node (CPUs 0-9): P3961
rcu:     (detected by 3, t=60002 jiffies, g=18533, q=4943 ncpus=20)
task:fio state:R  running task     stack:0     pid:3961
Call Trace:
<TASK>
? nvme_poll+0x36/0xa0 [nvme]
? blk_hctx_poll+0x39/0x90
? blk_mq_poll+0x30/0x60
? bio_poll+0x87/0x170
? iocb_bio_iopoll+0x32/0x50
? io_uring_classic_poll+0x25/0x50
? io_do_iopoll+0x216/0x420
? __do_sys_io_uring_enter+0x2c7/0x7c0

Reproducible with:

fio -filename=/dev/nvme0n1 -direct=1 -size=4g -rw=randread \
--numjobs=32 -bs=4K -ioengine=io_uring -hipri=1 -iodepth=1 \
--registerfiles=1 --group_reporting --thread

Record the starting jiffy and exit the loop once jiffies has advanced.
This bounds each blk_hctx_poll() invocation while also covering the
case where the reschedule flag was cleared by the context switch
before the loop condition could observe it.

Fixes: f22ecf9c14c1 ("blk-mq: delete task running check in blk_hctx_poll()")
Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>
Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Alok Rathore <alok.rathore@samsung.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..e5850dc6c5d9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5248,6 +5248,7 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 			 struct io_comp_batch *iob, unsigned int flags)
 {
 	int ret;
+	unsigned long timeout = jiffies + 2;
 
 	do {
 		ret = q->mq_ops->poll(hctx, iob);
@@ -5258,7 +5259,7 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
 			break;
 		cpu_relax();
-	} while (!need_resched());
+	} while (!need_resched() && time_before(jiffies, timeout));
 
 	return 0;
 }
-- 
2.25.1

