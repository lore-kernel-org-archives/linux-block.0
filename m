Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE72F9E8
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195656; cv=none; b=ImR2+KsrYWBc+CPE+E0XCTSWn/rLEaswO0o2a4VrezAfx3quUnQ99Ro/Q2WmLGnUn3K5jAspehvFmXlA7v+ZEuJoGddhqbHPDO2I4NkO7Fo5ZGyVbf1/OgvAWXE8h62k13Ya+KZySLxqn8IlqqJLDoPkKjJ9BnwAIAUbmry371Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195656; c=relaxed/simple;
	bh=VWmWVN4iMtPd5tLDSB0+yXOwKTrxXd4pxOWx96/5SjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=bJPedIhnQ1ibcR6w6GPTishgBmjcUFBn+q8xohn8RWMnBMhd7UuD82Eo3RjgdvHR/PZDsJZ2I1NtN2PsqgU0c2ng95zo8XrrT8TfPwVoBU+ZFk8HlKd/jGJAl8uizARgl+z5zDgQM8xaD0KRzjldxlm6tVvP7qUgzCGgcFjZ/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SsvRWJrB; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SsvRWJrB"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260611163406epoutp02c2c57d4aeacd0df435316c9cd15d1ac9~4FADTjSZx0786107861epoutp02F
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 16:34:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260611163406epoutp02c2c57d4aeacd0df435316c9cd15d1ac9~4FADTjSZx0786107861epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781195646;
	bh=vWQY7ZbF77HjDtGNh/rjmczl0wbkwNg/A1VsiMztkL4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=SsvRWJrBQpjec9yAcFJTTkPQU9zOqZc8i2IzU3LbQu/UbPmE+V8TcnzopXa4dpCJJ
	 8RXBJuQ/PzBB3Pi+CpdM2j9rzEwZGtjkOXTeVi4pCm3UqaurMmgdMV09T0IoWovOMm
	 jLyDV7s2AI+4ltG0bAkA49sWv+PbTInPCgOd89Ks=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260611163405epcas5p1389aa64aae76255281e7ad62522cebca~4FACHLwTY0373403734epcas5p1A;
	Thu, 11 Jun 2026 16:34:05 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gbpBN3JjBz2SSKX; Thu, 11 Jun
	2026 16:34:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260611163403epcas5p2bba1c085eaab24852acfb0751ef148ab~4FAAQoIIK0192401924epcas5p2Q;
	Thu, 11 Jun 2026 16:34:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260611163400epsmtip23f271590dbd57faf1f1d860d3c5776b2~4E-9gq4LM0975509755epsmtip2y;
	Thu, 11 Jun 2026 16:34:00 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	lidiangang@bytedance.com, changfengnan@bytedance.com, tom.leiming@gmail.com,
	nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com
Cc: linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Alok
	Rathore <alok.rathore@samsung.com>
Subject: [PATCH] blk-mq: bound blk_hctx_poll() to one jiffy
Date: Thu, 11 Jun 2026 21:57:19 +0530
Message-Id: <20260611162719.910837-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260611163403epcas5p2bba1c085eaab24852acfb0751ef148ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260611163403epcas5p2bba1c085eaab24852acfb0751ef148ab
References: <CGME20260611163403epcas5p2bba1c085eaab24852acfb0751ef148ab@epcas5p2.samsung.com>

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
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Alok Rathore <alok.rathore@samsung.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..d85fa4a51e79 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5248,6 +5248,7 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 			 struct io_comp_batch *iob, unsigned int flags)
 {
 	int ret;
+	unsigned long start = jiffies;
 
 	do {
 		ret = q->mq_ops->poll(hctx, iob);
@@ -5258,7 +5259,7 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
 			break;
 		cpu_relax();
-	} while (!need_resched());
+	} while (!need_resched() && time_before_eq(jiffies, start));
 
 	return 0;
 }
-- 
2.25.1

