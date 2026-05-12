Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65483D9693
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607986; cv=pass; b=WoXvIAnQq51mgyXTocY29eSKHRxA7i/jEE7ze9h7xsXGjgykNRFqeu2Aaz4xAhMxNldoRDZ/2QYSd5ZZEjg3aOCyAm87JVabfFjQ+lpseVqFwS+KUW9401sRV0zl8PvgbYiINdeoAfTyOszgt4KJgGt5UWWIlxoKK7eptX8dLLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607986; c=relaxed/simple;
	bh=Mrgr6G0kHwIbc8j4jUJh1eocVZ1V3eXYBjlfyutvb4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2zKnjGYBC0mYmQY4bfxyICvUBoAcDYZewLZ0dq4e1OqDMzgDswrfEJudaYqeMZ3V3+PYPhFLg7ISjrGiDJVAM78AhE3FWHbtBX1vOAGcWVZOJa81TSu99PyeDD52sg7f4BQ8Oyyf0gLRjVoEnZSXxUjgbUmxMDDM1989LRLMmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Iwo0uzcF; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Iwo0uzcF"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-694907f7967so376878eaf.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 10:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778607984; cv=none;
        d=google.com; s=arc-20240605;
        b=NrVqlIO1PbgCNGqAYlCQ8q4HIVA00G0BQCIsM2xlHgA15b6UaOihpgGHLOs82Ypfft
         eAUMD5yjrOln6e/vQ4W2HXxHc198DyNu1C2pI5J3JPe5SZUiY7wAom6fLFzZ+v4LXTLX
         TZGYK1LvelQy1+CnMWlQTIraWGgd9bcULtssYCxpypwqwrQHCEFtw9Zk0DZc7sH6GT1I
         PKIu1QW4TXq8sn8QZRhs1ID0PEMvRYOPARIKvvJDO7RJFK3e9cL755D5qg7rOUqIp2hL
         4TMzQ/CCWHulgZP7za1bq0Ee2DhaJdt6UC7Dg7Kb3CY7Y/B+hOrA2YXK45L+/sJy2bE9
         THag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        fh=TZyFy4R6L/4Wg1WWWp9Ozg9Mba9/OUtFQmx5qpzRpyQ=;
        b=fvKajy6ftNlnB17GZBBAGdS0HY38xj5Yo0H8VQQ32SKiS4k/g5ydCg08KJIe/ThKsP
         nTF+7KW4OxbYlRuXLQfmkj7f1P2FRoYLyOhHoprn2DlbREMmTbAgWlVS+KHYoSLpIuyz
         cb//nK/ZNIlos1Kh2SaA2JiHduNetwRHBPHWJ3J4j2V85SFT07YCu9qqtlexvjkBWKKE
         2vKvnN+yJYsM2u8BQJAzZxfkhrS7BJuDLBzOHm+nrJk51Q4BM4uxEveHrKy0vP1OJg5q
         Yr56PQmYs10YNQZTvw3lbOQzLe9yzcrSsmGaj6IZOY1usX9SwzE60H6nW8whO+fQt8au
         a40g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778607984; x=1779212784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        b=Iwo0uzcFki397oJwDPOoTKXwX1nbJ21i+0UA23U/HMR1954yhI51NNMAwSbN4+VuAY
         JCXwclucYyC6+XY6eamugvaLMwtAe73F/1ZKE0FMYgABDLRlJmcmbtDv6f8kAsnNyP0B
         GHAQpFkyVIdLRQMF/ttQ/E82YQKEEtPKUGqASLbdD4SlXL6bnDHUOLV4cHdPY5sPegC2
         w5k0PJkKe9L4bz1VFL2llk0m/UghXimx+DsxXv1Woqhqj8X4BL60MgWGjZDp24zc24Tw
         Ydvr5JBrTbMfECbIJnwlkhFqI0o8ZPsq0nKoQekxU1kiixc9vhXp5CKrvxJTJkSzTPHt
         ECmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607984; x=1779212784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        b=oAQggdXWTO5kqALutH9/8ajJit2LYtEnC3WAQyx2pIYnaOLF1cu23qul2TItPs4bys
         g16pgGGjhAuKio5EjP6nZYT4Q5wUIYkOwUCdRAXufj8Ehgbz2UkFjZjDO0wVcV+psm2c
         0pUJ3ywwz2Rz5/Ho9R16Gr3fwjqWGuTEo+clAkIBpRUtCeU9wvVk4XWVpogumChyokv6
         qIqQH5+UrgbmEDA0cFsPI8zLahBqoXlIqoWAfsv0PlDH8adVFAe99HTzsSLWOsbUR6T3
         FEQ6ohtcRiQK3YxvCY+3u5xrtUUH9vVhSeaQYnWivebtfwom0+6EWiEzB8r/ZG5tDgeY
         S0+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/X9DJHAp0a5ftrsslNcS/2QzRb/16mnkeo7YW684u9Uh25vYOkxoNhHjkSr95P7TJcy8pLySbhB4FUqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLfV5oHwTELf5tVih2/CccJbWDGqWZRTJN78ofXRCCFvYpuo5
	kP2JLnaaSPXqZGjcb3QBJ0k4RnsnfL4MlyzY0cWE8T2zR57H8wJRQaw2GYHqyGeE7XPNMbJmKEg
	VVCcjJHn3NHGSXoXhZaVaL5ptN4MtvbvB9JV7JmTPGg==
