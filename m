Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F31221FD4
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298589; cv=none; b=E2bCXdy76+7s6hVOiPbuSeE1HP1DQZ0rrA2+V9el9lytWPyKwREIdZvDFv8p8d+5IjalYMvXhTBi3LGWdyFLQFvWPBw4JtTCNtZVNFdHQ8+mABRdKvz3Rovrceztcj45BgOjRPJeS81IXay+xwlB+8vfZLXoHZhT5He2orOyoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298589; c=relaxed/simple;
	bh=tCXW5t1Mz9P3ETL+HcweC8Px35KG2K6X1VDJxlA4qHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayejs6oPw8lXHtaQzD4Fs34sasHw+88x7N0AbpU1vv8zYTUDL0jdV2SC+ivfV9926VHrYAghvIot4nmz7qFB6Q+L9b6fn+WrStHGWvN0VMR2HXsIa5AcWIf1hSr2R6qFVZbOoduVrAqT5b5/lO77U8d7oLy1GBUBg2Y7QC1yLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OY8vOmZo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OY8vOmZo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf52d15d88so5628495ad.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785298587; x=1785903387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sPPyDnnKTwvEm1ImFa96o4DsnAeC4du8y6Ije+DwQc=;
        b=OY8vOmZoGLlODmTU2A86VOoyS08ZJIdoS/U4oAYhmDsdj9dgMcmR89edgPZY6aTC2e
         1Kd3mSDSbZwQj5BS6e9TE6Bmbmv6jok/iMEWAUaDC52+7nmoVv/0JgtQEdZUrnO3o+s9
         mXn2MU0Z6k5O8lIKt7mt5HNQ+QKKTZf6y/SiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298587; x=1785903387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sPPyDnnKTwvEm1ImFa96o4DsnAeC4du8y6Ije+DwQc=;
        b=DlFxlA1N910909SJ1zAEgxnlWhabBSeGZw7w5x8yOeWNxeGv/Sr+KrY9BEXVgKnAuA
         0M0juMmIM/SfOwmDvLvYvRBPUfGHDz7daIV1mQ+yatj1f4y3Cj7o8jCa5Y+cXzNQ1sH/
         5LjgCw+mzCNTMWGDDUz+pDj8ZtrZ3cpknTOPLQoVEH4Vbl/OldXYv0YJHErf3IkH++Ft
         DDT95q8EB2pfOuVcJtgbh5rPxEEI8qdCDBd8dBvEA51oMVitzFjlMBpSfho9iJh3Hjpm
         YHz0EJX3rrrx5DzRQ/dmRbvvmXe4WO9UM48MMPLeYmfafwh579ODwMk5EjFcacGOSfA7
         KkHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfS+TEVq6/9Z4V6JYcrQJJ1KPVA8ruVtOUgYbskyEVtKrmObBARXY8Xb6tLN6HBvvQWYS//PwNJ7e13A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya1F9JCbSEK/20mCVUD08bfcO9zs8g/9ix/XoMNZuKtZ6X2D7f
	cSbTomm7L5RGRL8BzC8eww9P+mfAPYzukT5XBru8Sf2xcJN44I9XXih5yPTeB/Gcsg==
X-Gm-Gg: AR+sD13fX71AkhE/Y/h/+pmQTkpuNrW/eytIHyAB5MJpg3CX/OUNQbLVd5+31hJOdHQ
	zcjYuVLMoKaesRi0VPUHpLUOyqWj1iMC1shX+W1ONH6358D/NpZIbW4MQyEdW7XwyZUkD+WvFLj
	DgnfWGMORWrfcBlpGq/ZrQgS/Lh2KrH6+eMN/+LjYpUYqLc6M0IWHY2AO+31Y7yR9nPhQgwXuxU
	E1FkhiIgQigAnlFV1O3qlTFWCsYG7YrzSWDoArCdWMXIMBZfzMBYFOijXXUoQhH8N3L0UPS+LWG
	3FyJb1fBgyw8mSmurfBmyGuvy1balTH9bJz2HWCINitEaPAzjG87BtLZlW5ziT5G2eWfSupv0/G
	0H6vzUAptA9PlsDoXE8RNIsThWz82PffF7ZwUjxgQMkD7ECXZPUHHeFORpEmpkoDvqPMxHZnrdt
	5m/uf/gEZfcRuVqXKOlRKLoh+fT6D0XjUPWAAN5DsDwvJ0kEkP+wFbZlbBws86yHObKmK1JfW/C
	h4QX5B+aQJvcYZr4JD1176RhwGk
X-Received: by 2002:a17:903:3b8e:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2d015ac543dmr68106525ad.9.1785298586915;
        Tue, 28 Jul 2026 21:16:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc9fddsm4637035ad.40.2026.07.28.21.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:16:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:16:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 2/5] zram: make dict update in comp_params_store()
 atomic
Message-ID: <aml9GPvZ3lUdnd6I@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-2-haoqinhuang7@gmail.com>
 <amlk3lqSbtfEOkbs@google.com>
 <CAEjiKSm_q1X4O9H44raKYYo8WQRxNRBUN4VFi7+-JW_JkWkbVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjiKSm_q1X4O9H44raKYYo8WQRxNRBUN4VFi7+-JW_JkWkbVw@mail.gmail.com>

On (26/07/29 12:06), haoqin huang wrote:
> > On (26/07/28 17:29), Haoqin Huang wrote:
[..]
> > > @@ -1699,21 +1699,23 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
> > >                            const char *dict_path,
> > >                            struct deflate_params *deflate_params)
> > >  {
> > > +     void *new_dict = NULL;
> > >       ssize_t sz = 0;
> > >
> > > -     comp_params_reset(zram, prio);
> >
> > I don't see why is that a problem.  All you wanted to do here is to
> > handle zero i_size.  Why do we need dict setting to be atomic?
> >
> 
> comp_params_reset() calls vfree() on the old dict and resets level/
> winbits to NOT_SET before reading the new dict

But what is the scenario here?  Who would have several dicts?

  echo "dict=/etc/dict.foo prio=1" > algorithm_params

and if that fails then

  echo "dict=/etc/dict.bar prio=1" > algorithm_params

I don't think this is something that we need to consider.  What am I
missing?

[..]
> The "atomic" in the subject is about all-or-nothing semantics: don't
> destroy valid state until the replacement is confirmed good.

I don't think that "valid state configuration replacement" ever happens.
