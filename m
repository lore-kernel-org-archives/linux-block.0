Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289195;
	b=dFruTZV6f+AdY3ZoKy6MvA8FvRdWMBvPh3E0fXfmO/w5docUDvf/ppCbNOlog3+Nt6aI
	 Za7ikEFpzeolP6PdcKXyFoJEqQ2rGDoxYyMsqh1tRf3eJadDWaZvh6lOMkAAKjcjQLvPF
	 IPMCEa+Zq0t/SzmcFUqgu0WSJtn0+fJ9maDzjmYKGrMbDwgaYx2PBjxA75VOHPxu2IM4L
	 yL1d99htH9vJvJZpT1Jdy4thASWsaus0ZJvJLYPwEb/J2zCSLF0GF9q20OS0fteKG85vX
	 hkNY0h671NGQ7R9apXVzmOEEs/hjjCP/dgXizzLuVo+9bahmmdsukSjuy450gDzZ4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
	b=KjYPw/IKmSRfy7THcaSEU5Au4ZrVNne0aDgIZNbwPa1R62URfcK/VJwYfZLb7x9RHT5d
	 OqLz0bW4EIGpd2URFQX6L2X01XH2hbcN+kzk7Fs6COhd46eiWv+2JDSllQWfv4T6mASVw
	 eiFWjldAkCY4FNUoHFvTbbVRvYocA2S1PcTb0cxi7nvgFj4aA4NfC3jpjNc8mMxGAWACi
	 lpuwBG87TcoDAyxz2SyRHI6GeuccJVVFiW3k8MsIJqJkcz0owJYmuipf1Tov15pqWLjOf
	 77bAq/ENbeBqssWZUDZS/eFJPVJGo80DX/3F/sPX+Co9Xnn6rMRR1j7LDjni0gBuWwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nYCjfLCg;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA3606A32E
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5AA3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nYCjfLCg
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so764863a12.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289194; x=1794893994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
        b=nYCjfLCguMBjFt7Df/pwcAS/GPhBqgvi5e16XKr+oU3FTl4s7XEOa/w4lwVhENYNEy
         6HUfXInt0Qich4WYX2Rx0OD0rQnYQrTfrGD4byFmAPHBXNocTXgLKiro4pJRUUMPvCHC
         Ilr6Z8eXaJfgpRD2l9SSOO7VTdw3nLqZlt0Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289194; x=1794893994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
        b=Uqnyj+Qz/i+8SgxCXhPpFqAAeAWbveTjfRmdkwNSD+jrMnWoIXOAKSZwFBhFgIA7lh
         sgiybDXY8KLTbE4abnHU95twySDqLF5G14SS542vH0F2lAUO6DYAfRNEV17jhlg3jRNr
         90Cl5M0qiLE5OlU/exrBxWPBaHbP/lF4NdkvzHDEIeOKWER6w+MbEYTaY8E4JuHD2moP
         ZchyLg1nD60soMBnhSxQ+nF1HwmfhkFHOlgQf+RuE1VOFJzSd/TL+PJMbIqfAuLjwlwq
         0TAc6o08SUDRKZJdZB3tRExSvNvq80fseYPbnQPn3dF6J1iIEgPYKLCP2967vBShszGS
         lmNQ==
X-Forwarded-Encrypted: i=1; AL+hErE58b/EzY7C7woR7jAF+iwRQq/ibB8aJKa6xwmmWpTOA56edpIV6oo6Yb4/avHIXMvIPsfixP/Ekpns8A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AvPHRMdruRx1qQ7lZE3oQELCk54M+gFYSgSqN8NO5nLi31LMD
	cxVDOTttRtQeRe+FIKyzb/KaKMcw2S0jd61Dq2SSPhlUTstCH4BVLoLQfcC4FHyP9Q==
X-Gm-Gg: AYBFou1Uh5ZnPToWaDIQ9MOMEyN/sFHxBzJnYwI+bV3qzFvb3ldLa5UHQBWZ4anTFKW
	qw9e+GjOUSJPlc0pZglVvGTn6AoA4O030YUxhdLQzwwG8OSxXuMDPfj+N2JgdhExhZ06bHA//Gr
	MEYxB3zgYDNRL3i9VijOSk0+ajMZcPe1kQIKA0q4j5YvgbVxnEnDY7o3JKQryvyuaOXLAkqkoRu
	c4CK3WuERx+93dRi5BMoU0yDevvMLCI45JHqI56ItXe294v0zZDpQ6lLJGGWWjj56iSERj6Vbsc
	KWY0OfWfnJcKqbYnAuhmgo2k/iJvoXrxfoxEjh/RvnOWm4dwdlZXEiE8jtK5Uroa2SA32B9SOp4
	OLr8fQ0e5LBNAxu7MZZNGXDLABolmr13nuWjV4hi1PAXBUXGSoPlEKh1NauMlc00K3FCkgnaaYv
	LaZHevsmr+GD+rckCfYfcGv236tYak/qkZhpho5wdftGGT2jTRSB87P85Vd/5qx0fQoe5cTNwgR
	UrkDDPESUy0i3xtJXh/CH50lVP00aqyK+QQ3rAG+OUsJMaod9tUQ3ubdlzpRHkB19ZnlhGP0b2f
	zrh74NmeiAx3ICnUB8udXrsgQLzEnVqwFsY9dt5hAc7LlrXUOIfqPOwnAsN3PZ1A1rUB53F0JwY
	iCBcrpfg3AInNchk=
X-Received: by 2002:a17:90b:380f:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3b166d02addmr1882552a91.34.1794289194303;
        Mon, 09 Nov 2026 21:39:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168ff86e7sm1041404a91.2.2026.11.09.21.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:39:53 -0800 (PST)
Date: Tue, 10 Nov 2026 14:39:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Russell King <linux@armlinux.org.uk>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-block@vger.kernel.org, Yann Collet <yann.collet.73@gmail.com>, 
	Nick Terrell <terrelln@meta.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Laight <david.laight.linux@gmail.com>, 
	Sungguk <sungguk.na@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-erofs@lists.ozlabs.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 13/15] lib/lz4: switch the decompressor to the
 vendored sources
Message-ID: <avKtyCOOmK3AH0xy@google.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144310eucas1p1d60fe5c2e0170c49f38a3142bb1d8f94@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>
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
In-Reply-To: <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>

On (26/11/06 15:42), Michal Wilczynski wrote:
[..]
> diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
> index 50265e3ce256490994cb6dae32a45da376e408e0..b9b8a5f678c155442fa3fd2c1984e45182e6fc38 100644
> --- a/drivers/block/zram/backend_lz4.c
> +++ b/drivers/block/zram/backend_lz4.c
> @@ -84,7 +84,7 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->mem)
>  			goto error;
>  	} else {
> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>  		if (!zctx->dstrm)
>  			goto error;
>  
> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> index e7ee3740219852f079d1e0866da6b213a3f3a583..1e09c93016264259c149e2913b2819571b56fab6 100644
> --- a/drivers/block/zram/backend_lz4hc.c
> +++ b/drivers/block/zram/backend_lz4hc.c
> @@ -65,7 +65,7 @@ static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->mem)
>  			goto error;
>  	} else {
> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>  		if (!zctx->dstrm)
>  			goto error;

Ditto, outdated zram code.

My ask would be to not squash zram changes with lz4 changes, when (iff)
possible.
