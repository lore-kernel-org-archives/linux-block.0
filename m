Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F68313E3D
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123227; cv=none; b=UavY3cG9aSk+8cKTaamMBwLG1iGfJKSQUlOEsgZ+s8PpwRqfB/G0XXZfiFDtklo0yDVBe7K9Bk0uLOv+ZmM+iE1c5+aWT2n8XdiSbTcJj9NdwVJ5tpL9WQoioas5UTYBbWC8XennlbnP5KpL+3VvJNJ3LVe0gwzVxJY5LKHekm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123227; c=relaxed/simple;
	bh=zLJsL7pi4v3XLz/EgEHSGOIArkQrlrmDLpLfCY3mx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGBXktO4mrsnFfIxC5Z+mTkYy3XLvJgHuSobZ+0zhVdHWK4b7kMpX1gYyHgVhVxCGeDqsUUjgchQMbkKELjZXLLjUionMYZ3B/x8lsR8QGoSGkgY83dPmMlLtjTy7l3Yb0mPDhSXCGVsR/Gqu+i6srjjgJYPiVDv6RgXTp+AKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cmKO2eVF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cmKO2eVF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9a9be502so81724065ad.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 23:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773123225; x=1773728025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4ji8TdbgweIE6/GO1LR8k/VYUpCh62PQy0KsUDQ9gM=;
        b=cmKO2eVFhNgOng03jkc5y82ZIZbs81GXKijTcmCGeqeUNiSM639GupLKX95htQF7mb
         x8+wACMgXzJjjX8Outdp1QdIxeKSZjtpyCl+qzy+uo+/c2dSqijTzwRZG2EUm+TzGiZF
         glZqx0s1KzhCDu1B5RBitRPyW+ul6XtlKgrck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773123225; x=1773728025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4ji8TdbgweIE6/GO1LR8k/VYUpCh62PQy0KsUDQ9gM=;
        b=FnpOzC0FmwrFdxprvMn4FSIZzE+OtImeVeWjmdXhEiCppNfwzHYxwhXz+88l12PVd/
         jbklWbEAn+Q3Pgrjr/8UGyjCqIdAU0HKWFQwkG4xG1Z8NbAl2sUpF95GdHc+iC5dE8Rr
         TqO9SVC0pKDyIbefCquUf8OFT87r2Udevf1iB1kkBIJRTKAwgUuU+DAmB6bWLcFSwqFU
         A09lOTme3kSNrDJXdiBLT9n6EG90vrPUBdEV3yDK77s0QBkKLb4mAuouA3ZjX48RjMul
         /4nQy2csgnbVmIBN+lLi5DG+70DpC6LbelntAXKvj0uygsoAyUMvKPoc/1IDwznMe+d0
         BlWg==
X-Forwarded-Encrypted: i=1; AJvYcCX+qnqEivqjFtESVAsiR9bcXGj3Bu2H4AAgcy8rALeb3vbPymN2VsBMTUjl2/crEE3bVJbMCuiCi6mODA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5AeLZYkRPswVi2c+gzqM7h/kaHUTB4HLV78X00pRcygHj2Vkb
	gL4u0Vl/x7nb270V58XSBXqaXufhhzuTWjVsOcG5i8486hzTy+DyQCzBwjUq5AWtNw==
X-Gm-Gg: ATEYQzzID6O8Rot+1FUOOzz8TkzuzB+emRhywcUKpxMDvzZoUD7ouLSaWytG+BW9il+
	3hF/QxklvgeLV9CDd5ZLHoWnm7q53+VFs/8hx1OjrK0FP5RQ0Zkqc77LsaWfo067lmvt1+171yx
	0HBjpkmx2YCbChvZ3sOSf0VLYwo6ZNLVeo2ynkwboY/qJX85wBHxAKBNHJorC0zSRNcYVbkEzPF
	ycBxsQiP7WGnfBNqwh/whMev+/NGZawSY5jgUB1QDswesLNa+1fkwIKB+mHJf1HP+yzmcYD/6GL
	rfMvUXfhMB0qdk/G2uBH9oLCmCJZjRnf/3hjUuJSbvUwdd1gzKtaBu1byUEoXl5CeQPtxbvcQl9
	AY9OpM4X6PZ74+0WM5/6tIvj4y3zkOol6Gwx/LbQMpAsOFcu6R+9IWUbl6c+6UANJMK9q/+E1rv
	hkK4H0mZW7LowfnWj0iboeXarC/IKrvZ69dXlHB2KcjilrsaDnp5vq7fg5lQeG7w8=
