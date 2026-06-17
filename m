Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE439937B
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680049; cv=none; b=Kp0hipNlsy0+umjN7c9YUBZghAIYOTTODa7PXq68Km0pv9JbjWoVfn21S5PQV/KrTn0iHX8/HedqIC/rfujvaKaV4LyG2GCHoTBamnW/+l5n/FfoCJ+aC1nvezVH7H+SzQ53XPgqBDr6+JFG6LbWyXVMjUR9ml8v2THzfIkqEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680049; c=relaxed/simple;
	bh=zFNInB+jPdgDnhH+1ck2ZTby13fsgZOr6DGVSFjTUpg=;
	h=To:Subject:References:In-Reply-To:Date:Cc:From:Mime-Version:
	 Content-Type:Message-Id; b=Q3bREAZRporquN5WFhK2WGumHF+6X7B8mzONDPUZw51gcz0wRG6CNayJdcNNPg3ic14r/xQfDC2eu6aDEeEbqqDQ3aBsoLmF1jbQpXEjEVbaT0O4UYN3bGC2kQbsQHXAWJfelmsgOB2fXWIFGDaz1XgAwoF3R/XRL4B3Chl0LAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JwavUbch; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JwavUbch"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781680043; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zFNInB+jPdgDnhH+1ck2ZTby13fsgZOr6DGVSFjTUpg=;
 b=JwavUbchCoGuhnA2M2gKIZsBJNfrF4pPrNoGRgwEefLXoxb7uuwwete0dv+PMiQB7z7I80
 vyUC7zOOlopzFJBOJcG7bjJJN/kMOWt/Ubp1SE/+fxdH0AEQkZJw+Byi1JKTGgLVITcy77
 Whtb8BXEk7VYZeNe6Z9OX6I0rO7ToVn+cWcN6CZsbPXzDOV3A7d0pK0jHLKfIvmWrFeb0W
 qgjeOZ2JAjk6kJk8VoE2ZB109+vRRqk6MBUTZ90Cdm1+VCEdkKGcsNUgY6+lsjLuTza6k/
 y+kqNHdy23AQlJpZGwJ6viPN2NXLIUMt+LunN3/MXb46pXsZL2gzwBT06WwjXg==
To: "Anuj Gupta" <anuj20.g@samsung.com>
Subject: Re: [PATCH v2] blk-mq: bound blk_hctx_poll() to one jiffy
References: <CGME20260617061531epcas5p26e62bfdf2e91b646611191e4451d9843@epcas5p2.samsung.com>
	<20260617060850.1244788-1-anuj20.g@samsung.com>
In-Reply-To: <20260617060850.1244788-1-anuj20.g@samsung.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:07:07 +0800
Cc: <axboe@kernel.dk>, <hch@lst.de>, <kbusch@kernel.org>, 
	<lidiangang@bytedance.com>, <tom.leiming@gmail.com>, 
	<nj.shetty@samsung.com>, <joshi.k@samsung.com>, <anuj1072538@gmail.com>, 
	<linux-block@vger.kernel.org>, "Anuj Gupta" <anuj20.g@samsung.com>, 
	"Alok Rathore" <alok.rathore@samsung.com>
From: "changfengnan" <changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a32479f+cbacfb+vger.kernel.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.13478856.b38d.4719.84cf.f45afd02d8c7@bytedance.com>

Looks good to me.
Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>

> From: "Anuj Gupta"<anuj20.g@samsung.com>
> Date:=C2=A0 Wed, Jun 17, 2026, 14:15
> Subject:=C2=A0 [PATCH v2] blk-mq: bound blk_hctx_poll() to one jiffy
> To: <axboe@kernel.dk>, <hch@lst.de>, <kbusch@kernel.org>, <lidiangang@byt=
edance.com>, <changfengnan@bytedance.com>, <tom.leiming@gmail.com>, <nj.she=
tty@samsung.com>, <joshi.k@samsung.com>, <anuj1072538@gmail.com>
> Cc: <linux-block@vger.kernel.org>, "Anuj Gupta"<anuj20.g@samsung.com>, "A=
lok Rathore"<alok.rathore@samsung.com>
> blk_hctx_poll() can busy-poll until a completion is found or
> need_resched() becomes true. On preemptible kernels, the scheduler can
> set TIF_NEED_RESCHED on the timer tick and preempt the task at IRQ
> return before the loop condition re-evaluates it. After the context
> switch, the flag is cleared, so the poller can continue spinning instead
> of returning to its caller.
>=C2=A0
> This can happen with io_uring IOPOLL reads inside iocb_bio_iopoll(),
> which holds the rcu_read_lock() while calling bio_poll(). If another
> poller on the same polled queue drains the available completions, this
> poller may repeatedly find no completions and remain inside the RCU
> read-side critical section long enough to trigger RCU stall reports:
>=C2=A0
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: =C2=A0 =C2=A0 Tasks blocked on level-1 rcu_node (CPUs 0-9): P3961
> rcu: =C2=A0 =C2=A0 (detected by 3, t=3D60002 jiffies, g=3D18533, q=3D4943=
 ncpus=3D20)
> task:fio state:R =C2=A0running task =C2=A0 =C2=A0 stack:0 =C2=A0 =C2=A0 p=
id:3961
> Call Trace:
> <TASK>
> ? nvme_poll+0x36/0xa0 [nvme]
> ? blk_hctx_poll+0x39/0x90
> ? blk_mq_poll+0x30/0x60
> ? bio_poll+0x87/0x170
> ? iocb_bio_iopoll+0x32/0x50
> ? io_uring_classic_poll+0x25/0x50
> ? io_do_iopoll+0x216/0x420
> ? __do_sys_io_uring_enter+0x2c7/0x7c0
>=C2=A0
> Reproducible with:
>=C2=A0
> fio -filename=3D/dev/nvme0n1 -direct=3D1 -size=3D4g -rw=3Drandread \
> --numjobs=3D32 -bs=3D4K -ioengine=3Dio_uring -hipri=3D1 -iodepth=3D1 \
> --registerfiles=3D1 --group_reporting --thread
>=C2=A0
> Record the starting jiffy and exit the loop once jiffies has advanced.
> This bounds each blk_hctx_poll() invocation while also covering the
> case where the reschedule flag was cleared by the context switch
> before the loop condition could observe it.
>=C2=A0
> Fixes: f22ecf9c14c1 ("blk-mq: delete task running check in blk_hctx_poll(=
)")
> Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Alok Rathore <alok.rathore@samsung.com>
> ---
> =C2=A0block/blk-mq.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=C2=A0
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c5c16cce4f8..ae6c5f4b80ce 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -5248,6 +5248,7 @@ static int blk_hctx_poll(struct request_queue *q, s=
truct blk_mq_hw_ctx *hctx,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct io_comp_batch *iob, unsigned int flags)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout =3D jiffies + 1;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D q->=
mq_ops->poll(hctx, iob);
> @@ -5258,7 +5259,7 @@ static int blk_hctx_poll(struct request_queue *q, s=
truct blk_mq_hw_ctx *hctx,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0=
 || (flags & BLK_POLL_ONESHOT))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_relax()=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (!need_resched());
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (!need_resched() && time_before(jiff=
ies, timeout));
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
> --=C2=A0
> 2.25.1
>=C2=A0
