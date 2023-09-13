Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E3DEE0204
	for <linux-block@archiver.kernel.org>; Wed, 13 Sep 2023 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjIMUt7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Sep 2023 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjIMUt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2023 16:49:58 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8781BCA
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 13:49:54 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64914f08c65so1685676d6.1
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694638193; x=1695242993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFwFw82a57aBtQryliubY+OdXAAQrHVkDDwYmB6bvo8=;
        b=MPOogQ5fjF6DKVQuBg8MKjkNwYRvl2f969VAUVkHe+miGM5eSsfUGMukaXP9BdZwPR
         bqX4JKNGrJEyIw6kBb3uVa24PEfY2vMWi6W2scOiDAW3xTE93A3WyS4Damva0LMT+2sp
         MBtjNCDbL7yotboXE5rXpjcqiNOZ6sDuGiAju0sQsMTqSfNzxAisUln1Oa/++YPwPlAE
         CmTEpX9eN5UOXW5WLAYLjAqxRv7x0A3BAeo+KaeWQm4OmhGEJ2KrnPqpKOEYsFW/ZsvP
         pZiyRD/QrrPO36p3MoMPeEp9h0A2nCwXHX0Ki28BDWYdBzqoEuF2Obb5Aw/TNNkHNUqS
         jtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694638193; x=1695242993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFwFw82a57aBtQryliubY+OdXAAQrHVkDDwYmB6bvo8=;
        b=G0BSi5D1FaSj7zMNVqgOgybV2QYQH8qMLpPB5lZpUSho0Y944cIa32SlSw6CTnPvQe
         rXuIYJis5BMmpE7h+LkEK9SDVtpk8ADqUczoVqeTil3/f2adRsh1Xf8uMubTQiiq6uuN
         W7KwRMWAmBOg6Evws1fK4xGbjDsU1jhSgNlb1iTTQhD/MB7JDPRdfLqaHYXVLMmHHIDQ
         YDXrt8VcdTMH/g9gj+P2vbw6bTPVJWVQ72K2nawJwDYMANSW/+obXKBIaxecQKIzJc6I
         BUvLcyLBFns0xd+RwK3em2p291gcfavcoQL56vgOF+7eDuvm1cmURJyZjWR7NniAalI/
         hmFA==
X-Gm-Message-State: AOJu0YxyiV0o7SXvlOQG0+58YTD4xVV+eFySObpEhM1pGP6bVmUJCavB
        D32OLQ6ln9aeTUjYdOqRjUk0OEPis73URbnNOUKVew==
X-Google-Smtp-Source: AGHT+IHyO+7qjdiOWvRrn0TL1tvmNTBKXt4WU5GdAv9X4AWVEJU+Ajo7u738qSi8gvalqluc4GkG9Xfyc7iZk8lZYKw=
X-Received: by 2002:a05:6214:140e:b0:651:75a4:75b0 with SMTP id
 pr14-20020a056214140e00b0065175a475b0mr3474295qvb.1.1694638193146; Wed, 13
 Sep 2023 13:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230908153056.3503975-1-gjoyce@linux.vnet.ibm.com>
 <20230908153056.3503975-2-gjoyce@linux.vnet.ibm.com> <20230913165612.GA2213586@dev-arch.thelio-3990X>
In-Reply-To: <20230913165612.GA2213586@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Sep 2023 13:49:39 -0700
Message-ID: <CAKwvOdnbKA-DiWRorWMR93JPFX-OjUjO=SQXSRf4=DpwzvZ=pQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3 RESEND] block:sed-opal: SED Opal keystore
To:     Nathan Chancellor <nathan@kernel.org>, gjoyce@linux.vnet.ibm.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, jarkko@kernel.org,
        linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        keyrings@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 13, 2023 at 9:56=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Greg,
>
> On Fri, Sep 08, 2023 at 10:30:54AM -0500, gjoyce@linux.vnet.ibm.com wrote=
:
> > From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> >
> > Add read and write functions that allow SED Opal keys to stored
> > in a permanent keystore.
> >
> > Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> > Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> > ---
> >  block/Makefile               |  2 +-
> >  block/sed-opal-key.c         | 24 ++++++++++++++++++++++++
> >  include/linux/sed-opal-key.h | 15 +++++++++++++++
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> >  create mode 100644 block/sed-opal-key.c
> >  create mode 100644 include/linux/sed-opal-key.h
> >
> > diff --git a/block/Makefile b/block/Makefile
> > index 46ada9dc8bbf..ea07d80402a6 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -34,7 +34,7 @@ obj-$(CONFIG_BLK_DEV_ZONED) +=3D blk-zoned.o
> >  obj-$(CONFIG_BLK_WBT)                +=3D blk-wbt.o
> >  obj-$(CONFIG_BLK_DEBUG_FS)   +=3D blk-mq-debugfs.o
> >  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+=3D blk-mq-debugfs-zoned.o
> > -obj-$(CONFIG_BLK_SED_OPAL)   +=3D sed-opal.o
> > +obj-$(CONFIG_BLK_SED_OPAL)   +=3D sed-opal.o sed-opal-key.o
> >  obj-$(CONFIG_BLK_PM)         +=3D blk-pm.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION)  +=3D blk-crypto.o blk-crypto-prof=
ile.o \
> >                                          blk-crypto-sysfs.o
> > diff --git a/block/sed-opal-key.c b/block/sed-opal-key.c
> > new file mode 100644
> > index 000000000000..16f380164c44
> > --- /dev/null
> > +++ b/block/sed-opal-key.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * SED key operations.
> > + *
> > + * Copyright (C) 2022 IBM Corporation
> > + *
> > + * These are the accessor functions (read/write) for SED Opal
> > + * keys. Specific keystores can provide overrides.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/sed-opal-key.h>
> > +
> > +int __weak sed_read_key(char *keyname, char *key, u_int *keylen)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +int __weak sed_write_key(char *keyname, char *key, u_int keylen)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
>
> This change causes a build failure for certain clang configurations due
> to an unfortunate issue [1] with recordmcount, clang's integrated
> assembler, and object files that contain a section with only weak
> functions/symbols (in this case, the .text section in sed-opal-key.c),
> resulting in
>
>   Cannot find symbol for section 2: .text.
>   block/sed-opal-key.o: failed
>
> when building this file.

The definitions in
block/sed-opal-key.c
should be deleted. Instead, in
include/linux/sed-opal-key.h
CONFIG_PSERIES_PLPKS_SED should be used to define static inline
versions when CONFIG_PSERIES_PLPKS_SED is not defined.

#ifdef CONFIG_PSERIES_PLPKS_SED
int sed_read_key(char *keyname, char *key, u_int *keylen);
int sed_write_key(char *keyname, char *key, u_int keylen);
#else
static inline
int sed_read_key(char *keyname, char *key, u_int *keylen) {
  return -EOPNOTSUPP;
}
static inline
int sed_write_key(char *keyname, char *key, u_int keylen);
  return -EOPNOTSUPP;
}
#endif

>
> Is there any real reason to have a separate translation unit for these
> two functions versus just having them living in sed-opal.c? Those two
> object files share the same Kconfig dependency. I am happy to send a
> patch if that is an acceptable approach.
>
> [1]: https://github.com/ClangBuiltLinux/linux/issues/981
>
> Cheers,
> Nathan
>


--=20
Thanks,
~Nick Desaulniers
