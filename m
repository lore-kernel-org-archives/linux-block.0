Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F85356760
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572753; cv=none; b=djrersKwrkEqJQyhF73L7CTbAba4e0jlLLaTWM6WjNXkx7WvIztT4Na15NIxO4SLVSvTHtImEboCH+dtasiYvI6QE4IMTST8LesiHDVJagvh+UVcnmG2ZIQXm1zgiNaOmkumW9U5K8u+sRP5YV/5S3u4iG25EIDqgISqyNy1msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572753; c=relaxed/simple;
	bh=If6eyZW189bAWCED7HJ77WUzjEmoh3HbC+AtCUG98As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsR7h4Sxhm0JjuOLnKPMjRX1PDMNt4hWnsM1n7erldWEbU899n/jJVXiALRl64xINcgJ3P+qvapmCnRMqG8X9I3NyR0wVHkJGPaOl5N+q7nulHriDe83VQhZ9JesQzkjs7qvH3gccD5fsz4gS7WPePUVepmWWQSypdTFxxp0IXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VLsnHB05; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VLsnHB05"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b6200eb0so1932491a91.2
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 22:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790572751; x=1791177551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=;
        b=VLsnHB057PEqj83Cxn2yIfI+0MQoBNKmIded6dZ0nn1+ILxJUjWxutQUwC+y2sPiNA
         aI7sKbUXLH4zAqRUFKE7Jh67iQkWCvWPsKsZ4AQZlLlrBT68v5eADSnOMWla3s139WAC
         f50tjpI4WgqLGRh6nrmNJNv75RsAaiuO0tq8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790572751; x=1791177551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=;
        b=dcAFvJd0Jq+wahlOFMgRm80XgYf6MtXjHyRy9G0CkOHwiyPLigos8s1bC0Zmo2uSVK
         E8iHUWOkUklWHiYQ7uQ7eYQTtJ4Y1NPLmiUjr7v12OcaFME/7ojozTxodcWV8tJjr3EN
         UqD4i67bnaBv0CoqD+OsMtmThQLBu1JOMcu9M1PnPT9LAsSKSFo21CcFmdEGb8BGKFSR
         iFTza7Efns8t7wMr9Rc7lLfVN9+6pc5hl8WqquhH5lKK0rtQ8pxlpH+6qmhyzunYCqLo
         x8knQjaeOe4lTWlyZk4wASeObOOv4Gpl2mNj5Hkp7941LjanLWhX6Wi6MFve90KPGH/I
         9mIQ==
X-Forwarded-Encrypted: i=1; AKwUvByeR//9YxEOAJBQLvqzyo0G02fV0GhAU5ANdkJozOi4+kFhpP+DvZ0MesLIWMj4UvTkclmR4ttAgCSVKQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6QSloSkSGjOm3pA339zdlNYae2E2Bb41olTWydrma4HkupP8E
	Lue1Tz0ml0HvmKzJZqqSZlcEvCjwg1AvFf02M9yDZ5uqnJowxyINAS+B8nlgHRlQoQ==
X-Gm-Gg: AYBFou1yDZ7KoB3d+YWdU2o8J3chsWBB5ea+Pe0/hW3J7Nn7+KE139OCWRcFrTtcI/k
	VqczS9mKnfpiSNwJ+aMR16S4aJ47krnTbbVY/+b/aafgzu8djYf8UlgkztQQ6yBXRwVIdOPayuT
	MiyRpQtr2cvX/vvSlnRgXl9A1xuQ/wg0CLzkiEv+tvrRu+sKCIPdAF0Dv4mZ6NmQ0UyeUOYpLRj
	4KsxTrU2BK7hj/Ldi+kXkOaLM2CBDrOuI7GAW+9bHFZdLtqUbTZBKPQJudhrHfeRH1tz6KYfk+L
	CSOmkiDzgCWztBAPX9T86oXYfrytaziIk7KYX8MEgndm/HuXpII6fC03w5FHT+GDDI+/RBcNgUQ
	65NKBKCoX2UKSIXumz7W6//iy4WcVhm4I2l70daAvzrjD3hcmnqq+ddcy6cMA42X22+mWz5AaGT
	2T4dWbCd7fBYpHHz1qdrXyip4DaXW3OetI9GZPHvxJkw3x786S5zYSmvl6KfsqLMn8alAM0PzU2
	3dc96XwiJb1BiYf9URqbvHWE5Q3j3DsQ7SkWhM=
X-Received: by 2002:a17:90a:597:b0:3a0:a055:1759 with SMTP id 98e67ed59e1d1-3a0bb60e55amr5032133a91.40.1790572751469;
        Sun, 27 Sep 2026 22:19:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm18408378a91.7.2026.09.27.22.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:19:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:19:02 +0900
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
Message-ID: <arn3TC7BgjTXWmdG@google.com>
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
> +int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
> +{
> +    LZ4_stream_t_internal* const ctx = & LZ4_initStream(state, sizeof(LZ4_stream_t)) -> internal_donotuse;
> +    assert(ctx != NULL);

Probably in some other places as well:

LZ4_initStream() can return NULL, but the code immediately derefs
the pointer.  The assert() check seems to be misplaced, unless I'm
missing something.

I suppose those need to be decoupled.  First LZ4_initStream() call and
NULL check, then stream->internal_donotuse.
