Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670B1A682A
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381031; cv=none; b=NGqzIPrI4bulqWxKbi+Bdu8URsKIFyk3FWaONVKPyy3KZjxME8Fg/dWAx6TimE9bEkIf48lPUcudWFzJuXLNQcXcbBI8XNA02QZEAXoRXn+FbMDhj8AmvqNJclu2ERChjd9sXXyVOliGfWZaLBnQorIh0hRCmrEIxSSMXnFf4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381031; c=relaxed/simple;
	bh=88exG9pmM3SMqGni5Yb7adCKozp57ZgOq/ZTuaDDark=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlujRW/j7EQOP/veOo5MvaO6PZGyaTpSSer3ZF9ggDRFKDj0J2wqqlcXOHJV63n1M0qNCAd6mA+6d5Cm1XwtLzdYzJ4AY9eFZ14poIW9ijxAWPjToTpcJSwYfWUNuAOwqR7vICzE2Yv3Bv3opiRNnB4iBkETlCwSkk5ByDwhcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=naIbZB4m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="naIbZB4m"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1847974b3a.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785381028; x=1785985828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oOgqqXrAi7XNSCeF+yJUxbdmJlZKU68fKb3Gfk4Uqyk=;
        b=naIbZB4mjX93xHikZaPI+kI/CNE8OkfBj20Q/jAo3vnQTIhjIeHhTvAN3R3TnH1lVk
         OfMyPusqyDJIYOD/C/cl4lAUvWDerGRD9PROBmLpcEUgsWHeho8JRzjGrlycZPVKnse3
         1S1mIHTqdH6sYpPSJX0MctIOLyIXxwS0AUmyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785381028; x=1785985828;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oOgqqXrAi7XNSCeF+yJUxbdmJlZKU68fKb3Gfk4Uqyk=;
        b=c2FS6oHH5Cug1fzBqawkEaTtSMY7MJRV6BJ/67qZYppzmrMt/iIVzrPP2R8h37pbn/
         cooNtweFAL++uLCV/dbqwLXWb1nqRl+6VwMyROyvLCFtJn8RAYykeftS+e6WH4FCeeR4
         FQyU3v3vvfeP8xEfXJkHz6n6OxPPMKjfU/pZy/BiuW/RJwo3AlHFsY1erAZe53Tw853p
         O29+UVuveZwXldq6aEf8xcwZEwyAYnrfKhuvuA7MbOy3HlTYNL+/2erJ+bNWhs0izaWS
         aC7rmsVkLJQGKPYHl31ORnHnvACSm/CcxZ06f5OSBzKFwF0cOzyfF2OQ6MEyfiLnfDSc
         91Iw==
X-Forwarded-Encrypted: i=1; AHgh+RqyjVpHYNU9AAbbZqPvz8XNJQbEUXrYv4ZeWz7+oTTN73RmFBbLq5uUR5xXZ43z/ao9y4VjQIBzNDV3ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGb3zNLnrkmlKcCjbseneybCmreKoKL1J5hKnynZK0usPoJSd
	7iQxMp+morIbpya0g9OpqCJRK8/SvHohiFZRenr6rXkjlU7+GZkJAMXdppCV2rd6mQ==
X-Gm-Gg: AR+sD10ojt5q88QByaxvn2KunmUSx947Y4Gd2FS7o5/clsqlyeG58eyvG9zNec16WGz
	bRLC123lNaKPXF55nPXSXA1dJGioTZnTtEH/XX3JVM022LtYzjG4gXJYckpMpH03EtVhmeRYWyK
	ekd5zZKxf1GDHhZKBwPZPQJOZRdNO8akNwUBFc1D50KE2cP/cgiBkANy0ksiqSKlt1K1wofT+wS
	KeiCcYN0o8gowmVtkXZZ3aJSkr7nkMDjdrKLNcvXZHsAC5Z3kg9dVl16GKNWQNJ86DEU5mdI6u9
	w5iDDcFQPGzFfDiCT9dCR89aA5NRVOfPErujMyt4AsbPDJHaDSAl7OPin3O+sLuFvb3oXJc2oJl
	gVOzIRlIrWXmoK+M15r5pkuZHLTVC5o2HK0NKQlxb7M2iODZY2c4puzf106WptmON4RITPAUr8M
	QzxdfPd9tS8Hd0kdIzlabrL0ATuMNKwmowvyZS8pptY/703puOkCmmWR2wL0774eBXQa4tc7p4a
	347rwG22U7L1AyVi/f+FsCAx555DGMq8vLdvKc=
X-Received: by 2002:a05:6a00:e13:b0:848:4809:51da with SMTP id d2e1a72fcca58-84ebc3dd06dmr906931b3a.50.1785381027894;
        Wed, 29 Jul 2026 20:10:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fd2f:da94:c3be:e16c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0054afesm2240292b3a.17.2026.07.29.20.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 20:10:27 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:10:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v3 3/5] zram: add level validation in zstd setup_params
Message-ID: <amrAUPqAqrSzKoNX@google.com>
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-4-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730025240.17724-4-haoqinhuang7@gmail.com>

On (26/07/30 10:52), Haoqin Huang wrote:
[..]
> diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
> index 2584f47c9b3c..6febb366f76e 100644
> --- a/drivers/block/zram/backend_zstd.c
> +++ b/drivers/block/zram/backend_zstd.c
> @@ -60,6 +60,11 @@ static int zstd_setup_params(struct zcomp_params *params)
>  	params->drv_data = zp;
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = zstd_default_clevel();
> +	else if (params->level < -(int)ZSTD_TARGETLENGTH_MAX ||

I was expecting to see zstd_min_clevel() here.  What is this
-(int)ZSTD_TARGETLENGTH_MAX?

> +		 params->level > zstd_max_clevel()) {
> +		pr_err("zstd: invalid compression level %d\n", params->level);
> +		goto error;
> +	}
