Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeHVAqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Aug 2018 20:46:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so11055216wrb.12
        for <linux-block@vger.kernel.org>; Tue, 21 Aug 2018 14:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180821114441.23147-1-mb@lightnvm.io>
In-Reply-To: <20180821114441.23147-1-mb@lightnvm.io>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Tue, 21 Aug 2018 23:24:01 +0200
Message-ID: <CAJbgVnWYr6HMjO_gnQpyhrZ0cT5G9e-TPjqtRpaao0dW7rvEXg@mail.gmail.com>
Subject: Re: [PATCH v2] lightnvm: pblk: refactor put line fn on read completion
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        Javier Gonzalez <javier@cnexlabs.com>,
        hans.holmberg@cnexlabs.com, youngtack.jin@circuitblvd.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks, Matias!

LGTM

On Tue, Aug 21, 2018 at 1:44 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> The read completion path uses the put_line variable to decide whether
> the reference on a line should be released. The function name used for
> that is pblk_read_put_rqd_kref, which could lead one to believe that it
> is the rqd that is releasing the reference, while it is the line
> reference that is put.
>
> Rename and also split the function in two to account for either rqd or
> single ppa callers and move it to core, such that it later can be used
> in the write path as well.
>
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> Reviewed-by: Heiner Litz <hlitz@ucsc.edu>
>
> Changes since v1:
>
>   Moved into core for Heiner to later integrate with his RAIL
>   patches.
> ---
>  drivers/lightnvm/pblk-core.c | 19 +++++++++++++++++++
>  drivers/lightnvm/pblk-read.c | 18 +-----------------
>  drivers/lightnvm/pblk.h      |  2 ++
>  3 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index e0b513d07e14..5f99cf396072 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1426,6 +1426,25 @@ struct pblk_line *pblk_line_get_first_data(struct =
pblk *pblk)
>         return line;
>  }
>
> +void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
> +{
> +       struct pblk_line *line;
> +
> +       line =3D &pblk->lines[pblk_ppa_to_line(ppa)];
> +       kref_put(&line->ref, pblk_line_put_wq);
> +}
> +
> +void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +       struct ppa_addr *ppa_list;
> +       int i;
> +
> +       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> +
> +       for (i =3D 0; i < rqd->nr_ppas; i++)
> +               pblk_ppa_to_line_put(pblk, ppa_list[i]);
> +}
> +
>  static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
>  {
>         lockdep_assert_held(&pblk->l_mg.free_lock);
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 1ad501721d0f..dc8233f3fd6c 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -165,22 +165,6 @@ static void pblk_read_check_rand(struct pblk *pblk, =
struct nvm_rq *rqd,
>         WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random request\n"=
);
>  }
>
> -static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd=
)
> -{
> -       struct ppa_addr *ppa_list;
> -       int i;
> -
> -       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> -
> -       for (i =3D 0; i < rqd->nr_ppas; i++) {
> -               struct ppa_addr ppa =3D ppa_list[i];
> -               struct pblk_line *line;
> -
> -               line =3D &pblk->lines[pblk_ppa_to_line(ppa)];
> -               kref_put(&line->ref, pblk_line_put_wq);
> -       }
> -}
> -
>  static void pblk_end_user_read(struct bio *bio)
>  {
>  #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -208,7 +192,7 @@ static void __pblk_end_io_read(struct pblk *pblk, str=
uct nvm_rq *rqd,
>                 bio_put(int_bio);
>
>         if (put_line)
> -               pblk_read_put_rqd_kref(pblk, rqd);
> +               pblk_rq_to_line_put(pblk, rqd);
>
>  #ifdef CONFIG_NVM_PBLK_DEBUG
>         atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 64ae0c7ed3bb..be67bbfa3d0a 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -787,6 +787,8 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void=
 *data,
>  struct pblk_line *pblk_line_get(struct pblk *pblk);
>  struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
>  struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
> +void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa);
> +void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
>  void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
>  struct pblk_line *pblk_line_get_data(struct pblk *pblk);
> --
> 2.11.0
>
