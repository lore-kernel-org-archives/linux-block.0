Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE6443E4E
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567146; cv=none; b=kwz0W0EnhkGO6h/QdUnDxVF1Be2VCBU2F0l4Ca/BrrNbwL82FQzOVkOH6aZvDSKo+/rKHwgWKsFOJ75/7aBu8eMfBmET1/SAb+IysWbooblXJs8rZA4HIt6o02xgOVdVahvYib/4+BhBll07GwnHiY+zAySPN7qidfTrbdCDwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567146; c=relaxed/simple;
	bh=EPHXgE92OZtwrusVZTpJimPa6PHp1mjxA6Q2dzygXUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkBsSPd1uULx5Q8a6tq4s7hU9YWbIhvJaIqzeLENP1mXy18ZQQGLucv0QcRHjOANmtmFXVUgTIz704tz90qEdUP4j0/I2BgGJyyqeaebQcYN0a+gnTau1HMvyQNp9Yp54okDsRYAbXkOBiTMXOyutgOysH3ph4fbdL7PY5DBCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO5m1tKv; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO5m1tKv"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e8fa1b8d6so104462747b3.1
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567138; x=1785171938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqlMGabo3ObXGmn0thsIH4WBoZJD0hx7su/ezzAUMj8=;
        b=FO5m1tKvKY/aP9evleF+whRzKapro7xwpXTfGXXNFizkcZTJJYzjp7TrdtyJpzms44
         wEGW2ZSDLx2S2MiuDVvCk8mnjw/9LYB7guNFDmTc98T6KeIw5Zkd/f66x21agGOP8vry
         PovdbWeDQP3x+5VmgeCTa6UGAq4ANHuXSzvk6csHEpJNYDqFVYt6l9G+cAfj8RDzIunb
         Su7DWx3/CycylC+5AaLNtrwMDvbYMDdFmLddLDVLrsVdtcwiczCMsbgYdwLtlx4XtWdi
         3GILtvxicmAALWa0xztdyfuSXYXS0w/qc0ANr5jAvgXxedXmG7ptBY0fwtDISIKwezA1
         y9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567138; x=1785171938;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqlMGabo3ObXGmn0thsIH4WBoZJD0hx7su/ezzAUMj8=;
        b=AsHkXx+Eeathu8XjsUuN/dRu9pZJMyJL1lRJlkzR2woBiQfoEMLEkMcTdeTnax1igq
         KkkOPzQa/rqPvGJ6NGIhyCALHY//HS5hruiFBHJ0FpADsffWi5yMViAdywn+nRQEiG5O
         1BvkQ6UsDHOLXONOnClNKVCwa1e1El0+NpSwJ6kFMGxBoNizo8vSviV66sD5FhIJR6kd
         ZKwaBHYHF3S8Dqn3BDTxgAjOTc3SpaSSA9PsZ+I4XA+dYKd8qWbc41sxNf5o1xDzcD/m
         FWLVv9PYg7xuujQtoVlypfWWX3Z9r93El2RkzyjoI01677cNQkoeuH+4x5jbEmsVsw/M
         HjqA==
X-Forwarded-Encrypted: i=1; AHgh+RrQnz76j9XnpluMrlRmNyzSTWTxuAXLhAojDCQmVF6IDXFmUtFB5W2lnt1YLGkHIEwf8Hr2Elr//iBlNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/ZtOjy0XnsbylDO+fowKcbA+kO+/noOGML9fAiwx2qaIrz+1
	zEQ8JxFMIhEKxXgMgYyiHYUkVhkVfAWZJhfxZipq7QtjTWE/Wpl9rDE+
