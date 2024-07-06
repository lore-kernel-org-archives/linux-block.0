Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E517722
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246875; cv=none; b=O73ZdUsi50uPCjDznZAi32sOBMvNcK9S91usuCVPiwBsE+u694nPJE6A4DYnQvix+Geb7FH3pFw6WhjeL78ygy6NzVu8BAhBX+ScyJ5m7wHkDOCnv4I5DO6gjMYv1rRUZIGGsNTJtgDh7XFLokUR59qjwc1oof3znXbgPIXKtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246875; c=relaxed/simple;
	bh=GwthaGn+Mi6CPnQZbB4Nyzvt3Wzk+ihj5bUjV0opD70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cngoDsJAeSuWtu8zx+N6fQpIK7lOCPZvUY/yGMNSEyREcmQ3NNMA4HCZxskeOMnviWII/6mCnGnnKYTUyoeAm9pVkjYncUWBeixsJzIkqxGHEZv3ErB+AzCHHzM6qRNeys+REPCE60mMqYMiL2/ywfKIkQgQqOyVo2FVFaf4KbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sncO+X6j; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sncO+X6j"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c968fa1d4fso392881a91.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 23:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720246871; x=1720851671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHwDCrp33hs7plKKkNk/uA0Am8r7jSjt1Yh6eeOVud0=;
        b=sncO+X6jrTX/e1rZemdXvNo/wxH9KtUKr/BROYf1emwHlEoMiuEdo/6z9G9is4jWW1
         JpJ7OBqzZRJlDxH/A5iczXfXr6ZKpJkT6Lt0S12Mjs3xZ2K90tOiv6RqtAW3XyabJgkE
         lSNHw+4kmpdN7FDPhZZPF3j2JTz5BF+ZCrBd8B6U1wpIixp15d/trmc6t5R0J7wU49xn
         dJ+lA2vuF3ZLXLTsHMFzCIenJcRxje/DVUhVIwDSEJDmH/o5BhTX7DMdjucgGD16RNYx
         yDqcuBAVsfLAfLuprYrOP5FOzo9AESzcKt0UIXnllKWq3cKByBHQBY4gIJr+cQHQmkZZ
         WiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720246871; x=1720851671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHwDCrp33hs7plKKkNk/uA0Am8r7jSjt1Yh6eeOVud0=;
        b=H6qb08brH5jt3Fb429db6Yog3OOam/t/t3dstbSzcjbUed9PGSRvzaDx0j/ebgV2AK
         5UeSz4WlRc5YIDCxYeOfvgCW3LTB5EoR7Bf50r+ELBzSFFppxKwHYvt8sDqYg5Oj9Bn1
         DAALzCaDuOTUj40l1tmPHT9awgK50Qhlt6+yQgeOKNMkevtNTwsC/9ZWbPQ5rLXls2kp
         85zZnHJz/01gD5ykCo10Q6tu7R1g0s2dCacKezxGEzvYn/C9b7FZ6dME865OjvDeq8Nn
         Abugeujb5Ue2amLGj6B3o4DJG8kOITScdrQyQGkZreuR2Sz5qwEcWUeJgmYFmx9dLd5Z
         NjLA==
X-Forwarded-Encrypted: i=1; AJvYcCUjd9eDDA+SdjFnJ/EZpM7qPCoOwxRe2W6OYA2Nv/KJJ6YZE9uXMx2bP6yyGV2iL7Uq0zgTGcI1MG4+23dBaqgckJAthkiWXKdPqQA=
X-Gm-Message-State: AOJu0YxCnaihUXt5/Fv+U/bD7zSdGXm34fLpGy9/ulEMWSdv974SYjzs
	Vsbi14+AkTJvI1cvm1Pp1SBDkZmbN1RQ1j+FMEqpmldsTrKWWgC+XaQIWeD4nj0=
X-Google-Smtp-Source: AGHT+IFqpImcZYeF+q9yx4HjhMv0+L1uMX58YJi3GclqAj9rNXdFJkRgdkTBPfHMCRfWZpYSOCuGeg==
X-Received: by 2002:a05:6a21:9985:b0:1be:4c5a:eef4 with SMTP id adf61e73a8af0-1c0cc8f8c54mr7695077637.3.1720246871053;
        Fri, 05 Jul 2024 23:21:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::1011? ([2620:10d:c090:400::5:7b2d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c9e0ee3sm11952769a12.60.2024.07.05.23.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 23:21:10 -0700 (PDT)
Message-ID: <c2333a14-04bc-49be-8cc6-a03dcdb2eec3@kernel.dk>
Date: Sat, 6 Jul 2024 00:21:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org
References: <20240705123232.2165187-1-hch@lst.de>
 <20240705123232.2165187-3-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240705123232.2165187-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 6:32 AM, Christoph Hellwig wrote:
> Work on a single address to simplify the logic, and prepare the callers
> from using better helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index cff20bcc0252a7..b1e1b7a6933511 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -207,25 +207,24 @@ static inline unsigned get_max_io_size(struct bio *bio,
>  }
>  
>  /**
> - * get_max_segment_size() - maximum number of bytes to add as a single segment
> + * get_max_segment_size() - maximum number of bytes to add to a single segment

v1 had this change too, not sure why? The previous description seems
better than the changed one.

-- 
Jens Axboe

