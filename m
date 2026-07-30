Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A44377007
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379716; cv=pass; b=X4a4JkR4P+ageIsAdexhP4ugGG+JGinT/xsKkREFHzBQNxVCZhmkMoTiIrxssH5DzpaT0TknkiC7/MWa+vr9o8dzXIUpHTpnK4BRn3MqFJ5dmX51xojRISiz2kBuoyQbrVjHm+0WWTuKofcTHbLpThOgY1o+qaax9K+1tmX3D1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379716; c=relaxed/simple;
	bh=rr1CQwkN2FdE2Jaos8Y5EVXmPkKh+/8z2qhKWbyrmkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYF+BpwblI1LIA44mNY/SYJ7VoiRIdJAJDAVyTbHYvVRsuGajXHSIjqW45rfoOHglmS+PmlMYICx7W5opwkJeDGcZXCgsYTk4y3Rj1CMu2UkVzVRqQ3lt/RCssSjHSDlJhIaLLRB7dNpdUT3Ig/i6/KesE/MNOYx9gKQChKEZSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIcA+8C9; arc=pass smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIcA+8C9"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-c15e03c2763so60634966b.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785379713; cv=none;
        d=google.com; s=arc-20260327;
        b=EA29g8f5Nbjk+dvG9XalDiqBnuiVQn2AKKlz4CDkEFBnvCQ3yo1wBelnKPHN+Iup4T
         5ECa01/Oxdlt+ZZGmt+N/S+fxY5rxrD9oHTLTg19a8RYy7n7pDgr+kVVVd2GSzCYCKjk
         eM2EG2WJds3kn+4MDjXbAoiDCFt4ec3+L80SPrOVWEv11Q9k0oAw2kr0Qnt6NDZNuqbb
         D/7LQQpbDTwReDVMHAvEjxU4lhyqR1QI23oHDtK+PzRcoaiqxJQE0J2NWY/y+4pYnypj
         uRzZbqbqDIc1njl/iMAftfMx/Ct3HXGaNY1xl9qWeG1o4PheHywLyxcodXA41pXEXIH/
         POPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wv7enwJlBcNbdhqAYDL99bi8YISNaJcgIxHAIc4DxT8=;
        fh=kjhHtQjGn7qa/OCLsBuhsp2whPB4+d0oT8HkuxJ6Vv8=;
        b=Dn91qQJoBxY5HkriYRsHbI5WmMovUz0ZD+8f0MWkx9vzuLAir/EMcQR5q65w3ua04J
         OlNcgwBg4DqWwVuyXBAN3Vl31HkafjwuSUssxKXEusHs9qhObVqpJPPchvjZG+93iIIX
         GP5q89fB1m7siMXiFSkic6NVrfP92njUbRoTomsQkEitLIdm089k54equ8lifoSknkeu
         XTBuI1yb4jFGmU1woSQPKzAhmM2fCRhX4+9bcycnQSGGE8z/BZEpdU5b4LTpzsdY/zB2
         gH6FcRnWhCdCVsBgnnMJx5kfmjbAgFfP8XmQtR1fLkFJP1LqRqYhBFohrR6XaFgCLH2V
         L4UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785379713; x=1785984513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wv7enwJlBcNbdhqAYDL99bi8YISNaJcgIxHAIc4DxT8=;
        b=SIcA+8C9k4ce4+FdbKxBHIvgaaNujbdQRpLCLo+ylqQ/3OybphIbPKOcDj1FEDDzqX
         PW2d5zp1DK7CsyeRTNxBl5Qx3zWsN7Hilh6G7UY6hiQaFRttQrDsS8eo9mActJWaRvN1
         RYVqigZ5UZLt03EiOvBlu2dlReIxXYJ/uk4VVFgW1fZrB+VplIOs/OrXoiNpLmFb/Rs0
         R6gyhiwtkFowN+/Lugfdo7SeGp1hNQk26uqRmWweXocqI5zuTFJUF2+gNpghnaZ8seB5
         Jl4oKqJXjQs6VcUqVdy9UiR20I5fZv8DMndUq1qXghaZ70HHIPDA5tDdbiNxQ0GFMor0
         84Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379713; x=1785984513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wv7enwJlBcNbdhqAYDL99bi8YISNaJcgIxHAIc4DxT8=;
        b=HmfYw3vKqEUpjx/EDho/U0vNyrO4W/4URbxIP0Tw554QD4o2Jn2XEEhpn9Yj8C5nNB
         LUcw1tC1HE/dItgKKsL9433faFpulPK08fvU81ubx29TiMDAULxuP4aZZ7XyBntsKudy
         AISue6RC2SPblhReVeSZFnuvo6F6N1HdTJ0dVQufn5jRmdO+tASwW3LMTR3elce72TPu
         3L+gGl1Xb5PDgJcB8zfiNWKfd7a463vZGl2FwioNTZvKQVZrEvgvHE5T04tHGMEeHgea
         cd/cvDXi5MiAnVCPx6IsQsdK4gWMMtAo6qX8FWV1DPdarNZ+obviQZA7U6wTmR3W8oRD
         pmRg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0VxR2KuCSHd9ugATsE/f7LkNq3WN4YCD2+IJ8sEzOhIs9kVWRMQX9+1PPntYFReBDHA32qk+8WUbgUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDmHddcnbRAjP3/fZVnRtPpB/rCnjYwzJ04xhtR528/hheyPE
	HdhJ3wFYF0rGGjVYUkyyYCGtfVdsAqy/7KRWhzc/M++B+7AiDrx5EqFuEqciQhIHxyI2w+i0EHw
	LJ2G+MyVPri+xtGwKGZtkJViYCdG9Bn8=
