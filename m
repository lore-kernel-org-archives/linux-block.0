Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C9C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAC207D4
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvPbkzN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgEPIz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgEPIz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 04:55:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BDC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 01:55:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so6152847wru.0
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WqaUwYUJR76XTZVs/Z4k0+L2qcAAnaj61agUgGyGBMs=;
        b=LvPbkzN9nPOKTgGEs6/55XRB+n+7t1z0vfF9LvYMoAb9vymt2K4AYgHRoO12Wr5hP/
         nphQU9WW5HS2dFnqRNgiA+Ue0uJBpBougTEYri+JTeIQO0dn69neR5OckByPxkJtUCNL
         3p1ajPM5myWu3y+0NdGflW4BQuCWJuikVvB3yLTkw7BOeTTVVBbi1kjdKWEgAog1Dx8r
         29Wf0VJQTB2hdx1TDZDl9VfSPNnSymvL0mOP+7pS6hla43NbHoWhARrIgkJ5Fp1tWyES
         KOgiwqRDVzwyAus2ycaug8aLG0KJjfTNZni654c4sw+8OAAgNrVwISQrATNfgL4KvNYp
         v9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WqaUwYUJR76XTZVs/Z4k0+L2qcAAnaj61agUgGyGBMs=;
        b=jkwkayZG5FPzuls7Ek4DP8WSivcNkK18Ipv4QwrRRthgGjkbmfwo/3yjzOrh5QG8YC
         6YgNQwfxR9ZAzqE/yfsCW9J0w+oJ/IA4XpsEq29Ag1op0pVZMWTDTJ4/5S/QpS9RpFV8
         dybKJ63b74YeLkQh8znqe0c8Ql6RKkNg3j4kn0y2dPs+txV8ToiLuLSviGkyGesNeS0U
         1MB+8WACwPz+jB+8r0tkNihsC2GJem8GR1n7C0vz+JPuQaqZhaaRVoBaIwow6afLkLkq
         DQqB5+9jogcalpUDixqTTtNUDN0Y+IabmwurF4wujjviPsrDwu10oolw/Y/rOKd36Nt/
         0vzg==
X-Gm-Message-State: AOAM533uF9ZzHLr67cMv2VRz1FH7t62LxoD8gE3/GCVpui5p8fASYotc
        6Yd62VanXT0scYNb1E0VKoCe3sgB0juxDLVC/xjfjw==
X-Google-Smtp-Source: ABdhPJz5kgGL7xhHeP7LACwtS0QuufHlYWKNyzxoGj5V3uA6brSBdAzFs1Mm8WuIEsvQ/bKG5WdMO9BsX7rKa7KKRps=
X-Received: by 2002:a5d:6a8c:: with SMTP id s12mr9002658wru.345.1589619323787;
 Sat, 16 May 2020 01:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200516001914.17138-1-bvanassche@acm.org> <20200516001914.17138-3-bvanassche@acm.org>
In-Reply-To: <20200516001914.17138-3-bvanassche@acm.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Sat, 16 May 2020 10:55:12 +0200
Message-ID: <CAG_fn=WwtWxFhtx5esv_vqZ4=7Y1Ui0urLpVVvA4t3u-X=Oz1g@mail.gmail.com>
Subject: Re: [PATCH 2/5] bio.h: Declare the arguments of bio iteration
 functions const
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 2:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> This change makes it possible to pass 'const struct bio *' arguments to
> these functions.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/bio.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index a0ee494a6329..58e6134b1c05 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -70,7 +70,7 @@ static inline bool bio_has_data(struct bio *bio)
>         return false;
>  }
>
> -static inline bool bio_no_advance_iter(struct bio *bio)
> +static inline bool bio_no_advance_iter(const struct bio *bio)
>  {
>         return bio_op(bio) =3D=3D REQ_OP_DISCARD ||
>                bio_op(bio) =3D=3D REQ_OP_SECURE_ERASE ||
> @@ -138,8 +138,8 @@ static inline bool bio_next_segment(const struct bio =
*bio,
>  #define bio_for_each_segment_all(bvl, bio, iter) \
>         for (bvl =3D bvec_init_iter_all(&iter); bio_next_segment((bio), &=
iter); )
>
> -static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *i=
ter,
> -                                   unsigned bytes)
> +static inline void bio_advance_iter(const struct bio *bio,
> +                                   struct bvec_iter *iter, unsigned byte=
s)
>  {
>         iter->bi_sector +=3D bytes >> 9;
On a related note, should this 9 be SECTOR_SHIFT?


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
