Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367D10A17
	for <linux-block@vger.kernel.org>; Mon,  5 Feb 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115831; cv=none; b=qOu0sajeVWWLWw4/KptxTP7iv+GxwNVbJD0wWdxK1mot1WTHpqvh7EJabLWfjIldD0K+LM1arJgCGeRSck3im1Tjvfcc0J8ZcSkt8zbE9ZX5PKCjzkJd22hvBPCYF5YjM+rJu91rPk+QO7YTOm74+gzC5YMja+D8QqHS+3edkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115831; c=relaxed/simple;
	bh=4z9ZcjF769XAtLwWrmDf1Hmkw5cjXDQcnCmZxaYI8Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/OzIpBJVWWFFc/zsXgASeyLKs9M7sIOj2MkoGvDck4vAZ6cNqUpHUUndpyUGJP9scmQlqJvvY6V/QRPXSh9PskZVgIgRgV8adccoziIF+iRMuKZ6N8ysCpuTt7lDrJJGGEpR03pK/gxYihVmjp9I0I8GamtoAeFlwjbOQCFEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kX1d0KE/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX1d0KE/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2954b34ddd0so3444204a91.0
        for <linux-block@vger.kernel.org>; Sun, 04 Feb 2024 22:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707115829; x=1707720629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpKnnCOYQga5vn8ITAi5OrOel7iL2Gt+/8Gm0Pg8Xpk=;
        b=kX1d0KE/vBTE2OMhmbJuaWKFJELev3omR0zYeKbU/zoFMW62vbqXHj4JgC+k54n36e
         l1NYxdMContZyjmDIzZVQGMGLc3jN/UeetZFE4h2HjU6LTWdwHjci26d8nsVG4+b3oZg
         k6Yt8KwzckRvA+L+VxBUG0qdg409uyLSiC8V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707115829; x=1707720629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpKnnCOYQga5vn8ITAi5OrOel7iL2Gt+/8Gm0Pg8Xpk=;
        b=TACEIqXGlxrHy7fEwY/H6ruKjiy63uzyqhuhjgbNduAn87zJZ1u/RUDY8cTIQfdEQT
         Eibm6xJU+bQtj82ceDMy/HgFXxjl6HmRrpnwBBL74O2hBa9cfaZDFEFCrkBqiRr/ppAP
         im+KiECbL5yGZ1nuYKeF6gmn/FOdfOYA+e3/t6yequDCFBY9lsUY5NgCU8WeA4+lHgFV
         RwJJ1I9gU1W6nEEqVPE8t3GPTmhJLa65F7r4Okw45M2QRT3MbuL+cV43dKM3qELgTe4v
         qcIUI+620IGAszumYlbJCV62W7FZ6A8WoAlzXEJetCPbkTrl/3NSOFpiDUOZtNuOqVxL
         mt2A==
X-Gm-Message-State: AOJu0YwZLlygGRmwQqVrUXzCz617DyYdGnqPEKymvqLYrpAWr2sXvww/
	7ZW34PJM7KkYVNKtbHqFiXBzdKVtcmSZaq/heWrP9FEByAGtZSRfZWCtpcCaWw==
X-Google-Smtp-Source: AGHT+IG0H8aeLAvOYKXQnnEJD3qXYMf8kEawxoXZXlRZ2cUZJPYC+63FIOmTVYCu+bQUtbjz33aJLA==
X-Received: by 2002:a17:90a:e543:b0:293:fc07:22c7 with SMTP id ei3-20020a17090ae54300b00293fc0722c7mr12205375pjb.47.1707115829536;
        Sun, 04 Feb 2024 22:50:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWrrvS35Q79mS3tHqNtQdb2tO68fR6mrJvGRR0ysfRoULSlHXOTVCawWTbk0gZwXh1c3v1DEu753QH+YHr2JP7W2L/z9/n8HhN3QJ+j07DTzKxqLtMOq6H8XFRnetziNk0EQG4FSgc/SWmoHC3mNTCddrjNrgACLAEeCffsv81xWwzuYtIHorihkqXWZqgU9auqkeN/I4t05aImXuTzZXsZuXJGdVYYHU9i2Vi53DDhLVel2si2WGI/8XDtL26Dimnf16AJeluIDPpoEcy4MzvnIQ0Yv4+zgdp2sDc43FJbSkMCL47FCGTeqq8utANPs8eAI7ehs42pEmG3G61jC0Z4QZ77j7tShJJv4NIXxD56Gg7rxr/ScfPzFD1LkV6XSUHqZix5Dj684YHFctbD72BCi9QVRcfWzoeTXvF+5GHfO0ePAnNSGQ/qnLlm1+qWUwSqIg==
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id pt12-20020a17090b3d0c00b002968824041dsm2053378pjb.5.2024.02.04.22.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:50:29 -0800 (PST)
Date: Mon, 5 Feb 2024 15:50:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	yj.chiang@mediatek.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <20240205065024.GE69174@google.com>
References: <20231007070554.8657-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007070554.8657-1-mark-pk.tsai@mediatek.com>

Cc-ing Andrew on this

On (23/10/07 15:05), Mark-PK Tsai wrote:
> Some architectures, such as arm, have implemented
> optimized copy_page for full page copying.
> 
> Replace the full page memcpy with copy_page to
> take advantage of the optimization.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index d77d3664ca08..58700dd73d1d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1338,7 +1338,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>  	if (size == PAGE_SIZE) {
>  		dst = kmap_atomic(page);
> -		memcpy(dst, src, PAGE_SIZE);
> +		copy_page(dst, src);
>  		kunmap_atomic(dst);
>  		ret = 0;
>  	} else {
> -- 
> 2.18.0
