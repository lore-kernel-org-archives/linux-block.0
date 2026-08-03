Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A7369D55
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759631; cv=pass; b=s1C7G03qXatpn0JRNzC7AHAQGiFs4Q33ZNhdbvwfOttm8tbV4/DpjwUdWuo0mvtuXHU0rCTYyDgClOoxfoxM/CnIDdn2vNxE65TOPUf4GvyQZs3FKqyQDN9AFwDx7znGnzeUD09bSuowEvl/2Vnaq7nBCj8qkF+DkEZ8ukaCRQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759631; c=relaxed/simple;
	bh=rgGsDvmUPa6QzH1Rljaw/U++4UstqmFZJyTRj2fxItI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY6Kt9qjEBxQjJehAnWywAhEtBZqAoaYLDW2S1LQNB6x4ZLnUGXzkIT75MyxS9kPCEoJx6dHdaM37t8AZAwB2P0x0gjGxOMkYtEVFwO91soSlvCtPja6nYX8RvswbBXKPlsDBLBdjmYrRZrkt27Llha2NZrYUhtOFg/IHV/FwHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+kzyY5r; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+kzyY5r"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c1c5cb0f9f1so124130166b.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 05:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759629; cv=none;
        d=google.com; s=arc-20260327;
        b=q6/tpLyEdpW0/X0iVdIXBZClY9P+VZ0n0SwOOWaCLCMujJtztaAmDSkJQXBfOEzmrW
         tkKJnauqRbpcFz9DY5hIovJBcwi3EMEntlkzakIkKx2iU9NoSWPFTZaR54I/7BM2bKYz
         R1eYiNm7zUYETirA9SxprJa8e5UmlU1GfCV56D+C4ZF1SM914IgzXJKbmDSB7ZqekTXQ
         KiuW9slkbav7tMSHokxekXPCDO/Zb5l1FvoNk7ekwwhgNB2jurFaLe1bUzA/rCvrZGSw
         kjqardUyF4G3a1AXUlOTWd6NCRfTChjDoPlvqiGKGBUAvvd283fe0/rCL2kbvn80i0Ht
         mMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3HM/ke/Ra6qi4GyYjAzQ0jHHVFpTHL0tRAJZUWJXFQ=;
        fh=q57qE8qCApUNqdp2bfOZ7N4ofXDtlFO61fRz0WDGvvY=;
        b=dH5CAh2AWGniuTSpzXcmLA86Rbrjk1tgFBcAvfi2OQyYZ3u7/EnY9NXZ5pfcwlvbvO
         Af+0nv7thfQs50uOiLJWzL/HpBtoqxPs8P68fuPV2yPtlxI42KdrcTIe6hGYQ3ZDO6LR
         0AZhqKK+ilGFh1wP2MEcpq3vD3UiOeTwRf+LBiuPhkAbgAW7Wh1N/g02to2GIpXT+B4+
         Uz5PuGPuU/bSPQiC2ifwvORX+4VSqvM9MG4NL96G9vm5WTFcRp/JQfEkOfhcIj92gMLh
         he/4gdA3OLYj9TsBsawS3nrDLZgVkxE4ckUAYXPj0pTd1Ban/K/HZ04qy0unVvrly4e4
         Ekeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759629; x=1786364429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3HM/ke/Ra6qi4GyYjAzQ0jHHVFpTHL0tRAJZUWJXFQ=;
        b=i+kzyY5rZ4R7d+BVWu9Y4pl+2gawWzh080z7HtA5plQ7EJCdUDfeFGsgUmSO6YBqXJ
         GsW9pkS6bw/ou6hwiBnUAzpEHtPIHOxxSJfj9LBo8HiIBHRHl6OnAa25zL51EzfgwVpw
         tDbCVkkB0lvD2ciQAPGJBKMDQk1hszBndVMQ6KDErRnWQhzMUXY4Q3AeA2XLmYNqHYut
         Zkufk0jmMzFXsuGYe0tMUsscW/uYz5PTLirKGSAo1WJzwm9sMFiY4HCjbnw0NPQMAJM2
         koWV3BtWQCMAn/V2vCtf58k6JEAfNoY4axrpLIq+bPtv02pNy3rXmx+KvlSs5UFInav2
         UkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759629; x=1786364429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3HM/ke/Ra6qi4GyYjAzQ0jHHVFpTHL0tRAJZUWJXFQ=;
        b=YZLXPIx1o4jDfbLbtbtuC26lz+BvCsFt9o/qX9eVbouaJNHSEkpFp0bu3bDSaGvM6y
         KwXvSw32OtpabGNmsdt5e8EKJezt9f9d0fWJHxIDJoJerh5EUjr2be6vtSAGCeElA/4z
         NBqOFmEXhDv7lRqlr89ynQyvf2hirHfSgY25rl+zwyjKO1PwAWob62HvZ104b0/M9EJp
         P2Nf9R5TylbTrAMSb7BSYHzt+GriAOfC6Jn7xt5VCwV88RnjnV//sC7eZc0Ms3BbJ7fd
         IHtl51t9zAaFEOG6PYEDlA6uBRYvDtEwP2P7Iv4eV+ja0lV7Ag8fBH37/nNT00KW0iDr
         TS/g==
