Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4A3563F6
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297195; cv=pass; b=ZWjs3gRz5apl15fx/Ujo1N0FmAzTyfgzrf1fv/WZcsZFFA0oDRuGoj71stKVf/GcuuXGXsrljswckH+e6juROgmSdR8d0dLkNGDAkj0iuI0a1Pltg59JX9jtqR8nX4o+dwXc0UezIZApx2of0XV2ZUNaM522Fh9M2RwANApFd6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297195; c=relaxed/simple;
	bh=lZ9YTz9GIJH/x6U0XdcqNoYdrBoVmeOP1CF+wRtnGt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0GdTzqNWuCniGHItUOqHw5YSkoE21/pLvt1iRYaZfF835JJH2OBmbPCLjyUKxJ8W3owoYcweX529+l82B4KNy0P5TYdzDuaaS4DsNM5fmMx+sHNSUc9J5cR/KKwP9PWTWkJWwjaVZr54fwcMgccMiRFNgs2cgUFey62uJrcQEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2YeIpwo; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2YeIpwo"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15f8dd6f18so29836266b.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 20:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785297192; cv=none;
        d=google.com; s=arc-20260327;
        b=K9L9tWfZwbRcUOmXVcSNrVSRKq6ISy+A2abNBVHRKSGz6r/ULijQDpm79xatvMju5l
         M4IqHxUBdZotXFlD7Ocy5Xj09aR1k2XW2ZHy0yqt7HBAgYSvPPX2TJno26cjpEceMOpi
         vAhC2NOQISrMwTGOk/9tG5NYFY73sRIrxmtvXcO0bwgdqkivv44TfgMozfkgpR2YWVXc
         NwKyOtweih0h5fZGFCDy+RhT2d7iHVyOkGVG/YlRJRq+hdjzRRQc+wHvmlLfPowCD4lP
         kW3LBnvEPM+XZHENZ2tdMjcxA/Ie3kFpfDImKBfgumEhTkL62Waj3BTcPsB9yTFUPxUb
         IPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hHfbXNrMnnCUZ8zoxZON+waobYdfYt3QGWB1lQodV8k=;
        fh=HrTTEBFj/NRrYHSnP3pUgKoemE37TFkVv5rfL7LmNyc=;
        b=C2TEPXAR/26P1Ju+lE1q7/CqlW/XQrnUkDUBrJGrBMoScBkZykvR/p2XHID2hdu67f
         T/hPA3HltdiOPhTMw2KOlYU7VreRtmrAU3bXKMLVk4LKsdgTsupnoRkUva4Un9NvAQnn
         X/dk84+F3jpOCC3BanY1D81RXGxeWwE2eqT87rX344Ng9NmEPAMSFMjtJ4EBtCHl3Nlo
         BUAJBIFLMyTe0BTbgu+FGpuYo9KQfBLos13eogArgA7P54sVK4GgjjGXheEpFuS2wCA5
         Sah0yYOMdrHoNgysH+TB08r0Zin9B9WF9f9/hIyjcELpjxxiA72nFp9dsnd2yZTAjp1d
         3udA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785297192; x=1785901992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hHfbXNrMnnCUZ8zoxZON+waobYdfYt3QGWB1lQodV8k=;
        b=n2YeIpwo+F7xwYWE6BxAghBvjWBDDkMBoecaOgxqJ5TGCdeO23ZF5xxsNzFJuGoJZT
         7jub2Io3+qQv5jcPvlB7b33AabB0wWVm4BjeA29ND7JYrYEaOKguDe7qihow53MGx9IQ
         vArw3+LhElfd+gBWN7iAeCMiiTHlvf37XFeOMjbsH7TLsmLAhYuN4Q+4e5QV/4GmntcB
         oVfRg62kTIfuuHBdMxG2dw2HDa/o0CRn6Lv5a7AFamk2jj0XneGxQ52fSyPpuUjX4k9e
         fx10Jb/UpOXAAYmZpJLPtRVe5quyyDEPYI+UhxMPIl/MyZ6EFnfDQdo8K0pW2p4v2TNp
         yKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785297192; x=1785901992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hHfbXNrMnnCUZ8zoxZON+waobYdfYt3QGWB1lQodV8k=;
        b=QchWVxdA/mxtk7M3ADrPDX2Sa5QCSYzwny8B7Gf1LZUQyIzI9xO8PkSQdspwCEkHAO
         ArpbKSwPeGniFHD0qOK/O0O7zdUdcwUDMLXswOOEcwyF8lkLKSCBWDeQu9Ghvh64A6Zr
         DH1dDD2ABuSV+MUOBTPLsDsnXY6OkhBu+bmWjFdqdMSMBxwstF4w0THPqsRnF18U/tPI
         hOYTvpjbUnputKZUh2J/jLmq29Wef1XFn06ADWeG1Xjc7/0r/FpPvBaC2Bp/cplnVDD5
         j/5WO2XIQ7V0KP2kTfE2a53n75F+DUkNMFI8wyMkLGNgF+XDNpSjV4O5xFHI+p+T1XKG
         a0Xg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4BZ5ghwKnRDyJesViNw1hNh9lSNnzIvcCc5Tzj2e4Q58/7y8YpFCUSvDozZf18afjRLW8PO2Qr1n5qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6GXyLRMda8yjDgidQmoKBAdLzv3/Ubj5uVtKQjxMogUILiZL
	XMvXVmFxaq6dLPdeUYIY0hObBnfqyUAUuug/gaTVm9CHl+syQY43Cxzox/ZaC2e9Jml1Ru9ZET0
	SUuKmAg8efQ0Nil9dnBtdS8apJ+uvEsI=
