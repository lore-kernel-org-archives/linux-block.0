Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43623 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeHJKqb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 06:46:31 -0400
Received: by mail-ua1-f67.google.com with SMTP id f4-v6so1024714uao.10
        for <linux-block@vger.kernel.org>; Fri, 10 Aug 2018 01:17:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180802205023.29094-1-mb@lightnvm.io>
References: <20180802205023.29094-1-mb@lightnvm.io>
From: Hans Holmberg <hans@owltronix.com>
Date: Fri, 10 Aug 2018 10:17:41 +0200
Message-ID: <CANr-nt1SrDTa+im3THtOPgh=0vPP+iBfGjVJuLZkVnvF3Z0WXA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 2, 2018 at 10:50 PM, Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
> rqd.error is masked by the return value of pblk_submit_io_sync.
> The rqd structure is then passed on to the end_io function, which
> assumes that any error should lead to a chunk being marked
> offline/bad. Since the pblk_submit_io_sync can fail before the
> command is issued to the device, the error value maybe not correspond
> to a media failure, leading to chunks being immaturely retired.
>
> Also, the pblk_blk_erase_sync function prints an error message in case
> the erase fails. Since the caller prints an error message by itself,
> remove the error message in this function.
>
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
>  drivers/lightnvm/pblk-core.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 72acf2f6dbd6..814204d22a2e 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -886,10 +886,8 @@ static void pblk_setup_e_rq(struct pblk *pblk, struc=
t nvm_rq *rqd,
>
>  static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
>  {
> -       struct nvm_rq rqd;
> -       int ret =3D 0;
> -
> -       memset(&rqd, 0, sizeof(struct nvm_rq));
> +       struct nvm_rq rqd =3D {0};
> +       int ret;
>
>         pblk_setup_e_rq(pblk, &rqd, ppa);
>
> @@ -897,19 +895,6 @@ static int pblk_blk_erase_sync(struct pblk *pblk, st=
ruct ppa_addr ppa)
>          * with writes. Thus, there is no need to take the LUN semaphore.
>          */
>         ret =3D pblk_submit_io_sync(pblk, &rqd);
> -       if (ret) {
> -               struct nvm_tgt_dev *dev =3D pblk->dev;
> -               struct nvm_geo *geo =3D &dev->geo;
> -
> -               pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
> -                                       pblk_ppa_to_line(ppa),
> -                                       pblk_ppa_to_pos(geo, ppa));
> -
> -               rqd.error =3D ret;
> -               goto out;
> -       }
> -
> -out:
>         rqd.private =3D pblk;
>         __pblk_end_io_erase(pblk, &rqd);
>
> --
> 2.11.0
>


Nice catch! I just added fixing this exact issue in my own backlog,
great that you've already fixed it.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
