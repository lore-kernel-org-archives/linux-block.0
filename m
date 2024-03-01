Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C09535BF
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326332; cv=none; b=VXYyntFGtZqAdVzVYwF+V00UUpjcl3w7V5QEw0WUSU+QwNAKXPabBxwLLUBslNCt0F76r22GILDnA7hknBCuGE8HrlQ+lUNNhUK25yTPXELXwPU8/n1QvuAnbNfzCLZLgXMumejHRK1cDlwlcrwffnwgYlZVddiJTEtEc3sfT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326332; c=relaxed/simple;
	bh=aEdgxQYtBECo/5FRriOw1jSVW6tpqxhibPMpXP1GT9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed7qRvDXQzc6R2JIc7GfwoVzXhx112Li52Vll9cK9CrRB4TAdqFzg0m3EXdibscwIUu+j5P8aoS63aejBdRxrXsitixh8m8HtVXLsR2Gl92yHZ2Rb7wctFFT+q8zJZNAiv88HK+FQfz348fbGJ13BALTffjY+9yf04feUXEWxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fcwgQEOI; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcwgQEOI"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso2708564276.3
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2024 12:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709326329; x=1709931129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61skMyHPOZ+2FJBmqHM8+KKn8chujQjCus3XXKYLc+k=;
        b=fcwgQEOILpm5dIp0/t1/e284ZlNEbC+ebsko5qv/ewBgQcZKw7o/UlZvba7KddupfI
         UTmh0uWFtBZsyGO5jEtG8Mh8lLR5EGwjkgQZd7RhHi/mT8E4alz9ee2hk2sNwB+g0Ich
         kfeWcyY7iGyMiWZ8MG81LlGBP5Ymz5yzhj5egH9NyTFic1p/tuSrxF0rfTeQtmF5mV4E
         m5otgAQGNatMURUFC6hSOebQSTbSTN+MFCJspVkOO5vaBgwFewEsk5JMa5yJDTXISWvj
         XFUQE+zBPJnzA/zTRMNuijiDpIBzfmrYbdEOEuiKdPvTYNJlX/qkn5rn7xYTSwWDNSDK
         IBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709326329; x=1709931129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61skMyHPOZ+2FJBmqHM8+KKn8chujQjCus3XXKYLc+k=;
        b=ILkDjjph3yTXchzZQQhoBGjbeaazDRGObRLGzGjmT9Xmeu15T6uvLXsEOiza+9lTz3
         Ns637rN5iAl2ZICUCYy0bIh++Ah08VjbDYQlQibwdfHNWllsmJJsxHDtOdP1zCy4WVCu
         k2AZtR3kBOMBDo9GIue1GHEDxoqswmkCARdK9eMiJkxNSqPtBw+Z8FHHkEoLN0z8waUI
         w2Lznm1DXNwK05GjmmxLzxjd7ohnSCmxa7rkHHeN2EkYFBIb5NfG4JcqyCIVNz8bh/10
         UKh7H/g6uRZ0ygy7/8RVozn2gMZhJ7TjouGFO6dyI3x08+Mak4UnmayKy/2ULT22KMS8
         1mIA==
X-Forwarded-Encrypted: i=1; AJvYcCX3P9Qu7FJYM1ay5NAFuA4vBAbd9sc1fTuWNiSo5hdDb8S3jkCFRkpF9Nqu9OHYEEI15oMAHl3LSPI43tgGUCoMtVchVg1iJcdjpgs=
X-Gm-Message-State: AOJu0YzGNmzldjTctgSq0fD5sRqe+1MixZ4uMbVtnAMqJfJ6lexf2nyV
	Fzd5Bq9apaK6FvTDr8IPj/IdgpBwGSoRJlxcvpxjiLzJD5Ldapv77CvthMRtQ7OoLVV4pFFlfUz
	AdWsAHE9lL1dlSoszBNgZNH3qKiMe5Gc3v64m6A==
X-Google-Smtp-Source: AGHT+IEJTrol9zpTGrc65cEHl5GfDLndKMTd/iMOdDyW2qvdivH31lFCc5dyvWFqQHJfgehgMGewbuCG5BCBavmuIns=
X-Received: by 2002:a25:f30f:0:b0:dcd:6dea:5d34 with SMTP id
 c15-20020a25f30f000000b00dcd6dea5d34mr2859321ybs.36.1709326329380; Fri, 01
 Mar 2024 12:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
 <d5c07950-6f42-4ac9-b0d8-776d444252ae@app.fastmail.com>
In-Reply-To: <d5c07950-6f42-4ac9-b0d8-776d444252ae@app.fastmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Mar 2024 14:51:58 -0600
Message-ID: <CAPLW+4=T1eGrWQcEJWvOcHgq9tnRhfi=AH_=qj1022k2WHmEhA@mail.gmail.com>
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204 blk_validate_limits
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-block <linux-block@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 8:56=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Feb 29, 2024, at 15:14, Naresh Kamboju wrote:
> > The arm64 WinLink E850-96 Board boot failed with 16K and 64K page size =
builds
> > Please find the below warning log on Linux next-20240229.
> > First noticed on the next-20240220 tag.
> >
> > This issue arises only when one of these Kconfig options is enabled.
> >   CONFIG_ARM64_16K_PAGES=3Dy
> >   CONFIG_ARM64_64K_PAGES=3Dy
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Warning log:
> > -------
> > [    2.231008] mmc_host mmc0: Bus speed (slot 0) =3D 49968750Hz (slot
> > req 52000000Hz, actual 49968750HZ div =3D 0)
> > [    2.231714] mmc_host mmc0: Bus speed (slot 0) =3D 399750000Hz (slot
> > req 200000000Hz, actual 199875000HZ div =3D 1)
> > [    2.241961] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > [    2.249182] ------------[ cut here ]------------
> > [    2.252371] WARNING: CPU: 3 PID: 90 at block/blk-settings.c:204
> > blk_validate_limits (block/blk-settings.c:204 (discriminator 1))
>
>
> The warning was added with commit d690cb8ae14b ("block: add
> an API to atomically update queue limits")
>
> +               if (!lim->max_segment_size)
> +                       lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
> +               if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +                       return -EINVAL;
>
> Whereas mmc_alloc_disk sets the limit as
>
>         /*
>          * Setting a virt_boundary implicity sets a max_segment_size, so =
try
>          * to set the hardware one here.
>          */
>         if (host->can_dma_map_merge) {
>                 lim.virt_boundary_mask =3D dma_get_merge_boundary(mmc_dev=
(host));
>                 lim.max_segments =3D MMC_DMA_MAP_MERGE_SEGMENTS;
>         } else {
>                 lim.max_segment_size =3D
>                         round_down(host->max_seg_size, lim.logical_block_=
size);
>                 lim.max_segments =3D host->max_segs;
>         }
>
> and max_seg_size gets initialized to either one less
> than 64k, or to exactly 4k in the dwmmc driver here:
>
>         /* Useful defaults if platform data is unset. */
>         if (host->use_dma =3D=3D TRANS_MODE_IDMAC) {
>                 mmc->max_segs =3D host->ring_size;
>                 mmc->max_blk_size =3D 65535;

Changing this value here to PAGE_SIZE (instead of 65535) makes E850-96
functional again (tested with CONFIG_ARM64_16K_PAGES=3Dy). I'm sure this
is just a quick hack, but maybe it can be helpful in further analysis.
If anybody wants me to run some tests on E850-96 -- please let me
know.

[snip]