X-Gm-Gg: AR+sD103V5jSu5PzEcoHLMDuX+ivAftiLgyMqBt09S8tJ8qn/4OpcMY86P0+G96hjRx
	JEvvSXMTfnxJ6uLYe8oLy5VUWgTDpGPkGAM1l4HUyiCKN+Z4NhdoHadnSgXRYBi7IzIhSej7RgY
	AFv8qvcxLDJbfYiZWjlwb6xMevx3RkRqGjr98rHCVenedy2n6IBCVA4fdAgH3BH0KWuh9sasQ3a
	eYSDQk2N8TB7HjfIo9UL5LLsca3jWOztijnVT5H24TQ4mab446EDj0AERyDDoD1Jny9qh2Jm84R
	1oK+6CpYfu8bR+m/r4yi6zd/CoG2dT749EDZao2rlEf3HA==
X-Received: by 2002:a17:907:9813:b0:c16:a402:9d8a with SMTP id
 a640c23a62f3a-c1f71d2c1d1mr266756666b.11.1785297192009; Tue, 28 Jul 2026
 20:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <20260728092935.31139-4-haoqinhuang7@gmail.com>
 <amljgWJnBBJtZ6jQ@google.com>
In-Reply-To: <amljgWJnBBJtZ6jQ@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Wed, 29 Jul 2026 11:53:00 +0800
X-Gm-Features: AUfX_myzZHBgFfjXh9wD8p1O1OLJ2OhNhl0RXc1nAejD-wo_OG4IKu25vRj_-v8
Message-ID: <CAEjiKS=wwWX-2DuqQjALBUJ0-u1R0t5eLvF310bGTZwNepE_FA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] zram: add per-backend caps and validate parameters early
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:26=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/28 17:29), Haoqin Huang wrote:
> [..]
> > +unsigned int zcomp_get_caps(const char *comp)
> > +{
> > +     const struct zcomp_ops *backend =3D lookup_backend_ops(comp);
> > +
> > +     return backend ? backend->caps : 0;
> > +}
> > +
> > +int zcomp_validate_level(const char *comp, s32 level)
> > +{
> > +     const struct zcomp_ops *backend =3D lookup_backend_ops(comp);
> > +
> > +     if (!backend)
> > +             return -EINVAL;
> > +     if (!(backend->caps & ZCOMP_CAP_LEVEL))
> > +             return -EOPNOTSUPP;
> > +     if (level < backend->level_min || level > backend->level_max)
> > +             return -EINVAL;
> > +     return 0;
> > +}
>
> [..]
>
> > +unsigned int zcomp_get_caps(const char *comp);
> > +int zcomp_validate_level(const char *comp, s32 level);
>
> [..]
>
> > @@ -1796,6 +1796,25 @@ static ssize_t algorithm_params_store(struct dev=
ice *dev,
> >                       return -EINVAL;
> >       }
> >
> > +     if (zram->comp_algs[prio]) {
> > +             unsigned int caps =3D zcomp_get_caps(zram->comp_algs[prio=
]);
> > +
> > +             if (dict_path && !(caps & ZCOMP_CAP_DICT)) {
> > +                     pr_err("zram: %s does not support dictionary\n",
> > +                            zram->comp_algs[prio]);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             if (level !=3D ZCOMP_PARAM_NOT_SET) {
> > +                     ret =3D zcomp_validate_level(zram->comp_algs[prio=
], level);
> > +                     if (ret) {
> > +                             pr_err("zram: invalid level for %s\n",
> > +                                    zram->comp_algs[prio]);
> > +                             return ret;
> > +                     }
> > +             }
> > +     }
>
> So I wonder if instead of introducing 2 new zcomp functions (zcomp_get_ca=
ps()
> and zcomp_validate_level()) and still basically open-coding params verifi=
cation
> in zram, maybe we we can just have one
>         int zcomp_validate_params(comp, level, dict_path)
> and handle all the validation in zcomp internally.  So that in
> algorithm_params_store() it will be just
>
>         ret =3D zcomp_validate_params(zram->comp_algs[prio], level, dict_=
path);
>         if (ret)
>                 return ret;

Sounds good, I'll merge them into a single zcomp_validate_params() in v3.
