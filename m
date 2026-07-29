Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82551A681E
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292235; cv=none; b=buQ30ARuccjWMVKG45EJwCbgIW3AUtrYKjC43kt4n68B+LqEhWVBB/zQ3r1QcKuo53Y2t1eHGr2Q+hFrH0PBjVsLWWUe1PkAefJbPuzrCq4CiQeEbIBOgrlhwLPu2QUrDdSjbQjR4PW26SrozUtaVFzeDGYT/tI7+8O0+Cvrz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292235; c=relaxed/simple;
	bh=g7QEYrOw9EaaaIOTFujFRIHsufbM0ebGILd6J0jhxGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY78oIfP9gy+/OTDWEbloaOQ8F54Bk58tIsFoXErOq/scKaJQlaA3WGCi0YIgeQs5RlDghLl0TTvJ6OSp3NmyCFIBRfaMyZX2Nbppsc9eaGrCY4jeNJXug6nECXHYAJy4Pa5qI8qIpQglM90kkBpl3OIK3L+V8Q6DR/PEXoQk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JXwHVmR7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXwHVmR7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845c92bc464so402325b3a.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785292232; x=1785897032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jyzGf0CgXJsMY3HkDOX/hQFl618bqY72OQCBVFF3l60=;
        b=JXwHVmR7iv48QQ+9jevlwqdnpVzzILvdAUd3nEQPzMfesww3KU+8r57voDE8p6vEfT
         9ZQJxBt10lPmD6vcwdI5SY0Md7srN8QTzki1ymO9gLquAkTBkMy0EoMsRTb94Wo7iJEi
         qx7+Hx4KUk/G8yqlfLXLBpslF8rvNfz1bWoUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785292232; x=1785897032;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jyzGf0CgXJsMY3HkDOX/hQFl618bqY72OQCBVFF3l60=;
        b=XtcBVno4RnjJ2PXw8MG/kM7sePNZTzr0mS/HruDNRm9CtcDti+hbO1lKPYrd5rFb73
         /do5eeFq4oOF/3XqpvxhKc2kjv12lpsv9c80BP58oc2pZZu0YBvUfgllkRBK2HaSW+WE
         Djx8+KRyxiNcEA5XJ0Q+//05it6Z0C4Ha7aRDzlRJnJgPxKNlXHhDgXZIRw2BizYWCrt
         2Z2VRF0BGqWorqHRxe69oksUGVVHQIcIcj4Xty61RfTAl5OwYQyk90cw1lJuZityDiYH
         7Y7swTodsXsVgac7+bb9r3Ck8GOKg5tDrStfgFwrcawD9jBhtXJHa4/vV3gItyCYuynx
         e8xA==
X-Forwarded-Encrypted: i=1; AHgh+RrGNMn30+3TcY50+rOfw+9VjrFdYWvcWk9G+6Mc4W6U97+5BydKewGJQJFd39e2oHbN+C0DEakmvChYxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJBtVWgRVHRtvUOy8Ktfeujf7ccf8dx2yic2JaF+e40JunqJV
	+psRX3zwDA5XT4fAXReYWSX/jckM3pwkLAKMZZAwpWyxbNWzj4SgWF9KlCUPpK68LQ==
X-Gm-Gg: AR+sD13Gt+l6g/DYP1M8x+/IK0KNzZfI8FDQ6AV5gcgoF7BwA9PTwG4uKv0FDzsX3tP
	Q2lgf++IMeMh1D2ySoiUFk8BOiJpYblm+wMq+CRfUbIU0hi85LIoSuUZBYw+DGyHysE3+W/Fbdr
	s6KpRP2NCtxPXOU6ZyM3+XcbztStuABx24XDCasMZ5heH0dUe2O9BAOUB/vTNUC0r2aBBrrMmRw
	qNse9hVxRg5TmUX+GfoAEcCu2ZsI58PatLVwBOFNQ1AE79RVGuDJdUXxWLLsjMF+zRHDZUghVQ6
	znOsBY7OJqJ+sGdIcOFDFeTkGJr+2OzgeYb72LMjRP3H7B4s5P9z4L/RGAqNa3OqnPUcjw6K7Us
	c+MdniqwhXQMq4DiaDX7E1g8zCHHhFW8JgdRvvYvPS5+nB0h9frw+E1iRM8PGiuAtMzM90rQ1m7
	E5ee1Gxh5RAPvugnyULh79ehEqlfdghE3WTLqrSlxE7FF3EjWCLY6pmzZObZFoGnMaytUnmVGnM
	VPAoXxMZ83E0syBvtLD/9rPPWmw
X-Received: by 2002:a05:6a00:3992:b0:848:7f8a:8d0e with SMTP id d2e1a72fcca58-84e932c5f3emr4663339b3a.55.1785292232144;
        Tue, 28 Jul 2026 19:30:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02f8473sm611819b3a.31.2026.07.28.19.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:30:31 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:30:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 2/5] zram: make dict update in comp_params_store()
 atomic
Message-ID: <amlk3lqSbtfEOkbs@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-2-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728092935.31139-2-haoqinhuang7@gmail.com>

On (26/07/28 17:29), Haoqin Huang wrote:
> comp_params_store() resets old parameters before reading a new dict,
> so if kernel_read_file_from_path() fails the params are left broken
> and the actual error is swallowed. Fix by reading into a temporary
> buffer first, swapping only on success. Use sz <= 0 to also reject
> zero-size dicts.
> 
> Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
> Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
> ---
>  drivers/block/zram/zram_drv.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index ace65c586072..9ea7ba9d1ed0 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1699,21 +1699,23 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
>  			     const char *dict_path,
>  			     struct deflate_params *deflate_params)
>  {
> +	void *new_dict = NULL;
>  	ssize_t sz = 0;
>  
> -	comp_params_reset(zram, prio);

I don't see why is that a problem.  All you wanted to do here is to
handle zero i_size.  Why do we need dict setting to be atomic?

>  	if (dict_path) {
> -		sz = kernel_read_file_from_path(dict_path, 0,
> -						&zram->params[prio].dict,
> -						INT_MAX,
> -						NULL,
> -						READING_POLICY);
> -		if (sz < 0)
> -			return -EINVAL;
> +		sz = kernel_read_file_from_path(dict_path, 0, &new_dict,
> +						INT_MAX, NULL, READING_POLICY);
> +		if (sz <= 0) {
> +			vfree(new_dict);
> +			if (sz == 0)
> +				return -EINVAL;
> +			return sz;
> +		}
>  	}
>  
> +	comp_params_reset(zram, prio);
>  	zram->params[prio].dict_sz = sz;
> +	zram->params[prio].dict = new_dict;
>  	zram->params[prio].level = level;
>  	zram->params[prio].deflate.winbits = deflate_params->winbits;
