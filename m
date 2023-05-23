Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C796C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjEWJaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEWJaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:30:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431294
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:30:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1b2so1148500a12.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684834214; x=1687426214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE7Zyz9HNYfFLXNPnHTdc8FUA1/63qFYGKofo0jrisw=;
        b=DKFF7sF54l4WyR56IiTfPLOeSZHAWZkKUKNTXAPshapBBMYeZSj8yM/Qy2xUdq5rWy
         PQpc01vQnYxgKEceuBD6YtXGu2rezkSA8Ze0oOlxGEz2tYGuyOA+hSdG4btDwfq1f3+Y
         lIdhK6t3DYH282lEVdgPjbKoIv1bICazhgi8NoDp121wEiSFAZr2PfIEdVTTteY+sGjW
         QMQa6zIRCNO67iII865N9dorpQZdJVUdqOlauOlqXoP3Ctkb68a7dZ/OHo+5k2Bbe1/V
         tVlylg+ACGHXHlFiOILAx58MOXpPD54b3IcBSxLB6qKIlbXFZHFmIXNODxaWN4mMWdn6
         qWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834214; x=1687426214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE7Zyz9HNYfFLXNPnHTdc8FUA1/63qFYGKofo0jrisw=;
        b=D/2yur0jAiCy9hNMMCnxzeKhfQfPI6Rghrrl4pKpGzKIxyiA5xPw1T/mE+o+oTFT+u
         jtEwuDG/sNj1dfMG+Kaik8tvqHZEnpKfqT5X6uA0xPLXOWS0s9Ybla87qjq89UsPQejQ
         Kz6fUMUsAucScInaEyz47DaLUsmIVhQQjChYA7zdzd4q4jb2N+bnNE/P5gdHZyBw7b76
         YNq3q7D1BUDDjtd9OaOceBacSErbdIYVUmX64LzxEKrjoTNIZcz8tdArmSnY4GQj3FZF
         hs8OJhoZZdT91sT/mb0oVTKdTkIPIB3TbuTyrKYPi5Keqq89xL0f9cYwFVL0GhYfrXl7
         bpmg==
X-Gm-Message-State: AC+VfDxcB74fSfuosGNqw3MAu0BZ4b9fJrhEbK/OY6TsuzpQM3aWAxY5
        CUpJWYtCgtIiF9hsGd+HqEqgl5dn+dmZHzSFVnJwAQ==
X-Google-Smtp-Source: ACHHUZ47VoXKGZ4mF0MJz4K4dyOMJXaaYIYawzmSy2708P4NxpO7lVFCIOynjqbIvQ3uFxcMY3Zb/Uf4+YaaaPELmR8=
X-Received: by 2002:aa7:c1d8:0:b0:50b:b7f5:3128 with SMTP id
 d24-20020aa7c1d8000000b0050bb7f53128mr9820552edp.12.1684834214638; Tue, 23
 May 2023 02:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-7-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-7-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:30:04 +0200
Message-ID: <CAMGffEkexApuKZmE6oiB2n1RDHXJkjc_RGYZPMnn5Zdn43YJMw@mail.gmail.com>
Subject: Re: [PATCH 06/10] block/rnbd-srv: rename one member in rnbd_srv_dev
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
> It actually represents the name of rnbd_srv_dev.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 14 +++++++-------
>  drivers/block/rnbd/rnbd-srv.h |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index b4c880759a52..e51eb4b7f6e6 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -176,7 +176,7 @@ static void destroy_device(struct kref *kref)
>
>         WARN_ONCE(!list_empty(&dev->sess_dev_list),
>                   "Device %s is being destroyed but still in use!\n",
> -                 dev->id);
> +                 dev->name);
>
>         spin_lock(&dev_lock);
>         list_del(&dev->list);
> @@ -427,7 +427,7 @@ static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(str=
uct block_device *bdev)
>         if (!dev)
>                 return ERR_PTR(-ENOMEM);
>
> -       snprintf(dev->id, sizeof(dev->id), "%pg", bdev);
> +       snprintf(dev->name, sizeof(dev->name), "%pg", bdev);
>         kref_init(&dev->kref);
>         INIT_LIST_HEAD(&dev->sess_dev_list);
>         mutex_init(&dev->lock);
> @@ -442,7 +442,7 @@ rnbd_srv_find_or_add_srv_dev(struct rnbd_srv_dev *new=
_dev)
>
>         spin_lock(&dev_lock);
>         list_for_each_entry(dev, &dev_list, list) {
> -               if (!strncmp(dev->id, new_dev->id, sizeof(dev->id))) {
> +               if (!strncmp(dev->name, new_dev->name, sizeof(dev->name))=
) {
>                         if (!kref_get_unless_zero(&dev->kref))
>                                 /*
>                                  * We lost the race, device is almost dea=
d.
> @@ -477,7 +477,7 @@ static int rnbd_srv_check_update_open_perm(struct rnb=
d_srv_dev *srv_dev,
>                         ret =3D 0;
>                 } else {
>                         pr_err("Mapping device '%s' for session %s with R=
W permissions failed. Device already opened as 'RW' by %d client(s), access=
 mode %s.\n",
> -                              srv_dev->id, srv_sess->sessname,
> +                              srv_dev->name, srv_sess->sessname,
>                                srv_dev->open_write_cnt,
>                                rnbd_access_modes[access_mode].str);
>                 }
> @@ -488,14 +488,14 @@ static int rnbd_srv_check_update_open_perm(struct r=
nbd_srv_dev *srv_dev,
>                         ret =3D 0;
>                 } else {
>                         pr_err("Mapping device '%s' for session %s with m=
igration permissions failed. Device already opened as 'RW' by %d client(s),=
 access mode %s.\n",
> -                              srv_dev->id, srv_sess->sessname,
> +                              srv_dev->name, srv_sess->sessname,
>                                srv_dev->open_write_cnt,
>                                rnbd_access_modes[access_mode].str);
>                 }
>                 break;
>         default:
>                 pr_err("Received mapping request for device '%s' on sessi=
on %s with invalid access mode: %d\n",
> -                      srv_dev->id, srv_sess->sessname, access_mode);
> +                      srv_dev->name, srv_sess->sessname, access_mode);
>                 ret =3D -EINVAL;
>         }
>
> @@ -770,7 +770,7 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>         list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
>         mutex_unlock(&srv_dev->lock);
>
> -       rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->id);
> +       rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->name=
);
>
>         kfree(full_path);
>
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.=
h
> index f5962fd31d62..6b5e5ade18ae 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -35,7 +35,7 @@ struct rnbd_srv_dev {
>         struct kobject                  dev_kobj;
>         struct kobject                  *dev_sessions_kobj;
>         struct kref                     kref;
> -       char                            id[NAME_MAX];
> +       char                            name[NAME_MAX];
>         /* List of rnbd_srv_sess_dev structs */
>         struct list_head                sess_dev_list;
>         struct mutex                    lock;
> --
> 2.35.3
>
