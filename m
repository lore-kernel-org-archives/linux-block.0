Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768E35E1D7
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948456; cv=none; b=WHWBxXnSsuCtP/m7u7LY3zn9LdWfQzcIQFfqVbW+fjp5SF8UJz4G/Uus+w1y7eV4OASsnwckfAKvmLWCxpSn9vZpNi4Tt9KIfb5RauXf0zqli8oEZpOFP2g8MvVvenR6rAx3zmWI7drNKy9jAR5UjWyM/Y5c8TbKMNI6rEpuaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948456; c=relaxed/simple;
	bh=HqFa8t0Mu0St/c7ueD8Wr857Xx6Rk9ijgm+fvHfiV34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9Bu5zQuzEFFEpE9RgQATjTcHh9S1KumZOr5xqn1v3z/LZmpXWBqT9SgOT9dXvQVR39IVgWrq6mlNfyR0dx0bsngH0xptDWJ9xU+SXnUN/xGHKQHsjOobxS9T+wD09+B5uc9zrQwfdO2I86nkHnS9RcgTznLsnDnJqLQPiPJBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Namclkn8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Namclkn8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c7ebfb63c6so9247135ad.3
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782948455; x=1783553255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3Kgk9bdMHQMKWT8xLRkESCb3V8jhwc8jniCVPFYClk=;
        b=Namclkn8tVk5w8zKiTa1BWq6+XqjNw147xchCigXAEHmLk/A2YjnVnBgSWk5x5JPcD
         7oCeZsO+oivng3qlR8bpwxFRMMBlQokPtIm6P5o88VGJlEV0dHwFHxxITdAj0l5jwejY
         HoLVV9plSzWpjzuG35n6E2Vkx+SgWPR/UHzwrwJW2pPg09I4ROWJKf5y1JTWHac06DMs
         d0dlx2OdhBWeN/+JbbedvHo3FYqvHFlkWSAbr4vSt7rEJe99fmKhx8D5t6bb9CALJKA3
         D/a1VrLvAaFNyhgDckCDuQMtqPWsg3ojwDDpeECfM0Tb2h8aGcaCBEvr7jhtg4zQ7m+K
         l9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782948455; x=1783553255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3Kgk9bdMHQMKWT8xLRkESCb3V8jhwc8jniCVPFYClk=;
        b=oD1EfHkpewW/MwYW/c8TpkZi+50jCXtcRJqP/qnZg6MZlfdB57J9XK2PHVZzYb/WYT
         n3d2+gZEJSZBpufQgvhiutXGpS8ZkCzHBiy9wDX22RPpfAtAjvARZ9wwdVpA72mM0yI+
         QMo+R6KbU3gbDIU5+8JnBc4S71ix9AntcWjNkE8+QqYnSKMfe8voLtqIkzkzHlPQ+Wn0
         KfKwsg47bT1sOF9DmmXjx/zlx3A+h6IbKiELwh8R6Bi+hMl42v0m9fMHGW1nTzSFUt1W
         mHgD4HXW10FyNO0Z1BdTCJZajmwped+ScrY8+Rdfva2Z3ad7vUJ4kxilrWqF3MZreGLi
         NPjg==
X-Gm-Message-State: AOJu0Yy6Jtq8ed0h+skU6Fd/SltLg7WFf+Adtk9ARz8z3pPMO+SZGcNz
	/5sdInqw68YlJB7qPTnaNRZx5PdVN7Lxuo3nFXP+NWc7YUAXcTUKC9RP
X-Gm-Gg: AfdE7ckqG40KkWVgRbqlAEsUMEwEDQ6MrHJN2f+DCFe4RH6IpuedqTxyS2EvG2LrrfD
	zy1q6CL1lmeF5S3Thq/yGg9PaEc8cO19bi0UD2xdSC3YmW1MsqLc1FZsW9mgaF0KBwpvRIjXVVN
	3GRjzZKEn500PJ8J3N3E1MxE1mxjYujHbcLGx3evMKJBikflJcwxERmcgObvpfi1uOFNVv+VulQ
	JIm0P9CrqZ3S3gqzpndVA0habd9MlJzaesSCVWQdLZE184u7ml0gM09x+VCAMzPhnY6W5Eo9mFz
	WS6EEjXeXTBGdmL9OA0aGQp9/KU2/kkDVJOJE6h0PPts8Obmb88+PVA3gmqu+FRdBk8Cy27OOpu
	Meh3YUnx+LbzdaAH/ujd0clQ2np7NF6wNTpoTyMGEiv6qzw+gLcfRgwR92fVvbN0HQ/Cju9M+C/
	QzFY/OZWjYzpRW5xDqGJVYWqe81iIJ7AE=
X-Received: by 2002:a17:902:f650:b0:2ca:6c8:abd4 with SMTP id d9443c01a7336-2ca911f336cmr27682945ad.34.1782948454275;
        Wed, 01 Jul 2026 16:27:34 -0700 (PDT)
