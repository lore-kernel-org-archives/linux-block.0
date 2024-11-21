Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5522AD00
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204394; cv=none; b=r6vpzXK8WuIq/MddPl4HX02oK7hkWsZ7cEoewXgDSXS0rrGJww8ux7Z4NBy4oWkMDU2BW4Ae20/sHxZNpHzVO1LepBfuJ166XjIXVSL2WQi2bzmJhtKPxSArktkAtQ870LQVemLcALQzLJpmGJIapFfHjw8ZkgwXuqBRqIir3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204394; c=relaxed/simple;
	bh=gQ/7o3NtNQdkt1xIyshCgRb4euFWzBcL0D8LiXhMi8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov6NDBjSN18fbtklHsseBlEvO3pwxBAM2qNbA7ubtp3t08V8EX3acQkXa+CuV8GMIKwDki+IRD/uBd0yEJ9FOaz9sEPZJbzpFYzkXJT2aMbq6yBJ46NwkZvOC2HCe1j3hFzYwcEoekQlZuteA3uOVWU9PktAQvhUB0Htkg2JPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BuF1eEtC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuF1eEtC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-212583bd467so10506665ad.3
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 07:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732204392; x=1732809192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvge4gVLXbEkzNxyNWuzrgHVGstxhxPYrLjNP2/nbGw=;
        b=BuF1eEtCOBnbv5Emc1wfPA/e8TErV9NGEFfLj6sle9dBortvh+3ogEzhunQDRmgTkK
         rMLymbh/EJhfAVzbTlPUWBwGCKHd79Jc4QLorMBvDZJg18PuccWpFhVMjs69SSdNzOQ5
         4xA8oQN2tLRfrC5i8l31qhq4p9nzNUhcs3Dr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204392; x=1732809192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvge4gVLXbEkzNxyNWuzrgHVGstxhxPYrLjNP2/nbGw=;
        b=tM6dnj8ht1U81oZlralHbi/XmuW+3IgHG3zKwTOcU5dt0+gCzKHXMB03yfvaWcArT5
         zj1Lr1F2TfiZhS/8fAAvnJQmOrw7nufI+A3VuNCbywDQmsF1kQWYiSkyWqlpTacBgeeZ
         U51W0i9yG6hN8J/gBepCk8dC4jZ4EjvPkb+8Y2oItc1K/+AtyVYPL6b054WoscfgQUjL
         FaUTkQPXpW2g/0nc5NtNfbwEDiidezsKW0q1FpJcGhXBWHxYfcNMrkUg9xwO1JfR8RsS
         7fZmw5Psvdqv7JpT/kIjqo/IOwnSbyjKgGtEIXl61P2LtInKRcSl2GkoEC/wsVGhmjrN
         HHRw==
X-Forwarded-Encrypted: i=1; AJvYcCVpbNz9jZvRCrtGTb6Wt26B1XoFebJZj4anvrXFQ343OoQE/FPEBWMb62br5SaUkuIDqvJacgOsEBuhBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPR5M5qXB40wlZ0TCQhkv98Gtd2jX0IQAjFxRgYNLvh1aEH7R2
	Un8ge0yJEnaZG7QXRex0vldqLsu0Wde9hvyL2Js7wxAncIxP5utvrfwtanetmw==
X-Gm-Gg: ASbGncvaWjthJ4DN6bPfYhWbegOnmX0GIIoaMElMD8xCpEKYr5hq/hgRsT8+fSYB9jz
	jjr10WwkLU27vDEEyzoXpFKqATDYRScyVDP+H6AS5e1XiZLkfnr6icsDpGfLVrWGfTvl1n2KiCJ
	5SsRYDq41xwDi3x81+Rjl11FMXOOHDtAzHNOy2CHguGx7F2lkZwdHzAA2K26mRs/F5K7ts03Fjs
	49enfKC6HrxC8nvyIXm4e0NGXTC/A8JFn6QAbcFiSUZD9eR3NR7Dw==
X-Google-Smtp-Source: AGHT+IE+4igqunFl1DvRHlIVf/Bz4JhFZQ5n3pWuSu4BGR0fCPYVbkpfSbpwwNCtGXhrwwn3VneJ4Q==
X-Received: by 2002:a17:903:41c8:b0:212:b2b:6f1d with SMTP id d9443c01a7336-2126c1299f8mr101602745ad.32.1732204392296;
        Thu, 21 Nov 2024 07:53:12 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4a18:f901:8114:dc7d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21287ee13fcsm15302955ad.145.2024.11.21.07.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:53:11 -0800 (PST)
Date: Fri, 22 Nov 2024 00:53:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"terrelln@fb.com" <terrelln@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] zram: introduce crypto-backend api
Message-ID: <20241121155307.GE2668855@google.com>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
 <20241120031529.GD2668855@google.com>
 <20241121121120.ch4qbmbiuje2cjog@cab-wsm-0029881.sigma.sbrf.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121121120.ch4qbmbiuje2cjog@cab-wsm-0029881.sigma.sbrf.ru>

On (24/11/21 12:11), Alexey Romanov wrote:
> > Sorry, no, we are not adding this for a hypothetical scenario.
> > 
> > > For example, he can use some driver with hardware compression support.
> > 
> > Such as?  Pretty much all H/W compression modules (I'm aware of)
> > that people use with zram are out-of-tree.
> 
> At least we have this:
> 
> drivers/crypto/nx/nx-common-powernv.c:1043:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> drivers/crypto/nx/nx-common-pseries.c:1020:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> drivers/crypto/cavium/zip/zip_main.c:377:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> drivers/crypto/cavium/zip/zip_main.c:392:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> 
> Anyway, if we want to completely abandon Crypto API

It's more complicated than that.

> these modules still need to be supported in zram.

We support what we have always claimed we supported, namely
what is listed in drivers/block/zram/Kconfig.  That's how one
enables a particular algorithm in zram - during zram configuration.
If those algos are not in zram's Kconfig after so many years,
then it's most likely because people don't use them with zram.
If we ever need backends for those H/W algos, then I really would
prefer a patch from folks that have a corresponding hardware to
run and test it on.  The thing is, zram, in its current form and
shape, imposes strict requirements on comp implementation.

So we should not add algos just because they are there (especially
H/W algos) that's how we added 842, lz4hc many years ago and now
have to carry them around.  We are not doing that again.
