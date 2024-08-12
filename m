Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F01183CA6
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486568; cv=none; b=BKQWUhj5HwOS4t0F6+SslkG8BZ34m8p2CFvCYrk4VUnmiJRyHwndyz/dR7LMPLAu13uuh7DE7nBWEzDHkBxlHrdKPdgXEJiDcpaCQL3MMkUOaZwxv2rh93iumQ8Nmt1XiiHPseHtSDEk4T2QnfmiS2abU5heOFE0uWqa/IUm7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486568; c=relaxed/simple;
	bh=6JmLbnbx+OUTQCZBrk0Fxg5GM2wldZociS56hBj+viI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7P4s/0To0lZ2U6ek7nMxxKTqnhNGdDpP8kNNO3DJWTZKhJyr9sYms9TUq9oXGKDsR5lhJGVFB9pJHtKhBbaH5u3I4fcCjKGolLaYhXdYwbCQTwkcTxiPV4sdQdJGAth+3aqz3Bnxp51Z8N2YdglsMFqKMnvOCTA+9CrAVg7dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgIVJmsG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgIVJmsG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so35565605e9.2
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723486565; x=1724091365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W+8MbPRCb0YozGx78yHpevgqK7LlyJSrraSWxDfDgOM=;
        b=wgIVJmsGbgiBYdUW0JRO15Vbq8hNwoEOIiVIfZYClC5e2/HBy2RusePdcRVFaS9LiW
         KzqaKchBL6JNw8bvXiyR3s8+iBTFlXOKADZk3xPdtAHnsjjaXeGb9rb9HeP1KM3+NV3B
         4H3csn47TZfpPfOUV2Q1TWHHdO+E8sGfTpS0t3OWc2cjypVqbAZCMWTQGk8cCiN3+VOT
         HZXVdmUlgVEXG1g4Y7Ff/CfaiY563AZru5AMQkPtmgNMyzgufUjMIFbvQpOlGVnMdYN/
         YnY/ShG8rG/fLHmalhJLofc4I06yhH5qC5YiI2T2CxKFm2IbVQqAaUB7uxl44ssn/PPR
         LbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486565; x=1724091365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+8MbPRCb0YozGx78yHpevgqK7LlyJSrraSWxDfDgOM=;
        b=RQ59qACg+Im3Of5ybvcPcuHKDqk+MjUrgIGWWuXVlr0O624IfVZdO8EiNDhJl5ndqG
         iAGdNq0EXm/y8skymMq7Pk5PtH93RuLkc7KdTvV7Gla/l+8HhftKBh6nTAb7cqzjJ4Cz
         6H9a7rmJvUOunyUeMyeo30Eg0lAlXcv5CpNo0NZIPjFntZ8I+aBHogi8UedjmE/V1IpY
         ldLdPbBwLs2D/ReMR1t0xlDjY8WAUQb90bDlZIbxQzx+Oxnbl2TsDQEDm8z+rHUGGjbM
         oZ5eEsGLaKYdFZ6ifnosacVenoYQ3dmcNZtDqX1RoaLLpQpRNBlwJrO2g4nzmH+GYuha
         5dHA==
X-Forwarded-Encrypted: i=1; AJvYcCUf+7uw+iHl4kIT8UFSbtO20dkPZ98c6yXMoqCMtFlAih27bfodMl3OoOVHw8/4Zwb+kemwQhNd6fQuYrGI5IYdA6AAvQWYw9kB6A8=
X-Gm-Message-State: AOJu0Yzatmh1l1AEjKGP7wy/sKBZxlsWdZhRu9rxI+Enogq1noeWho1D
	CfCS1yLmRg96bsQvW6jxEXIgJYPZOFo005236jjbzdjJZssyRHT/89UuZh2QM4eo853omv9W/11
	cg/e5sU8JCVuuz81d+Nc8yVUN8K9vUcy0eR+y
X-Google-Smtp-Source: AGHT+IExKlU1NFFrFQYmtgcScdYfbBmkxO/ooNiafkX9LH+DZEKBJ9sd9KmyHU56XLEJx2YRHqMLA6HPRgVez8rVI2k=
X-Received: by 2002:a05:600c:3147:b0:426:6f81:d235 with SMTP id
 5b1f17b1804b1-429d480c135mr10690545e9.15.1723486564807; Mon, 12 Aug 2024
 11:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com> <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org> <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org> <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
In-Reply-To: <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 12 Aug 2024 11:15:52 -0700
Message-ID: <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: MANISH PANDEY <quic_mapa@quicinc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Qais Yousef <qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>, axboe@kernel.dk, 
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, 
	linux-block@vger.kernel.org, sudeep.holla@arm.com, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, kailash@google.com, 
	tkjos@google.com, bvanassche@google.com, quic_nitirawa@quicinc.com, 
	quic_cang@quicinc.com, quic_rampraka@quicinc.com, quic_narepall@quicinc.com, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Dietmar,
[..]
>
> So the issue for you with commit af550e4c9682 seems to be that those
> completions don't happen on big CPUs (cpu_capacity = 1024) anymore,
> since the condition in  blk_mq_complete_need_ipi() (1):
>
>  if (!QUEUE_FLAG_SAME_FORCE && cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
>      cpus_equal_capacity(cpu, rq->mq_ctx->cpu))
>
> is no longer true if 'rq->mq_ctx->cpu != big CPU' so (1) returns true
> and blk_mq_complete_request_remote() sends an ipi to 'rq->mq_ctx->cpu'.
>
>
> I tried to simulate this with a 6 CPUs aarch64 QEMU tri-gear (3
> different cpu_capacity values) system:
>
> cat /sys/devices/system/cpu/online
> 0-5
>
> # cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 446
> 446
> 871
> 871
> 1024
> 1024
>
> # grep -i virtio /proc/interrupts | while read a b; do grep -aH .
> /proc/irq/${a%:}/smp_affinity; done
> /proc/irq/15/smp_affinity:3f /* block device */
> /proc/irq/16/smp_affinity:3f /* network device */
>
> So you set the block device irq affine to the big CPUs (0x30).
>
> # echo 30 > /proc/irq/15/smp_affinity
>
> And with the patch, you send ipi's in blk_mq_complete_request_remote()
> in case 'rq->mq_ctx->cpu=[0-4]' whereas w/o the patch or the change to:
>
>  arch_scale_cpu_capacity(cpu) >=
>                             arch_scale_cpu_capacity(rq->mq_ctx->cpu) (2)
>
> you would complete the request locally (i.e. on CPU4/5):
>
> gic_handle_irq() -> ... -> handle_irq_event() -> ... -> vm_interrupt()
> -> ... -> virtblk_done() (callback) -> blk_mq_complete_request() ->
> blk_mq_complete_request_remote(), rq->q->mq_ops->complete(rq)
>
> The patch IMHO was introduced to avoid running local when 'local =
> little CPU'. Since you use system knowledge and set IRQ affinity
> explicitly to big CPU's to run local on them, maybe (2) is the way to
> allow both?

Thank you for doing the experiment.
I agree that changing cpus_equal_capacity() with greater than equal
check (this is what Qais had in his v1 patch [1] ) will allow both.

[1] https://lore.kernel.org/all/20240122224220.1206234-1-qyousef@layalina.io/

Thanks,
Sandeep