Received: from [10.0.97.160] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9e9792sm4794115ad.58.2026.07.01.16.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 16:27:33 -0700 (PDT)
Message-ID: <980612c3-ca06-423c-88af-e69d00e770f9@gmail.com>
Date: Thu, 2 Jul 2026 07:27:31 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Make WBT latency writes honor enable state
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260621014030.1625306-1-guzebing1612@gmail.com>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <20260621014030.1625306-1-guzebing1612@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gentle ping.

This patch addresses a case where writing the current default WBT
latency to queue/wbt_lat_usec returns success but does not enable WBT
when WBT was disabled by default, for example after selecting BFQ.

If this is intended behavior, then perhaps no fix is needed. Please let
me know if I missed the intended semantics here.

Thanks,
Guzebing

On 6/21/26 9:40 AM, guzebing wrote:
> From: Guzebing <guzebing1612@gmail.com>
> 
> queue/wbt_lat_usec controls both the stored WBT latency target and the
> effective WBT enable state.
> 
> The old no-op check skipped updates whenever the converted latency
> matched the stored min_lat_nsec. That check ignored whether the current
> WBT state already matched the state requested by the write. For a queue
> disabled by default, attempting to enable WBT by writing the default
> value through sysfs could return success while the enable state was left
> unchanged.
> 
> Treat a write as a no-op only when both the stored latency and the
> effective WBT enabled state already match the converted value.
> 
> Signed-off-by: Guzebing <guzebing1612@gmail.com>
> ---
> Background:
> 
> The issue can be reproduced on an NVMe namespace when BFQ is available:
> 
>   echo bfq > /sys/block/nvme0n1/queue/scheduler
>   cat /sys/block/nvme0n1/queue/wbt_lat_usec
>   echo 2000 > /sys/block/nvme0n1/queue/wbt_lat_usec
>   cat /sys/block/nvme0n1/queue/wbt_lat_usec
> 
> After BFQ selects the queue, WBT is disabled by default.  On a
> non-rotational NVMe namespace the stored default latency remains
> 2000000 nsec, while the sysfs file reports 0 because the effective WBT
> state is disabled:
> 
>   queue/wbt_lat_usec = 0
>   debugfs enabled = 3
>   debugfs min_lat_nsec = 2000000
> 
> Writing the default value succeeds, but the old no-op check skips the
> state transition because min_lat_nsec already matches the converted
> value:
> 
>   echo 2000 > /sys/block/nvme0n1/queue/wbt_lat_usec
>   # echo returns success, but:
>   queue/wbt_lat_usec = 0
>   debugfs enabled = 3
>   debugfs min_lat_nsec = 2000000
> 
> As a control, writing a non-default value first does work:
> 
>   echo 5000 > /sys/block/nvme0n1/queue/wbt_lat_usec
>   queue/wbt_lat_usec = 5000
>   debugfs enabled = 2
>   debugfs min_lat_nsec = 5000000
> 
> Writing the default value after that also works, because the stored
> latency changes from 5000000 nsec back to 2000000 nsec:
> 
>   echo 2000 > /sys/block/nvme0n1/queue/wbt_lat_usec
>   queue/wbt_lat_usec = 2000
>   debugfs enabled = 2
>   debugfs min_lat_nsec = 2000000
> 
> With this patch, writing the default value after BFQ default-disables
> WBT also re-enables WBT as expected:
> 
>   queue/wbt_lat_usec = 2000
>   debugfs enabled = 2
>   debugfs min_lat_nsec = 2000000
> 
>  block/blk-wbt.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index dcc2438ca16dc..953d400fd0137 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -813,6 +813,21 @@ static void wbt_queue_depth_changed(struct rq_qos *rqos)
>  	wbt_update_limits(RQWB(rqos));
>  }
>  
> +static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
> +{
> +	struct rq_qos *rqos = wbt_rq_qos(q);
> +	struct rq_wb *rwb;
> +
> +	if (!rqos)
> +		return true;
> +
> +	rwb = RQWB(rqos);
> +	if (rwb->min_lat_nsec != val)
> +		return true;
> +
> +	return rwb_enabled(rwb) != !!val;
> +}
> +
>  static void wbt_exit(struct rq_qos *rqos)
>  {
>  	struct rq_wb *rwb = RQWB(rqos);
> @@ -1005,8 +1020,12 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
>  	else if (val >= 0)
>  		val *= 1000ULL;
>  
> -	if (wbt_get_min_lat(q) == val)
> +	mutex_lock(&disk->rqos_state_mutex);
> +	if (!wbt_set_lat_changed(q, val)) {
> +		mutex_unlock(&disk->rqos_state_mutex);
>  		goto out;
> +	}
> +	mutex_unlock(&disk->rqos_state_mutex);
>  
>  	blk_mq_quiesce_queue(q);
>  