X-Gm-Gg: Acq92OFT3RDeSYIs+YYMAk1f7FUTck5lLbCkaPCQVS4P9ivxnPt2MhESYp1xUGYy9hP
	bAykkyHm5MBqYi4tdKp60UK8Zny0m9B+QE9wJnfGvcLDdjTVZfdnSOS5+eHIMBYAjr7GaMIbPIK
	4zbPW5XTFI6B17gL+xM3ZbQa+aRSgRTTyapHK0GF0kUNj+DFSsiHFpsJ6Dh/bJkqOdPzRragAj6
	rBFCG3OqiU8gdxN/0LXuYXPR7QOeGT+JxQtKNenY47pT0lbSfmdIqdBW7Ldrd5drHnCljvfpatQ
	qqiVL1jg
X-Received: by 2002:a4a:ba84:0:b0:696:1d76:9dc with SMTP id
 006d021491bc7-6999a3b813fmr6694789eaf.3.1778607983722; Tue, 12 May 2026
 10:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512170525.357573-1-dmantipov@yandex.ru>
In-Reply-To: <20260512170525.357573-1-dmantipov@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 12 May 2026 10:46:11 -0700
X-Gm-Features: AVHnY4KWcjBva7nw0Ibsy4xgzTd5kc75h1GtStF_42Kjh1hgALO9DNt1vTHxy7Y
Message-ID: <CADUfDZqnV5BRwZq3c3Atu8w3gOm87AbmtexL=MenWcSbTVOgvw@mail.gmail.com>
Subject: Re: [PATCH v2] lib: free pagelist on error in iov_iter_extract_pages()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org, 
	Fedor Pchelkin <pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:05=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> Users of 'iov_iter_extract_pages()' may provide small, likely
> stack-allocated, array of pages by itself and then reject to
> use it if it's considered too small. In such a case, passing
> NULL pointer means that 'iov_iter_extract_pages()' should
> allocate array of pages internally (via 'want_pages_array()').
> An overall scenario may be:
>
> ...
> struct page *stack_pages[SMALL];
> struct page **pages =3D stack_pages;
> ...
> if (not_enough_pages(SMALL))
>         pages =3D NULL;

The example is a bit over-complicated, this can just be:
struct page **pages =3D NULL;

