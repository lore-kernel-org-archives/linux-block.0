Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41471 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHJKdi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 06:33:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id h1-v6so998738uao.8
        for <linux-block@vger.kernel.org>; Fri, 10 Aug 2018 01:04:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Fri, 10 Aug 2018 10:04:52 +0200
Message-ID: <CANr-nt18UvLY7YjUqTDtd-mi+Az-WTMvcbCTC1uVgBpddS=zxQ@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc: Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 3, 2018 at 2:05 PM, Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
>
> Since metadata I/O is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
>
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metdatada scheme could cause
> ordering issues.
>
> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>  drivers/lightnvm/pblk.h      |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 00984b486fea..160b54d26bfa 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nv=
m_rq *rqd)
>         return nvm_submit_io_sync(dev, rqd);
>  }
>
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +       if (rqd->opcode !=3D NVM_OP_PWRITE)
> +               pblk_submit_io_sync(pblk, rqd);
> +
> +       pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);

This will only work if rqd->nr_ppas > 1, better check if rqd->nr_ppas
is 1 and pass &ppa->ppa_addr on to pblk_down_page when needed.

> +       pblk_submit_io_sync(pblk, rqd);
> +       pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +}
> +
>  static void pblk_bio_map_addr_endio(struct bio *bio)
>  {
>         bio_put(bio);
> @@ -737,7 +747,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pbl=
k, struct pblk_line *line,
>                 }
>         }
>
> -       ret =3D pblk_submit_io_sync(pblk, &rqd);
> +       ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
>         if (ret) {
>                 pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
>                 bio_put(bio);
> @@ -842,7 +852,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pbl=
k, struct pblk_line *line,
>          * the write thread is the only one sending write and erase comma=
nds,
>          * there is no need to take the LUN semaphore.
>          */
> -       ret =3D pblk_submit_io_sync(pblk, &rqd);
> +       ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
>         if (ret) {
>                 pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>                 bio_put(bio);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 4760af7b6499..6ccc6ad8e1ce 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -782,6 +782,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm=
_rq *rqd);
>  void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
>  struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
>                               unsigned int nr_secs, unsigned int len,
> --
> 2.7.4
>
