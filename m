Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A31AC45E;
	Wed, 31 Jul 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424074; cv=none; b=XfCNGKkmFArgk0lBKUVT/1nCn2M2rV2bz2D+iKfpqvSDhVIOt3um3jeyDwp0IrqeUkE1NUxT92vUaiQ8QuOxNXiDxIGIVrVjalmlyZbsVvxld8jrEYnw6gLcL8cjqt7oEkGlk2rl6AtrpPuGdGMU15m6OlMGMvBp1nJ4Ljr9KaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424074; c=relaxed/simple;
	bh=2XIezujcd96fYdk+kidrvyJZCZzYRLsW4NQmN9b+SME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0SdasY+hYMBTabsASS4jNaKPa6BgvUMRe/vkDh7BgbZjphWYdpocAgo5pqDPuynnhYugV3TVEI71byRtoQRjemp3i6DFIjZamfsUxs2Dwc11ZtY8eKnoeQJGnmG0H+oTIRui5URdlraEweiRB6OzJRG0O2MPJKo5PGembim9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKmcsp7v; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKmcsp7v"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368584f9e36so2675228f8f.2;
        Wed, 31 Jul 2024 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722424071; x=1723028871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPLojDhXru3wmfjBui5fentX1cCzpIegWmfdDJsI8hc=;
        b=UKmcsp7vwtHgGqVfLobm60pnynHkoeJr6J34sv5vPjc+AazKy+m1NN3yGCvBlwDvC4
         PX3SGQLYP+fbkMTMZTy/7Ch9tKuaw9twKogaR8GOdv+IG4ZnNAKTS0ESGpjGY6AqG8a9
         S8i8V9bPPk2R6o7pt09UhEYldXop6Y+c3eeY6GNk9h3cUgGABmY8aBw3XaJMz54ujXpD
         +UPsQrFgPF5Apu2KGLUSIgBupD5y2LkUVZTMigNCQ9OlrQoGqtp0xp9nN/VPZ3m6E5sE
         /aEVfTIsn5iwNwolTGsTFqk8WbXCEK1oQktlA5Ac6I04cjjXZYXyNe0hImmJI/AZ9oCA
         t2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424071; x=1723028871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPLojDhXru3wmfjBui5fentX1cCzpIegWmfdDJsI8hc=;
        b=JNpRG+TEI1Vn1Em5148OcTTeERA8uV5+Gc+Lh+ihh2oBw+SwlfF4hlgN6j1BhflBwy
         d4RCHjYZoBOLtrbWNsRAPbUCi7wwtqoJ+dxSnkkq4IO9lE9IGFv5pU35N+TlHuhnGCuv
         2gjgPanY7XcmbS0nHy477uXZCY54pngJ3HVz0oNSY1KFE36xUxWGuB31J6N/c7enEQKB
         xOyf7OKM64dUmFvmLfm6IT6lWQaIfQY5QbRBWd+6BIn3uu+dCXX+HXKAggD9J3gMZYGT
         hkk/ygR4TYza5dwuDXdpJ14JhthHeLPAzDgC43E4TBMjj8WbIrPSiLiDKrZjCSGThLAW
         /d9g==
X-Forwarded-Encrypted: i=1; AJvYcCVejbH1bsxI1H2l+ALgFDXX/f8eot0gTENkF6CmUZWnMKqJ5/QxDbx6Mj/Kb9fdaXlaPGbAhDmzSCGE3w==@vger.kernel.org, AJvYcCXwxVYoXwKagjOQkyiS0kmzw11qsSevFQBu9BywI4gAy2f80rWn3feVS1Tu6TpzQ7SlIn/qKFn13HrUeuga@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkgEnCzn+sG4NozAMv4xJYOLfWJsTVe0I/aLp4JXVeSuTNuwm
	t6mkFLbGtbtGoDFsnUIV4H59llG1Bqn/XCxQfFg/YsqUYrwygyf7Sv8DekC+gurQyUWNA/d9qnL
	Afj19D4CniVsySq5EzXCCy1vLPttwzbva
