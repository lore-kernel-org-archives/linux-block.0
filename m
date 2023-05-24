Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD2C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 10:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjEXKrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 06:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjEXKrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 06:47:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C7CB7
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 03:47:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so1883202a12.1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684925219; x=1687517219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgiK84gwFKYDZvHu3YtoXPZvgp8ed/hev2I/1d1Gf9U=;
        b=cpatNOGgWTwRJump8NHz7qH4Iz7eFzBdfym3WW6hXmr1PWwpW3rSBz5zw6MJlq7tAE
         pKRpW3aTMQwh67et5LwnZ00AqhzEZJE5uFDtpZ7AhQyKv6tpXzEVnD4bb/3eBrYUBtph
         1j5pqtam/sdTPI+T2+Pq/3E2/gcx9YaqU2IbYy2GSbIVl1Ge0FSChgVNlnEVvtzw/qJ3
         oTWRIU6pi4G2pV6fG4XUaHoGjxFQ4g3Qa4IWi6zuKOWr+uwQBZJeFJcJF+rZ45Yqer2T
         Y7T1cjJqRfTjERwidoqf32K8gbH7yd4AIXQlzPSM2BRi2WKAuQISaK7zj7hrlhqT+FV/
         S96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925219; x=1687517219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgiK84gwFKYDZvHu3YtoXPZvgp8ed/hev2I/1d1Gf9U=;
        b=LSLVcN3GDn9FFS4GY2WuClMxjmBF7eIpYnf9LZp9kY7Dw76kfagwzGH/dZkHT/ogqd
         hss4gYlPNxGS7dHPVPz806EjxrAvJfzTp2XBzjPkn1XETeFzmNvnCgsWrRokbO9o+IIs
         2ziUwVCtG1vw8c2EKtsMDmVknZurQ5kA58fyGi807NcdLrYPGcLwlnPX1OB6pbOmfpf7
         6z9uw5+mz0hbTRp8OQUnlztdaqrxvsXKLZHXw+arr3l32kyMS0pvLnBWfcCDPjOovwpw
         1JczzHoWzws7f9ZvH4+ueXivsE64pEYR2LRXs+Ps7I5Z3kUxony7FzUnvNeR7/wtXk2i
         iRrw==
X-Gm-Message-State: AC+VfDwieT9+3wXyL/IZTooLbiWhEWnniRfUC+nx+01NzdSYNiNztelO
        xmGj2B/xP7Zthx0k3+yT95YkclTBq1HgnlhsHNts8Q==
X-Google-Smtp-Source: ACHHUZ4y3GIKPVGg2RSo2XHtIPTelZL0Sb6kHAtyStaRzrsula3Tckagu/SeLDWwEvaQvf2Rxw8FDDgMLptMQZk77sU=
X-Received: by 2002:aa7:c688:0:b0:50c:804:20bb with SMTP id
 n8-20020aa7c688000000b0050c080420bbmr1987117edq.16.1684925219522; Wed, 24 May
 2023 03:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230524070026.2932-1-guoqing.jiang@linux.dev> <20230524070026.2932-4-guoqing.jiang@linux.dev>
