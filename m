Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40689 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIFMZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Sep 2018 08:25:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id 101-v6so7985872uav.7
        for <linux-block@vger.kernel.org>; Thu, 06 Sep 2018 00:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180905084017.27593-1-baijiaju1990@gmail.com>
In-Reply-To: <20180905084017.27593-1-baijiaju1990@gmail.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Thu, 6 Sep 2018 09:51:25 +0200
Message-ID: <CANr-nt3AS_p9n7R54045iGAd=woK+S66d85Q8SLgVTBFhZgVPA@mail.gmail.com>
Subject: Re: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
To: baijiaju1990@gmail.com
Cc: Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 5, 2018 at 10:40 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> The driver may sleep with holding a spinlock.
>
> The function call paths (from bottom to top) in Linux-4.16 are:
>
> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 754:
>         nvm_dev_dma_alloc in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
>         pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
>         pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
>         pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
>         spin_lock in pblk_recov_l2p
>
> [FUNC] bio_map_kern(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 762:
>         bio_map_kern in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
>         pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
>         pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
>         pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
>         spin_lock in pblk_recov_l2p
>
> To fix these bugs, the call to pblk_line_replace_data()
> is moved out of the spinlock protection.
>
> These bugs are found by my static analysis tool DSAC.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Move the call to pblk_line_replace_data() out of the spinlock
>   protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
>   the calls to bio_map_kern() and nvm_dev_dma_alloc().
>   Thanks Javier for good advice.
> ---
>  drivers/lightnvm/pblk-recovery.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 3a5069183859..5fde414d78bb 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>                 }
>         }
>
> -       spin_lock(&l_mg->free_lock);
>         if (!open_lines) {
> +               spin_lock(&l_mg->free_lock);
>                 WARN_ON_ONCE(!test_and_clear_bit(meta_line,
>                                                         &l_mg->meta_bitmap));
> +               spin_unlock(&l_mg->free_lock);
>                 pblk_line_replace_data(pblk);
>         } else {
> +               spin_lock(&l_mg->free_lock);
>                 /* Allocate next line for preparation */
>                 l_mg->data_next = pblk_line_get(pblk);
>                 if (l_mg->data_next) {
> @@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>                         l_mg->data_next->type = PBLK_LINETYPE_DATA;
>                         is_next = 1;
>                 }
> +               spin_unlock(&l_mg->free_lock);
>         }
> -       spin_unlock(&l_mg->free_lock);

Wouldn't the most straight forward solution here to not take the lock?

As pblk is doing all the recovery sequentially during initialization,
I don't see the
reason for grabbing the lock.

>
>         if (is_next)
>                 pblk_line_erase(pblk, l_mg->data_next);
> --
> 2.17.0
>
