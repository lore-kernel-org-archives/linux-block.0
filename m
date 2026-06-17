Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947335295C
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676938; cv=none; b=hxQQvXoBeAHA+eo+/W1ez7yN1wll67LrzEtP0R5YPhbSrTAWDkHQQXwf6yM//iSAsOqDQCB0EYIMlvpofE7oDYHz6MTWGIJCO+Mho9PEfVPgJBNfGNevAypuk6dU6LEPbw/Hi0/8QY0cJLA9mwCuij73/9EUg4BIezDjid4rZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676938; c=relaxed/simple;
	bh=rd9nZIR5GFCCq8qWBxFRnIAfcp23iVw7nQshGUOLZ8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Rl26CGTTl9oQOLhNdCVvV79NVPS5JEyDRGIiHiCQJOH24aJdQtk2bmnZmDY1rLzbifmVTple8s9Tfg2oKjs2LjjRaUTm7frj+l2nLS7OY/FAVCurJwJDxzQ4ZXFKwE665DOXJiZ4dL5GwxpZa2DPoaKDaTePVllBDidSQDbhuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cVt/rSx3; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cVt/rSx3"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260617061534epoutp03894647d767ade79de0d2b579b18e27ca~5ybtZxpWB2366223662epoutp03F
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 06:15:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260617061534epoutp03894647d767ade79de0d2b579b18e27ca~5ybtZxpWB2366223662epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781676934;
	bh=1JDIGw6mV01ejlRTO7f1XdvDZ7U0fhI4Xe7zbLVaYtg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=cVt/rSx3Q2C2TwPs1wUcPr3CEaKYPpw4na9goajMLykUfmf4Hhi8vJzW2tI8Gxpbx
	 05yZwi6Qk4x22Li640fXyZGmSRaWbYhOJepaF8qJ1aLZ4Zb1po/HuiXwL7fbzUDUp/
	 UzYx7OeDXSNj0mD42IPm3/dgBTc77ol+7feeNVpw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260617061533epcas5p4af3958522c954826dc6eefc1bf3314e0~5ybs_XtEY0432704327epcas5p4k;
	Wed, 17 Jun 2026 06:15:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ggD9w4vZQz2SSKf; Wed, 17 Jun
	2026 06:15:32 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260617061531epcas5p26e62bfdf2e91b646611191e4451d9843~5ybrCfM2m1694416944epcas5p2k;
	Wed, 17 Jun 2026 06:15:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260617061529epsmtip18114e74c6474860dbf4bf160cca68608~5ybpP0yEi2669226692epsmtip1_;
	Wed, 17 Jun 2026 06:15:29 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	lidiangang@bytedance.com, changfengnan@bytedance.com, tom.leiming@gmail.com,
	nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com
Cc: linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Alok
	Rathore <alok.rathore@samsung.com>
Subject: [PATCH v2] blk-mq: bound blk_hctx_poll() to one jiffy
Date: Wed, 17 Jun 2026 11:38:50 +0530
Message-Id: <20260617060850.1244788-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260617061531epcas5p26e62bfdf2e91b646611191e4451d9843
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260617061531epcas5p26e62bfdf2e91b646611191e4451d9843
References: <CGME20260617061531epcas5p26e62bfdf2e91b646611191e4451d9843@epcas5p2.samsung.com>

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
Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Alok Rathore <alok.rathore@samsung.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..ae6c5f4b80ce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5248,6 +5248,7 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 			 struct io_comp_batch *iob, unsigned int flags)
 {
 	int ret;
+	unsigned long timeout = jiffies + 1;
 
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

