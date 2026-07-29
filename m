Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5033E348
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291989; cv=none; b=OliosqUIfXevTjnaxgOTfadDhR7BbtF4D2ygMpYKHXr50ewksd1OLVP7leh9LkuH3seONHF/XUh18nF0/i7FKeBgvSGEqZN1JnRiieV6Fo2L/Bvr7sav8d6LuRCHMM13fm62+z2LEIIoUmBIep7zEXoGt6ocI46Btp2+XpPA2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291989; c=relaxed/simple;
	bh=hivAOR8N+Xt+ufInnjZZnb657U+WLEFfjWzHl8DOtuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkXNtEgxaCkbpMhR3n34Jf3ieGmcnTcgifdtjWLG/wWaKFT2And6aXCfIb2RPhsUk6wM3HRP5YHaTsJHFzYWmE/S9VbUiMo8rZSM8RNJjkRMw8d65X8zusIOFp7rHOp6O8LNevzFiThLTIqvEIiL0BGTSYLp8oD4p3yaQss38kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h397NECU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h397NECU"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e04df8c46so513315b3a.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785291988; x=1785896788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kpraT4CawMq6YGj/IbrtX81/Emx0E8iaFU/2bR4eB7M=;
        b=h397NECUh3ONoodtEzp20pjE1K1GQkUe4/fhWVr+iYzsAr4SpASQGN5UHTHv/eCwzj
         mHMtfEJdM0CItySHkmYD+X3guUmguizaEKGM3E8/bUoaz44MZcnL1tRi0LG0EOPWG3ZO
         1XJJbrWMNXiW0Mx4BzeJkfKxztinchruUqs20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291988; x=1785896788;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpraT4CawMq6YGj/IbrtX81/Emx0E8iaFU/2bR4eB7M=;
        b=mBZG5iFzG1/wIsK5KTA4AFyRUCKXivXK9jyOg+j88vjBGQcjxbHgeEUSfxZbdm4799
         b861lrxfN86nZzt4jIvbwXhg/mVm6NkScP84T+Ws8wfYt7mKsbqDfsmoUlktTFGvgw47
         8trxxcEr3mnH/Tg1X8uLDNUMzO4nnvn2P63WYmgztJ3+RaP52kZe7qVPfbICbCyvz1wP
         ZIbopyLUK3I1yYziu/YWqdIfEcyr+Mv4a3JP8LsH1kM8MYA6njP6hXGVNApBpOwGZ+ci
         aMxIqq/VMIl24jFZqKifgDPc3dQOYsSXj62u/aQYwXuoMt16KweiZ/3FFYez2WoxJ6n2
         JgjA==
X-Forwarded-Encrypted: i=1; AHgh+RowEV8bqTpTpbueni7ommJEMk45LrD/ZOmSuwSO8G9AoRq2pJdE8d3Y8+ueWUl5HXuwgiiRgr5lZMMoHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynh/XQn8vtSkmAD3PYSNZBsxjp7sGkV6xRj1tJFkSAiE/0AZw7
	RVxOthNkttk5A//4Bp9xaeQa+07vxEdnQ4iC7dqOHoHI3wAhHqG0ZAatS2gPO3D+EQ==
X-Gm-Gg: AR+sD13VxFdtwRKWL14nifVdCmI19ejNOPGfgTiTcfsafWgpQ5Wb9KcLrH5uC8tYHpj
	hMD4wpvauz7C1v7qXnbrc39E9XMdVuCP9d90ga1l/aijbJgKGphZlXvHOQuDIAAnBKSsoZwSgmN
	HyIPsWCGKSokXzgqL1okwrAFzyx1GrFBzFIF65y07Wgw/UBE5+E95t6v3RSbL5gWx1MIFy2eeRG
	rv1FFrcRFzwVgnt9kolaa9a1yBq0SV7eO9GIOTNwxD61ttyW7r/8rC2pVgv1bV4Pb05QTbvQdRe
	uN/JETUeoDSYQsexd+yhiM3t1kXJDUTOZrfOpjmVE/OlkdVzDaOEoOLEXH+u/awdMcJYERuX4qv
	HPJBXMTHZuTPX1hmsNqePoRbam80l0XplEHJmGSQeZ/vtR3OAMXb7h3dmrEOXniKuhIiP0ch1n/
	r4Ub1RcZBTEtxYGT/tLCUhXm7J5d+q6xi6IZM0RB2uN/YIC5bkitnIAyaVCOOEvwVJcuaQQtT0r
	7PSZxRX8LJHUqOJ2H2yMe4lzXWV
X-Received: by 2002:a05:6a00:cc6:b0:848:467d:293b with SMTP id d2e1a72fcca58-84e931b505dmr4975846b3a.11.1785291987708;
        Tue, 28 Jul 2026 19:26:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb83459f6sm231635a12.14.2026.07.28.19.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:26:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:26:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 4/5] zram: add per-backend caps and validate
 parameters early
Message-ID: <amljgWJnBBJtZ6jQ@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-4-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728092935.31139-4-haoqinhuang7@gmail.com>

On (26/07/28 17:29), Haoqin Huang wrote:
[..]
> +unsigned int zcomp_get_caps(const char *comp)
> +{
> +	const struct zcomp_ops *backend = lookup_backend_ops(comp);
> +
> +	return backend ? backend->caps : 0;
> +}
> +
> +int zcomp_validate_level(const char *comp, s32 level)
> +{
> +	const struct zcomp_ops *backend = lookup_backend_ops(comp);
> +
> +	if (!backend)
> +		return -EINVAL;
> +	if (!(backend->caps & ZCOMP_CAP_LEVEL))
> +		return -EOPNOTSUPP;
> +	if (level < backend->level_min || level > backend->level_max)
> +		return -EINVAL;
> +	return 0;
> +}

[..]

> +unsigned int zcomp_get_caps(const char *comp);
> +int zcomp_validate_level(const char *comp, s32 level);

[..]

> @@ -1796,6 +1796,25 @@ static ssize_t algorithm_params_store(struct device *dev,
>  			return -EINVAL;
>  	}
>  
> +	if (zram->comp_algs[prio]) {
> +		unsigned int caps = zcomp_get_caps(zram->comp_algs[prio]);
> +
> +		if (dict_path && !(caps & ZCOMP_CAP_DICT)) {
> +			pr_err("zram: %s does not support dictionary\n",
> +			       zram->comp_algs[prio]);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (level != ZCOMP_PARAM_NOT_SET) {
> +			ret = zcomp_validate_level(zram->comp_algs[prio], level);
> +			if (ret) {
> +				pr_err("zram: invalid level for %s\n",
> +				       zram->comp_algs[prio]);
> +				return ret;
> +			}
> +		}
> +	}

So I wonder if instead of introducing 2 new zcomp functions (zcomp_get_caps()
and zcomp_validate_level()) and still basically open-coding params verification
in zram, maybe we we can just have one
	int zcomp_validate_params(comp, level, dict_path)
and handle all the validation in zcomp internally.  So that in
algorithm_params_store() it will be just

	ret = zcomp_validate_params(zram->comp_algs[prio], level, dict_path);
	if (ret)
		return ret;
