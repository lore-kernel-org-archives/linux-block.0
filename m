Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE02FE59B
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131108; cv=none; b=LmXFhKswzEjciB+ZbvoSO+grp0fL8So7y5g0KGCJnbAukFo++Ibgem6VDkqZK+YPJRmy+IF2UoFlMiCnLlovW6o9/NwsSfZ0cwqQSc18kOjYwZavrhT8Fr3Nz02WWLDMZf6HEDOX+IYdAmXnLIfH/NSQI+bXYCLI2vGz90/4Eec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131108; c=relaxed/simple;
	bh=5iuf9C0YYWH1kYthHU1g6tXfYZEX/0Va1SJRCSVmapo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y31I19MieJ7lkC+Pfc2H1V7iPnU8MXFUxXlYwV2l5MIVFxXreXF6WI6esyvz0P1w7WSSLiaxOBDmJEvHvG/EU1mgGjeGlFfJnYna1NMkE5lIcVR3Vz+5haa2Hw90dkRXKrNRjYA0NY26N1PPXn8RSra2mAMPD6zJHEjmTcdhEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=m+2QQfTR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="m+2QQfTR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48909558b3aso4481545e9.0
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778131104; x=1778735904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6Jp37zhxwN3XqSlNZKdzsgEkelv6JcJbmHDb1v+eLQ=;
        b=m+2QQfTRPK+8nVZukod2skB5Qjxacizbf1VElJUod+Axh9YvEKuYhnHBMRZy/Nl6IH
         g9Pm4vG9ldkccU4q4YwA/BqvP+AzmYDsTelho7gKZsfWrj5w4xWv1M0SVW4CsyEUZkK7
         D686iptwOKy0Jwq4HbGpbcd0Awmi99w+Ic6y9KPlEqPqbzLfdWm55fWuYweZTykT1q/G
         dIpuD2r9Tn1SwS5IBFNtuOMaiVg56L87gwX0KDkDafHNf93kNTUn7gpk43sFHriJR12I
         hmfujgnXxwGzMlH45/6Vh4R5BQPC5iVfucB32N4qfQftIM9VymNenMfYlIovckqGrQPN
         dTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778131104; x=1778735904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6Jp37zhxwN3XqSlNZKdzsgEkelv6JcJbmHDb1v+eLQ=;
        b=dJ9xiWyPrDHzHTMrwmWN5vs0XoxqfPV7c1WMSnJHX1xrw5DpzGXpbtR/ILynfU58Bd
         FAZl/gc8eeAHdCZxNX8zV89bJf8W1xBie3ZHk/1ptN8cE89ZQqLElV4SPhNgo0/w6TjK
         P0HrVy4lNwApRrKD4rVCT9LbvEY6zkEHQ7XBXRwPL5jGnvjbOSOaDMoDzPTxvULjlI33
         zjmeCbEN5ygVa9gnrAs/VFfk0n5M7xMZP1cOd1I4F/X7RCKhes+8q1f4D8izR3kJLyPd
         p9q+7GZyUYrNHOBiiThdhnz2HX+d2FLBqtbMcs0PoY46kzyZTR+YLw9ZvwIL4uc2KGdM
         xO1w==
X-Gm-Message-State: AOJu0YxQkjJcdh3GnhoyNIbcgKLIi+bfDKrcozRPy09vwngjouXe265S
	GmhV6sBke6EzyqSAiGQRUdHUswF0bOWsDsAjNhmF1s9dP5uWjSKZvLOer98b7GCAYIo=
X-Gm-Gg: AeBDieujRtlFZi3bGwBbZxyqlD85kQhbym9jNYDfU/cFlHZRhfJQIuoC21HyKLiVEmA
	rHYg5sXGm8W1686jWvLHrpXhKtNQfyxR4ze9NVRkONEZvf0Yba++iKa+jIPTayQgBHzXDgxp/6i
	HYi/8PJifEQ/8NoBqgyznB6pNQYCmMLftf4v2l4R70obMLoyQwbrQquKnhQaqT1FBoHNqVIsIz4
	aDkcD2t/a7dB6D1uuRyt4qMxUn+wrqfsP6lI63QT1/q7k39fgLQt7fcBonNFYj5L4Q2ma0z4aBZ
	LB+q+ETqhx8YXIUZWXvH+lm+b08Nr08lo/YOCt+AH4OD+HH3Po6uDKKOqkWlC5G7bmAwW4Hf/iO
	QtR+1mKdSkc+fYVgCEg4dZi5vaR+6Emsedy7sc8gJby5JHA2a7ZcUYX8+tD96cDrJp22bpqAdYf
	enEebr49fOBl+Zz4qsXW9TqwvbsgP6aiUZnctIacNtM6Y5DAgBrwaRw5mm87hQTM3mdgu0O1LG2
	2k5EfXM79BsCLNE4tKWnnSToeM=
X-Received: by 2002:a05:600c:8b08:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-48e51f32ca9mr107828255e9.18.1778131104293;
        Wed, 06 May 2026 22:18:24 -0700 (PDT)
Received: from [172.19.1.192] (213-209-180-188.ip.skylogicnet.com. [213.209.180.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538c4ae1sm91729575e9.12.2026.05.06.22.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 22:18:23 -0700 (PDT)
Message-ID: <4e9e8eff-b619-4062-9783-511d9771abc9@kernel.dk>
Date: Wed, 6 May 2026 23:18:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: add NULL checks for bic in bfq_bfqq_save_state
 function
To: yanlonglong <yanlonglong@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai@fnnas.com
References: <9face7b3-d4de-474f-8948-d8efde02bfc8@kernel.dk>
 <20260507012826.1535-1-yanlonglong@kylinos.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260507012826.1535-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/26 7:28 PM, yanlonglong wrote:
> When the `bic` variable is null, referencing `bfqq_data` through `bic` will
> cause the program to crash. Therefore, the null check for `bic` should be
> moved to the beginning of the function to prevent referencing a null pointer.

This part is obvious, what really needs explaining here is what conditions
can lead to bic being NULL, as that is supposedly the problem being fixed.

So, which conditions lead to bic being NULL here? A good commit message
should explain the "why" of why a change is being made. It's obvious
from the code change what is being done, what is not obvious is why it's
necessary.

> Fixes:fd571df0ac5b("block, bfq: turn bfqq_data into an array in bfq_io_cq")

Still incorrect, need space after Fixes:

> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 141c602d5e85..c8cf8764d48d 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3036,7 +3036,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  {
>  	struct bfq_io_cq *bic = bfqq->bic;
>  	unsigned int a_idx = bfqq->actuator_idx;
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
> +	struct bfq_iocq_bfqq_data *bfqq_data = NULL;

Minor nit, but why initialize it to NULL?

-- 
Jens Axboe

