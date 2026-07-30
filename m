Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A253BAD81
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396263; cv=none; b=LkEJalWUis/dcABKsAjs9xuMbCw7qPY4wjxUAv06RiH4P1Nu3oERLcNmjRxPZrzVjKgulMmsA9ssPSqg6vy2eEbFGilRoZ9Dyd19lPAOAMY9SzV5UP6OoPdfJZs/qy38B91to52V5bv1H1l2zrQ0azu2yIQALFUbdXQBRegJkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396263; c=relaxed/simple;
	bh=rHQZ0mK3QjCE1DISbQlcq4BVcYBfs5RNZJrtzlebC6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u92A2r1HZYR3yRsP99KfiOQ1Hy47XatVUTwurs2DIdtAkFai6Yl9IC+fPosHFEuilsTrojUUucurivB2JA2pS9caj+A6krYWo84NlXTfZPmEdKW4XkHKXe+vKtOj6Jp67cKN9bz+vpo6zz6Amja1+YcQ52ojXRbI4n+g/1sIohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ckFazdI4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ckFazdI4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceaf8a1265so23054425ad.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 00:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785396262; x=1786001062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1+WbTy4voezVhA/fXo6JCCCgngPgLHEDcKTQGEErv+s=;
        b=ckFazdI4kXG4a0/AnZE6sEgnx5pw2rrzaxkNqfVMe3vRlFSxvqSVPx54rACrnVZoPO
         B22LNHi371w1RCk9Swumf1mgX7hhVkHvAxHAwIfW+V79JmJDwQy2wwQEiyVoFbS8WwUv
         rujG2LZRw2ksYnzsEG2Toikba80Nrpro5OXjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785396262; x=1786001062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+WbTy4voezVhA/fXo6JCCCgngPgLHEDcKTQGEErv+s=;
        b=l5cA9zCaaLNtCs5EZI6f8vP9+hHDbD7mdUsjoF8zybz/ceUTo5ZkXLsqSNaN0yM0xa
         R/WTuDeTAP6spsJe/F1dYmyn8jrrQfQRyNGSaxk2O//M0VyQWGIxV7Z0J72umkOct7t3
         4lSw9afjVewTDUJ/IxtGvZG36QZQFVhymStmkaeje0AewcrOi3B5vJBFQbdIDGdLEq9W
         qvdAHMEBHA04PEe1VkdtbJoYcOV5ilBxYRIrjpXlIUARS9byG5zwoccnXVG9c1MpY29w
         eEDSm6K26xc8LP/wYomen5XcSM3ySbjfwLC95Z4IdyhMV1UkreNCwso1+rr/w293UWd3
         nvWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMm/ZQokDso0jE2Xk3tPfKp+lEkQxyVo04q6+mk3VEyx95Z1uW1A5v3Y2zeHwp6u6nPO7N43N6HcGyBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyioRBHnIvTnvKhaSTLBbpjcANS3iJz9qmax2fgT50CcZbmHbOf
	oXP9fo9NozTrRSjzEYykOJ/965927W7XR3P5Ujqaemte3uyLYYM2mL2ZswfE2TaYjg==
X-Gm-Gg: AR+sD11ry3Ned6pYskO5iluhZk0OUS1KlymvdTZgaOpExdBAHh/Ao4qVXaqHnEiTfA5
	0ZlQ3R6An9bCz2ISvLVo2TKcZ3Czb4OtTTOI1naM+aoFwIjreUdo2dxNZgmgzhO1fh44dWEBp5b
	U6OUE86sbhHd3MAm/l/CIchaJb7qqLCb5tFie1UozZTvMLhJcVLTQ/NfKDsOCTla7+Ure2xSN3b
	S5O+zZygcj8Gc4i8oWzmpphRQz4bw/CSFPlGLJ1qWCNlIo90BZiOiKE5xN07k2CXy0n9DkznaPn
	eNCVkne/s647Xtpjz0IYu2vNKn5zRghxRICxPRMvHHxBHwMgWczPiXHTs+kIfSfFPalbmr1vAd7
	1O86IQFijXDaVDcBCRPvGuYqqtqno0c6/EmwRwK3ebNJEaXdoYNrLQYe55lsyI8796GB+Owx9t7
	JRRBNjqhccmIq1EJzTDbWyAqTmHL/jUT/dJ0bS4O840kVK+2qTYuI8GjfPCuhzvA8z7QQtLukxD
	PH4pd7Mtt/3OyvneEVoxn9OkZ/3
