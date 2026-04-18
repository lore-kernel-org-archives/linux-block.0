Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D137F73E
	for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776520719; cv=none; b=Y5yy3V0BZZrW/i6qgCQxVvjCsLs+fujUy7BtM1tg1uu+xvQZjkhY7VSQQqD8ATNuOPZmtW0POfEyav0YmiUpQa97q2MJ1zCZLvWbZSJXRtPF4ojAVGfh9nmwoiI12Dx3j+NZFs8rq4R611khQkYPJJ5kCbUifDPtidouK3uSnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776520719; c=relaxed/simple;
	bh=FmGT8sviMUmQz6B+64HOLENp2S/l7PMC67SXDN1LTYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDyUeTXUOEo6meVCupEb8VHy2WS/SDvQM5RUZr4+rGn7YC2yay7dYJjT4HRIrK1quvOTyqVguW0/krPl0UNFpZpu/fqkTzen1g1Z6ra/DDw4MOd7U2XYhiK216sc1EFbAJtpHSzmbiKZkozwv5BMIddR7rR2X80iaovvTPtT5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HsuKaCW1; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HsuKaCW1"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4152698e745so723211fac.1
        for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776520715; x=1777125515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4s/9dRVcdsPjUGW14AbSFb9ABr1Dapn3OeNb8bZYUc=;
        b=HsuKaCW1pgeiHw+3LUQdZwkzcdHhSZ2moKQYERUJH/8gxfmpbuwtWBwWi9zE3/a/i0
         4iY5ZUCf+2VjjTmNUqr2Xy+3KYIQ6ZZ72IQwU2TSQJPdpH155llaJ3ENEPTrSErOAL72
         RPFddIESbHVueWEb5ZnsCVa1t8+q4kffHkk6Zm6VNAWW/OLeUiuuwsZAZ6emWqrL+iVy
         oJor3P6zxfYamN7fevcqYYuiSGrTXD9ZrPguUzftsnNz/GNI1VBOS7IXOXKqS4lCirFf
         tBoimq1ft8W/7lzvy+WH1VeMFqLmOG/PvT1cc3BIpvXJ/jwFaHzdutALv3484bWkPSDK
         qSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776520715; x=1777125515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4s/9dRVcdsPjUGW14AbSFb9ABr1Dapn3OeNb8bZYUc=;
        b=B4cfJBh1NnSIEZu53ZZ1jVsQst9FDDPzhiUh4IZ3sRkqVx/8TRgc8vG/+FpOamfghv
         UOOj1ToEZtOkAYU3TANdZXY0KazY2TJ6wVqocqL1X3o3ZlHjauXpU2ucq60wRFCxiJtP
         3W9M/kqldmFLuv6OyZPEMcsp8Ou6NiBMueFjcIiRK9oAfwB7XhBlNE2TR+HIt71FDx8F
         lO0RoukpH8N0TuikuRFkuuxaAfy8gra3XWBSrzToPmOa2nz3ySBQo+bX8chpYSK47+AO
         UAi3prdwXVSLMUyMDN/xxk+hzTb0q1xrNO2inuVVvTaCZyEqxSQxbTsKLcbvwLBnQdE6
         4yAg==
X-Forwarded-Encrypted: i=1; AFNElJ8JuLchI4hmWERr+KkHk49Ib2wHDtJ//lyGJH1BdybYAbXyhOkcEhYyJ4YrDHmPS6jnb+KHFT0vk4Nhtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNzHzYJl9mumWzk0Ka5W/sJABU0PrMVXVKhQBDdRGsFBhkVDF
	BSyLkA3q3v3XRKEPEGYD9HARRqxGh3TJ3ZEPP64O6hB0VB0tGq019Nys3Z5ui91j0C0=
X-Gm-Gg: AeBDieuUu1whUms6NxQHuaVqc4yn+Gou6B7EtAXtGm2YwFPspmkB9PE9MmA73rX1T9h
	zpsh/KbirUZTcXyyRRi6V7hMbakHI03QaOdoyAQ52RyX3HNU1/7NL3lr0R19406GY6zBQMu2o6k
	96r6C/mmGyC1b7wtNkLHUDyAb51bk9NB67S76Q0+lPY2UKj/c0Gaqeovt0qztRf94flAxmE9l4X
	Nn5lsmrI7SkHn/5GPzeLeRxaClJkRZPykhOG6ff77k1lTYtPl6oWH5C0v62hMLcMXK5t7OjU96F
	aGJ/id+HXEE97SmIlgyhuADnQslRg0Il0MWcqET+wGOnrp1QsONq6+LP5VklH6v3iua9PVOjpR7
	SarRgs5iZx6IUyWEFNN3DvCauk/wIDh+wEtzvlTOrhQZR3Nj1xqpqPdpLc1fD+sS5rfl8qWVz03
	x+U6ZWvyAJTFIVfu0aVynIqLYqafk/AsklVJd1wkDk3BsmcY4gDAA4XlLBLyiBXkUbgprsnV4Oz
	D1JuD4ygDlDH7tcX5Tl
X-Received: by 2002:a05:6871:3607:b0:423:f59:31d9 with SMTP id 586e51a60fabf-42adecb0c3cmr3902134fac.22.1776520715561;
        Sat, 18 Apr 2026 06:58:35 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9acc056esm4113736fac.17.2026.04.18.06.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 06:58:35 -0700 (PDT)
Message-ID: <90eed72d-d097-4dc6-ab90-6f08e14c57fa@kernel.dk>
Date: Sat, 18 Apr 2026 07:58:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nullblk: main: use lock guards
To: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Cc: Ellian Carlos <elliancarlos@gmail.com>,
 Gabriel B L de Oliveira <gabrielblo@ime.usp.br>, linux-block@vger.kernel.org
References: <20260418043837.721045-1-ricardo.kojo@ime.usp.br>
 <20260418043837.721045-2-ricardo.kojo@ime.usp.br>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260418043837.721045-2-ricardo.kojo@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/26 10:38 PM, Ricardo H H Kojo wrote:
> Use guard() and scoped_guard() for handling mutex and spin locks instead of
> manually locking and unlocking. This prevents forgotten locks due to early
> exits and remove the need of gotos.
> 
> Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
> Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
> Co-developed-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
> Signed-off-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
> ---
>  drivers/block/null_blk/main.c     | 74 +++++++++++++------------------
>  drivers/block/null_blk/null_blk.h |  1 +
>  2 files changed, 32 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f8c0fd57e041..fbe34e8a6c93 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -423,9 +423,8 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
>  {
>  	int ret;
>  
> -	mutex_lock(&lock);
> +	guard(mutex)(&lock);
>  	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
> -	mutex_unlock(&lock);
>  
>  	return ret;
>  }

If you're going to use lock guards instead, why on earth is this not
just:

{
	guard(mutex)(&lock);
	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
}

?!

This odd intermediate state you opted for makes no sense.

-- 
Jens Axboe
