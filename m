Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0D3C77B61
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 07:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjD0H0l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbjD0H0k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 03:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51394C04
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682580300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyM98MAbqceja1B6CK2zBG+Cejjx3FV6fdgUYnmjENI=;
        b=WwhC5RIe2mhyQsaQUlvXPmJn8tuJ19ujQGKNr1t9El6SqSzoeA4Fl2rC6c1zej1XAjUXeu
        +6tRNsuLswTPxpfT9n729kp0h4ogtOC2dnVcnwiMlZH9qVqXcZ7e2fCOE7//J65pQQXT8d
        UyG+ZTFASJtA4Vv3dCuLIhQSfAhHN8I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-PkZ1uWSgMnu7Vu_d8f0b8A-1; Thu, 27 Apr 2023 03:24:58 -0400
X-MC-Unique: PkZ1uWSgMnu7Vu_d8f0b8A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2475be6f3a9so4765663a91.1
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 00:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682580297; x=1685172297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyM98MAbqceja1B6CK2zBG+Cejjx3FV6fdgUYnmjENI=;
        b=ahCB17AEDAoXxQ/6kdJF6wTCYICBfryC5Hpwlo6zFuAbZSQs3FYr7hl3IegmvAMhsa
         d+y4def04TW9YY96csn2PvwU23nzK/VN3VYFapgv8Vey1o40eYK50wd4yzakoXjU7bjR
         KzwMheqMiyutAuzru/jx2DakYE5zZ5ddLv2pTwpRmJXBheqQ29LmpjNYNlg2P6Mzs/Dp
         QDhcWO/VzP8REKnreNDfcHqHkALtMUyVcyjpAO1iBZu1fO8rtcoDBUXbgTLXXTMsnaYV
         eg/Qr7q+18vB4x0qgu7quHzZv9j3NkArVRwma9G17dqrJ0epVQtnaNVGii9sTUF5jB4e
         XOyg==
X-Gm-Message-State: AC+VfDzTo3937JwRkjkmp3y0f2rIwOnBCNiplJvrPltWtOIM9TmwUR7R
        VTRvZz+UaPyMBrXhRwbXFpZmWqyNdInIvSlVPLeR0VZgC3HKzR7blrG+AtatA1KvUdLHhg08H9x
        RPg6EKp1jn/LsTjMDAPD2Y2whHiMXyNHKUyo/KJw=
X-Received: by 2002:a17:90b:19d5:b0:246:818c:d8e4 with SMTP id nm21-20020a17090b19d500b00246818cd8e4mr1119509pjb.11.1682580297320;
        Thu, 27 Apr 2023 00:24:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vQpFO5Oei/YTEoy+0BUpIad1HoAC2N38UNodYaZb1WTOw3xO4U4+aomv+OI5+gEOy+9SYcRydwdv+rFrW8gw=
X-Received: by 2002:a17:90b:19d5:b0:246:818c:d8e4 with SMTP id
 nm21-20020a17090b19d500b00246818cd8e4mr1119496pjb.11.1682580296981; Thu, 27
 Apr 2023 00:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me> <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
 <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com> <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
In-Reply-To: <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 27 Apr 2023 15:24:45 +0800
Message-ID: <CAHj4cs_urWYi_yPQ-FoFo2kV4h1gz-mwxfRiOTj7co3=bUnO5w@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya

The kmemleak in [1] is fixed by your patch, but there still has
one[2], would you mind checking it, thanks.

[1]
nvme_ctrl_dhchap_secret_store
cdev_device_add

[2]
unreferenced object 0xffff888288a53b80 (size 96):
  comm "nvme", pid 1934, jiffies 4294932237 (age 237.359s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
    [<ffffffff87395fa0>] dev_pm_qos_update_user_latency_tolerance+0xe0/0x20=
0
    [<ffffffffc08c783c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
    [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
    [<ffffffffc0d38177>] 0xffffffffc0d38177
    [<ffffffffc0d38613>] 0xffffffffc0d38613
    [<ffffffff867b5056>] vfs_write+0x216/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

On Wed, Apr 26, 2023 at 4:34=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 4/26/23 01:23, Chaitanya Kulkarni wrote:
> >
> >>>> [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
> >>>>       [<ffffffffc09fb710>]
> >>>> nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_core]
> >>>>       [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
> >>>>       [<ffffffff871b47d2>] vfs_write+0x802/0xc60
> >>>>       [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
> >>>>       [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
> >>>>       [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > can you check if following fixes your problem for dhchap ?
> >
> >
> > linux-block (for-next) # git diff
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 1bfd52eae2ee..0e22d048de3c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3825,8 +3825,10 @@ static ssize_t
> > nvme_ctrl_dhchap_secret_store(struct device *dev,
> >                 int ret;
> >
> >                 ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> > -               if (ret)
> > +               if (ret) {
> > +                       kfree(dhchap_secret);
> >                         return ret;
> > +               }
> >                 kfree(opts->dhchap_secret);
> >                 opts->dhchap_secret =3D dhchap_secret;
> >                 host_key =3D ctrl->host_key;
> > @@ -3879,8 +3881,10 @@ static ssize_t
> > nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
> >                 int ret;
> >
> >                 ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> > -               if (ret)
> > +               if (ret) {
> > +                       kfree(dhchap_secret);
> >                         return ret;
> > +               }
> >                 kfree(opts->dhchap_ctrl_secret);
> >                 opts->dhchap_ctrl_secret =3D dhchap_secret;
> >                 ctrl_key =3D ctrl->ctrl_key;
> >
> > -ck
> >
> >
>
> sorry my forget to add ida changes, plz ignore earlier and try this :-
>
> linux-block (for-next) # git diff
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1bfd52eae2ee..bb376cc6a5a3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3825,8 +3825,10 @@ static ssize_t
> nvme_ctrl_dhchap_secret_store(struct device *dev,
>                  int ret;
>
>                  ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> -               if (ret)
> +               if (ret) {
> +                       kfree(dhchap_secret);
>                          return ret;
> +               }
>                  kfree(opts->dhchap_secret);
>                  opts->dhchap_secret =3D dhchap_secret;
>                  host_key =3D ctrl->host_key;
> @@ -3879,8 +3881,10 @@ static ssize_t
> nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>                  int ret;
>
>                  ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> -               if (ret)
> +               if (ret) {
> +                       kfree(dhchap_secret);
>                          return ret;
> +               }
>                  kfree(opts->dhchap_ctrl_secret);
>                  opts->dhchap_ctrl_secret =3D dhchap_secret;
>                  ctrl_key =3D ctrl->ctrl_key;
> @@ -4042,8 +4046,10 @@ int nvme_cdev_add(struct cdev *cdev, struct
> device *cdev_device,
>          cdev_init(cdev, fops);
>          cdev->owner =3D owner;
>          ret =3D cdev_device_add(cdev, cdev_device);
> -       if (ret)
> +       if (ret) {
>                  put_device(cdev_device);
> +               ida_free(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt)=
);
> +       }
>
>          return ret;
>   }
>
>
> with above patch I was able to get this :-
>
> blktests (master) # ./check nvme/044
> nvme/044 (Test bi-directional authentication) [passed]
>      runtime  1.729s  ...  1.892s
> blktests (master) # ./check nvme/045
> nvme/045 (Test re-authentication) [passed]
>      runtime  4.798s  ...  6.303s
>
> -ck
>
>


--=20
Best Regards,
  Yi Zhang

