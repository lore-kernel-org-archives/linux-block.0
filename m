Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D4F9EA
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270289; cv=none; b=Wr5k/OPq7pvppHpBNh9O9kxMGd6wWI+n3C+Tw9SEDZPHvyDdY7+nPnVbNB/BgezftbiqITigBqVkEiLebOZM6KHoDzFjbeku0tlPm+lK2zL6DAiD5mzBhy9hpNsheydPTjU2U5l5E4GGYSFz0LxdjefssyCzxab9hOR/UHUk7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270289; c=relaxed/simple;
	bh=IPRdW2Nq/kBnNQmgFtqfLx4rMNeGj8stoeMb4OYyzHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUSbHPUHKFSfyQ0sTRIieay2KAvdzRiMq2MCS/4JW0Bz6oc2Zs9N9gPUVphQpgSgeRA4eY47TFK8bV+JLm/hPSgPg5uJLH5gwMC1W+v1o7bEORg5BlWr4MKLLNTcbCGsoRYCFO4+L/W4iVLYEJrzyiKynOeFRS6xcEfmlrYAm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X5MO7plA; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5MO7plA"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbbc6bcc78so128313b6e.1
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707270287; x=1707875087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5rxXK+ENB15+cBUK8jk8L71LtIFkIUbhV2tF6desBF0=;
        b=X5MO7plAzCyeY4r8WGHUwUrssg9ecq1ViBu0fM3lsQCQxfGphhHuvzWwzEGs+4bxXk
         g7yHfuhO1FGMkjbYdUUtW5D+UTtbOz8OZovUcYd7bGjSQBcujnuZp0saSVhuavW8ZaFx
         6Dt4yKob8hFoqQlX86BsPuSnmR6igt4jE0H1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707270287; x=1707875087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rxXK+ENB15+cBUK8jk8L71LtIFkIUbhV2tF6desBF0=;
        b=ay24xyAvG5nR435Je+fGs4IwElzC86Y4x9F3V50CCEFvQzGSLOVy0C6xUxU6dbKliT
         6SKoyYp+Ot2E2IJEVL8l5CziX2WTt0Z6iX2zBNQJ/FMS3wI0EI4OY5tYkunmECStYi1W
         ED+GDi3XIMM6T01h4PfodQiWBnjVYOTbrKlDM2XUkzW15ucL81aBzQ3UfBQOdF2fa4Ml
         WC1EVR4p6u2DU1m9cye1LbQ5YO2LYkiScoQTLGXQ79k3nes+bxwLWsH3bZivrR/QYGmY
         z5Ahhs/SJtmkbFYL0NaoXkrGat6HhuzKKZF1IbJ4F4Ix4di6Ru8vctyY74kRC0We92jB
         hSkQ==
X-Gm-Message-State: AOJu0Yxo+d5VHe0xE58Pqh+jFZJSQRbAq/akmUhYzaweZUuBFv3k3GtK
	hzLHy6xmdSLu1edOcJ8tl/nJ+PHdPSjv2ANbSM0umf7M2/k/3v+gBmUNWLSz+Q==
X-Google-Smtp-Source: AGHT+IHbD6DZgnSsP+W4UVUlpKqeyLthk4r12WassXSdeYtHLIu5gD4K5ebM5iJ/a5LbYrzBduzvlQ==
X-Received: by 2002:a05:6808:e82:b0:3bf:e29e:ed81 with SMTP id k2-20020a0568080e8200b003bfe29eed81mr5149290oil.22.1707270287313;
        Tue, 06 Feb 2024 17:44:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGYJo8tVZSlqHTkwn6ZXM5gEsHJybA0a13Vvaba/9Ckq2LU8IYja+jNFtQe/qzXV2sR/Bbgd3+QfPD6k7s7Pw1jleLC0jTQpAbcslYy+Uwj6kweb4a5+f1pphfb4XtwuPBAQX67GKVr5PailydsKbtjVmerbpoa4YolGwsU9Wi6y6N4Mz0Xailbm5hykyOy5b4hVFWTCJIrWP5FFfzPSPOsyvUDAaceMBQUU2yrza7CrfCYj/0XVfphB+toGQbAwGLmncpjdY94b9jUhKVrhCMhLfDC2PK4Qx99TB4++BlE2w=
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id fn20-20020a056a002fd400b006de050cf904sm169822pfb.22.2024.02.06.17.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:44:46 -0800 (PST)
Date: Wed, 7 Feb 2024 10:44:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>, Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Message-ID: <20240207014442.GI69174@google.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206202511.4799-1-21cnbao@gmail.com>

On (24/02/07 09:25), Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Firstly, there is no need to keep zcomp_strm's buffers contiguous
> physically.
> 
> Secondly, The recent mTHP project has provided the possibility to
> swapout and swapin large folios. Compressing/decompressing large
> blocks can hugely decrease CPU consumption and improve compression
> ratio. This requires us to make zRAM support the compression and
> decompression for large objects.
> With the support of large objects in zRAM of our out-of-tree code,
> we have observed many allocation failures during CPU hotplug as
> large objects need larger buffers. So this change is also more
> future-proof once we begin to bring up multiple sizes in zRAM.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Note:
Taking it in NOT because of the out-of-tree code (we don't really
do that), but because this is executed from CPU offline/online
paths, which can happen on devices with fragmented memory (a valid
concern IMHO).

Minchan, if you have any objections, please chime in.

> @@ -37,7 +38,7 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
>  {
>  	if (!IS_ERR_OR_NULL(zstrm->tfm))
>  		crypto_free_comp(zstrm->tfm);
> -	free_pages((unsigned long)zstrm->buffer, 1);
> +	vfree(zstrm->buffer);
>  	zstrm->tfm = NULL;
>  	zstrm->buffer = NULL;
>  }
> @@ -53,7 +54,7 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
>  	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
>  	 * case when compressed size is larger than the original one
>  	 */
> -	zstrm->buffer = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
> +	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
>  	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
>  		zcomp_strm_free(zstrm);
>  		return -ENOMEM;
> -- 
> 2.34.1
> 
