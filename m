Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35925 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeJYTtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Oct 2018 15:49:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id c205so5224890vsd.3
        for <linux-block@vger.kernel.org>; Thu, 25 Oct 2018 04:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <1540428404-30196-1-git-send-email-zjwu@marvell.com>
In-Reply-To: <1540428404-30196-1-git-send-email-zjwu@marvell.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Thu, 25 Oct 2018 13:16:38 +0200
Message-ID: <CANr-nt2bHSPhpRprvYcb1L-rhPFri0Cm2YBWdV+6AHe1Mk3mMw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: ignore the smeta oob area scan
To: zjwu@marvell.com
Cc: Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        linux-block@vger.kernel.org, hongd@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 25, 2018 at 2:44 AM Zhoujie Wu <zjwu@marvell.com> wrote:
>
> The smeta area l2p mapping is empty, and actually the
> recovery procedure only need to restore data sector's l2p
> mapping. So ignore the smeta oob scan.
>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> ---
>  drivers/lightnvm/pblk-recovery.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 5740b75..30f2616 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -334,6 +334,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>                                struct pblk_recov_alloc p)
>  {
>         struct nvm_tgt_dev *dev = pblk->dev;
> +       struct pblk_line_meta *lm = &pblk->lm;
>         struct nvm_geo *geo = &dev->geo;
>         struct ppa_addr *ppa_list;
>         struct pblk_sec_meta *meta_list;
> @@ -342,12 +343,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>         void *data;
>         dma_addr_t dma_ppa_list, dma_meta_list;
>         __le64 *lba_list;
> -       u64 paddr = 0;
> +       u64 paddr = lm->smeta_sec;

Smeta is not guaranteed to start at paddr 0 - it will be placed in the
first non-bad chunk (in stripe order).
If the first chunk in the line is bad, smeta will be read and
lm->smeta_sec sectors will be lost.

You can use pblk_line_smeta_start to calculate the start address of smeta.

/ Hans

>         bool padded = false;
>         int rq_ppas, rq_len;
>         int i, j;
>         int ret;
> -       u64 left_ppas = pblk_sec_in_open_line(pblk, line);
> +       u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
>
>         if (pblk_line_wp_is_unbalanced(pblk, line))
>                 pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
> --
> 1.9.1
>