> ...
> if (iov_iter_extract_pages(..., &pages, ...) <=3D 0) {
>         /* Even in case of error, new array of pages may be allocated */
>         if (pages !=3D stack_pages)

And these checks could be simplified to just if (pages)

>                 kvfree(pages);                                  [1]
>         /* The rest of error handling and return */
> }
> /* Regular flow */
> ...
> if (pages !=3D stack_pages)
>         kvfree(pages);
> ...
>
> That is, if you're unlucky so SMALL amount of pages wasn't enough and
> new array of pages was allocated, missing [1] causes the memory leak.
>
> Currently 'bio_integrity_map_user()' seems the only place where such
> a leak looks possible. Older kernels may have more. In particular,
> 6.12.x has this type of leak in 'bio_map_user_iov()', and it was
> found with syzkaller and reproduced experimentally.
>
> So adjust 'iov_iter_extract_pages()' to make cleanup [1] itself rather
> than rely on caller's handling on error paths.
>
> Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list fro=
m an iterator")
> Cc: stable@vger.kernel.org
> Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: fix commit message and issues observed by Sashiko
> ---
>  lib/iov_iter.c | 54 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..30c5baccc6a9 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1807,7 +1807,8 @@ static ssize_t iov_iter_extract_user_pages(struct i=
ov_iter *i,
>   *  (*) Use with ITER_DISCARD is not supported as that has no content.
>   *
>   * On success, the function sets *@pages to the new pagelist, if allocat=
ed, and
> - * sets *offset0 to the offset into the first page.
> + * sets *offset0 to the offset into the first page. On error, new pageli=
st
> + * is freed if was allocated, and *@pages sets back to its original valu=
e.

Clarify that "error" includes a length of 0 but not a positive length?

Also not sure it's necessary to say "freed if allocated"; from the
caller's perspective, it just looks like it was never allocated.

>   *
>   * It may also return -ENOMEM and -EFAULT.
>   */
> @@ -1818,31 +1819,42 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i=
,
>                                iov_iter_extraction_t extraction_flags,
>                                size_t *offset0)
>  {
> +       struct page **oldpages =3D *pages;

I think a bool would suffice, as pages will only be allocated if the
initial *pages was NULL.

> +       ssize_t ret;
> +
>         maxsize =3D min_t(size_t, min_t(size_t, maxsize, i->count), MAX_R=
W_COUNT);
>         if (!maxsize)
>                 return 0;
>
>         if (likely(user_backed_iter(i)))
> -               return iov_iter_extract_user_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_kvec(i))
> -               return iov_iter_extract_kvec_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_bvec(i))
> -               return iov_iter_extract_bvec_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_folioq(i))
> -               return iov_iter_extract_folioq_pages(i, pages, maxsize,
> -                                                    maxpages, extraction=
_flags,
> -                                                    offset0);
> -       if (iov_iter_is_xarray(i))
> -               return iov_iter_extract_xarray_pages(i, pages, maxsize,
> -                                                    maxpages, extraction=
_flags,
> -                                                    offset0);
> -       return -EFAULT;
> +               ret =3D iov_iter_extract_user_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_kvec(i))
> +               ret =3D iov_iter_extract_kvec_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_bvec(i))
> +               ret =3D iov_iter_extract_bvec_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_folioq(i))
> +               ret =3D iov_iter_extract_folioq_pages(i, pages, maxsize,
> +                                                   maxpages, extraction_=
flags,
> +                                                   offset0);
> +       else if (iov_iter_is_xarray(i))
> +               ret =3D iov_iter_extract_xarray_pages(i, pages, maxsize,
> +                                                   maxpages, extraction_=
flags,
> +                                                   offset0);
> +       else
> +               ret =3D -EFAULT;
> +
> +       if (unlikely(ret <=3D 0) && *pages && *pages !=3D oldpages) {

The mismatch between ret <=3D 0 here and ret < 0 in
bio_integrity_map_user() would result in a use-after-free in the ret
=3D=3D 0 case, no? I guess this should be fixed by the "block:
bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()" patch
that landed today.

Best,
Caleb

> +               kvfree(*pages);
> +               *pages =3D oldpages;
> +       }
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
>
> --
> 2.54.0
>
