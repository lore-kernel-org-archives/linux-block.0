Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0676EED61F
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjIOS2l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjIOS20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 14:28:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A2271B
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 11:27:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso2820409a12.3
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694802436; x=1695407236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TVRLEu9EJ9mGV2bipP8Xm97KGB9uZNTupnuQjSJdsE=;
        b=sKKT+kRRXdqHAoUZgMTugOxbcrbgqDgkkXjasxrWctWJd77Sw8TlsGuTd98pSRft9A
         jN/MMQ3oP4/QuTKHBD9/YypfLSNU+2cuvu8u73JxBHsdsSFjo1rojX5WJRXSO1lIrr4X
         Q/i++DKlLWUNrBbI96a2DUSv9ydwwnivZJKP06X04/cK0r2bQFBArjWiQF6VYJBobiMX
         PGK/u5s+F2yWQLPEdRhYCODQlNQ8S+qDRhy7Nh2noe1XmCVyac1kWiIlCNg4DMBP7SEd
         a3S1lxEG5glLqSDYO5PGcLNoSDLKwOIaoa1Db4onOn/2goDJ5rYfzEFwI2eODMv2KWvJ
         JQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802436; x=1695407236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TVRLEu9EJ9mGV2bipP8Xm97KGB9uZNTupnuQjSJdsE=;
        b=nKUr+SvpE80ctWlTLyYS10WYASqlG+i/+a+Tfmw738j7pti06pSJxGGP4L870++QbK
         nfZZHi9on6C0wLFKVIdpqXC4hCAKjGW4PVB9KNtcSceU+UBYFbXNP1kbXoIR6OT6w/RY
         ESXYoRCjoeUqppuWCol1S6XtBQ5p8b+v2QVawpSaKSh3+4Il8Nx3jBRBMe1jsZF4sxGT
         FgsWtyfzDeaLoBbqwKO0WHTzHGW3BwkxYM9kH4CO/B8zjh5HdQ3IWS0nqne7hR8XT7Q0
         kCfOxwviVJO6athl5HLH3TaGKWGsD8KwUtkvqBvdMTBJl0bIChqIiGjBuGI9USQQklf+
         H9zQ==
X-Gm-Message-State: AOJu0Yydr+ApEBivK47qdKSSFFu3sFgFyaGH0RhE1RHAbnjg1SG2S8Ax
        /d+ZQDrVbp6RYq5U/FuA5oMo3CjGbr92zzg2YWcGOA==
X-Google-Smtp-Source: AGHT+IHg0l+d+9eXrE3JQYT1rNSzTJ30WS4x3AxsO8Su5H91K9tA7o+8Ltb2jJoMejIzZEOsQjI7O6t5d3aHWeK0K/E=
X-Received: by 2002:a17:907:75fb:b0:9a1:f3a6:b906 with SMTP id
 jz27-20020a17090775fb00b009a1f3a6b906mr2140406ejc.36.1694802436299; Fri, 15
 Sep 2023 11:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com> <20230915095042.1320180-7-da.gomez@samsung.com>
In-Reply-To: <20230915095042.1320180-7-da.gomez@samsung.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 15 Sep 2023 11:26:37 -0700
Message-ID: <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
Subject: Re: [PATCH 6/6] shmem: add large folios support to the write path
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 15, 2023 at 2:51=E2=80=AFAM Daniel Gomez <da.gomez@samsung.com>=
 wrote:
>
> Add large folio support for shmem write path matching the same high
> order preference mechanism used for iomap buffered IO path as used in
> __filemap_get_folio().
>
> Use the __folio_get_max_order to get a hint for the order of the folio
> based on file size which takes care of the mapping requirements.
>
> Swap does not support high order folios for now, so make it order 0 in
> case swap is enabled.

I didn't take a close look at the series, but I am not sure I
understand the rationale here. Reclaim will split high order shmem
folios anyway, right?

It seems like we only enable high order folios if the "noswap" mount
option is used, which is fairly recent. I doubt it is widely used.

>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  mm/shmem.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index adff74751065..26ca555b1669 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1683,13 +1683,19 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
>  }
>
>  static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode =
*inode,
> -               pgoff_t index, bool huge, unsigned int *order)
> +               pgoff_t index, bool huge, unsigned int *order,
> +               struct shmem_sb_info *sbinfo)
>  {
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
>         struct folio *folio;
>         int nr;
>         int err;
>
> +       if (!sbinfo->noswap)
> +               *order =3D 0;
> +       else
> +               *order =3D (*order =3D=3D 1) ? 0 : *order;
> +
>         if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>                 huge =3D false;
>         nr =3D huge ? HPAGE_PMD_NR : 1U << *order;
> @@ -2032,6 +2038,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                 return 0;
>         }
>
> +       order =3D mapping_size_order(inode->i_mapping, index, len);
> +
>         if (!shmem_is_huge(inode, index, false,
>                            vma ? vma->vm_mm : NULL, vma ? vma->vm_flags :=
 0))
>                 goto alloc_nohuge;
> @@ -2039,11 +2047,11 @@ static int shmem_get_folio_gfp(struct inode *inod=
e, pgoff_t index,
>         huge_gfp =3D vma_thp_gfp_mask(vma);
>         huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
>         folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index, true=
,
> -                                          &order);
> +                                          &order, sbinfo);
>         if (IS_ERR(folio)) {
>  alloc_nohuge:
>                 folio =3D shmem_alloc_and_acct_folio(gfp, inode, index, f=
alse,
> -                                                  &order);
> +                                                  &order, sbinfo);
>         }
>         if (IS_ERR(folio)) {
>                 int retry =3D 5;
> @@ -2147,6 +2155,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>         if (folio_test_large(folio)) {
>                 folio_unlock(folio);
>                 folio_put(folio);
> +               if (order > 0)
> +                       order--;
>                 goto alloc_nohuge;
>         }
>  unlock:
> --
> 2.39.2
>
