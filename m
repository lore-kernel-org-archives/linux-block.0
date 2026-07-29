Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5712EEE73
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298584; cv=pass; b=olLrZa+BJ//4O/VzxD2cZY57oZpKsVNmbBZfpuRV91qyYOEylLTLUKyUWNPIdAjAqg8Z7jR+YHGHH46fiYZBKietTnb4WiL3MZrg/Ksix8jbFK0pPhV3SHB8Fa13tebZtQfj36Dj/qXT36mlL6aVlbZbnQ1XF42znvr7+aLVXlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298584; c=relaxed/simple;
	bh=I46EmE+W1ZFgGSsYZENxoXzo4ZCo7+JBwBtj6qglRH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goN43Vjd7blOOcmhmgm0mZ7ELAKD8W0eG1VJJ5smq+8gasKJoVimIdaEZlUrPf99A/fhubtQIqO3nqxekb+zjS5fVOI0EPPx872LoFWBLBIveA0xHCvapbUnewZmm+pWk3WU2e8zqJuzPT531dzVcDNOh1dif0oiWzleo9lxTt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pR6iFarc; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR6iFarc"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15b719d71eso30262066b.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785298581; cv=none;
        d=google.com; s=arc-20260327;
        b=NBJloKnunrBlf5l63y/YE8aUMM3vmaY/Z2UwJqFgQ/xwWN0yI2GpGw+bX1I+VQD28p
         kkBNTSH66tSe6QeMBVKSA81+9Buq0qfwXFRuWiECNWF5gmulAH7yLJ9vn5hnpFcegM4f
         JCVnjIbHBR47pOFuTNnOvrxj93H3HH1hjLu8PMqHWINKJzpiFfl8HzN6Vfk8ppbnseWE
         62aaBlDm522r39P87C33IphJAm3Wc7vT6ac0X3oKB9VeJIBjH7XL/nfPzyHKcnzA9mqf
         IFIa/0JzOyNf6KAmLzQ+cVJjjaM7wbBCkls6PhvuWGSYvEPFxGZQUIw2xtWEdT373Q1s
         V2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=miQDplpi/8f3V3mGk7hG0QYFv1hIYSkFbqF2hjSdT7I=;
        fh=i+IQxTJVa59z92qmHARNi1EI24kplckRlFQMjO1LYcg=;
        b=Kr7J4f0tWkQpgOwTwH4ceDziwHZdykvmrBZJ/TxmptBhf1i8EvTKkW6ySuxLFzMaNS
         nuahmnC9+VCE6q9h34pckFlNNGEtS8vp21vro4SYisr+B73IQ/bx0Asx95Cz/f0A6xCM
         PASqQSclwuWtSsblmn66tMPXeZlQOo5tl8+9rhFesmKeR7QCgozL6p1asiF/Wwwdiq6M
         04uEpfxcwkGvaqCwj5UadGd6e3Rt8X2TJcyHPYi71r/rc2ZZ31ecMNgzB6J3vGbcRwNg
         3oS4KnEZBG3P0FBPL9ZhPB3fjXkA5OHkMSLo5R7ktjyJhKCjlKM0XHgXormplFgTvHDI
         mcXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785298581; x=1785903381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=miQDplpi/8f3V3mGk7hG0QYFv1hIYSkFbqF2hjSdT7I=;
        b=pR6iFarc+1Jt9h4OlLW6hksGk87uoc8vQ4YYxn3NCEyhlP0NXXK9zlcMbyI0JirsEJ
         5Q98dCPW/Puo7mfX8KB1oVPq9MU/KnmhhvXEI3pFZE1du7jUopyGvvg31j4Hs9U+5exR
         97t5PDnHpJ+u+xgNXnnyg6L7/rnCTKE1swaXQCGxoM7mopZWMnf1WP08TdeXstlnhGiT
         BZOHvP2O47jzMjOzPYyV1fZifa9ob3pRfx8t6Qt52R2LUJrggKTIrbTvRd3rm4TtQuWW
         0h9pJhdqnNyodo+5eLL9NG+zekS7abMmeFxLp+d4bX6gsbSUMkkIL51DIlDdc67gKE1j
         s04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298581; x=1785903381;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miQDplpi/8f3V3mGk7hG0QYFv1hIYSkFbqF2hjSdT7I=;
        b=HNWxlC10pabAMH8MaAB2eRcL9xaMgqGA9pQRFLaa6ME3xeRcB08xL5q/75+CaT0XRE
         bDAkghVDAPx1UoChahNu9YUkT1qgH3huJlMrZlumZYDt/CDzMOHJO14XsA1Y/Dd+WrNm
         +0ie59a0u51LA8uwVLpm2U8z0H6OntLdEki8nh6qUv65jfDU7IF0Z/xdlyS9YWC4SM7d
         iYuR7SD/CMzzzCixAgmlANNQBNoPxyuW5djv+Pkk2H/OUNWh5sMh0XnjfdmStvYPX6RC
         9OF2is0jwi8tfLW6+NJ2B4waJOtlCoAWIfujGfRd+J68+yG76ei12sn+9b1CYv3ZBO+S
         tHtg==
