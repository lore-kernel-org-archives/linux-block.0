Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34227 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbdF0LBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 07:01:23 -0400
MIME-Version: 1.0
In-Reply-To: <20170627104315.GA52146@dhcp-216.srv.tuxera.com>
References: <20170627104315.GA52146@dhcp-216.srv.tuxera.com>
From: Frans Klaver <fransklaver@gmail.com>
Date: Tue, 27 Jun 2017 13:01:22 +0200
Message-ID: <CAH6sp9MMAenKxknXYkCwOY9H7h_CT9zkBTvrykssVMPOdGtzqQ@mail.gmail.com>
Subject: Re: [PATCH V2] lightnvm: if LUNs are already allocated fix return
To: Rakesh Pandit <rakesh@tuxera.com>
Cc: Jens Axboe <axboe@fb.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias@cnexlabs.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 27, 2017 at 12:43 PM, Rakesh Pandit <rakesh@tuxera.com> wrote:
> While creating new device with NVM_DEV_CREATE if LUNs are already
> allocated ioctl would return -ENOMEM which is wrong.  This patch
> propagates -EBUSY from nvm_reserve_luns which is correct response.
>
> Fixes: ade69e243 ("lightnvm: merge gennvm with core")
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>
> V2: return error code directly instead of using ret variable (Frans)
>
>  drivers/lightnvm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index b8f82f5..c5d71c6 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -253,7 +253,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>         mutex_unlock(&dev->mlock);
>
>         if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
> -               return -ENOMEM;
> +               return -EBUSY;

Why aren't you propagating ret in this version?