X-Received: by 2002:a17:902:f543:b0:2ca:bb7e:29a7 with SMTP id d9443c01a7336-2d035d3bf1amr15298915ad.41.1785396261766;
        Thu, 30 Jul 2026 00:24:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fd2f:da94:c3be:e16c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a48858sm21918825ad.30.2026.07.30.00.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:24:21 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:24:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v4 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <amr3P_4zxX2w7ZNR@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-4-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730060133.80233-4-haoqinhuang7@gmail.com>

On (26/07/30 14:01), Haoqin Huang wrote:
[..]
>  static int deflate_setup_params(struct zcomp_params *params)
>  {
> +	if (params->dict_sz) {
> +		pr_err("deflate: dictionary is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = Z_DEFAULT_COMPRESSION;
> +	else if (params->level < Z_DEFAULT_COMPRESSION ||
> +		 params->level > Z_BEST_COMPRESSION) {
> +		pr_err("deflate: invalid compression level %d\n", params->level);
> +		return -EINVAL;
> +	}
>  	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET)
>  		params->deflate.winbits = DEFLATE_DEF_WINBITS;

This will conflict with winbits validation change that we landed
yesterday.  Can I trouble you with a rebase request (either on top
of linux-next, when winbits patch hits it, or on top of Andrew's mm
tree)?

[..]
> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> index f6a336acfe20..5d551d165213 100644
> --- a/drivers/block/zram/backend_lz4hc.c
> +++ b/drivers/block/zram/backend_lz4hc.c
> @@ -20,6 +20,11 @@ static int lz4hc_setup_params(struct zcomp_params *params)
>  {
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = LZ4HC_DEFAULT_CLEVEL;
> +	else if (params->level < LZ4HC_MIN_CLEVEL ||
> +		 params->level > LZ4HC_MAX_CLEVEL) {
> +		pr_err("lz4hc: invalid compression level %d\n", params->level);
> +		return -EINVAL;
> +	}

So...  lib/lz4/lz4hc_compress.c supports levels 1 and 2.  However,
LZ4HC_MIN_CLEVEL is set to 3, but clearly the compression library
supports levels lower than LZ4HC_MIN_CLEVEL.  In fact, LZ4HC_MIN_CLEVEL
is never used in the lz4 code.  Maybe here we need to just hardcode
"< 1" and put a comment:

      } else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
              /*
               * Not LZ4HC_MIN_CLEVEL: that constant is advisory, and
               * LZ4HC_compress_generic() only clamps levels below 1.
               * Levels 1-2 are valid.
               */
              pr_err("lz4hc: invalid compression level %d\n", params->level);
              return -EINVAL;
      }

[..]
> diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
> index 2584f47c9b3c..4d19d6089f13 100644
> --- a/drivers/block/zram/backend_zstd.c
> +++ b/drivers/block/zram/backend_zstd.c
> @@ -60,6 +60,11 @@ static int zstd_setup_params(struct zcomp_params *params)
>  	params->drv_data = zp;
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = zstd_default_clevel();
> +	else if (params->level < zstd_min_clevel() ||
> +		 params->level > zstd_max_clevel()) {
> +		pr_err("zstd: invalid compression level %d\n", params->level);
> +		goto error;

Should we also remove "zstd_release_params(params);" from here?
Same reason as with zstd_create().
