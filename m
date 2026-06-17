Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950F1DD877
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708775; cv=none; b=RtguRAhqX6jt9Ju0iKIwUjkBlOac9/QBx0cRE7EVub47Wz+1XcKB/7by2ERNg7fF7oKRET6VSLsDDVxBGvaBHHNXJX87y6/C2jW0BQKwfdY32ylSnT6x6N0a6VIjTXxb3CdU9MMgIn+lm5Dr57R8ZU1D9Mh4ck3cElY8OjiFhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708775; c=relaxed/simple;
	bh=+IZrTSKOmCMWffKDoS8DsOy0cIDUWr4neEOXFd0I93A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV+ucamrLvtcoDdb8yZcxzRBK0U0u1TflBCpO046GO/JGxmgxNjmvPXTSLFig6fbbO4XaGNjLqffp897wqn9UYEwulyWiZh1N9pht42REo1VHrGO/iJTK4wm+d6PwUob7sAsC31YAJY+DyTDKEm1v9WfvWN2PK8OZBr9Q5gpgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=h+crDyHv; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="h+crDyHv"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-486560db81cso4389631b6e.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781708772; x=1782313572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWkME3UubDCWfnghCnb/pyR7HEy65kfkjwrbeWa3czk=;
        b=h+crDyHvjLPXalogQY/rQpjwq2ffMg2k/WRCLHfamOPK5KzXRfCYIn+USXEezDRn85
         W7fxOR3tgvInB21sVy9yiOHWsV3aYF/e5oL+hYSFDljKtwPq2ND7eOEzF216pC5QDdIV
         w3V4GlvaOGEA3WZCJXFp0YkAdSkWAZEbjrJdodWiufsT2T73OJoNxgQ2L5OQWUVXxb+a
         8/3VwDodRt8ZX7akqp3wcJ63s1zRlSYdguMKkVRGuxKi5UeYNYUMt4G6cVpwG38Pv3mI
         hV7dLgvZd1kP6k8mWPKDGda35AWr//NtshxMGQEtb1Z/ORE8jmAqCw7zAXXi87/AkKyv
         sRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708772; x=1782313572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWkME3UubDCWfnghCnb/pyR7HEy65kfkjwrbeWa3czk=;
        b=YyhSVWuirZRDYy/ShcgZhJkSXkibIbVkmNS6U7UuOLefRz8Bb3PjfCdUqs3mH+hOmc
         1NdyaGALHPN7v6kKw5VvsVoIWWeZD8aj9FHdJEYZr4oCji6e3O06QPbSZ0AB86oIrQa+
         Zvs7C82BlDlyecnH56RLHnFZmnqA0I0uoEr/Ojhtg1M65FVT0c2r12W9f1kK97syjTCi
         TsK5u/IcPPVK2RGh6uXHEUrLLigby7O7wjYsm0RERiif1F+qHvoStT+gFDaBnoa66gbb
         e7YyR8t0cn75SBV/GDylBBBlS6nZwZHWhWdBIJSCQ/6mkMfViwMsFNaYeWUdwhIF0fms
         dOSA==
X-Gm-Message-State: AOJu0Yz/Bs/pFGopUs4LjVdt7aPPuQ4dzg2/rjCD1FE1SRsznjiCq1KA
	8qs24ngtuCm7g3145cpuIKTAaCOnUmb6Fs789CGBunnRq7eExhFtZIfmh2OC6SAwrjY=
X-Gm-Gg: Acq92OHjBXjmPb5zJ0MFd/STdb7dllWgDAkJvH7OrT+bFMzmxJauS6+LgG1h7Z6xgDl
	oClONCFAmfHf3gmPoy/tEB9S9opu8pAvTDu7uJwcsQ/TqHLzwMC+dFFljBlMSfNfxONBq7DEm7L
	FZMDygW3s7HHu+UC7YmR7uGGySMlsMG3s4GT44XQJh19gFABV82fzp//duN4shJRgR8N3XqdlGp
	9u1XKhUCjNo298UQuewwFrV9MxhuIl2v+x9HVZGYueZebGbg1mfMHlEYgUCWD/rWoDRI6jSmAMG
	em7chMi/NQhxqbIVOPkwAR5M7ExwLrh7QanUSKKJ0g8ttzBhNAZyivGI7JC9zXMAioGt5N/fQyl
	dwEAk04AyB2DABdmji7p02LddEkeR2GzWH55CXpPl+/3AnORA9dh4QEygTg4TaxcFsX3nwC9Rdz
	fBsKJtxE65t+skwK7adu/XTLkgiyDhpSFx290AN5E=
X-Received: by 2002:a05:6808:c2cc:b0:487:55d8:f0eb with SMTP id 5614622812f47-489429b1525mr3382627b6e.2.1781708771868;
        Wed, 17 Jun 2026 08:06:11 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.128.98])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfb4574sm6528668b6e.16.2026.06.17.08.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 08:06:10 -0700 (PDT)
Message-ID: <d71f62d7-f1f1-4169-bc05-1b354b94ef78@kernel.dk>
Date: Wed, 17 Jun 2026 09:05:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: bound blk_hctx_poll() to one jiffy
To: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org,
 lidiangang@bytedance.com, changfengnan@bytedance.com, tom.leiming@gmail.com,
 nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com
Cc: linux-block@vger.kernel.org, Alok Rathore <alok.rathore@samsung.com>
References: <CGME20260617061531epcas5p26e62bfdf2e91b646611191e4451d9843@epcas5p2.samsung.com>
 <20260617060850.1244788-1-anuj20.g@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260617060850.1244788-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 12:08 AM, Anuj Gupta wrote:
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
> rcu:     (detected by 3, t=60002 jiffies, g=18533, q=4943 ncpus=20)
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
> fio -filename=/dev/nvme0n1 -direct=1 -size=4g -rw=randread \
> --numjobs=32 -bs=4K -ioengine=io_uring -hipri=1 -iodepth=1 \
> --registerfiles=1 --group_reporting --thread
> 
> Record the starting jiffy and exit the loop once jiffies has advanced.
> This bounds each blk_hctx_poll() invocation while also covering the
> case where the reschedule flag was cleared by the context switch
> before the loop condition could observe it.
> 
> Fixes: f22ecf9c14c1 ("blk-mq: delete task running check in blk_hctx_poll()")
> Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Alok Rathore <alok.rathore@samsung.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c5c16cce4f8..ae6c5f4b80ce 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -5248,6 +5248,7 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
>  			 struct io_comp_batch *iob, unsigned int flags)
>  {
>  	int ret;
> +	unsigned long timeout = jiffies + 1;

I wonder if it'd be better to set this to jiffies + 2, just to avoid
skipping after a single loop if jiffies changes right after this.
Probably not a big deal, on average it should be fine. But also should
not really matter if this is potentially spinning uselessly 10ms or 20ms
at most, if HZ == 100. Similarly, this is also a misuse/misconfiguration
if you end up having multiple pollers on the same queue. Yes it'll work,
but it's a terrible idea for obvious reasons. Hence the patch is mostly
about ensuring that bad case isn't TOO terrible. But you'd really want
to sort out the app/config side of things in any case.

-- 
Jens Axboe
