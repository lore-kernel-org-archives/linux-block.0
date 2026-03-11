Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE61D5ADE
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206528; cv=none; b=YGuCJ8svAxD15XmPY2uS4nN33bgma+TDgkb1xhlOvQ++Msefy8ZQ6DVuxhjSlmkt0wYterRcIzGdL1SWDtyggyRduG+A9YS+wAIF3RRhUO03sNQGrLlu1kJ2g6lm1LaBX6CXMkgA+UjG71rPWscW7bNp8KaduuQZc0MJayKlTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206528; c=relaxed/simple;
	bh=zan1LPmq6HbmulMzgA9gW+UUtyY5DbZLNRaN3yrnRdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia/Sm2jH0NJSW3oUAi3lPHRQJTxM2F4NfkG/USCt9cqpmy3eUDfJSCa/jpWCnhdIRyUWEyXiAjWmsZsuuDrQC2kiyB4XKlCz6lcoRm+bSOc8e5ZNPJCVil9vg0ZKXL5qmIp6av/euBrwHcI8zzvKQFzwcJxgqQcjnZFr3xUEYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n3X508/B; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n3X508/B"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so4264459b3a.3
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 22:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773206526; x=1773811326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NorOqui97Uy+vQC59x0dyKRHlJOJ9bIHMLqnBZs2Jos=;
        b=n3X508/BMyN/vIirFR8yZFoGj3FhFqg9MViZu+NnjCN8k+wvwY97NaHgHKUXza74KB
         Qd/jpaflMauHqHqMVHX2maMIecDAP+jhkuVBgemAAc8zNbLegdp/r43JMr0AfxbiKydj
         cPEM61axCxeKkvg6VUd2a4FWPUHr1Zq6mKa38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206526; x=1773811326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NorOqui97Uy+vQC59x0dyKRHlJOJ9bIHMLqnBZs2Jos=;
        b=mkiH38Sr3oOKeGJuYFRiIaGvWJtiD/mxbv6iH/oNKgwORnfZmiYOforaJcm/+GpUWQ
         B8VK5hNv1/5iwU4Ic+JGWAApxjU95dydDzWJZPFAi20HV3pB02VVg7/IKTq//gdMaIjb
         waNTUPyJHxRtuRLCeM/CvIbhVZFLmq4/ulYY88YbLF+fH4Sg4bk8uYzSaXz8ptmQJoIW
         nDXmOjSIrb+t9xBxzjrP8U18vGQn81sR7SO95ykLPs8aSotr7AcV3AQQSWwWKk6K6eX4
         EMKzuPIZn0U4UHquwJL3OoId8s51Ekkr5kO/Ih3tZQNE70rfbT7uKP7iT5Pgp6MKqM4d
         JGsg==
X-Forwarded-Encrypted: i=1; AJvYcCWbyKM3K+ihDsn0KaZ7bhGr0rkbyc+eU4eTZTQBHHQyg5eSHa3pYQYfri7rHbba+j8yxVowFtQYoWNLJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BTMz2tQRjuPx00206iGt79XjLGlSUgzat9ZjYUOgOpBbnRGH
	fuXmsSBLs9CnV85A76dU2C/WqeJqCVpHE6ChYNeekullMmOcfeKIcZLYtnSw8ei/n/619YrYldC
	LzjE=
X-Gm-Gg: ATEYQzzk+wLgi4stJjTlOGfZDYYnK2diLkCEbHRXLKT7kpIFAVTZEv+GGldn9ePb1DH
	4utqA3d9NAIvdHfDIxzu67njxaGsrYhOa8EO3bEdNyZuCr0DSyggFQBiFjEaZj9I++pBeDclcqH
	34Vav+j2gr01a8jzJkbIX3soptCUQd8yY1rz19Vdkzj6nio1PJOvm89uLBq4cy+xtotoiJIbHP1
	hYxkVnQmvR6ZqG9AzrqntBBAtRY6YfnZasUmKSE6BxOTkJEpo50CBIgXyb9PIHPqpN97qOPzq4R
	InkGYnrPd61T1v6r88F2LHaYiBrWCAPrKETNj8MZN6tFdcJk2S6CaOW2SGdCAsb4mAGw0JHLONB
	dfjd6IsFRcjTNGgyhWEzAgvUwmtITEsZMxqcCLzwLOvtAelodHVbePlAeDT3z3Qew5PbgUO47NP
	5hgDuOPdtJqXzTpButP4M76whTA2e/GFcrzkUeDUkmw9dYzm74FimDHOIH6mysdLBdCADXxqKl2
	A==
X-Received: by 2002:a05:6a00:430a:b0:829:6f82:5953 with SMTP id d2e1a72fcca58-829f6eee0damr1238945b3a.5.1773206526485;
        Tue, 10 Mar 2026 22:22:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc0c9bsm978368b3a.5.2026.03.10.22.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:22:05 -0700 (PDT)
Date: Wed, 11 Mar 2026 14:22:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: zram: Optimize LZ4 dictionary compression performance
Message-ID: <abD7boWrSrE-2-5F@google.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
 <aa-2nItXDdeDj4Xi@google.com>
 <cfb89ffc52d649f39ec98b844efa8bd9@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb89ffc52d649f39ec98b844efa8bd9@honor.com>

On (26/03/11 04:00), gao xu wrote:
> > On (26/03/10 02:54), gao xu wrote:
> > > +		memcpy(zctx->cstrm, &drv->base_cstream,
> > > +		   sizeof(*zctx->cstrm));
> > 
> > Do we need to do this memcpy() every time?
> memcpy is a replacement for LZ4_loadDict. LZ4_loadDict updates
> the LZ4 hash table using the dictionary. Furthermore, LZ4 also
> updates its hash table with the results of the previous compression.
> Therefore, to ensure the compression dictionary remains effective, we
> would need to reset the hash table every time, which would involve
> executing memcpy() or LZ4_loadDict()

OK, I see.  (I assume you tested and verified that.)
