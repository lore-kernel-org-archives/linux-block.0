Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21190143887
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169449; cv=none; b=J68FeBT1oAlew+HTm+oi1/713Nm7AkHrnRCM0xS+V3996Fuu6VgMp6zbk+jydjm6Rgc/Yk/1SjVWXo6heVlDSS1r18B3Zc9ntBUUgCKhChcfXZ4K4dTvLy4x6bHEnP66u5ZNsaI4W7ZEFk6Hlom1eZcbL/uMc8sRpNmmrLMdm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169449; c=relaxed/simple;
	bh=Ysknbk+hiZgDVZAUXq9FS3NO9wuZ3Nb5zi3xvAsQbTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpNTFiIOO8ArDR6juAk5yvl9Ro5JyeAWjsAVywo2lOXlVS2/GbILfVcyAkobVQFXl4cqU+uUlqLIk/taFXKPWlzUFZGYRS836+/bcjdtvsInOJ810UytTN05dIOY8SxHxUp2+olM9dZJv8hhKC1+90ShFsSwZOhTCL7cUuaOZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03d49ff259so427422276.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 01:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720169445; x=1720774245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp67WgAJJ4FXBbGl+w7rf8SvqvtYOO80Tf4oX8oWCSc=;
        b=KIW7Kbit3jDEKPn+oRE0Zj1VVDzRxv3H+0ze+cvX8Itiib9hqOky5t48wtY9yaHKCZ
         +sLIXf+YSuCM1vZttlabd4rl2LwAfO8oR3hQAfAsaQjIidFBxvm8GWgfiASW1MJ8PlUC
         yHkHLtK9U5PQobLqIvnSjsJWYplcsc/EgHve4iQSAPjtyG75ASZkdlKsUmtjj2nmGyk8
         ruVl4xqgg3r4b997jIpWczalCtnCKCYt/ohd35QYeNpdJ3Fed2J2mCI4p0dcQbQIB989
         jQZnowM8CdyzWavodcqBze0bRfwn8Mtl1ZNqK2yHRjr7rljZA2fpOtKnD6NB3Z5m8DmA
         RlPg==
X-Forwarded-Encrypted: i=1; AJvYcCVN33SyhasTYuRJFfc71uGk4ItsMYddh6wWOBgpelIUFbniwig9tiNx2IkO2PtzFp80TEvlWNQm0wcQkP5OCGrr4CMIx8SM13Qj+qc=
X-Gm-Message-State: AOJu0YzprjvzmsKsq31ayHeOO2qT1hHSb5WQ9E8OZ/Lsz7rd5xxZWArg
	XzpA9Lt625s1KYxGuvinvv8ZK9egHblBtknelLGix8jTk1OWq2i523UJa11s
X-Google-Smtp-Source: AGHT+IGhAaplE+wpEZFLHVTgfSTk9ZtKydOr6eXku9ufn+sC1pcUSPk5pr9gH/lvC/UyPS87WKsMTg==
X-Received: by 2002:a25:ac21:0:b0:e02:a265:34b4 with SMTP id 3f1490d57ef6-e03c1961890mr3900252276.16.1720169444766;
        Fri, 05 Jul 2024 01:50:44 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0353d58286sm2587509276.2.2024.07.05.01.50.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:50:44 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0365588ab8so1386892276.1
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 01:50:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyP6vdbZjDQb0alNfXgJb/8RdDCB9x83LH+5cW4sXXthNHlDSyXir56T1ZW0DrsAgu9Pl+k0ZHUGpIVlWK67JdPxgwsrZ7Pz0TjhY=
X-Received: by 2002:a81:8b45:0:b0:627:de5d:cf36 with SMTP id
 00721157ae682-652d803a93amr37717067b3.39.1720169444245; Fri, 05 Jul 2024
 01:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705081508.2110169-1-hch@lst.de> <20240705081508.2110169-3-hch@lst.de>
In-Reply-To: <20240705081508.2110169-3-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 10:50:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmqRq2oBtgY0w1ZPcCchqBm7pmsWBGmqQhAPK6V-Tz7g@mail.gmail.com>
Message-ID: <CAMuHMdWmqRq2oBtgY0w1ZPcCchqBm7pmsWBGmqQhAPK6V-Tz7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: add a bvec_phys helper
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, Jul 5, 2024 at 10:15=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> Get callers out of poking into bvec internals a bit more.  Not a huge win
> right now, but with the proposed new DMA mapping API we might end up with
> a lot more of this otherwise.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

>  arch/m68k/emu/nfblock.c |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -255,8 +255,7 @@ static bool bvec_split_segs(const struct queue_limits=
 *lim,
>         unsigned seg_size =3D 0;
>
>         while (len && *nsegs < max_segs) {
> -               seg_size =3D get_max_segment_size(lim, page_to_phys(bv->b=
v_page) +
> -                                               bv->bv_offset + total_len=
);
> +               seg_size =3D get_max_segment_size(lim, bvec_phys(bv) + to=
tal_len);
>                 seg_size =3D min(seg_size, len);
>
>                 (*nsegs)++;
> @@ -492,8 +491,7 @@ static unsigned blk_bvec_map_sg(struct request_queue =
*q,
>         while (nbytes > 0) {
>                 unsigned offset =3D bvec->bv_offset + total;
>                 unsigned len =3D min(get_max_segment_size(&q->limits,
> -                                  page_to_phys(bvec->bv_page) + offset),
> -                                  nbytes);
> +                                  bvec_phys(bvec) + total), nbytes);
>                 struct page *page =3D bvec->bv_page;
>
>                 /*

If you would have introduce bvec_phys() first, you could fold the above
two hunks into [PATCH 1/2].

> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -280,4 +280,19 @@ static inline void *bvec_virt(struct bio_vec *bvec)
>         return page_address(bvec->bv_page) + bvec->bv_offset;
>  }
>
> +/**
> + * bvec_phys - return the physical address for a bvec
> + * @bvec: bvec to return the physical address for
> + */
> +static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
> +{
> +       /*
> +        * Note this open codes page_to_phys because page_to_phys is defi=
ned in
> +        * <asm/io.h>, which we don't want to pull in here.  If it ever m=
oves to

Which suggests this is arch-specific, and may not always be defined
the same? I checked a few (but not all) that seem to differ from the
above at first sight, but end up doing the same...

I think it would be good to make sure they are identical, and if
they are, move them to a common place first, to any subtle breakages.

> +        * a sensible place we should start using it.
> +        */
> +       return ((phys_addr_t)page_to_pfn(bvec->bv_page) << PAGE_SHIFT) +
> +               bvec->bv_offset;
> +}
> +
>  #endif /* __LINUX_BVEC_H */

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
