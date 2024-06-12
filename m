Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99017B437
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211277; cv=none; b=BqlyeEG6JV1I/Yeav2n1aI1TqcdKTKktqoPpwys347kL/4M/qyCJPYii0qTtKcl70DXuob/EzZk0g2kBLwFfC7q2nuOIrydG2kuQ/7MaGfSU1ZskGOPQ5T8MMnUwYZS8kTz5amfZHWRSLIROhTwMHQxSHsr/q6zlAato25kelCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211277; c=relaxed/simple;
	bh=1thz6tnKYh4W3UTSkm0UIqpLg3cHhFT9lD2SEIdOi/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCJQvnlKz4Nx0+1+S42hxK76PSK7Coa6vFIjyEq8215TDgN8gdcKBM5qkohd9yRpzNK/dHCqKOYuk2OVmn754Vi7ixrlYcU5HPw+wW3LYW+dJZaQvMcvkMON+2cKZqdV0P0w8pcx/yoCjUD7YmV61zUsz9v/tvNtKCmFU4QFwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QvZReln7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QvZReln7"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d21bba1f0fso173755b6e.3
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211271; x=1718816071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auZ0CYhLHHpQv2x9Ok7hNHgDuK+aHHonoO28jfXMPus=;
        b=QvZReln7r68NLkOTDgHWwJzHAQIaTsk73QqqpzeSsyWy9AnHX+yyVgR8Xyqsi1ONlq
         ZOpBOXgInNueyYB0WcyfSiemEW4DOwt7zufFeo5hGm8/zK5dMobj2NA7dvxc+TQw5kDZ
         WLLlSYNBg2CjYVjgTma+bHZMCcPGleDq2Js8a5IhB6GPTWiIg5xffaSiF4w6QsWtaxvg
         IklMz9JCxAXj5+bz1z1hZaEOPQyr9YbcY+s5UYn5HcXZjyo0jwywp/F8x3cyPjw7hsWh
         HJAVakPnbicQKlt1F0nyXLohZWLy5BZ9TzGsdTeuicjDAkJGZ5kF65kllaFO3g2Yf0R4
         PC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211271; x=1718816071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auZ0CYhLHHpQv2x9Ok7hNHgDuK+aHHonoO28jfXMPus=;
        b=prSfACSnEtLpM+18q9T2w+FXlRintYodmLH0hIeIX2oLo7pwNcZgbNMSA/gqF2AD6p
         H4iXG7LRrof0y8pyPhKZiZed81hhQiStF7jnKPvOxYoZwdctKZ0baCnhiGWSbKsZSXa7
         L/Ta8hwFZ+ScOSaZT7krmEmkY0Fydw640YlAfBOxjCqoLGfoZ1OieR17C5w8ykikWNLq
         eRl3Y/be/BR/wK+TmGRGzNanb5CPpnl01v69Vw0f7vo+UczPC8qgExCFEXMZGNCtUtuA
         vkPEIO32lsmGdvs/w3S9DMl8unql+a8UgvKs9ZQiAUv3uQtlV04PsJTEbFFPMZk/Dj7V
         ODqQ==
X-Gm-Message-State: AOJu0YxTkyX0FlYKM1H9ZWTXBFjy9Ag6ZWrvNNRfZ4k2rCOB7dsm38IH
	2ODWq65kKvkQCeptB1597a+mUFbf1y11oYBOv5sHOYDHlg++gywijJpcWboH9ME=
X-Google-Smtp-Source: AGHT+IFJcbrN0mfMMLSdZ99zjcbKdGCqyR/7L8hjEBh1nwrgjfG7Nv1hKm/yTAjp6qCBcgUqV8S5Zg==
X-Received: by 2002:a05:6808:1520:b0:3d2:1b8a:be6f with SMTP id 5614622812f47-3d23e1841d5mr2768358b6e.4.1718211271170;
        Wed, 12 Jun 2024 09:54:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2219a6274sm1434752b6e.37.2024.06.12.09.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:54:30 -0700 (PDT)
Message-ID: <795edef9-2bd7-413f-bba2-04d569da63b6@kernel.dk>
Date: Wed, 12 Jun 2024 10:54:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: consolidate flags update to prevent race condition
To: Gui-Dong Han <hanguidong02@outlook.com>, justin@coraid.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
References: <ME3P282MB3617DAD141ACDD21170355E0C0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ME3P282MB3617DAD141ACDD21170355E0C0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 9:52 PM, Gui-Dong Han wrote:
> In aoecmd_sleepwork, there is a race condition caused by two consecutive
> writes to the 'flags' variable within a critical section. If a read 
> operation occurs between these writes, an intermediate state may be 
> read, potentially causing bugs.
> 
> To address this issue, the 'flags' variable should be updated in a 
> single operation to ensure atomicity and prevent any intermediate state
> from being read.
> 
> Fixes: 3ae1c24e395b ("[PATCH] aoe [2/8]: support dynamic resizing of AoE devices")
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> ---
>  drivers/block/aoe/aoecmd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index cc9077b588d7..37d556f019c0 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -897,8 +897,7 @@ aoecmd_sleepwork(struct work_struct *work)
>  		set_capacity_and_notify(d->gd, d->ssize);
>  
>  		spin_lock_irq(&d->lock);
> -		d->flags |= DEVFL_UP;
> -		d->flags &= ~DEVFL_NEWSIZE;
> +		d->flags = (d->flags | DEVFL_UP) & ~DEVFL_NEWSIZE;
>  		spin_unlock_irq(&d->lock);
>  	}

It's modified under the lock, and any reader should do so as well. If
not, there's a race regardless of your change or not.

-- 
Jens Axboe

