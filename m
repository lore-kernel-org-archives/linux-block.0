Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236824;
	b=tzq3BosUc3zpEjkENfI3NRoKDZGCsRgX5Viv89SIfefyIhNq7AQTKgdYLtNY01w0dydC
	 NeDA7XbJSGpnxrRX1mRoYbPzyM1l0SrLYxOBlegt5PXB4MoELQvtVmZ4Qt2P+MYSZ8Zai
	 /Hv3gkAb8XIcq4UGnDIevtWtjSS/FDSeDih9rer5gGLbMlIA/2pRGu0lKzCOXYTM+cnj6
	 JeuNVWZIJyR7N/v0Ng3MG0ye18ZQb/aPbP40ZXZVZYkJFzGnyTVxA3ipVGZrbb5PyWA2c
	 aWrmrUXINFiN9qzvbxbxEW6MVDtFFylUs+8tHCUnLkN0ZPCVs1eWxC0hfeXYdUGDXBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=raG3vVfUPhLVsBSoXiZmnc5vCQoMo45Q8BuXthAhwQc=;
	b=Mrw0zEQ3+p2z3md1JUqIsfZpcICvCVTwUvL2DSKJcqkOyW1i5il1EXw5eiBHtlURlY1l
	 fYXv0uHtFWE0Y+TrUIIJoZpvGMkJzo/ubZcOkpb8z4JQ8OS189tAW4giKS7nzC+Rdi7mN
	 38/zsbKU5rSk3pQT3QZKhpyHswC5mygPAR98qi7gvhGxhqEW8p6XT9gKtU8zJ5rfYDFDB
	 Z/AyQYE8+9kovVnP9cDdt6y3QMgSvmzLIJ6UqzHWDfn1X5f/CzGTy6WFTelnny2bjylUz
	 tMaOw3Z7b6Kkx4f7EXbfCRpX4UZFc6ZF/lMKtVHGjcY2HoqiDNGZrITaTui5iB9zunw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fNp7cOAo;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03A606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 01:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E03A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fNp7cOAo
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a8cc11ac42so569241c88.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793236823; x=1793841623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=raG3vVfUPhLVsBSoXiZmnc5vCQoMo45Q8BuXthAhwQc=;
        b=fNp7cOAobOXyl9ee8FwtIYxT2SPmIJXZpDuuuWSW/Ccr+kr8ZGhreeyJdC2W4xNEeO
         /NSyCTcO7WmFxDPPsHqsYiuIsWip5WSSqVX2dW9XdYkcXyUAI6xpfclHViwADZZSbCE/
         B5Ns69ZMejPHL6M8OZ5uODg7aRYz2AIvFS9Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236823; x=1793841623;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raG3vVfUPhLVsBSoXiZmnc5vCQoMo45Q8BuXthAhwQc=;
        b=vQ22NfpsEGPMFUZsLxVMbwT497ADCJ3Yc3U5aTzkFO0cvEd/5JuUwo7jrsoh9k+Wkd
         GYYiGfuZkvxu8MFeKp1M37AN+9UEukRUS30L2LU2Np45VxcRlFntAwZOQD9HuYmKV001
         MPVItT+J0FTmHCRqlRU++G5PnYPdrP7C8pDfNzkvfUwt5rAA7cCV+KucFwfPTQzeexnJ
         aYFdhqf3dtPGkcttKni78zfAqpNP0WGfwmWSO/kuQ+b1/WyKAKVg+jGbfwe4FqEtxply
         ERuB9Pf4DDh79BL0QSeXKx7SjkaeDsLi7a/7epYeW+jFlhTnENIhuzzEpZuNTecAdIYz
         tdsg==
X-Gm-Message-State: AFq9FYIvF8ffRFLQWRl8Vatt1XfByAYTF8NwQu29osL4caOXmti/dO0q
	8U1GeuTxzAi4u69DCi445gsIklTHjVFu1mk1FffGU9RpiSnpXiBKWxo2L/R18rdQbQ==
X-Gm-Gg: AYBFou2Ljdx5loIDOSKd81mm4BzjlZKFR/i2OruTdPm7QFpVZS5Lua0ZG7JvOcOBZu+
	l64qpFJl3C7eBbQp39NeSlBhdIsQGM6aeGOBItqFw+2oIuuRqqHf2kofCA2gQWIM9JF2E/txsss
	z2PtAjymeDIYr/+axzYegmF2LwN2a0pl41rhVh7lzBdohLPOnuFZYvKMt2R7gc1AsvL1dasV0+X
	BHgGr7S6Md+o1ES3nW6w7jY0Z99T5Wz54OBR3+YyBOGFdbiL4as8KG63Ass2bYiGAkygHrFvsy2
	0wR3OOcuppw757hwM3ipKsIBWgmWhW643pkVdC2NT/UAF+cZWDa4/RWbpi1f6WQzL2c30WUqvGC
	GnpU7YPQ/4Hf83apsan4mr4HHgv1ilGZV+4Ry2oDCNgPP/s5eMWskWVqECvZcTkpuIxNyS3qzvy
	2iHl8JGB8/ekJww7EpUdrjLZl9pusvioCWJYkn0Xo1lrZDXKXEP5vk+OsD7UkUdSphUTetrBIhD
	UxCRm5LAPExlqLMHx3Xpsw6Mmpc0ZRi+G2ZvkL+ZLwCwA+Cq7xF9hlIUe75bLKEzvG5xmpIKYaB
	i3OCMdgH02QuphCns3dLknL9EVW9fzuSqnOE9Pa5Y9OOclUYNtbgFVLIQxbLv/TSg5F5JA==
X-Received: by 2002:a05:7022:ed07:b0:184:992:c9ec with SMTP id a92af1059eb24-1a6cf914373mr5369697c88.38.1793236823101;
        Wed, 28 Oct 2026 18:20:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:f72e:e03e:c64e:b5b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23908449sm11762231eec.11.2026.10.28.18.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:20:22 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:20:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 24/98] zram: accept lz4 dictionaries of more than 64 KiB
Message-ID: <auKfEyDhNK0lf0c6@google.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-25-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-25-axboe@kernel.dk>

On (26/10/28 10:41), Jens Axboe wrote:
[..]
>  #include <linux/kernel.h>
>  #include <linux/lz4.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
> @@ -48,7 +49,8 @@ static int lz4_setup_params(struct zcomp_params *params)
>  
>  	ret = LZ4_loadDict(dict_stream,
>  			   params->dict, params->dict_sz);
> -	if (ret != params->dict_sz) {
> +	/* Only the last 64 KiB of a dictionary are of use */
> +	if (ret != min_t(size_t, params->dict_sz, SZ_64K)) {
>  		kfree(dict_stream);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> index d8aa01bb258f..d163ff0ae8ae 100644
> --- a/drivers/block/zram/backend_lz4hc.c
> +++ b/drivers/block/zram/backend_lz4hc.c
> @@ -4,6 +4,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/lz4.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
> @@ -96,7 +97,8 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>  		LZ4_resetStreamHC(zctx->cstrm, params->level);
>  		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
>  				     params->dict_sz);
> -		if (ret != params->dict_sz)
> +		/* Only the last 64 KiB of a dictionary are of use */
> +		if (ret != min_t(size_t, params->dict_sz, SZ_64K))
>  			return -EINVAL;

I think this should patch lz4hc_setup_params() instead.
Similarly to lz4 hunk.
