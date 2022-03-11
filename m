Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5456C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 18:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347145AbiCKSyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 13:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350246AbiCKSyU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 13:54:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76899F7441
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 10:53:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x5so11964183edd.11
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhiJoyGK6i48A+CV44wvGM/sNOc2SA/ZHL0e71y9Ouw=;
        b=oxd6LAQKWQ5hKfBrALwTaY5UPGW3xSf9z0WFCbd/U2Y6H0HdsW/os1CmTDYsESly0w
         tqUHS7uXcBfX3xvTcS15ysDWNektRriLFjwr2sFQrEkwYcoMX8VEWNHfqqXCDF3yJGQv
         NydGiZKzqXKRAx3KfjS9uNw11cYYRQcS/FX2RoEVSsCkVCHpb3WSXmZ63bSDR5fQfyUL
         epYrOqC8w1p7y2RIEPMp8bx2BMtBa3Q61oUyL1IgQd6FtXH1elLFXVm9PyDdAGEDEe3z
         A/aZlLmcTeMQ4MaY52V9j7G8gOX5WZdDofYqd8HZfnGW0lzoThKe4Y+F5geLdfpjodDv
         7Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhiJoyGK6i48A+CV44wvGM/sNOc2SA/ZHL0e71y9Ouw=;
        b=c6Ei7QvOGRmz2p2VP4prN9kSLPPOSbAHQ4JNg2QK59yo1eEoaCQQcmAVTNpjIYy3af
         vKZ2UIJOh4Te0f8vXaqkYgozt1rQEuzSO7PdFJn1/UtvpkmJOn+pX5Z9wfWWIReKuo3C
         wx4zktJNt7aTcpqyRAfLuUzy4mdsn49rxafDL8S+3qNsRZ5Hqwuj/Mh1+L6xi85G4eCx
         +xBzKDz+KiN2C3iK/5dA4QJoAi8bS6ybCW2WUVaJwwB12xc5l/LHSeuiKv/q6CYRpsrx
         QN5fcHmQ64SCTeAC5N2/evrAOXipI72UglOSAHiSDmEc5zCTygx2yd9rL/4UTwfU+YzI
         HMAA==
X-Gm-Message-State: AOAM533RRqUxqENsQgsVf1Tk/OaOYkSHkMpb3ENmHZOkgNB3HZRryeu9
        qyIoMBuazcq799NMVseGFXaXigXLScomhyiuRd4N
X-Google-Smtp-Source: ABdhPJwxFS6emBP91ghOo78Xcf38HmQKuJ92uGWWAskNZTBSdMpqT2NKwaEKOmMFF9dvmety1PBkMMF2unwneHLaEzA=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr10168594edc.232.1647024794826; Fri, 11
 Mar 2022 10:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com> <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com> <YiuNZ7+KUjLtuYkr@bombadil.infradead.org>
In-Reply-To: <YiuNZ7+KUjLtuYkr@bombadil.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Mar 2022 13:53:03 -0500
Message-ID: <CAHC9VhTnpO6LyaYWDTjJAy_ztGw+qqf-YS0W7S-djyZVnydVHg@mail.gmail.com>
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on char-device.
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        kbusch@kernel.org, asml.silence@gmail.com,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
        a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 12:56 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Mar 08, 2022 at 08:50:53PM +0530, Kanchan Joshi wrote:
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index 5c9cd9695519..1df270b47af5 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -369,6 +469,33 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >       return __nvme_ioctl(ns, cmd, (void __user *)arg);
> >  }
> >
> > +static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
> > +{
> > +     int ret;
> > +
> > +     BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
> > +
> > +     switch (ioucmd->cmd_op) {
> > +     case NVME_IOCTL_IO64_CMD:
> > +             ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);
> > +             break;
> > +     default:
> > +             ret = -ENOTTY;
> > +     }
> > +
> > +     if (ret >= 0)
> > +             ret = -EIOCBQUEUED;
> > +     return ret;
> > +}
>
> And here I think we'll need something like this:

If we can promise that we will have a LSM hook for all of the
file_operations::async_cmd implementations that are security relevant
we could skip the LSM passthrough hook at the io_uring layer.  It
would potentially make life easier in that we don't have to worry
about putting the passthrough op in the right context, but risks
missing a LSM hook control point (it will happen at some point and
*boom* CVE).

> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index ddb7e5864be6..83529adf130d 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/ptrace.h>      /* for force_successful_syscall_return */
>  #include <linux/nvme_ioctl.h>
> +#include <linux/security.h>
>  #include "nvme.h"
>
>  /*
> @@ -524,6 +525,11 @@ static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
>
>         BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
>
> +       ret = security_file_ioctl(ioucmd->file, ioucmd->cmd_op,
> +                                 (unsigned long) ioucmd->cmd);
> +       if (ret)
> +               return ret;
> +
>         switch (ioucmd->cmd_op) {
>         case NVME_IOCTL_IO64_CMD:
>                 ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);

-- 
paul-moore.com