X-Gm-Gg: AR+sD12Ar5pJcdN01N3NNKovl7+1Ahn7LAs2xuSzOeEkg9OT5sUGUoiKHI66vNtEktQ
	gC5oFU3c6X2YCFQ92jf7/CIW8ubaD/TjJX5qmr44XTvYK4gvsojeFJyOQn9fIhAD6EiEtv7m69R
	qCXhT1IYMr2lWNBzGIW+UjyDx51XB1r0XwMQREWqKi/X3mOG1/XwKKsUVK6y2S3hktq8lR6uGBJ
	992t8XNvIQerLVYyvUGYXsZEvViooykVENtBDInvZfn53LQxqE8BjwMXbKLcuRCe9j/i/+FUKQx
	rZb8R2iY0kbxER+wn3OoayOVnwNujfWgeQTstu1JbqYSaNNfUnotUgg=
X-Received: by 2002:a17:907:a60b:b0:c1f:e5f:4d2d with SMTP id
 a640c23a62f3a-c1fad038c03mr14999266b.19.1785379713363; Wed, 29 Jul 2026
 19:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <20260728092935.31139-3-haoqinhuang7@gmail.com>
 <amltU9PgLGZYCD-1@google.com> <CAEjiKSkotZQAwUGgAggpS0Ar8Ewo5suB1kDssDK7jw=1w7xDoQ@mail.gmail.com>
 <aml_aEB6BDBqgIRH@google.com> <CAEjiKSmLSrfbtBukdC+fRqDY0tOVnyPtnxBEUyhrvrrwLbaxMA@mail.gmail.com>
 <ammFplxvg_6BQRD8@google.com>
In-Reply-To: <ammFplxvg_6BQRD8@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Thu, 30 Jul 2026 10:48:21 +0800
X-Gm-Features: AUfX_mxd182Hcctsb7qVBPeqiGGqgoT4JctLZx5Tc_wSlf--0iE24J3QpN3eYyg
Message-ID: <CAEjiKSkQ2+Amf2SbD09tnmKVKh0Of+c+SSBfEFtg=Lfk+b64NA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:50=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/29 12:32), haoqin huang wrote:
> > > > > > -#define ZSTD_MAX_CLEVEL     22
> > > > > > -
> > > > > >  __attribute__((__unused__))
> > > > >
> > > > > Sashiko made a good point.  Can we use zstd_max_clevel() instead?
> > > >
> > > > Good point, I'll drop this patch and use zstd_max_clevel() instead
> > > > in v3.
> > > >
> > > > Since it's a runtime function and can't be used for static struct
> > > > initialization, I plan to set backend_zstd's level_max to -1 as a
> > > > sentinel value, and query the actual maximum in
> > > > zcomp_validate_params():
> > > >
> > > >     s32 max =3D backend->level_max;
> > > >     if (max < 0)
> > > >         max =3D zstd_max_clevel();
> > > >
> > > > Do you think this approach is feasible?
> > >
> > > Hmm, no, that doesn't look good. zcomp should not include
> > > zstd.h or any other libs directly.  Should params validation
> > > be a per-backend callback then?
> >
> > Good point, zcomp.c shouldn't include library headers.  A per-backend
> > callback would be cleaner.
> >
> > I'll add an optional validate_params to zcomp_ops: the zstd backend
> > implements it using zstd_max_clevel() internally, while lzo/deflate
> > and others just rely on the static caps check (no callback needed).
> > zcomp.c stays free of any library headers.
>
> I'm actually leaning towards validation in .setup_params() now.
> It's not immediate but, first, it doesn't matter that much, we still
> don't create zram with invalid params configuration and, second, it
> sort of makes sense to do validation in .setup_params().  We already
> started doing that for deflate winbits (a patch from earlier today).
>
> Can you please add your validation to per-backend .setup_params()?

Agreed, I'll move the validation to zstd_setup_params() in v3.
