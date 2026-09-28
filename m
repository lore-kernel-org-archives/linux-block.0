Received: from mail-pj2-f26.google.com (mail-pj2-f26.google.com [74.125.227.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD117D6
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569026; cv=none; b=A9siL3dkpz0SG0i0ddrMjLrqRaBvvMGCzk5pQH1GJLgA0QGRaDnm1yXSBdIfJ44h7oiPjP9LL6oIKGfQv1I9w31sb3X9DvOcAJlhglhkn7q9O0wMyPqLCuf6AGqTHg9+EqGEghKpU4SmgC/D0FdlARTPKh5SwDZ9CBaYY7P8Nlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569026; c=relaxed/simple;
	bh=YTfotWDlml5UR/GBD1wY4ze1xpdJN2PButuZynaIwOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7YfG7Th97X+heI4ZE578GwFHeg7XWB3R8j0Sja4jtBzeSH9GdKaxEJ3R1OO5QNQ0p75t1M5mP2Fkfp9gkHsUlvDhHkjxsHBpEHcnp1hk1XArAhUWmsiT4lqeVtoBD/OwVwx8DRFdzGE5glq8/pJFPTgeNMC8NRzW5hGwf7SuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vl6hKHEa; arc=none smtp.client-ip=74.125.227.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vl6hKHEa"
Received: by mail-pj2-f26.google.com with SMTP id d9443c01a7336-2d8fb334e72so9798355ad.1
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 21:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790569024; x=1791173824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j3LIx4OT6RdJGRg4qDatJ4q0rZ8i4sT2AGqSbaU6cDI=;
        b=Vl6hKHEaXEdcAzoKtczHGRU/G2h/ayHxmm+e+tQu7a8exJeSf0V0VTZUZvFfDEC+qr
         uaS5ykicmMjcPG2F300+GWSGIgoHFryctlqLrq4RX5UIzgXGZOpwYKUq7PSsIJnoA/cu
         Qm/6IBIB0JW+vCRkKg39ZOQq4CH+G65dtOCTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569024; x=1791173824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3LIx4OT6RdJGRg4qDatJ4q0rZ8i4sT2AGqSbaU6cDI=;
        b=w5wODf3ZZv4/OLNuE/5mx01A2lDGOqE4OC90CqaH9QNim78OizllJ5X97BkGM6JfV2
         k0NciG6uFNQRtt8GDw5iGBZ9jvsCco241Wn4xiXuHlitUMHiNFK9zfCVU4+R0QDJboRM
         2P6NtuUjs/IMG+RVj+Egr/OwB8TlZ9KGIKAjvWAaah7NXCN7nqrnjnUBPJAyASz37g1M
         ViCmPjZyiTLVXBxJc80UtcoDSpN55TQ2Yf8XwZK+RxA9ZXsCLDUqFiarGrzRJw4Raxt8
         tr1ihH65ggqCOJf/J67o3i/V007Y125NBXpJK1iB7/ybk3WX7+1y26BUVtcxDKCTr3WH
         YTCA==
X-Forwarded-Encrypted: i=1; AKwUvBzuHIYG7sDtNaFIMIw8R11hbjBnirMk8fj2uWE4eo0azMRt7uw+10fRn1/sKxd4TuM5EulNLrQ9B6kRmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJZuR/of0I6NGl1rxE2jyChRos0pB46yFTT9S7EzwtZF5q0Fg65
	AQWYWYWqTh/OCsGoxw31asZUSbxoSZy4XYqq4xVkl7+ror4B4IlUqIulkguhLEV6sQ==
X-Gm-Gg: AYBFou3L2XTqPgCS9BYWh9jOKF2wu92D9Pmk0vJ7bv5B29KKJNEnKcenpSa6BEsOzLw
	cgTzJeFzKA1Gxkz4cOY/rWwFPRffhXAEhzh+lPZdzSFUMh95/6ePfcZuKUzRE8oVDMa5KVAHMKj
	tC6zpYvHojf9J/lv1ZjgIMdciwceXw1cImoOQyIJ/jOJMM/P5INJTjkV7yng40NZpXTg4Tp8l/v
	hSQAqI7aGcrSwPShIQrtJj+anJPRKxwKtkxFf7Ifg3Tgvh6IZko/c8Rquqpnb/9tcs/i38iYnei
	CvxpfdIyVcjIDks9iMjsMphAhMYViX7sYO88VHubl7HL8CpuEuVahf2YBvDe9jWxGsyX4Gh3kFg
	8QENhRh2o6qM1TBMP4A8qJbkNUVkgOeFihmo0KpiIBtqgGoOmBD1ln+kA8MuTr8oF16k1a7MVWy
	sNR5O6Hl5d74W2CM1+UJrzZX72UimVlbACXdJq6X6ekAojj78RkZPPee6t4QA7A4Q3a+PlgfE4X
	Ld0Eg/w23eDSkY9NBq2JhmTKQPdG13a0JglSQk=
X-Received: by 2002:a17:902:d98d:b0:2dd:c100:7cc3 with SMTP id d9443c01a7336-2df7dd72aa3mr103163935ad.63.1790569024011;
        Sun, 27 Sep 2026 21:17:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e23ecsm35034075ad.18.2026.09.27.21.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:17:03 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:16:54 +0900
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
Subject: Re: [PATCH RFC 7/9] lib/lz4: switch the decompressor to the vendored
 sources
Message-ID: <arnpj53cgDErAQEz@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113504eucas1p25e50de59c02681fc1385220be8acd184@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-7-1c7ffbe21c4b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-7-1c7ffbe21c4b@samsung.com>

On (26/09/25 13:27), Michal Wilczynski wrote:
[..]
> -static FORCE_INLINE int LZ4_decompress_generic(
[..]
> -			/* Necessarily EOF when !partialDecoding.
> -			 * When partialDecoding, it is EOF if we've either
> -			 * filled the output buffer or
> -			 * can't proceed with reading an offset for following match.
> -			 */
> -			if (!partialDecoding || (cpy == oend) || (ip >= (iend - 2)))
> -				break;

Worth noting, these lines are downstream commit eafc0a02391b
(lz4: fix LZ4_decompress_safe_partial read out of bound).

Is this intended or are we "loosing" some of the downstream fixes?