X-Forwarded-Encrypted: i=1; AHgh+RrqFpl0biC6ysMMgRereKwrxwPGwsAZtOb8NfiVg1W9AMbYpSAmGagVTimNF/qcxkEXwN4F5du9MPatIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwADH7EaNr8cIBanTNw+yyxbk20CN7Pe6ibX0IplJWhrjLcur91
	tSVsf1XyI2jlpBefbTxUSZim6dMoVYhh2R70S2lBjXSYovJvktOJn56nVjlzh4Nf8PwUZMwf1xW
	GOUz+I7MBbf4ogtB169XPJmYX7KVgSmS6YlayVESr1w==
X-Gm-Gg: AR+sD11nckPdME/ovUVQSDEi6ZedRA4RXJYnOfvWjR60A9D9jRZwh48a5NXnVWts0qQ
	8IXHl7FnYMWasCDvdDQc3VlBXFQWy3Ax2AAYuqaBq1/kCqlQYXgJSl/ST0yXpSllXOATHpNgKhn
	NKZqKdGdvYuazGgJMLZ+tUEJ24NZAt2OtbI4tW5anCmEGvy3LxKmI2kBkSwpIdKTMh1+E5Cbd2P
	osMOgkGetgbqubKtoreLg6K8qkamu3OgGI+Lmggy6wosczFrUMiBSv1/QnggnkOYaL+53UT5l95
	ZW0E3eoFyjEU0lxuqA9BzVw44mGMll+WTEdIK7wSZKlmgA==
X-Received: by 2002:a17:907:3e0a:b0:c12:6632:e7f0 with SMTP id
 a640c23a62f3a-c1fe813d8d4mr763972366b.24.1785759628378; Mon, 03 Aug 2026
 05:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com> <20260730060133.80233-4-haoqinhuang7@gmail.com>
 <amr3P_4zxX2w7ZNR@google.com>