X-Gm-Gg: AR+sD113ZcSJ+2kpvIMgrtphhPZVJ+wIwZiVWYqx0+3g4npCGoldMlIqkmkBV9fs7Om
	8mVexou92xk2P4imHV4aqy8GIn6fuiZBbti6oRBtWZgJd+uDme3GK+snJYCwFcu2ggxBqn1ReGE
	vQD69GOubGkizQYvAx5mANSUTXnXQTtbSODVBHWdeJVtONcaDLW6UJ+oMjR1HC+AwPiEg0VIfl4
	dzkb1yZQ96FTsxHjBhly3oHIrEk4CxKMFBIu/NzO0ZEvUAsSxhzkefd2KQBdYXAErSDOw9XFPPI
	45RIn5RLqsazQDcTmzIRTXAuaRvklui9T6c15KBd7fVcFiI+itWO3lsST9cUAZ6TXOBFLA8RFax
	Dieuh4p4134sNg+eqh+0Q/Ag1NOQCfFPSMyD+8MQN+4D5T/uF9jkkGQB7BPL7JOiGvJSLrgR4e6
	7vQPZdhvFvY+GEalfmWfqU
X-Received: by 2002:a05:690c:4b0a:b0:80c:5ce9:8f1a with SMTP id 00721157ae682-81ef27f1ccbmr48967227b3.34.1784567137799;
        Mon, 20 Jul 2026 10:05:37 -0700 (PDT)
Received: from [192.168.0.23] ([210.10.76.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4034901sm53073037b3.12.2026.07.20.10.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 10:05:37 -0700 (PDT)
Message-ID: <296cbf18-86da-4c1b-832d-a27a78881dd8@gmail.com>
Date: Tue, 21 Jul 2026 01:05:31 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/blk-stat: fix mean loss when re-summing aggregated
 stats
To: Tao Cui <cui.tao@linux.dev>, Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Omar Sandoval <osandov@fb.com>, Bart Van Assche <bvanassche@acm.org>,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260720133813.45150-1-cui.tao@linux.dev>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260720133813.45150-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/7/26 9:38 pm, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> blk_rq_stat_sum() folds src into dst but only advances dst->mean and
> dst->nr_samples, leaving dst->batch untouched.  The mean is computed
> from src->batch (the raw per-cpu sum), so a stat that has already been
> through one sum carries batch=0; if that aggregated stat is then used
> as the src of another sum, its samples add nothing to the new mean.
> 
> iolatency hits exactly that: iolatency_check_latencies() first sums the
> per-cpu stats into a local stat, then sums that local stat into
> iolat->cur_stat.  After the first sum the local stat has batch=0, so
> every later window drives cur_stat->mean toward zero.  On non-SSD

Good catch, this is indeed a real issue.

> devices it stays at 0, making the latency_sum_ok(&cur_stat) check that
> gates scaling up always true -- the scale-up hysteresis is effectively
> defeated.  SSD devices use the percentile path and are unaffected.
> 
> Keep dst->batch in sync across sums so an aggregated stat can be reused
> as a src.  blk_rq_stat.batch is internal to blk_rq_stat_init/_add/_sum
> (no other reader in the tree), so the wbt and blk-mq consumers, which
> only read ->mean/->min/->nr_samples, behave as before.
> 
> Fixes: 34dbad5d26e2 ("blk-stat: convert to callback-based statistics reporting")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> ---
>  block/blk-stat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-stat.c b/block/blk-stat.c
> index de126e1ea5ac..4d4781350083 100644
> --- a/block/blk-stat.c
> +++ b/block/blk-stat.c
> @@ -36,6 +36,7 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
>  	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
>  				dst->nr_samples + src->nr_samples);
>  
> +	dst->batch += src->batch;

This change doesn't actually fix the issue. As you already found, the local
stat's batch is 0. Also, according to the comment of blk_rq_stat_sum(), @src is
a per-CPU stat, so there is no issue in blk_stat_timer_fn(). Your change would
actually make this case look strange.

-- 
Best Regards,
Yi

>  	dst->nr_samples += src->nr_samples;
>  }
>  
> --
> 2.43.0
> 

