Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9835956;
	Mon,  9 Dec 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763176; cv=none; b=b3F9WLl3WBlUnuenq58YEaI1EnrclmhcR9WP4bAbb4wTn8uQ5QLJQow6E7EfhEi/wn1tt7a2B15aSZtb9b0aLCBNXzZfUt8mE3lgvvWBasqf6z1DRZX7QKsuhWpYv6cI/ByjPxbyKZVEWTKkii5PE0pTU2dLQYQHEZiq2AyH6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763176; c=relaxed/simple;
	bh=BEJSrdcQEMAqO6NZAi7z6/czjWS6uwS86uL3dliZBx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxFTBnOmHSAGh9at9r0nOw+eSoHD8JcxJs3JflVsfDeXpR2xEURHMp2MapnOifblrbyp+U9kNdsGT+fozWArv/SZ2sVkK8GZVenQtgahS4HpCJ9kPhI6rMx2xS/slFhuBVxRXkh23kFLmjWoqlya7yokxVBm4BJaz52HnJxVwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+msIlcc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+msIlcc"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so48130921fa.3;
        Mon, 09 Dec 2024 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763173; x=1734367973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkiWcOXrAlAxqqLCJ/KAQ1yQEFRTTCQcJdAddZbbZ1s=;
        b=X+msIlccZuZE+jDAJg2uxUNYJWvpi7UtO22ReEKtQl17l7OGjKLY9WVBsTgMGNloWD
         z/1e7pUaw/5Ate0u3/fxFG7xTpF7mmVwZzuPiOOuR2kun4uOvcIKHZvtZNxWaASL7BbV
         vLsKDdpfkQdVPURtps+xyw3fiH+awZGc/PDTNm2JvuX0fA+dU7zHamfUC4En3c2bFdG/
         ePliJmRdpE0TzZ6L/JP2oYkRzV0TAiYbi7poCGs06N1gdNo/CXJKL9DuGCoIDubGEA9f
         oZvJQuN4wbG6kR2qGlrjkuygbDo0FdePYxZKa2Y64DF8mLkXHOmObFrcK8QTDIP5Oh9e
         VGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763173; x=1734367973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkiWcOXrAlAxqqLCJ/KAQ1yQEFRTTCQcJdAddZbbZ1s=;
        b=AoDgkOHmNqZXmXGjTMFr6+z7Pwd9P0e2YrJflcu9THJr2PT8AknNtNfK8ZaYStoZRY
         doVAy1TV1Gi0o9aBl+7XJyny1TUDF/8n/OKbU9dB+1Y9cYiUex1rG9FqKQhJnoopNKHN
         wU+6d4ytd1hWrGT5pa6zHQs1t9cGhh9ydjl31Qn7FYchHe+38m4lvF48EDvuTEuhl9R1
         mo83/Jsf4a2SD1E2QcwnAwrMp8TnMbZ2U1uy10dC0p4x2uMlK2IeAQ1zw7vjQJ/hQ3CZ
         uQ6agAkv4NjpRkOKnISSKbXhCiVBAae98aDpBy8P/i7lfYhHSKEa6IFYf7/78Z37heIy
         0UVA==
X-Forwarded-Encrypted: i=1; AJvYcCVwueHjoHlb2yeyrgHY/IQsQUhW8w7vnK4z9tp9z1/ARkv8cxXGlUljAtAHKRUbpFTXghb4AjgCfxyvKA==@vger.kernel.org, AJvYcCW24XNGQiTQD58fHO8Wy6Pi46Ujpqj0wP3PoDP2dpag4yqMbNv1MgRHyuxGmlj2qybyel180kV3@vger.kernel.org, AJvYcCXqRTDTVwcz/p576tEhi1Wdk26R4F28BtjuWOoKtFVmvtqeYsuGE5LMEGtgsPVlZ2nnzd6YvOMcLEU8xtHG@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYmhN11otGaoRQTdTuL6XbbNFA2lJHnix0ROeYeCQsa2V2Mre
	wcZK4AxExcsO8951JJYuWeao9ufc1r4qdBF2jesB2nr21KLYzGI95cmLfhw5alW0f9Ar4cd7u2P
	a6ULhU0fhLQ/0lKfnKQLyjGyJEughWFFT
X-Gm-Gg: ASbGnctAUH55DXMAUHvP127J3Q2ATOV3cVjpl68wKImfaBH0mZhr2hUdgHoY61F1tJL
	cdZ9rY557jg4cHSKwGfXlimeuXzTAjgQ=
X-Google-Smtp-Source: AGHT+IENQl4Nc5lF30ol6UXzbTLguVyc/JsFURLtyoI2Px1WGiLmX0RVNAXTyxminD80fO/yjJS2UhJ4fkEeaNVOwtY=
X-Received: by 2002:a05:651c:1602:b0:302:29a5:6dea with SMTP id
 38308e7fff4ca-30229a5719amr14979111fa.27.1733763172455; Mon, 09 Dec 2024
 08:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204180224.31069-1-ryncsn@gmail.com> <20241204180224.31069-3-ryncsn@gmail.com>
 <20241205070939.GF16709@google.com>
In-Reply-To: <20241205070939.GF16709@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 10 Dec 2024 00:52:35 +0800
Message-ID: <CAMgjq7Bf=m-KUkZiy_7pFcE=8U0yvy0bqrUNkGj--asMbMC8vQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] zram: fix uninitialized ZRAM not releasing backing device
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Desheng Wu <deshengwu@tencent.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:09=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/12/05 02:02), Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Setting backing device is done before ZRAM initialization.
> > If we set the backing device, then remove the ZRAM module without
> > initializing the device, the backing device reference will be leaked
> > and the device will be hold forever.
> >
> > Fix this by always check and release the backing device when resetting
> > or removing ZRAM.
> >
> > Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> > Reported-by: Desheng Wu <deshengwu@tencent.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/block/zram/zram_drv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_dr=
v.c
> > index dd48df5b97c8..dfe9a994e437 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2335,6 +2335,9 @@ static void zram_reset_device(struct zram *zram)
> >       zram->limit_pages =3D 0;
> >
> >       if (!init_done(zram)) {
> > +             /* Backing device could be set before ZRAM initialization=
. */
> > +             reset_bdev(zram);
> > +
> >               up_write(&zram->init_lock);
> >               return;
> >       }
> > --
>
> So here I think we better remove that if entirely and always reset
> the device.  Something like this (untested):
>
> ---
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 0ca6d55c9917..8773b12afc9d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1438,12 +1438,16 @@ static void zram_meta_free(struct zram *zram, u64=
 disksize)
>         size_t num_pages =3D disksize >> PAGE_SHIFT;
>         size_t index;
>
> +       if (!zram->table)
> +               return;
> +
>         /* Free all pages that are still in this zram device */
>         for (index =3D 0; index < num_pages; index++)
>                 zram_free_page(zram, index);
>
>         zs_destroy_pool(zram->mem_pool);
>         vfree(zram->table);
> +       zram->table =3D NULL;
>  }
>
>  static bool zram_meta_alloc(struct zram *zram, u64 disksize)
> @@ -2327,12 +2331,6 @@ static void zram_reset_device(struct zram *zram)
>         down_write(&zram->init_lock);
>
>         zram->limit_pages =3D 0;
> -
> -       if (!init_done(zram)) {
> -               up_write(&zram->init_lock);
> -               return;
> -       }
> -
>         set_capacity_and_notify(zram->disk, 0);
>         part_stat_set_all(zram->disk->part0, 0);
>
>

Thanks for the suggestion, I've tested it and it works well. Will send
a V2 shortly.
