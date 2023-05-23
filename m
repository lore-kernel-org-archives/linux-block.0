Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B22C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjEWJXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjEWJXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:23:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D811F
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:23:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9707313e32eso162530766b.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684833800; x=1687425800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8uIC4MzlwIy1wmWITQ1JfrMZgFvpHYeu/O8FoQ8aJs=;
        b=am1E2cMsEXm2VuMb9ENJO5/7LwEW6t1bQ0FQ2aZdfy4YEE4aW5JmIBe3xb6376Q4Qf
         Yy7SXYeaZqh6nnJtLfkz8MMpZsZKI/rpS3fejuBXChGcWPHdgrpmtDvn0Ap5iQBv1ng6
         9q4i9407tkvS3buQzETh4cLfgoWsWFr6KdORaarK5jTI5xg1RAqvs0rI3BivhjGUz1Ow
         UG4gD9yO+Ev5GQAjtvMvIaKQZm+1YerTPuUgqn/v4q0CBkMKAX57hKHzh0iLCkujd6FC
         19Wmqa+NrJlGMaf8vGmeEjcgr0h6QP0GJzO+WjNRJGk0QfAy8QH5+DEm/vNvnY5fLkir
         zVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833800; x=1687425800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8uIC4MzlwIy1wmWITQ1JfrMZgFvpHYeu/O8FoQ8aJs=;
        b=XZ7W2HbDixEiowgXdimI4oNSEaTLzFmkMuov9Paz9dJSdSfiZjBsH8JreQI66CLi5c
         ozPHJxDwLvm6GOL1tqyhL6cagrsYoeZ/u3YF7CuuUamrrKMRovo/uKE90atDKP+b90+M
         dbMBZs9HE/3iHX/tM6L60eg58EskpWzTErQ3lKxqbtej8Q6o82N6Ls5sc90FQrFkSL+T
         CSU/1JT1ghiyijgc+P/99kOsWVUvMO5JU7mzZXqExSYYx/pZIOhQIpipCEs/0dQwN6cF
         IqmfzrjkBzhPo4YQoLLzj3t6x6U6UAUXImlmgZ1TR22fkyNy4FaNPkrJsRzG3BlmkQZM
         UCVQ==
X-Gm-Message-State: AC+VfDy6QALB0ZOVOsI005Cscy3x9qI4j2fqk+9BUHuggLqEdX0t006H
        /DqUO8j/2/EMsdEIDg2M7hfKIl8UGkHRkFWMOjPUCA==
X-Google-Smtp-Source: ACHHUZ4+v0f52gMvcvpjMPv6Wl1BwkX+th3Qr82PK5PORKvhk+k1rWEFO+8HuuuGuSslS1oIKeuRIARk3XxCpHBKQpg=
X-Received: by 2002:a17:907:930d:b0:96f:5cb3:df66 with SMTP id
 bu13-20020a170907930d00b0096f5cb3df66mr13627763ejc.18.1684833800509; Tue, 23
 May 2023 02:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-4-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-4-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:23:09 +0200
Message-ID: <CAMGffEnCKArKzc0KwAbWa-XnELSYybAKptXE+o7zfOGSwjmU2g@mail.gmail.com>
Subject: Re: [PATCH 03/10] block/rnbd: introduce rnbd_access_modes
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
> Add one new array (marked with __maybe_unused to prevent gcc warning abou=
t
> "defined but not used" with W=3D1), then we can remove rnbd_access_mode_s=
tr
> and rnbd-common.c accordingly.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
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
> index 84fd69844b7d..185e24eaf2bf 100644
> --- a/drivers/block/rnbd/rnbd-proto.h
> +++ b/drivers/block/rnbd/rnbd-proto.h
> @@ -61,6 +61,15 @@ enum rnbd_access_mode {
>         RNBD_ACCESS_MIGRATION,
>  };
>
> +static const __maybe_unused struct {
> +       int             mode;
why not enum rnbd_access_mode?
> +       const char      *str;
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
