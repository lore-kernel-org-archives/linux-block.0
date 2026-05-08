Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BC33A029
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265244; cv=pass; b=dJZ0VJF01/Khk+vTZWXLQfsucSvvbWPCO8cPYepJ9emvG5SlT7zs/ja4g4T1/e2pGnX7VYPSLHamIffAeqNwU8bCTES3wrttwl9AsG4EnfmIXHnhrEAzPRNQkht51vMxmNVyysW6kZQkj5SHGcSXuaKnDloeOgueoFtiU85c76s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265244; c=relaxed/simple;
	bh=r3XXb9IN5ZVx+jLOe7kh1RVJqYQ8qmUQn0mB+j/aYU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEIqUGxSpNj8JmF/Zkg3zoZv8tYd6b4GXzDqagtGnNvtppRchwsPax9EuSOgWMpEkJevdzLzKQxue279lvdvKZ90mxmpU6FRXvd/oPMs95FFdbTv2E5cXyHWJO6Q/ON+gz/oDXgY2FvQ8Sw9uKrN4681xPmCK3exEE9zXTnIt0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TxWul6wm; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TxWul6wm"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6949e5171acso107065eaf.2
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 11:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778265241; cv=none;
        d=google.com; s=arc-20240605;
        b=d7vkX7YZvXbxWwMxhMDLuzTG1XxQZvwAAGn+R0asPl3PpAy4+OuHLqBfgtvaYlCR4m
         mAUiFwoP55wRC1OQm4ZKjSeSbMJGKoe3MsX9FU6S2XCD58VJ2aTWtu7KuZG226es5oyv
         B2PccbgZUNlo5Nwj4DmTg5YS6EKUjtiVn7DFUhjU70V98wCYMvDDfHnm3c4qtJmE/opg
         wlSAkDQI6UIR10R9d2y88CS7z4nTc7JRyxP7l9e68sXxS1QzU9yfg/vlr6ZKCBhDDZjw
         aY1x3DzQx9EVsdYrTYj6HpirY5ayL29UQ84bWxnAkoe9/qdbkG2hVurKb3zvANV7q7Uw
         NZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8nkOfPakqBrzI3UVxelt6anKkv3W2RalwTF2aEOhdFY=;
        fh=Bmi8VojLQs0RSEBo21hdVt2AXN0PHltAexj7Vt45pZ8=;
        b=IFUOW3cEz54DR89JYG0LpkBuLeqaqvZAeTxgo8WH10TlAkACXWSYIfC5OXX6bkQljU
         XzACQ+awGqgJzQfeg+PHSoN4JKIIQiGnqNG4JBJwviZQETDKnmzZIWSS7SG8y+dgW+Xr
         A11lvXXQpAFcOi/uW/NwdABajqv43IX2AbD5zro5SKMpokZ19NeXte4l+JKoteawk+XS
         TDDGeVCpC07jWZJX6HdC1G0hJTIU+027ao1T09zZ/clkzTNARO7bArQCOMrqiwJJ+lot
         0wGjn2i+uk+31isV1gj1BvcH2r/KGS1hGhB5jZrioVIbLQtA5P1nSM28Y2FQspwBaPa7
         MSbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778265241; x=1778870041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nkOfPakqBrzI3UVxelt6anKkv3W2RalwTF2aEOhdFY=;
        b=TxWul6wmar2qgbWa5kCDCA71H6U0jczZrhTnPm6L8c4/LP8whI/iPF3rdICuDD81bF
         fyv/f8/I5rSWur7buHAqJ93rclHdlhHeH/No54EOKE3I732HGRuA7d0i0j4dRipSMKUg
         dtIgMhZ+LmbZ10RXAzELpiPF0n28uwZRnqdUInNVe8ruhDs0mMcN6fnDbWO0uR2ck6PR
         7Os5qAUm2LpIKDTQHpRr1pNji2/MQFVva2tZ2ZS/4tZf/uQ3qFMoLup8zxJpb0+R9T9g
         R+EOUdQjyvV00yF1A1SWaK+9ITuvkm5Kccwp7lOtW61+x5q+T6+3QS6w41L0+M4N1t2T
         Ot3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778265241; x=1778870041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8nkOfPakqBrzI3UVxelt6anKkv3W2RalwTF2aEOhdFY=;
        b=fGqN7pw/ylW9hRrzHp5Dyj/s4kSuDel5soBsDPZEOq3JNsPO9zsR8D1hjagJH1c16i
         A6ubrANv+jiMaYZc1RInRuqmo9QbchdzE5nPnTogzFzQA60AyRbounjQqIH3G1/44+Se
         2362P/vCRXBGcCqGmcm5BWhFMAN+51wKL7WlTmVqB5VdrCFwdUWJpYYedYYi7v1AumrI
         3ZogaaJqc8nreA0+LKJydn/Zs1ODcXOuARxWzjlKzFWmXOsTMzBRLi3bzAWqQQzE5Mf/
         tEQmJ7wilmFVxDfzaetVOWeIWmrScyi4oBDZ/2zIVEWpK1EjDLMDLcgEY6Hy0wKnelyo
         qP5g==
