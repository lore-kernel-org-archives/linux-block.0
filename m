Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437A3BC685
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396913; cv=none; b=TI3JC8SslId4BcbEg/b2QtN+ETf1wq965XfPdaF17t7SM8qpf/E9yrOt3caGzLQLTW6GczEW9Uco5hfWFZ+SeiZS0nZJxWL44ji6zT39gyWat3Sni26I2/9uM/GLVuFX38kH7nRyZMk5UkgVA/OSdjppL8j18tiI5gpptesd+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396913; c=relaxed/simple;
	bh=wLc4k1j1fXxZ0smM+8WIf1wx40c+WnorH2aWDTqpEfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC3LvvtYIzlOc6+ux/wfIhWSwCyxNYuNuQEN1jYijOiDI2zd36M9iLeKk4RjtFt0FlNjgOclWjDnkA9jq56XBIvjxyPX5dVzujs/d3OvUfd+d7yA6uaKFdi0TQP2xhbwaDm6u+/OAmC08gBgJKWR0QlEjdBXYDFqUwvagB839is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxEyzfN7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxEyzfN7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1839868a91.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785396911; x=1786001711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vSElZmcx3GZLBTKn99h/682uKRLjwH085BtIe9qww84=;
        b=jxEyzfN7LPB2vOdGGOuNzeNZy+wWnOGS2FLMiJ/MW359YQJC7h9/jE+8nHbnMfxnq1
         OrmspWbG3o0j3sZDfiqp7LbAzjB38k8dhEiAxCp1/fl7oWwNM4Ub5n+LcA0B9bwnNckN
         aTDMpIufMofh/C07vC9xEhS6N/Id+DU/0ro7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785396911; x=1786001711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSElZmcx3GZLBTKn99h/682uKRLjwH085BtIe9qww84=;
        b=RAF7nEg+1r5wEWa1yqSCACmtuDpPuXzxlYmNEotUBOhae7JkVPlCfVQ2Rf5w6vBF+U
         KzqVyh4QR2Vm1a/T4vmXLDC7uwBgqgKv+6k7Hooh0LNhWmO7HaFg16ecC8iJoiv3/QQb
         WkGQUZ2grzFuEdgahL+hD7jAEJEhTIH1fzUo/r4M/V4pSrSF/2KEu2AmVr+n8XrsWWEJ
         qWj+4d0XRhKoYieQugIOhIpHdg2rEnUtxon5TILR4r5DhqXIEMAn7jZ+rklZPZiBQqTI
         1AIjdHuBne8oeY0RkyQYvomBpEH28jGxkRnFa43soRmatGPLQXaSA4yV8V1j/hK2nCDE
         W2pA==
X-Forwarded-Encrypted: i=1; AHgh+RpDj0b95dINfsD6fRwRDFdM8nmUQPJ04E2NzU/SgJgVo0xbB+onAcfWgqTqjdBuBOeaJgzdXBzQJBOUOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xYP0qQqNyr2/HL770Vu9g49jQgkwK3B+w//5z0LjDEOIr0Jg
	QgsDUJZuCpD29+Y5OeonNWFBhoWwKGIEtBJYS8ecb6yIs3+OYp04RYIOwzXSCsTU1Q==
X-Gm-Gg: AR+sD11nENnBh9zCbUH0+qg01FvONE2fn3M2xb+JzBH47E3KnFP5a14M2Dy9nVd/vqq
	WueR875k56+VRDXTEmJZQQfCAJU/EA5KJnOkI2NtW+y41G77/h8ml092PBCMbozdsdWUjCGVL6O
	8f1Ke6y48T4cdtLDVx7UYcZUVyVqtqxaEBw9LVUwDGkujSKshWMwBb0bQ8WBsz/sytxyMJphQ98
	fW+e5KY9PtoIQ6o4XH0klE7TyXfHFNSYgthiS6trUtol03KWD8EEZEqduN7pujzSLO1etVdBOrB
	P8v8atqTJAnMw6E1oiHN5zuWlpy6BMZUIqjAkdeDDnFvMJfXiwjNEk5rlCjvkDvZRVCK5KssPi9
	VJ93SIZ8DNOuqIfBSXx3Qunm6nYPiknMBUuGdiXkWBuezXMgK357vBSKSdTeHTvYD5y/Hr4VTUh
	UjlwfLkgepcdiRu8TLCgtnCNSDLaYtVyJ2zQuZBqVhIQgwjawjSulbMAiDpqg6mBKKDZtu9eTRW
	FW6VD56MoTM3bSKEuRqISqjFEnB
X-Received: by 2002:a17:90b:17c4:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38f9bd86f5emr1327560a91.14.1785396910872;
        Thu, 30 Jul 2026 00:35:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fd2f:da94:c3be:e16c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b770e33sm589659a91.15.2026.07.30.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:35:09 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:35:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v4 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <amr-WAM6pWhyVexY@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-4-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730060133.80233-4-haoqinhuang7@gmail.com>

On (26/07/30 14:01), Haoqin Huang wrote:
> --- a/drivers/block/zram/backend_lz4.c
> +++ b/drivers/block/zram/backend_lz4.c
> @@ -30,6 +30,11 @@ static int lz4_setup_params(struct zcomp_params *params)
>  
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = LZ4_ACCELERATION_DEFAULT;
> +	else if (params->level < LZ4_ACCELERATION_DEFAULT ||
> +		 params->level > U16_MAX) {

Maybe there should be no upper bound check?  It kind of seems
to me that lz4 doesn't define any clear upper bound.  Or am I
missing something?