X-Google-Smtp-Source: AGHT+IFEk68WStqcMrl0oS7X+TXKSqrVofXQ06JUXcRCm6IrEvickdLTwqz/xcOS8mtd6/P2zU7zs7wlHXqCt9AdBb8=
X-Received: by 2002:a05:6000:1861:b0:368:3789:1b6 with SMTP id
 ffacd0b85a97d-36b5d073e6emr10342628f8f.47.1722424070778; Wed, 31 Jul 2024
 04:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722409287-12183-1-git-send-email-zhiguo.niu@unisoc.com> <dafe01f5-5f08-4298-b020-7e3c80e4f15d@kernel.org>
In-Reply-To: <dafe01f5-5f08-4298-b020-7e3c80e4f15d@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 31 Jul 2024 19:07:39 +0800
Message-ID: <CAHJ8P3K6sN2_pNWUNc3C0XhLZJfmFnN7gzC7N70U2M4w6MgJPg@mail.gmail.com>
Subject: Re: [PATCH V3] block: uapi: Use unsigned int type for IOPRIO_PRIO_MASK
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien Le Moal

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=B8=89 17:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/31/24 16:01, Zhiguo Niu wrote:
> > Generally, the input of IOPRIO_PRIO_DATA has 16 bits, but the output of
> > IOPRIO_PRIO_DATA will be expanded to "UL" from IOPRIO_PRIO_MASK.
> >  #define IOPRIO_PRIO_MASK     ((1UL << IOPRIO_CLASS_SHIFT) - 1)
> > This is not reasonable and meaningless, unsigned int is more suitable f=
or it.
> >
> > So if use format "%d" to print IOPRIO_PRIO_DATA directly, theire will b=
e a
> > build warning or error showned as the following, which is from the
> > local test when I modify f2fs codes.
> >
> > fs/f2fs/sysfs.c:348:31: warning: format =E2=80=98%d=E2=80=99 expects ar=
gument of type =E2=80=98int=E2=80=99,
> > but argument 4 has type =E2=80=98long unsigned int=E2=80=99 [-Wformat=
=3D]
> >    return sysfs_emit(buf, "%s,%d\n",
> >                               ~^
> >                               %ld
> >
> > When modules use IOPRIO_PRIO_CLASS & IOPRIO_PRIO_LEVEL get ioprio's cla=
ss and
> > level, their outputs are both unsigned int.
> >  IOPRIO_CLASS_MASK is:
> >  #define IOPRIO_CLASS_SHIFT   13
> >  #define IOPRIO_NR_CLASSES    8
> >  #define IOPRIO_CLASS_MASK    (IOPRIO_NR_CLASSES - 1)
> >  IOPRIO_LEVEL_MASK is:
> >  #define IOPRIO_LEVEL_NR_BITS 3
> >  #define IOPRIO_NR_LEVELS     (1 << IOPRIO_LEVEL_NR_BITS)
> >  #define IOPRIO_LEVEL_MASK    (IOPRIO_NR_LEVELS - 1)
> >
> > Ioprio is passed along as an int internally, so we should not be using =
an
> > unsigned long for IOPRIO_PRIO_MASK to not end up with IOPRIO_PRIO_DATA
> > returning an unsigned long as well.
>
> I would write this commit message like this:
>
>
> An ioprio is passed internally as an int value. When IOPRIO_PRIO_CLASS() =
and
> IOPRIO_PRIO_LEVEL() are used to extract from it the priority class and le=
vel,
> the values obtained are thus also int.
> However, the IOPRIO_PRIO_MASK() macro used to define the IOPRIO_PRIO_DATA=
()
> macro is defined as:
>
> #define IOPRIO_PRIO_MASK        ((1UL << IOPRIO_CLASS_SHIFT) - 1)
>
> that is, the macro gives an unsigned long value, which leads to
> IOPRIO_PRIO_DATA() also returning an unsigned long.
>
> Make things consistent between class, level and data and use int everywhe=
re by
> removing forced unsigned long from IOPRIO_PRIO_MASK.

Thank you for your professional advice and sharing. I will update this.

>
>
>
> --
> Damien Le Moal
> Western Digital Research
>
