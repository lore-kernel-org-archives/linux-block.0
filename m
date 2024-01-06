Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6591381
	for <linux-block@vger.kernel.org>; Sat,  6 Jan 2024 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ISjjADD2"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dbbc637df7so102849a34.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2024 17:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704504627; x=1705109427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uenrlMRPsRutka3ylqscmBMBSunDEpkSYimf7XoR7pg=;
        b=ISjjADD2HXfTePGW08F17+dvXmmFxIOlFnvx3qE3L0mvzvXDkUBFeX31k95jayWIj3
         nc6hMOaZJb30FD85tc73bd7/2AKtW+1Zj/Feu6hWRx9TyymL1qmia243yhtNbC8TwNXf
         50RZKwSAvh2e0Y7SzDjxTRPkLShJ2PQs5SzAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704504627; x=1705109427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uenrlMRPsRutka3ylqscmBMBSunDEpkSYimf7XoR7pg=;
        b=caWksAzppONzcb4QEai+cycWu1F8YxFILmAfa/OTvwoGOl1STCcJ5RTtcZMusxMH9+
         Lm3q2E46nWa9aLW65wiYh7b7ZV/czUGJmOXpwAb2cPsxkbiVF5FOJ1Fb3ykzAsefFaMF
         gXX+HAk7vLsbyXgON9oF/BeM89/wDUELmeCJo5urLB3mfR2egMiZYmNhmxqVepo/npCB
         ZZXCG3VanSvxb6WWI1p6VUN9Ws1shww+pAzVuQYuCsmKAloEaLSawi9ZwpvCcHw9xuPV
         M5x5w7CLJzMVGxJX1gZvBTdcNVzFwYYKLd35KuIGoemvpaACw9+CtS0+ZzJiXCWXDIqr
         /sQg==
X-Gm-Message-State: AOJu0YyUQVXSC0a2YP203/USxLpc+BA8q27EYOxFNR/6FRfp1sYR3blp
	YEYzGxFAyNP5vVQPjaUmKTxBi0pqlU2X
X-Google-Smtp-Source: AGHT+IGKrZE3RF/VPZPnZJhRPku95hyprnJnVax+/mJZRgJw3HIFof+xXAXIg+RY7oWDic64Yhx/pg==
X-Received: by 2002:a05:6808:1802:b0:3bc:3cf4:f082 with SMTP id bh2-20020a056808180200b003bc3cf4f082mr367676oib.81.1704504626824;
        Fri, 05 Jan 2024 17:30:26 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090ac24300b0028c8a2a9c73sm1919418pjx.25.2024.01.05.17.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 17:30:26 -0800 (PST)
Date: Sat, 6 Jan 2024 10:30:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: easy the allocation of zcomp_strm's buffers with 2
 pages
Message-ID: <20240106013021.GA123449@google.com>
References: <20240103003011.211382-1-v-songbaohua@oppo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103003011.211382-1-v-songbaohua@oppo.com>

On (24/01/03 13:30), Barry Song wrote:
> There is no need to keep zcomp_strm's buffers contiguous physically.
> And rarely, 1-order allocation can fail while buddy is seriously
> fragmented.

Dunno. Some of these don't sound like convincing reasons, I'm afraid.
We don't allocate compression streams all the time, we do it once
per-CPU. And if the system is under such a terrible memory pressure
then one probably should not use zram at all, because zsmalloc needs
pages for its pool.

I also wonder whether Android uses HW compression, in which case we
may need to have physically contig pages. Not to mention TLB shootdowns
that virt contig pages add to the picture.

[..]
> @@ -37,7 +38,7 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
>  {
>  	if (!IS_ERR_OR_NULL(zstrm->tfm))
>  		crypto_free_comp(zstrm->tfm);
> -	free_pages((unsigned long)zstrm->buffer, 1);
> +	vfree(zstrm->buffer);
>  	zstrm->tfm = NULL;
>  	zstrm->buffer = NULL;
>  }
> @@ -53,7 +54,7 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
>  	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
>  	 * case when compressed size is larger than the original one
>  	 */
> -	zstrm->buffer = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
> +	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
>  	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
>  		zcomp_strm_free(zstrm);
>  		return -ENOMEM;
