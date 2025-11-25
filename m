Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48A2D8363
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075578; cv=none; b=K39BlUzhZhKlUYvzSC6L7VnTKrltx4nnyH0LGLdUgV4YPGmug026eNzPrt/9E5raenOjmXHDZDkmiR5Y0ywIhCJhdLQQ6/b5ztwxF6r0FLqkql8ObV5Gtp+T+ypukm73ilH7rIjySDTQjMEkAfPkQYOnHs4goOfl2+/5rvvIBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075578; c=relaxed/simple;
	bh=y9MCt06oxEaIowpNNPYp0G6Zb0Ic+eLdfqHFK5MEa2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuhGJY1l7NLb6Gg0YeuM/3+Vgi7bYlGdjb4DrzOf0SqnpyXJfMdpaWtFHUNRpk4uCrCGj5sw5VHraKyNZfsRbLxG6UO6KD4pq5/7IFrJQF+CK0HI+pvfcnkMiBfxXWCm66bUhQ4B+TVI11ZlP5BBoj5Wy/aePoy96K4uAeLre4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ey5gts+n; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ey5gts+n"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29845b06dd2so68020105ad.2
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 04:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764075576; x=1764680376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzekGeD6YFeZEIVpeIB8iSStQtARNiE9okxDPO0xNVg=;
        b=Ey5gts+n5H8xA8C+tjuKFH00Ii3BKtESOsEn3Ed7zbu0OYQQRxc+sUiV/T7o4mF+pn
         jsZgVGaP8u/d86NSu+ypvDURYOn0gmAUG6VitiR+Jzgsv9xRTeJxp8pRNeIrOh1Ho/an
         oAMOzf7QDDCdKW/YKM1ZFHa+io2BRCNYf+DMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075576; x=1764680376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzekGeD6YFeZEIVpeIB8iSStQtARNiE9okxDPO0xNVg=;
        b=mUUkF/gmwK/HcKLsBTL6LxOVde0f0lLWdJTd+WzAX/S7PR4IGcta8rpuvjPXriFG8f
         8dFCe1JJsEBD0isEFj+7wpWjVQW9LhqFcTN/Pu4025R/vUKn+BuHmcVhJo+MCsrcxreX
         PRfDGu01N4cxsjmqL+PpDYsHcxmfK9XT4YEN6k0euEV8Mwv3C1nR7j7oMkc8EY8JZWzn
         AmAWJrzl0hSnKkAjBE+OwbfDAyNV3vKxIJXXF8SFqRtr4J0FaTVEhGu5EJ1/tao0RlZr
         B1sQiSVemuwZQisv/c7hrFbkgvp3QoRXfBlNWXgNLpGF+fvr8vgBmjQrs2NBIuqXRb/c
         ZPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJSkXPiIN5WOL0ytHl+VIEEVs9gyTwQzukbAniN7C5YCKtP2OZhhEhArCaaJDypFZucS3/i5NqncK+wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXRXSTuuHz27CLuuxTADx9eAbX+sF1Rc/mtH9IuN5Yi9q9gT5
	7annacrqQu23etvkVvuRktAsw+OMVsrGMCpKZG8wK0AmRHh2YvDSTAEhGQ7wjdVundfkzIn60BJ
	Ub3w=
X-Gm-Gg: ASbGncuhkntV9g9L/y0nWMXldlMkYp8RPFkTdL7wf0tFI0XPeZ8BTVxDhX7axj4b+8y
	vroRQb+3z+psoGhW5qUr5EXWZvBTaMUauFmEnXbav2xLky35+OrbBDuKpVaPW/V6rnt2trJ+kpZ
	sc/j9f8HVIZEpxhEIgNQ6NWKSJUG1VwTHFQceU6sHWGDNv//VQ1DVpJ14442CuyLy2u8GlrEIMu
	g6V6yVEWpWlR38SB6EyJw4yVmCjiVN2xT1inrZ2sEcKpMmQ9vAgjOOdnXyLJztqNkTkgYdrys2t
	atWOLMRS7ENvp4vgUHfuRIZv77JsMmTVsPNhMsaO0IVHExtahTrN96yFuBuDVee+u/RsmHiOPiV
	rnj5FP0UCYKPrvuep8ol5wr5LrgxaH2iSUhZ+vrrtxxzU1EikAS5B4+Pt6nzyINKCZjQnDZupVP
	ow16q2/Bj37ul4y6xIctx+Xx9Cwj6evcNyiaM2axG2IM0Ijq2PU94=
X-Google-Smtp-Source: AGHT+IHkjY4bmanzRCOwED5K3GjL8i1Wzs4XcaTpsclMXBVDa11BHdBFuYk+NTQyxvFMxn9tpQmL1w==
X-Received: by 2002:a17:903:3d0c:b0:294:f711:baa with SMTP id d9443c01a7336-29b6c3c71b6mr196915565ad.2.1764075575976;
        Tue, 25 Nov 2025 04:59:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:f0d5:a584:feeb:fc1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13de62sm168663515ad.36.2025.11.25.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:59:35 -0800 (PST)
Date: Tue, 25 Nov 2025 21:59:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Fix a spelling mistake
Message-ID: <gbszooz7phjyo26ofhnchmugp6vsi7gk5sqr4hjpcxyoluwac2@3bk2rutk2cof>
References: <20251125020522.1913-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125020522.1913-1-chuguangqing@inspur.com>

Cc-ing Andrew [message id: 20251125020522.1913-1-chuguangqing@inspur.com]

On (25/11/25 10:05), Chu Guangqing wrote:
> The spelling of the word "relases" is incorrect; it should be "releases".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 1a1159a70fb4..5759823d6314 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1043,7 +1043,7 @@ static int zram_writeback_slots(struct zram *zram,
>  		index = pps->index;
>  		zram_slot_lock(zram, index);
>  		/*
> -		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
> +		 * scan_slots() sets ZRAM_PP_SLOT and releases slot lock, so
>  		 * slots can change in the meantime. If slots are accessed or
>  		 * freed they lose ZRAM_PP_SLOT flag and hence we don't
>  		 * post-process them.
> -- 
> 2.43.7
> 
