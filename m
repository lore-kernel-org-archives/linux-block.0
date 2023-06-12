Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C6C7EE25
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 09:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjFLJuk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjFLJuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 05:50:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2159E5
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 02:35:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b3c43279c1so101985ad.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686562514; x=1689154514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29GQz4N1RuYE3YAahRNzsPBKqNihkCK7xJvEQHxVFP8=;
        b=h5PXdrEXv3zRjkg/o1XhxWAB8orJ+9cw1KEkb5ZfVk54k7CDl58HC3ZT13QTFKKljA
         9eyR3GgiTntD4bEDoiL8LfajNUDevgkS5amQXFd8KlyStubkhdnitkm9rN0DJ+/l+qMc
         gKAhq08hcqqYwpLb6pNUFFLhk2ZIEmrh9c3G29zVIh04p+8SW9mHw4JP7I7rOgJlxJf4
         CRfJhAqu9RlgloFE9x0RLhD7vOWOaqBSQef6WHA6qivk6f92tXVvTTXa24d7A+yEg84G
         dBgYgR/IR6jiKQKRFqwB18u84Cf5RoMggL0CNWTi9cCY8ytvVP/ylbxOCFII3gTFDyEq
         T3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562514; x=1689154514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29GQz4N1RuYE3YAahRNzsPBKqNihkCK7xJvEQHxVFP8=;
        b=JTVuc+ECaVk/mr3mwmLlMoSo04I2o70X8SzJAwEYSfwt9+Bqch1UpKlnwrUQnWjUef
         C3vZ0BDS3oCIYgO8vvCSlzYI9YJOv0WWSQ/Te26MEIkAu9hjZDFhbRxnq1X1gjjvs44I
         N+CCL1xFZMttJTCk5MwW172dNOTa8VVayPbg+YbNOAVPamcAd0+2QlR7PZuFehZgDAL/
         +SO6sIbEONRXNbTdjdrQ05HRqo/6PDr5qTdHl5+7p1POdJlc626j0cq+CCPw/RRS0IB8
         bAnuYEP7EjfEXTTihxbFklhECgLqqCnYswqAyftIRQzj1yDZAAqROhkhrPRgHAb4tz0k
         bJvQ==
X-Gm-Message-State: AC+VfDzn0XjNZe57lMIi2OJlNlApCAAFP0WtfYB32+kxvUuTo3z7fefq
        EX2mO4VOSnO4Du4u4JUPHr1R1Z1CkuB1l1JKmkM2YFiKZ4GC2B0gicDa0A==
X-Google-Smtp-Source: ACHHUZ6VSzU+28jYfHnh9y19cPzK91DF4XYimogK8gfXPdG66/VYDFjMtNdF9daKFihp7vh32DX1VfValI2Pu7/TNrw=
X-Received: by 2002:a17:902:e849:b0:1b1:d1fe:e73 with SMTP id
 t9-20020a170902e84900b001b1d1fe0e73mr229259plg.8.1686562514065; Mon, 12 Jun
 2023 02:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230609131355.71130-1-jordyzomer@google.com> <20230609131355.71130-2-jordyzomer@google.com>
 <ZITKoBzJq+Y5Hi9Z@equinox>
In-Reply-To: <ZITKoBzJq+Y5Hi9Z@equinox>
From:   Jordy Zomer <jordyzomer@google.com>
Date:   Mon, 12 Jun 2023 11:35:03 +0200
Message-ID: <CABjM8Zf_xSNirWzMFVi816CuZAdRT-9edOpX0j526fQXNUm7xg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks both! I assumed array_index_mask_nospec was the same as
array_index_nospec. I'll send a V2 your way soon :)


On Sat, Jun 10, 2023 at 9:10=E2=80=AFPM Phillip Potter <phil@philpotter.co.=
uk> wrote:
>
> On Fri, Jun 09, 2023 at 01:13:55PM +0000, Jordy Zomer wrote:
> > This patch fixes a spectre-v1 gadget in cdrom.
> > The gadget could be triggered by,
> >  speculatviely bypassing the cdi->capacity check.
> >
> > Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> > ---
> >  drivers/cdrom/cdrom.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 416f723a2dbb..3c349bc0a269 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -233,6 +233,7 @@
> >
> >  ----------------------------------------------------------------------=
---*/
> >
> > +#include "asm/barrier.h"
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> >  #define REVISION "Revision: 3.20"
> > @@ -2329,6 +2330,8 @@ static int cdrom_ioctl_media_changed(struct cdrom=
_device_info *cdi,
> >       if (arg >=3D cdi->capacity)
> >               return -EINVAL;
> >
> > +     arg =3D array_index_mask_nospec(arg, cdi->capacity);
> > +
> >       info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> >       if (!info)
> >               return -ENOMEM;
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> Hi Jordy,
>
> Thanks for the patch, much appreciated. Sadly, as Pawan has already
> pointed out, array_index_mask_nospec actually changes the behaviour of
> this function, such that 'arg' would no longer be an array index.
>
> In addition, it seems to have triggered the kernel test robot with an
> alpha build error.
>
> Regards,
> Phil
