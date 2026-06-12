Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2712673B0
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229238; cv=none; b=ga3PhBBsIlFp7Nh7jkdNOvbd+lrmy8VXmjykaFYwiltbUnHNpZ/c8VXXPTDv2Wq//a6L/kFRi90sBjD/DnCd7jRaLCih5wYJ1sU0ZPTkuoJrxrp9peVTTyxM1OO3KBQ/cce+SQz7Y5L4A5Qf819DxHBREsE6U7ouydKLYb0M6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229238; c=relaxed/simple;
	bh=rRUrd+xHHdo8/Tq5jBRvNCNLl57ksv1mSEUHP29/F7U=;
	h=Cc:Message-Id:Mime-Version:References:To:From:Date:Subject:
	 Content-Type:In-Reply-To; b=Em1GmrC7hr8BNZcncPJIbmDcZC2hmbZ1tl2UJPz1u3c2Vilc/qAlGDjp+buZYf5hvaZ9qiW5rcki0Vq4xKP37X/t0C5m+OuPE0qJzUK/YnAKvpx3pizrgl6Jxd4LYyaBa2F4+3/zC+egS2O02308Pcv2zVVj+7WoNrOM9TBXPNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GhHviRM1; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GhHviRM1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781229225; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zHnyVOO9SwGYCmYgeEWyxtlMp5tP0BX/JpEiOeecCzE=;
 b=GhHviRM1Kb/JvTm7xmVanGHGpCAul0E902cc6qPNxco+hEpRJpE2VHJ9xR+VHDTM6m24aD
 zZ+bFJDf/Z2aoyFwXae3ZKuW0vH8h47KAl4bhKrPUQ52gB3WF0zCYFgI4ExpWULWy3rRXI
 EcR9jzhjzkWHUwbt2fgX0hRcxujNqkhYhiAzy+Ebjmhwz8PhJPv8MaiUuSP+L7fEPGKZRe
 6hOaGhGySPLeE7OIn+EG3keYld86lpgVxHRxPcbOWuQwAGSQS32TDmGkTW4ZKooudjXnGC
 PvOU/7YcC0zUVqHIeNTv6kBUcFSyBJuKnYsvofP6YTn/leuysGv0si5caob6Yg==
Cc: <linux-block@vger.kernel.org>, "Alok Rathore" <alok.rathore@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2e916cee-3a82-47ac-a416-b52a9744cdd5@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CGME20260611163403epcas5p2bba1c085eaab24852acfb0751ef148ab@epcas5p2.samsung.com> <20260611162719.910837-1-anuj20.g@samsung.com>
X-Original-From: Fengnan <changfengnan@bytedance.com>
To: "Anuj Gupta" <anuj20.g@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>, 
	<kbusch@kernel.org>, <lidiangang@bytedance.com>, <tom.leiming@gmail.com>, 
	<nj.shetty@samsung.com>, <joshi.k@samsung.com>, <anuj1072538@gmail.com>
From: "Fengnan" <changfengnan@bytedance.com>
Date: Fri, 12 Jun 2026 09:53:25 +0800
X-Lms-Return-Path: <lba+26a2b66a7+cb53c7+vger.kernel.org+changfengnan@bytedance.com>
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: bound blk_hctx_poll() to one jiffy
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260611162719.910837-1-anuj20.g@samsung.com>

=E5=9C=A8 2026/6/12 00:27, Anuj Gupta =E5=86=99=E9=81=93:
> blk_hctx_poll() can busy-poll until a completion is found or
> need_resched() becomes true. On preemptible kernels, the scheduler can
> set TIF_NEED_RESCHED on the timer tick and preempt the task at IRQ
> return before the loop condition re-evaluates it. After the context
> switch, the flag is cleared, so the poller can continue spinning instead
> of returning to its caller.
>
> This can happen with io_uring IOPOLL reads inside iocb_bio_iopoll(),
> which holds the rcu_read_lock() while calling bio_poll(). If another
> poller on the same polled queue drains the available completions, this
> poller may repeatedly find no completions and remain inside the RCU
> read-side critical section long enough to trigger RCU stall reports:
>
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:     Tasks blocked on level-1 rcu_node (CPUs 0-9): P3961
> rcu:     (detected by 3, t=3D60002 jiffies, g=3D18533, q=3D4943 ncpus=3D2=
0)
> task:fio state:R  running task     stack:0     pid:3961
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
>
> Reproducible with:
>
> fio -filename=3D/dev/nvme0n1 -direct=3D1 -size=3D4g -rw=3Drandread \
> --numjobs=3D32 -bs=3D4K -ioengine=3Dio_uring -hipri=3D1 -iodepth=3D1 \
> --registerfiles=3D1 --group_reporting --thread
>
> Record the starting jiffy and exit the loop once jiffies has advanced.
> This bounds each blk_hctx_poll() invocation while also covering the
> case where the reschedule flag was cleared by the context switch
> before the loop condition could observe it.
>
> Fixes: f22ecf9c14c1 ("blk-mq: delete task running check in blk_hctx_poll(=
)")
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Alok Rathore <alok.rathore@samsung.com>
> ---
>   block/blk-mq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c5c16cce4f8..d85fa4a51e79 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -5248,6 +5248,7 @@ static int blk_hctx_poll(struct request_queue *q, s=
truct blk_mq_hw_ctx *hctx,
>   			 struct io_comp_batch *iob, unsigned int flags)
>   {
>   	int ret;
> +	unsigned long start =3D jiffies;
how about this :

unsigned long timeout =3D jiffies + 1;
...
} while (!need_resched() && time_before(jiffies, timeout));

>  =20
>   	do {
>   		ret =3D q->mq_ops->poll(hctx, iob);
> @@ -5258,7 +5259,7 @@ static int blk_hctx_poll(struct request_queue *q, s=
truct blk_mq_hw_ctx *hctx,
>   		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
>   			break;
>   		cpu_relax();
> -	} while (!need_resched());
> +	} while (!need_resched() && time_before_eq(jiffies, start));
>  =20
>   	return 0;
>   }
