Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33299 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdE2I1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2017 04:27:42 -0400
Received: by mail-vk0-f65.google.com with SMTP id c185so1090118vkd.0
        for <linux-block@vger.kernel.org>; Mon, 29 May 2017 01:27:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495554595-30945-2-git-send-email-idryomov@gmail.com>
References: <1495554595-30945-1-git-send-email-idryomov@gmail.com> <1495554595-30945-2-git-send-email-idryomov@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 29 May 2017 10:27:41 +0200
Message-ID: <CAOi1vP8K8n4KwctoaVWUKS2infACNMN0OV2mkGmwBpmynWGL_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nbd: don't leak nbd_config
To: Josef Bacik <jbacik@fb.com>
Cc: nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 23, 2017 at 5:49 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> nbd_config is allocated in nbd_alloc_config(), but never freed.
>
> Fixes: 5ea8d10802ec ("nbd: separate out the config information")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index e725d8d5ab0b..f3f191ba8ca4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1021,6 +1021,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>                         }
>                         kfree(config->socks);
>                 }
> +               kfree(nbd->config);
>                 nbd->config = NULL;
>
>                 nbd->tag_set.timeout = 0;

Hi Josef,

Ping -- I think these should go into 4.12-rc, Jens is probably waiting
for your OK.

Thanks,

                Ilya