X-Forwarded-Encrypted: i=1; AHgh+RppcfJTD+5hKLKkN81aVYngUpT3QC3QgixBrhUmYk34jXtW5WqPd+uTaDi+l1guFfWdfpmlWcKSfx/How==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcyfsKMMOgljKcwwjt2Qi2u0KpTH7sCklHwq8t4ESwzbm8t7d
	UvNrA5JSmEUG+9CUJZqnMubdmti9nTTP5AsNzpJ6IhNZfDrCAj2Lf9iJw8Fzz0KjZAWgyUCD93i
	Sk7SRQw3o5OYTgL7sg4oFHBxmlzAHJ5dY31yktIUEOlXFvfE=
X-Gm-Gg: AR+sD10fiv992+PioIpSnbe6wgZCwNWoiQ5pJsKPyD4rUWrmW1o9gNkTOwnEOm71NeH
	jyuIRcCa/tGNxfhhqDkqA6XImpxMj197C6fErZCmBa98fsspdeVcqWI+Fi88hNhi0QnULqasD0r
	21IBo6rUoActF7fkMb519HztRjUsj1kSqzPM4hRDerPhzxn3WowIKa+ji99ZBtWwLueLpo2fQ2i
	kK53xAO33hIqRQ/YcCLfuVEXncg6z8cHfPSQYSkbhQW58w4rtGCZgweUpsw7Wj+nFf/x5Xe0ERN
	0fevB5hcimMdmcGQwTfa3QJKun4P5jhT/l7Qx2TWNu6uIA==
X-Received: by 2002:a17:907:60d5:b0:c1c:2c32:1163 with SMTP id
 a640c23a62f3a-c1f720fbe49mr247767266b.25.1785298580804; Tue, 28 Jul 2026
 21:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <20260728092935.31139-3-haoqinhuang7@gmail.com>
 <amltU9PgLGZYCD-1@google.com>
In-Reply-To: <amltU9PgLGZYCD-1@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Wed, 29 Jul 2026 12:16:09 +0800
X-Gm-Features: AUfX_mzgjL1N_FM4CTEfcbVxb2rgo5Oa6iSq_96oOiKxWgQFWgVFf6ISshS_HZg
Message-ID: <CAEjiKSkotZQAwUGgAggpS0Ar8Ewo5suB1kDssDK7jw=1w7xDoQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:03=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/28 17:29), Haoqin Huang wrote:
> [..]
> > diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
> > index e295d4125dde..f4b26844e53a 100644
> > --- a/include/linux/zstd_lib.h
> > +++ b/include/linux/zstd_lib.h
> > @@ -1241,6 +1241,7 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_D=
Dict* ddict);
> >  #define ZSTD_SEARCHLOG_MIN        1
> >  #define ZSTD_MINMATCH_MAX         7   /* only for ZSTD_fast, other str=
ategies are limited to 6 */
> >  #define ZSTD_MINMATCH_MIN         3   /* only for ZSTD_btopt+, faster =
strategies are limited to 4 */
> > +#define ZSTD_MAX_CLEVEL              22
> >  #define ZSTD_TARGETLENGTH_MAX    ZSTD_BLOCKSIZE_MAX
> >  #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this constan=
t to an unsigned results in a tautological test */
> >  #define ZSTD_STRATEGY_MIN        ZSTD_fast
> > diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
> > index 6ab8be6532ef..06565e064456 100644
> > --- a/lib/zstd/compress/clevels.h
> > +++ b/lib/zstd/compress/clevels.h
> > @@ -17,8 +17,6 @@
> >
> >  /*-=3D=3D=3D=3D=3D  Pre-defined compression levels  =3D=3D=3D=3D=3D-*/
> >
> > -#define ZSTD_MAX_CLEVEL     22
> > -
> >  __attribute__((__unused__))
>
> Sashiko made a good point.  Can we use zstd_max_clevel() instead?

Good point, I'll drop this patch and use zstd_max_clevel() instead
in v3.

Since it's a runtime function and can't be used for static struct
initialization, I plan to set backend_zstd's level_max to -1 as a
sentinel value, and query the actual maximum in
zcomp_validate_params():

    s32 max =3D backend->level_max;
    if (max < 0)
        max =3D zstd_max_clevel();

Do you think this approach is feasible?