In-Reply-To: <20230524070026.2932-4-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 May 2023 12:46:48 +0200
Message-ID: <CAMGffEnDjAP3zqytmsYxacvUROLKZj+KhH6LOXicOoPhS9FJJQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/8] block/rnbd: introduce rnbd_access_modes
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 9:00=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
> Add one new array (marked with __maybe_unused to prevent gcc warning abou=
t
> "defined but not used" with W=3D1), then we can remove rnbd_access_mode_s=
tr
> and rnbd-common.c accordingly.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/Makefile         |  6 ++----
>  drivers/block/rnbd/rnbd-clt-sysfs.c |  4 ++--
>  drivers/block/rnbd/rnbd-common.c    | 23 -----------------------
>  drivers/block/rnbd/rnbd-proto.h     |  9 +++++++++
>  drivers/block/rnbd/rnbd-srv-sysfs.c |  2 +-
>  drivers/block/rnbd/rnbd-srv.c       |  4 ++--
>  6 files changed, 16 insertions(+), 32 deletions(-)
>  delete mode 100644 drivers/block/rnbd/rnbd-common.c
>
> diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
> index 40b31630822c..208e5f865497 100644
> --- a/drivers/block/rnbd/Makefile
> +++ b/drivers/block/rnbd/Makefile
> @@ -3,13 +3,11 @@
>  ccflags-y :=3D -I$(srctree)/drivers/infiniband/ulp/rtrs
>
>  rnbd-client-y :=3D rnbd-clt.o \
> -                 rnbd-clt-sysfs.o \
> -                 rnbd-common.o
> +                 rnbd-clt-sysfs.o
>
>  CFLAGS_rnbd-srv-trace.o =3D -I$(src)
>
> -rnbd-server-y :=3D rnbd-common.o \
> -                 rnbd-srv.o \
> +rnbd-server-y :=3D rnbd-srv.o \
>                   rnbd-srv-sysfs.o \
>                   rnbd-srv-trace.o
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnb=
d-clt-sysfs.c
> index 8c6087949794..a0b49a0c0bdd 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -278,7 +278,7 @@ static ssize_t access_mode_show(struct kobject *kobj,
>
>         dev =3D container_of(kobj, struct rnbd_clt_dev, kobj);
>
> -       return sysfs_emit(page, "%s\n", rnbd_access_mode_str(dev->access_=
mode));
> +       return sysfs_emit(page, "%s\n", rnbd_access_modes[dev->access_mod=
e].str);
>  }
>
>  static struct kobj_attribute rnbd_clt_access_mode =3D
> @@ -596,7 +596,7 @@ static ssize_t rnbd_clt_map_device_store(struct kobje=
ct *kobj,
>
>         pr_info("Mapping device %s on session %s, (access_mode: %s, nr_po=
ll_queues: %d)\n",
>                 pathname, sessname,
> -               rnbd_access_mode_str(access_mode),
> +               rnbd_access_modes[access_mode].str,
>                 nr_poll_queues);
>
>         dev =3D rnbd_clt_map_device(sessname, paths, path_cnt, port_nr, p=
athname,
> diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-c=
ommon.c
> deleted file mode 100644
> index 596c3f732403..000000000000
> --- a/drivers/block/rnbd/rnbd-common.c
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * RDMA Network Block Driver
> - *
> - * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> - * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> - * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> - */
> -#include "rnbd-proto.h"
> -
> -const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
> -{
> -       switch (mode) {
> -       case RNBD_ACCESS_RO:
> -               return "ro";
> -       case RNBD_ACCESS_RW:
> -               return "rw";
> -       case RNBD_ACCESS_MIGRATION:
> -               return "migration";
> -       default:
> -               return "unknown";
> -       }
> -}
> diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-pr=
oto.h
> index 84fd69844b7d..e32f8f2c868a 100644
> --- a/drivers/block/rnbd/rnbd-proto.h
> +++ b/drivers/block/rnbd/rnbd-proto.h
> @@ -61,6 +61,15 @@ enum rnbd_access_mode {
>         RNBD_ACCESS_MIGRATION,
>  };
>
> +static const __maybe_unused struct {
> +       enum rnbd_access_mode mode;
> +       const char *str;
> +} rnbd_access_modes[] =3D {
> +       [RNBD_ACCESS_RO] =3D {RNBD_ACCESS_RO, "ro"},
> +       [RNBD_ACCESS_RW] =3D {RNBD_ACCESS_RW, "rw"},
> +       [RNBD_ACCESS_MIGRATION] =3D {RNBD_ACCESS_MIGRATION, "migration"},
> +};
> +
>  /**
>   * struct rnbd_msg_sess_info - initial session info from client to serve=
r
>   * @hdr:               message header
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnb=
d-srv-sysfs.c
> index 9fe7d9e0ab63..4962826e9639 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -103,7 +103,7 @@ static ssize_t access_mode_show(struct kobject *kobj,
>         sess_dev =3D container_of(kobj, struct rnbd_srv_sess_dev, kobj);
>
>         return sysfs_emit(page, "%s\n",
> -                         rnbd_access_mode_str(sess_dev->access_mode));
> +                         rnbd_access_modes[sess_dev->access_mode].str);
>  }
>
>  static struct kobj_attribute rnbd_srv_dev_session_access_mode_attr =3D
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 2cfed2e58d64..e9ef6bd4b50c 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -483,7 +483,7 @@ static int rnbd_srv_check_update_open_perm(struct rnb=
d_srv_dev *srv_dev,
>                         pr_err("Mapping device '%s' for session %s with R=
W permissions failed. Device already opened as 'RW' by %d client(s), access=
 mode %s.\n",
>                                srv_dev->id, srv_sess->sessname,
>                                srv_dev->open_write_cnt,
> -                              rnbd_access_mode_str(access_mode));
> +                              rnbd_access_modes[access_mode].str);
>                 }
>                 break;
>         case RNBD_ACCESS_MIGRATION:
> @@ -494,7 +494,7 @@ static int rnbd_srv_check_update_open_perm(struct rnb=
d_srv_dev *srv_dev,
>                         pr_err("Mapping device '%s' for session %s with m=
igration permissions failed. Device already opened as 'RW' by %d client(s),=
 access mode %s.\n",
>                                srv_dev->id, srv_sess->sessname,
>                                srv_dev->open_write_cnt,
> -                              rnbd_access_mode_str(access_mode));
> +                              rnbd_access_modes[access_mode].str);
>                 }
>                 break;
>         default:
> --
> 2.35.3
>
