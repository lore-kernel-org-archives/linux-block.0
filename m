Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328559;
	b=bHwW173Va/wSGuOwxrakukk3wCUjBVQAmePF4WMtFnJi6jHInajXmghLEVzqikTBnOTw
	 Tt76dwU4IYRD6VccrOQiX3I+R35pvQ3WHiXsujdkU5fz4Ar5/rHHhKuLKUQKSztdpkbW0
	 vCvnt7vGkwE3mLjYXqUrSeBT2O0AoKpwOvp7ylUEt9zEnOmEaPVrozOAY9sabBSyEeNY+
	 8outGXGhgXugtfv0E+bo5dsWnfbn+uqUBfomm1gXzHPB5D/nbbP/oZrOB5pphN2/ByCiH
	 I1N31fGixHun11Tb3DroaoxAFVS2gOCAUbJKtt9/+/dyb1C3Vd6QfjdVAYOkvT3y8yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328559;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6B8q2oqRr8i13Z8GdT5dzIPKIxv4OsmoKM7uYVudI50=;
	b=d4mcQbtj8s/asbRUiuuvVOFDjtVGsGzcXBjWIlrHjY3iw5pMCbKyWZaqQdG2kNmINjGD
	 HULlyMENou/SVpoKpH4ofTUWPnupfrJJvCqk/efUd87WbA207ZbFSIeqRcREPUyD249QT
	 kw5UKwKPfS/UqkGcS8KDT620R/Wy+hzE60WyLPfmKZxxfnYPAEc9oKGU8txSAQGfXgC9f
	 Q+RAJVWyhtZRHa6rHHfGEmMD2QggGp2gN22wFge4z/N4apeqBKY9THWTACPFXMXfOOvIF
	 6uXIbbDxK/BbsbaE6TbaIyLrO7sA+rwEMW1n+AxPpBK9mEkFOWl1scFzUMxWlSYOjnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1SkZeEE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14041606A211;
	Tue, 10 Nov 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1SkZeEE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387081F0089F;
	Tue, 10 Nov 2026 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328558;
	bh=6B8q2oqRr8i13Z8GdT5dzIPKIxv4OsmoKM7uYVudI50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i1SkZeEE/TPAW5CajYVIcy1XUV71QNqZ/NtonNl/JIuGfqXNpd5ZkIpdShFMEMPCx
	 DiMXSUPKxkADORb0WktAtloGnZRbhr+Jev/m0tgRTdTNJ7PdUOwuEP0t3ljK/Qaa2q
	 fo9yav1hYqrRUI6iF6tvMsAcfp1GrsGx0eFuO3WP7FrPWSik4KGbI8artMgSLDspQX
	 mPVcEra8EiNHoueCe6T77cKuNXFZpww1Ypfd1KKFzRbHBpannY520Unq/gAYwfYZnX
	 ++YkJ8Dz0kwAL46lQ4cRe+mlFkudAZ22c+90UEV0FGE+NQNPavpAy229+cAJCJ9tBk
	 iFWkTl3boMCXg==
Date: Tue, 10 Nov 2026 16:35:56 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 04/11] zsmalloc: switch handle type to struct zs_handle
Message-ID: <avNHoaIU-RV8_fEG@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-5-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110054836.1515030-5-senozhatsky@chromium.org>

On Tue, Nov 10, 2026 at 02:48:09PM +0900, Sergey Senozhatsky wrote:
> zsmalloc handle is an unsigned long that holds an address of a
> handle_cachep object, so zsmalloc and its users have to cast it
> back and forth.  Introduce struct zs_handle and switch zsmalloc,
> zram and zswap to struct zs_handle pointers.  Functions that only
> read the handle take a const pointer.
> 
> This is a preparation for embedding struct zs_handle into zram and
> zswap entries.  No functional change.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 28 ++++++------
>  drivers/block/zram/zram_drv.h |  2 +-
>  include/linux/zsmalloc.h      | 13 +++---
>  mm/zsmalloc.c                 | 85 +++++++++++++++++++----------------
>  mm/zswap.c                    |  8 ++--


zsmalloc and zswap changes LGTM with a small nit below:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

[..]
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index dab71f582103..3a6a7253fd01 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -264,6 +264,10 @@ struct link_free {
>  	};
>  };
>  
> +struct zs_handle {
> +	unsigned long __private obj;
> +};

nit: Update the definition of ZS_HANDLE_SIZE to sizeof(zs_handle)?
