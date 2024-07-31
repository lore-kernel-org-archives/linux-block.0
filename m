Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4D1B14F1
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444416; cv=none; b=eg3o7JkZ82JzK6hDpuW+GeFNgCRQy8A8K90q0Uu/H44Nv5nDtsR/R6H+5nVsaC+tqSCR7eutd3ltnSL0hnhSuxyNHoOXQxA0Tdrm4X3ptqmMCtgDfJ2guVJc4zAXkDgL1ymJBqHk64gbP+Ykz5u5IkHnKO2rAfIk+3wYRVhBpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444416; c=relaxed/simple;
	bh=DPC7a/ItVVS/ZUsDBa3A34Cag7H61CGwBsA/cvnuO+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwEj4TpseF9tLPur/aQ8CKSGc/0Y+g8OsxgfCu3XB0588OmuUOm38TByhxZflyMXtFxiS0bimB4rJieQROgB3oWphzC389iLCKHkdEiCLqicUnLtx3d3wpAH1Bp6h718yNfvz6PJ1UIvmBZ0GmkcCZ+I7+RZ0j58YPsBXn4xXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJHtM0RG; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJHtM0RG"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db1956643bso3736343b6e.3
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722444413; x=1723049213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y17BSh/uyhoM7VykjQAyLacxqXElZzql32CV9WyQ20=;
        b=pJHtM0RGdLn5+O28CzkMS+62BASSYNGIjbh3LTlIWM+rmVD4m/sy+flHKKJvMWNNdR
         0JyVBE0aA0oDIZute/5Wo+kOyfhU9UUVxmUUqI2+ThmVNwo5JrJkXZ0/pNx1Th+AYeSU
         oKvYKE4izz4lL789eHTT2PRLUFu41SB9wAIyIakwXMxVOORt+gBfZz/2FTGs/W2HYGDb
         +RnVS/3jzVGKEpjtcuEmNmzDVlwCiFmAd7YMCBegauOBOB61ojDwvOPvkA/UWETvGCCw
         1dMEVsYnYYc7GLHfoTSsbv3P8OSCKA7tIoAkuijcvoxMrZ/quL4eu8lopXXM+Ro20z2z
         Ui6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444413; x=1723049213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y17BSh/uyhoM7VykjQAyLacxqXElZzql32CV9WyQ20=;
        b=EIvxdxUEFIByFMEckgd8hdD9M+vBmr7wo2vw/CGS4+cZhCf07m5q0VWLrDQgrGGXCE
         VelM6+K6reeVsyYDpUW1FGXscGZhD2y7XAVBp1HZBXaj8+gfyP1HlzP9nssMSp3m5kl8
         z7FstRlgfuQSRQRw1v/VAmgAJhD6C1ztA2H6bnr1lu2rr81QgJg8hpbM2Dri821jUNwC
         eb7m2J1wmM2cVm9KxFmay/JP28HgpcDshrIHxtOgB2ZbwzU9svGid9mMEPj2AzFXJOkd
         qWVBQ+G0zt+IevbXXIyBJ318PZfuf8MyjUTJY/66XPaJQiyhTLBPqgsY1Rd/3ZSMHETQ
         zvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqvbly1isvb43hiC854hmX+RtNy5uiQEFZ739G2wFYFy2rAuKRlv+cZPKHFxZA46AU++HotME09etUao9HbvOOhZ4nBAH9RVxQ2Dk=
X-Gm-Message-State: AOJu0YzGoniWY/hFlqSQBB/xA3W08sW2u3sz0J+iiYEE5/XFantuBUKK
	S87efhwwKNPxN4KPPi1nUmX70pGqq4yz/Oy+HvKGH9pVG496lIIIDzxphjYTUug=
X-Google-Smtp-Source: AGHT+IFRqHHmQ3zAhsmwrlSOV1mFp0GjcMDmn6Si4PesAAvwXnlJVIJpEu0YlsAaasZvPrDHo57arg==
X-Received: by 2002:a05:6871:aa06:b0:267:e2b2:ec52 with SMTP id 586e51a60fabf-267e2b304ffmr14807007fac.49.1722444413477;
        Wed, 31 Jul 2024 09:46:53 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:c572:4680:6997:45a1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26577239eccsm2721257fac.53.2024.07.31.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:46:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:46:51 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
Message-ID: <ea202d37-7460-4e45-9e19-6a2b23ada0a0@suswa.mountain>
References: <20240730151615.753688326@linuxfoundation.org>
 <CA+G9fYuGGbhKgt6dD2pBCK1y4M3-KUhPZcw21gYtUFzQ32KLdg@mail.gmail.com>
 <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>

On Wed, Jul 31, 2024 at 10:13:26AM -0600, Jens Axboe wrote:
> > ----------
> >   ## Build
> > * kernel: 6.1.103-rc1
> > * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > * git commit: a90fe3a941868870c281a880358b14d42f530b07
> > * git describe: v6.1.102-441-ga90fe3a94186
> > * test details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186
> 
> I built and booted 6.1.103-rc3 and didn't hit anything. Does it still
> trigger with that one? If yes, how do I reproduce this?
> 
> There are no deadline changes since 6.1.102, and the block side is just
> some integrity bits, which don't look suspicious. The other part this
> could potentially be is the sbitmap changes, but...
> 

I believe these were fixed in -rc2.  We're on -rc3 now.

regards,
dan carpenter