In-Reply-To: <amr3P_4zxX2w7ZNR@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Mon, 3 Aug 2026 20:20:16 +0800
X-Gm-Features: AUfX_mzL-WIZeHM99nsy5pfsjGzvVGdRmInAWR1Z9pHEkSZqlkCfmIJP3Iv_1bE
Message-ID: <CAEjiKSkExTnRc77Va-cOSpoNJ4S0i_-r2-iGFyxoSw2mqh1Diw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] zram: validate parameters in each backend's setup_params
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 3:24=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/30 14:01), Haoqin Huang wrote:
> [..]
> >  static int deflate_setup_params(struct zcomp_params *params)
> >  {
> > +     if (params->dict_sz) {
> > +             pr_err("deflate: dictionary is not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> >       if (params->level =3D=3D ZCOMP_PARAM_NOT_SET)
> >               params->level =3D Z_DEFAULT_COMPRESSION;
> > +     else if (params->level < Z_DEFAULT_COMPRESSION ||
> > +              params->level > Z_BEST_COMPRESSION) {
> > +             pr_err("deflate: invalid compression level %d\n", params-=
>level);
> > +             return -EINVAL;
> > +     }
> >       if (params->deflate.winbits =3D=3D ZCOMP_PARAM_NOT_SET)
> >               params->deflate.winbits =3D DEFLATE_DEF_WINBITS;
>
> This will conflict with winbits validation change that we landed
> yesterday.  Can I trouble you with a rebase request (either on top
> of linux-next, when winbits patch hits it, or on top of Andrew's mm
> tree)?
>

Sorry for the delayed response, I'll rebase on linux-next for v5.

> [..]
> > diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/ba=
ckend_lz4hc.c
> > index f6a336acfe20..5d551d165213 100644
> > --- a/drivers/block/zram/backend_lz4hc.c
> > +++ b/drivers/block/zram/backend_lz4hc.c
> > @@ -20,6 +20,11 @@ static int lz4hc_setup_params(struct zcomp_params *p=
arams)
> >  {
> >       if (params->level =3D=3D ZCOMP_PARAM_NOT_SET)
> >               params->level =3D LZ4HC_DEFAULT_CLEVEL;
> > +     else if (params->level < LZ4HC_MIN_CLEVEL ||
> > +              params->level > LZ4HC_MAX_CLEVEL) {
> > +             pr_err("lz4hc: invalid compression level %d\n", params->l=
evel);
> > +             return -EINVAL;
> > +     }
>
> So...  lib/lz4/lz4hc_compress.c supports levels 1 and 2.  However,
> LZ4HC_MIN_CLEVEL is set to 3, but clearly the compression library
> supports levels lower than LZ4HC_MIN_CLEVEL.  In fact, LZ4HC_MIN_CLEVEL
> is never used in the lz4 code.  Maybe here we need to just hardcode
> "< 1" and put a comment:
>

My bad, completely missed that LZ4HC_MIN_CLEVEL is advisory and the
library actually accepts 1-2.  Will hardcode < 1 in v5.

Btw, would it make sense to fix LZ4HC_MIN_CLEVEL to 1 in the lz4
header as a separate cleanup?  It seems misleading as-is.

>       } else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
>               /*
>                * Not LZ4HC_MIN_CLEVEL: that constant is advisory, and
>                * LZ4HC_compress_generic() only clamps levels below 1.
>                * Levels 1-2 are valid.
>                */
>               pr_err("lz4hc: invalid compression level %d\n", params->lev=
el);
>               return -EINVAL;
>       }
>
> [..]
> > diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/bac=
kend_zstd.c
> > index 2584f47c9b3c..4d19d6089f13 100644
> > --- a/drivers/block/zram/backend_zstd.c
> > +++ b/drivers/block/zram/backend_zstd.c
> > @@ -60,6 +60,11 @@ static int zstd_setup_params(struct zcomp_params *pa=
rams)
> >       params->drv_data =3D zp;
> >       if (params->level =3D=3D ZCOMP_PARAM_NOT_SET)
> >               params->level =3D zstd_default_clevel();
> > +     else if (params->level < zstd_min_clevel() ||
> > +              params->level > zstd_max_clevel()) {
> > +             pr_err("zstd: invalid compression level %d\n", params->le=
vel);
> > +             goto error;
>
> Should we also remove "zstd_release_params(params);" from here?
> Same reason as with zstd_create().

Right, same reasoning as patch 1, zstd_setup_params() shouldn't do
its own teardown since zcomp_init() already calls release_params() on
failure.  Will merge this into patch 1 in v5.
