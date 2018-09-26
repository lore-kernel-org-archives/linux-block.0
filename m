Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42524 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIZMlP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Sep 2018 08:41:15 -0400
Received: by mail-ua1-f65.google.com with SMTP id w7-v6so10425899uan.9
        for <linux-block@vger.kernel.org>; Tue, 25 Sep 2018 23:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <1537941384-25324-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1537941384-25324-1-git-send-email-weiyongjun1@huawei.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Wed, 26 Sep 2018 08:29:43 +0200
Message-ID: <CANr-nt2AugGYaifCj7dbeZ+3b4A8JyxKjZZeQQ7yhXbnJVGhDQ@mail.gmail.com>
Subject: Re: [PATCH -next] lightnvm: pblk: fix error handling of pblk_lines_init()
To: weiyongjun1@huawei.com
Cc: Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 26, 2018 at 7:47 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In the too many bad blocks error handling case, we should release all
> the alloced resources instead direct return, otherwise it will cause
> memory leak.
>
> Fixes: 2deeefc02dff ("lightnvm: pblk: fail gracefully on line alloc. failure")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/lightnvm/pblk-init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 537e98f..a26f4e6 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1083,7 +1083,8 @@ static int pblk_lines_init(struct pblk *pblk)
>
>         if (!nr_free_chks) {
>                 pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
> -               return -EINTR;
> +               ret = -EINTR;
> +               goto fail_free_lines;
>         }
>
>         pblk_set_provision(pblk, nr_free_chks);
>

Looks good to me.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