X-Forwarded-Encrypted: i=1; AFNElJ9HAImqHFju9jZXocxSxOy3ynnih+kHU5RgUU2EXbmrzYdIVsqLegfabg/XXc4Nk3MbMH1JOGMyLRjIfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKOsfVZsFOUtKr9NMeW+KsNOxUIS0Pw/be2Bqtug+5nUdRoBy
	HDSB3QO9i1pbW1UQ8WVjRTta3yp98dtuzFP2YHjujzEZdk1zX0aQPEEOAGrWOnOH4bxIsfb0CvB
	M7f2uJLLrp7KFTJ11wFWRGg2+51CJN6TeBLOlmI1IaQ==
X-Gm-Gg: AeBDietx9umspAdEVeGN7P1LunAX60mXDxJFwwEPzE8Tz/YzYFVKmp6Cksnb3s0O6MQ
	PB6HYV1aJRILHgKqDbQcUXnCaORFOZhC4Cle4/fqdToBrwraPGQxMuhiLY5PWYmEOuh3OzKFG9F
	HIdy896A+AlLROKVImJkAilIWvReUKHnqpqcfWiECEUQnByWKH+nqgw7cumFm58KeazPx+egiUf
	MdkmZh2qggRKtAHmvUiIuiEmUUmEAxKta14IAJcUL6XN35PVHfPBlZOim00QU6jv2wMVdZkF7aK
	V/MshDCV
X-Received: by 2002:a4a:c008:0:b0:696:1daf:3e97 with SMTP id
 006d021491bc7-699abb80692mr1912064eaf.2.1778265240827; Fri, 08 May 2026
 11:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508111329.329943-1-dmantipov@yandex.ru>
In-Reply-To: <20260508111329.329943-1-dmantipov@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 8 May 2026 11:33:50 -0700
X-Gm-Features: AVHnY4KYBHj_X1o9i3IsAyatyr5IiUqrj-vxG_frJgzDpEzijRG1010Eo-aP3JE
Message-ID: <CADUfDZpC5WOBY4_xvAy6ORtgQsxwFYj3Px81RdN7NKQZBFdJSQ@mail.gmail.com>
Subject: Re: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:16=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
>
> Since 'iov_iter_extract_pages()' may allocate new pagelist if the passed
> one isn't large enough, the worst-case scenario may be:
>
> ...
> struct page *stack_pages[SMALL];
> struct page **pages =3D stack_pages;
> ...
> if (iov_iter_extract_pages(i..., &pages, ...) <=3D 0) {
>         /* Even in case of error, new pagelist may be allocated */
>         if (pages !=3D stack_pages)
>                 kvfree(pages);                                  [1]

iov_iter_extract_pages() will only allocate a pages array if the
initial struct page ** passed is NULL (see want_pages_array()). So the
condition pages !=3D stack_pages will never be true. Indeed, it looks
like *all* callers of iov_iter_extract_pages() pass a non-NULL struct
page **. Would it make sense for iov_iter_extract_pages() to require a
pre-allocated pages array and remove support for allocating one?

>         /* The rest of error handling and return */
> }
> /* Regular flow */
> ...
> if (pages !=3D stack_pages)
>         kvfree(pages);
> ...
> return 0;
>
> If you're unlucky so SMALL amount of pages wasn't enough and new
> pagelist was allocated, missing [1] causes the memory leak similar
> to one I've recently observed and fixed for 6.12 in [2]. So adjust
> 'iov_iter_extract_pages()' to make such a cleanup itself rather than
> rely on caller's handling on error paths, thus making [1] not needed.
>
> [2] https://lore.kernel.org/stable/20260505094529.406783-1-dmantipov@yand=
ex.ru/T/#u
>
> Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  lib/iov_iter.c | 54 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..46dd11913df0 100644
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
>   *
>   * It may also return -ENOMEM and -EFAULT.
>   */
> @@ -1818,31 +1819,42 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i=
,
>                                iov_iter_extraction_t extraction_flags,
>                                size_t *offset0)
>  {
> +       struct page **oldpages =3D *pages;
> +       int ret;

Should be ssize_t to avoid truncation?

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
> +       if (unlikely(ret) && *pages && *pages !=3D oldpages) {

iov_iter_extract_pages() returns a positive value (number of bytes
extracted) on success (even if all maxsize bytes were extracted), so I
don't think this condition is correct. Callers seem to be inconsistent
about whether they treat ret < 0 or ret <=3D 0 as the error case, which
is another argument not to handle freeing the pages array inside
iov_iter_extract_pages().

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
>
