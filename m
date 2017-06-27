Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36768 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdF0JGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 05:06:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170627083950.11312-2-matias@cnexlabs.com>
References: <20170627083950.11312-1-matias@cnexlabs.com> <20170627083950.11312-2-matias@cnexlabs.com>
From: Frans Klaver <fransklaver@gmail.com>
Date: Tue, 27 Jun 2017 11:06:44 +0200
Message-ID: <CAH6sp9NuonymjV0n2nsChcTKZ6sq5+S_s3uQ-48M0mY9LQh9mg@mail.gmail.com>
Subject: Re: [PATCH] ligtnvm: if LUNs are already allocated fix return
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 27, 2017 at 10:39 AM, Matias Bj=C3=B8rling <m@bjorling.me> wrot=
e:
> From: Rakesh Pandit <rakesh@tuxera.com>
>
> While creating new device with NVM_DEV_CREATE if LUNs are already
> allocated ioctl would return -ENOMEM which is wrong.  This patch
> propagates -EBUSY from nvm_reserve_luns which is correct response.
>
> Fixes: ade69e243 ("lightnvm: merge gennvm with core")
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> Signed-off-by: Matias Bj=C3=B8rling <matias@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index b8f82f5..9ff348f 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -235,7 +235,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct=
 nvm_ioctl_create *create)
>         struct nvm_target *t;
>         struct nvm_tgt_dev *tgt_dev;
>         void *targetdata;
> -       int ret;
> +       int ret =3D 0;

Is there any way that you can reach a 'return ret' without having ret
set by some other assignment?


>         tt =3D nvm_find_target_type(create->tgttype, 1);
>         if (!tt) {
> @@ -252,8 +252,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct=
 nvm_ioctl_create *create)
>         }
>         mutex_unlock(&dev->mlock);
>
> -       if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
> -               return -ENOMEM;
> +       ret =3D nvm_reserve_luns(dev, s->lun_begin, s->lun_end);
> +       if (ret)
> +               goto err;

Why don't you return err straight away here?


>         t =3D kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
>         if (!t) {
> @@ -314,8 +315,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct=
 nvm_ioctl_create *create)
>         mutex_lock(&dev->mlock);
>         list_add_tail(&t->list, &dev->targets);
>         mutex_unlock(&dev->mlock);
> -
> -       return 0;
> +err:
> +       return ret;

This should not be necessary. In any case, the de-init order should
always be the reverse of the init order, so we don't end up confused.

Frans
