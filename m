Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AE4C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjEWJUE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjEWJT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:19:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334E494
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:19:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510dabb39aeso961857a12.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684833594; x=1687425594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njheqMAnz+SnwPmcBRKc1PFPVJwj65Fa0AvgXdZcxWs=;
        b=adTbGgwErcfrw1aZe4skLHB2SCE/6DklAZ7bF0dAODmzYIo95fxnNH7GACk1p7KYSD
         xtdmV/B7R7szCKd/i4kg3sN7ASsyRII9XaO70doOKWNvtIMcUYUY6xWzUvbb5VH718LM
         6o0X74iXxYWcG0XTeZywoGY0EitsdlIRDfUYiIn4+aAOTtDrZw75CAgBEOpijEEXlD5c
         BEuytOEn167xGLVtyCQbRouzZrpT8Oii7U0UsSGKe4o4SVAjAv3M04GOyakZav/rMzOj
         Wb0faBuLOIeLQf5CcSqbh6Hv0vgVMDtR4wHAdYlp9wPuYLBDAAhdkrcTc1YYkpK3pSvq
         YWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833594; x=1687425594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njheqMAnz+SnwPmcBRKc1PFPVJwj65Fa0AvgXdZcxWs=;
        b=CH1emBKeacN7992Z2UOWJQhTwSMPNaWM4jYQLaAzHuwUbU5b5SKwXTniU3vmar12T4
         K2kWcVyuUYjBphqB7bUxr+0qjKLi2oPfmFmLONJ8aBP27zEeOjmw5qe2T8rWjAGxlTAk
         DWiUYQpvRKUnMd636krbQKL3Nin6EpapUi4QS/4xpLHQA3qGd/hwJxYT7pWW0ejqz434
         l4SfIA9bKQHc4V9VVkWzIVMbFmBq+fwEtUX9318cMGAFi8d7+wCgguXsa0hWIJztMki1
         5+P4l+IaaifvovOx91RsXXWXM54J3uY8+W6yKCFJZfIDLULM/6C8DoUPdlW1lKrbcljh
         bEiQ==
X-Gm-Message-State: AC+VfDwo5uyR+bOGjPF2OipD2MSohf7NbXd2hEr5Lb5C/nJuVKI667OF
        ieEV2UUXSXFZzR82BZsnNCTas+TQgFP66Ju9EqB8nw==
X-Google-Smtp-Source: ACHHUZ4fat3E0b6plQXKtzhpf9RySfGD33/ADSaT2YOd2etoXN2WnEYMw/VEMvFaztA4m2nAqs4lcZ8FBUFltXt8eiE=
X-Received: by 2002:aa7:ca5a:0:b0:50b:f72f:adf8 with SMTP id
 j26-20020aa7ca5a000000b0050bf72fadf8mr11323491edt.21.1684833594550; Tue, 23
 May 2023 02:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-2-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-2-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:19:43 +0200
Message-ID: <CAMGffEm-COASh5Tgrp2tjpOyDjtmf64WvvjvYPW+H-+88Cw+yA@mail.gmail.com>
Subject: Re: [PATCH 01/10] block/rnbd: kill rnbd_flags_supported
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 9:53=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
> This routine is not called since added. Then the two flags
> (RNBD_OP_LAST and RNBD_F_ALL) can be removed too after kill
> rnbd_flags_supported.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-proto.h | 22 ----------------------
>  1 file changed, 22 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-pr=
oto.h
> index da1d0542d7e2..84fd69844b7d 100644
> --- a/drivers/block/rnbd/rnbd-proto.h
> +++ b/drivers/block/rnbd/rnbd-proto.h
> @@ -185,7 +185,6 @@ struct rnbd_msg_io {
>  enum rnbd_io_flags {
>
>         /* Operations */
> -
>         RNBD_OP_READ            =3D 0,
>         RNBD_OP_WRITE           =3D 1,
>         RNBD_OP_FLUSH           =3D 2,
> @@ -193,15 +192,9 @@ enum rnbd_io_flags {
>         RNBD_OP_SECURE_ERASE    =3D 4,
>         RNBD_OP_WRITE_SAME      =3D 5,
>
> -       RNBD_OP_LAST,
> -
>         /* Flags */
> -
>         RNBD_F_SYNC  =3D 1<<(RNBD_OP_BITS + 0),
>         RNBD_F_FUA   =3D 1<<(RNBD_OP_BITS + 1),
> -
> -       RNBD_F_ALL   =3D (RNBD_F_SYNC | RNBD_F_FUA)
> -
>  };
>
>  static inline u32 rnbd_op(u32 flags)
> @@ -214,21 +207,6 @@ static inline u32 rnbd_flags(u32 flags)
>         return flags & ~RNBD_OP_MASK;
>  }
>
> -static inline bool rnbd_flags_supported(u32 flags)
> -{
> -       u32 op;
> -
> -       op =3D rnbd_op(flags);
> -       flags =3D rnbd_flags(flags);
> -
> -       if (op >=3D RNBD_OP_LAST)
> -               return false;
> -       if (flags & ~RNBD_F_ALL)
> -               return false;
> -
> -       return true;
> -}
> -
>  static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
>  {
>         blk_opf_t bio_opf;
> --
> 2.35.3
>
