Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDC353A7B
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568756; cv=none; b=ABun9bqF6X2z4zVDNWZmxB3anXYiUNT/GDaxh1ByIgoh3bTGK3ROu4A+TOkxGdGmymjr6mekqYfqtU/B1ClTVyrpZDf8g1qFBB+rMT73wI+n4lIBBqMHSv7yHb8SlXaKvFMVhwyAPmEfHBFlUA3vdWOso2l5yYucEicQmtA9XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568756; c=relaxed/simple;
	bh=/sOtv+Jy0VfC/zdAlOtrQTC1fDfCRtKdJKUcnFIpFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4Exz/rkgXBmleTthvndR1EzPxQ1D2lXf2aqkGTQNIeeviCAnbIeGN5/CmnlAjuuzM4tO4fZMPXFdcYExIV9nIWeP4aVS43QluoDrRshqnpva+jKR7KyNbe5AdG8QlcTsH7gUiuEaeVci+sSU4pqmySUr3OrASy1JMo7IzcJSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KEIR3m9W; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KEIR3m9W"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1deaso482474a12.1
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790568753; x=1791173553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=;
        b=KEIR3m9WIJGGxbDxu5WT7d1D8pdjysg2u6EOJPP2gwFE4OJjvQnJ287pxIflD0w4Cg
         3KRo1HxvqGoz0UssGc+2rSuTUyOtycuRzbtmoCDu1UD7mwkHfhAOWZum2XbziBA9oVWv
         jJBljzLhKQzGV32PJczj1FgBrq2QfJL1amKgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790568753; x=1791173553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=;
        b=FmpSKdfgC9CHlvdg+PSEB/eK/gNB2jnVMh2UwUVc/1G+iduTjGgPIbL1ZFmDdvOFaP
         zi6qOYH4dD8kFpCiNBSrpjTjlhdfsnBSu/MT86W/7xSKzjRKhSnxwZomfg1jOvMKqbuc
         2r5O9ie0g5QlYIrdZBpc1SkpR8TK808jRSL8bQQNhnmMU5XXS2aitrwq1PHcmwLn+yN7
         otGpKw+0p0BendBu7KIzKxM31E9O5mNCStl7P1o9to+gtbfmNArHSiJPyD9O0sdF1g6A
         +IuB7gAiACHBCq2925c0Uo2SOrS2tbKKfkk+3SiTjPO4OJUR4HR5kFoG2EspCvaqa1Hv
         FCbA==
X-Forwarded-Encrypted: i=1; AKwUvBwYgbnwQ8Fg9GDLtmIN0xOCF3/7Hj8VfAUOrUuZVtznRH506s0k6ZXfMAv0v53yFVra/2Ki9o2qW+tb1g==@vger.kernel.org
X-Gm-Message-State: AFq9FYK3Eng1wFC5XR4tpVkukb1BAcRIFF27lHiLUQVKK6QprqWmsJIJ
	Zi8mTq9h2ftZFO+QgOMq1AuWp/Pl5gyKxRN9sOgArW/i4+wZmpKRHLBvjja6jpPgrA==
X-Gm-Gg: AYBFou3eWtuDTlZw2bCJgPN3QIHEhiVkNfk1aNc4rKk99DfFvMcaUvD1UTkEAyxpkKE
	eCHffvqrgV6gdqyO5/OhK6D/tkFEmO9KfTMje6VjzdOQxA2BxThUAf5J/YEvIkX3J0bu5jkXNum
	7cAc5IzNBZVGWPLvaKBFA0cFOF27GubwLejz2ta3GNtUrNAKZKoY4quDz2fq4v+A57BP1Y2GvZ4
	+UBykqb9CZz0goXnRf11/fdHbc6hk5D25T5TumbIaAnotvQHSVqth7MAEXsYWg5e+Hj6RRJLC0Y
	ZpWXwuOOPKXJRmLhJfxU9rsjOvFWxp9Hid7iNNAym/TLxYDVXpwRaThgtG85B53uMY5eLn/fZ9I
	Px5tXkDH0+HVpeua92Upl3zuqMiM6xFDx6NHbEtioX47dPmro22l5XnBGFbbVQdi0nhNZpPuj97
	de9rc9H8DrnO/2R98pDY1wPl1l2ALSOE35EYUbN87GS+PGMoB0LulxtANQoCoZ0amENvkxl9Haj
	pbpRHXwWU6V3wTHX0bBgoAJWxsLAjMWxuvUf5Q=
X-Received: by 2002:a17:90b:1c82:b0:3a0:7d97:37c1 with SMTP id 98e67ed59e1d1-3a098aaba1dmr10891588a91.59.1790568752817;
        Sun, 27 Sep 2026 21:12:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm17381254a91.15.2026.09.27.21.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:12:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:12:24 +0900
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Sungguk <sungguk.na@samsung.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC 1/9] lib/lz4: import upstream LZ4 sources verbatim
Message-ID: <arnosKlQYVIdmTR7@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>

On (26/09/25 13:27), Michal Wilczynski wrote:
[..]
> +#ifndef LZ4_FAST_DEC_LOOP
> +#  if defined __i386__ || defined _M_IX86 || defined __x86_64__ || defined _M_X64
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  elif defined(__aarch64__) && defined(__APPLE__)
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  elif defined(__aarch64__) && !defined(__clang__)
> +     /* On non-Apple aarch64, we disable this optimization for clang because
> +      * on certain mobile chipsets, performance is reduced with clang. For
> +      * more information refer to https://github.com/lz4/lz4/pull/707 */
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  else
> +#    define LZ4_FAST_DEC_LOOP 0
> +#  endif
> +#endif

I just checked https://github.com/lz4/lz4/pull/707 and it seems that
LZ4_FAST_DEC_LOOP is enabled on aarch64 now, but we still disable it.
Am I missing something?
