Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC135C19F
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028769; cv=none; b=SngVsEv4NWKrg8ZSB3oVdskjZtO0+pnT8zWjP/5jgTZhay+472MKbolB9POCjQ6yT83fC/AZT7s2YCSSUH5JGFbBOgKhiERzqJqCFvyqh8zyMtldWi8DIv2nP22QOnNPvAJGS1YQqMV3XmiQZiS32K96j9zQNKfJNNtN/K1GGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028769; c=relaxed/simple;
	bh=JW4SKwS9Sw6yTBXBo9sFe8ouOcRn4MEMwBkrwaQ4RB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2aQmjdEKtBHZsjWM3M2wPoDbqBwbeREHQ4MIoYWoc4grQ8L4j8KrPGlPMnZ8CUwaQvsuvVwFwctteFYcYI1c+Qk3dQzrxTq6cDuE/bYx3/ZQt7OVxNrQa1UCXoets06/5jfcumaINMutHBS1EAhnz9ndq6ne/WEifLYDP7ibBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAvoqXa1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAvoqXa1"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-472326ca506so3429652f8f.2
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028766; x=1784633566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXVTwIzWV4cMwvPDxnoNwAyB741h/M12a9/WAB/GHT4=;
        b=mAvoqXa12w5a9DWTYhc9WvB7EJLjOS6aPW6Yf+iYxxFFqEqVwadlEFH32yCmi/Ahnb
         Fb1z7agoPA0hgq1p4H8eOgYUyxmwg1k1gIp11wflJ4JIhQjYRQUHkhaBc910DauPel73
         1JsKuZogRlZjwndLp9eFjP+w5a1I/+5MM9dF9iI1EAfQ8HsUSJL/s/dHDfVbQ5ZUNfUY
         jD9AoC0Swd5xVfI3XvDvvbM3UZgrcqQNftylxDIAv+NgJfC4taUDQoPRZFo9j4FRoAQu
         2Rcu/ZhaucDJwU3/rsE9gt5dukYSFfjG/6rARMWoHiOLM0og54nl3jyttyTQUiWeDQto
         4/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028766; x=1784633566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXVTwIzWV4cMwvPDxnoNwAyB741h/M12a9/WAB/GHT4=;
        b=pH56UZDiP8gsIYLjFq7Uvfek571O7Yx1nubcPwgQjK9j6tr+7FN3EYrnqGGD6a/6GI
         KTbSIuVgbyIl3Zqjglhdl9QTba5Fj0ZSOVBKsYmwPaIRNokSV1MbRiATvHaQvxSMo4dP
         u/h0hkj8hMHKbEqeKTOmjTTLYNeZYVMTX+qaIyw3/w6S5d8TPSX4TxAD2b7iZ8BV1dqc
         B23YPnMkpqh77hoDc6E1wK19GXINLX7HL6ENxOdOHekmJYHIOvq3EPegpl603C9Y3R+0
         uhDSrsl5Ufq0dkNhaFcj2lm/ifwAnOKDFqVX8RBMTp2uknEcAqHl6tkLYGYXlM3BwGx4
         Sbiw==
X-Forwarded-Encrypted: i=1; AHgh+RrRlVV+6YOC7z3wMIL+TrBpUDG/CywOLJb+g85MVGyUnnUc0knmrdx9WGz2qLpFm2B3bIZcyTEF6oL5Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyItbRNR8FsCJq8Qjbx6wm7XvMRWsGd55dgUaZRWJmM6CeIgfIW
	48t7yI7DQE6ljfFJn1sH3lpK8Y2Bgay/HgTgu1jner8AxRC8RtzxnLeX
X-Gm-Gg: AfdE7cnhb9f2KHin3pxwxvJa0y4OA0CpE6z2iw0KOyUI5zQtr0nqdQQKpjM87PoRFMy
	UY3vMJgjdZqRB4dt0c4O3qy6NjF7iOFCf9A8DqUGNNWFRHAAIoryyarZwHdUBnMnXhf5IzCppkB
	/zaLiU2IW+xlW9b1Iq8Mj0wgDkWPJPM3YM00T0rD9Axvk16EZ6CFnUKa28VVdeIfNy+Dfq88cRn
	hghZZcA9kK9ga0DzcW5Z10zovpIoDgn2ksFG9okErL1TL1xfrDV+jACRTOi5tv7EXr6SEtKFLjg
	fbnIEamuieao05yUxvZBTbMnKketMevRVeabVDsfUjjhDmUoftwMP4fbDZ/vDt7sUSqdnYbmxA+
	QcUgPrz+41Z144O2NS+roMtaNLFxZXofHWRPHyX3CDCYox0G1NDg6LQtGmRFZNNuHXlMaIUr1ch
	YbVNPyipppuOeQ+MVqoV29CpYoMdC9GCz87MIvBZXkdjbN/MoNGw==
X-Received: by 2002:a5d:5d89:0:b0:47d:edab:1b4e with SMTP id ffacd0b85a97d-47f4632fcb7mr4290530f8f.8.1784028766331;
        Tue, 14 Jul 2026 04:32:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c7c96sm7312549f8f.33.2026.07.14.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:32:46 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:32:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] blk-throttle: avoid ilog2(0) in
 calculate_bytes_allowed()
Message-ID: <20260714123244.69fbec98@pumpkin>
In-Reply-To: <20260714103028.1334831-2-cui.tao@linux.dev>
References: <20260714103028.1334831-1-cui.tao@linux.dev>
	<20260714103028.1334831-2-cui.tao@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 18:30:27 +0800
Tao Cui <cui.tao@linux.dev> wrote:

> From: Tao Cui <cuitao@kylinos.cn>
> 
> __tg_update_carryover() can call calculate_bytes_allowed() with a zero
> jiffy_elapsed right after a slice starts. The overflow guard
> 
>     if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
> 
> relies on ilog2(0) == -1 (fls64(0) - 1) to stay below the threshold so
> that the subsequent mul_u64_u64_div_u64(bps, 0, HZ) == 0 is reached.
> That works, but the ilog2(0) dependency is non-obvious.
> 
> Add an explicit early return for jiffy_elapsed == 0, which is equivalent
> (mul_u64_u64_div_u64(bps_limit, 0, HZ) == 0) and removes the reliance on
> ilog2(0).
> 
> No behavior change.

There is a pending patch to make the x86-64 mul_u64_u64_div_u64()
return ~0ULL on overflow to match the generic code.
That would completely remove the requirement for the overflow guard.

I can't remember why it got lost (again).
There have been arguments about what should happen for divide by zero.
Personally I'd return ~0ULL and let the caller decide what that means,
but the generic mul_u64_u64_div_u64() goes to lengths to generate any
trap that a normal divide by zero would generate.

	David

> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  block/blk-throttle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index ffc3b70065d4..f37911abefdd 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -603,6 +603,10 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
>  
>  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
>  {
> +	/* 0 elapsed => 0 bytes allowed; also avoids ilog2(0) below. */
> +	if (!jiffy_elapsed)
> +		return 0;
> +
>  	/*
>  	 * Can result be wider than 64 bits?
>  	 * We check against 62, not 64, due to ilog2 truncation.