X-Received: by 2002:a17:903:1a26:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2ae82368445mr141368195ad.2.1773123225415;
        Mon, 09 Mar 2026 23:13:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5620:959c:240f:eb2a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840be379sm136280495ad.87.2026.03.09.23.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:13:44 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:13:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: zram: Optimize LZ4 dictionary compression performance
Message-ID: <aa-1iKEWKNB0zDwj@google.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae51966c3cb445e9983230243bb6a5b2@honor.com>

On (26/03/10 02:54), gao xu wrote:
> +struct lz4_drv {
> +	/* template compression stream with dictionary */
> +	LZ4_stream_t base_cstream;
> +	/* dictionary index of the current template */
> +	u32 dict_gen;
> +	bool base_c_valid;
> +};
> +
>  static void lz4_release_params(struct zcomp_params *params)
>  {
> +	kfree(params->drv_data);
> +	params->drv_data = NULL;
>  }
>  
>  static int lz4_setup_params(struct zcomp_params *params)
>  {
> +	struct lz4_drv *drv;
> +
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = LZ4_ACCELERATION_DEFAULT;
>  
> +	drv = kzalloc_obj(drv, GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->dict_gen = 0;
> +	drv->base_c_valid = false;
> +
> +	params->drv_data = drv;
> +
>  	return 0;
>  }
>  
> @@ -67,10 +88,32 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  	return -ENOMEM;
>  }
>  
> +static int lz4_build_base_cstream(struct zcomp_params *params)
> +{
> +	struct lz4_drv *drv = params->drv_data;
> +	int ret;
> +
> +	if (!params->dict || !params->dict_sz)
> +		return -EINVAL;
> +
> +	memset(&drv->base_cstream, 0, sizeof(drv->base_cstream));
> +
> +	ret = LZ4_loadDict(&drv->base_cstream,
> +			   params->dict, params->dict_sz);
> +	if (ret != params->dict_sz)
> +		return -EINVAL;
> +
> +	drv->dict_gen = params->dict_gen;
> +	drv->base_c_valid = true;
> +
> +	return 0;
> +}

I think this simply can move to ->lz4_setup_params(), becase that
function is supposed to loadDict.  I guess we can use backend_zstd.c
as a reference.  Also probably can inherit naming scheme from zstd
backend as well.

>  static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>  			struct zcomp_req *req)
>  {
>  	struct lz4_ctx *zctx = ctx->context;
> +	struct lz4_drv *drv  = params->drv_data;
>  	int ret;
>  
>  	if (!zctx->cstrm) {
> @@ -78,10 +121,16 @@ static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>  					req->dst_len, params->level,
>  					zctx->mem);
>  	} else {
> +		/* rebuild base_cstream when the dictionary changes */
> +		if (!drv->base_c_valid || drv->dict_gen != params->dict_gen) {
> +			ret = lz4_build_base_cstream(params);
> +			if (ret)
> +				return ret;
> +		}

We should not need this, unless I'm missing something.  Params should
change once algorithms are setups and the device is init.

[..]
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index bca33403f..f34f3fa43 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1709,6 +1709,7 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
>  	zram->params[prio].dict_sz = sz;
>  	zram->params[prio].level = level;
>  	zram->params[prio].deflate.winbits = deflate_params->winbits;
> +	zram->params[prio].dict_gen++;

We should not need this, as far as I can see.  It was a bug that we
permitted params change after init.  I sent a fixup patch.
