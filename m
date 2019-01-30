Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F95FC282D4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 07:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4572B2084C
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 07:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="0IPeQnf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfA3H1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:27:34 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34543 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfA3H1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 02:27:34 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so5143205vkd.1
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 23:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=624FBY/Fw6/U/ipevPoFmrcGDIjBaF9pON78J8dMy9U=;
        b=0IPeQnf5CvnJXoCtyinE0i2XiKBl+b+Gm6/Ed1qfBOlgp3zUkJ7JXRJi3HwSskMg3H
         eVtzp+pEWmMgDHf73xki7pjD47/yq+j35fHt8gX2teF4FK7uTXkHHIusssK4keG3zevy
         uJtsU2e7yVPuCU0eG51T97uymGVF3PJ8lVx2iyfMYknyL0b1mfHrlQRgrmy5KPdk7N00
         kK36I7ZAYdha1Gfj6nLjRCxR7b3J3YyOqQ6/hQITbXLnI87tLqV2DDcPXSxtS13XAtV8
         gsvVnYU70nNhxmy8Ryn+NIhB8aplZqkrK56q4rh+4+WY+iAXpNlW20OK5+AlAgPgN7RR
         r+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=624FBY/Fw6/U/ipevPoFmrcGDIjBaF9pON78J8dMy9U=;
        b=iacd78i8alkVyn3aRKnC0vP5un702HwS1SzFyrmwUooVS9TatpjZFqQoYEroIHNuxS
         yy0Wo5MvRKGujhnfrmTxzoXBjab0SjGeoysWyF/wJXD8cpRKzzX5rgP+QWfs7zlO2FXd
         qOrGyxw9ObkxxkVO3iis0ALTPBA5lSWeZ15bccwWM9n1PZDNZLHcWwA0J0EIQv5aFTQ3
         iCC+dF0sqhWq0N8xsxWV6VxmjMHWOvvvngBPuIJg8qZk3Eq7H5yu6W9Z8qIV0y5tpl4a
         AD7+KZGL7EQwUSdnmDqVjOnVMuKxn0MkrZpDnHaFuScS8fePWFrPjInSdaIwj/ueQUDs
         cICw==
X-Gm-Message-State: AJcUukfdguhu0j/HLGJRuQ6a7ZfVYVImj04kWggkc2O9uxvk927zh0pZ
        GYMTT9pcFFQm4ePoHR3r/yZgMSZe2ZPaO8bIiHNJXg==
X-Google-Smtp-Source: ALg8bN6OfxsfsmWl2KSyLgzLZ/5SBXgJKyf6IS98kebKCcw/uALRsxlZ1erLMcuQjuEs4RBM9f89hLOfUpdTp7KPjg0=
X-Received: by 2002:a1f:d1c3:: with SMTP id i186mr11652042vkg.51.1548833252986;
 Tue, 29 Jan 2019 23:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20190129084737.718-1-hans@owltronix.com> <MWHPR1801MB20300A1F6E55F7979DC0072ECA970@MWHPR1801MB2030.namprd18.prod.outlook.com>
In-Reply-To: <MWHPR1801MB20300A1F6E55F7979DC0072ECA970@MWHPR1801MB2030.namprd18.prod.outlook.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 30 Jan 2019 08:27:20 +0100
Message-ID: <CANr-nt0pXX+jMTo7J3vf3tdApVyHkeH=hET+H95EAyeR89oJPg@mail.gmail.com>
Subject: Re: [EXT] [PATCH] lightnvm: pblk: extend line wp balance check
To:     Zhoujie Wu <zjwu@marvell.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 11:10 PM Zhoujie Wu <zjwu@marvell.com> wrote:
>
> Sorry that my Linux email client has configuration issue and can't reply email. Used my outlook to reply as plain text and hope that I won't corrupt the format.
> Tested on my board and it works well. Since this is a good fix, I think you don't need to do it based on my previous v3 patch and can directly apply yours:)
>
> Tested-by: Zhoujie Wu <zjwu@marvell.com>

Thanks Zhoujie!

I'll squash the two patches into a V2, carrying over the tested-by and
credit you as Reported-by if you don't mind.


>
>
> -----Original Message-----
> From: hans@owltronix.com <hans@owltronix.com>
> Sent: Tuesday, January 29, 2019 12:48 AM
> To: Matias Bjorling <mb@lightnvm.io>
> Cc: javier@javigon.com; Zhoujie Wu <zjwu@marvell.com>; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Hans Holmberg <hans.holmberg@cnexlabs.com>
> Subject: [EXT] [PATCH] lightnvm: pblk: extend line wp balance check
>
> External Email
>
> ----------------------------------------------------------------------
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>
> pblk stripes writes of minimal write size across all non-offline chunks in a line, which means that the maximum write pointer delta should not exceed the minimal write size. Extend the line write pointer balance check to cover this case.
>
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>
> This patch applies on top of Zhoujie's V3 of
> "lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
>
>  drivers/lightnvm/pblk-recovery.c | 60 ++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 02d466e6925e..d86f580036d3 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
>         return (distance > line->left_msecs) ? line->left_msecs : distance;  }
>
> -static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
> -                                     struct pblk_line *line)
> +/* Return a chunk belonging to a line by stripe(write order) index */
> +static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
> +                                                 struct pblk_line *line,
> +                                                 int index)
>  {
>         struct nvm_tgt_dev *dev = pblk->dev;
>         struct nvm_geo *geo = &dev->geo;
> -       struct pblk_line_meta *lm = &pblk->lm;
>         struct pblk_lun *rlun;
> -       struct nvm_chk_meta *chunk;
>         struct ppa_addr ppa;
> -       u64 line_wp;
> -       int pos, i, bit;
> +       int pos;
>
> -       bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
> -       if (bit >= lm->blk_per_line)
> -               return 0;
> -       rlun = &pblk->luns[bit];
> +       rlun = &pblk->luns[index];
>         ppa = rlun->bppa;
>         pos = pblk_ppa_to_pos(geo, ppa);
> -       chunk = &line->chks[pos];
>
> -       line_wp = chunk->wp;
> +       return &line->chks[pos];
> +}
>
> -       for (i = bit + 1; i < lm->blk_per_line; i++) {
> -               rlun = &pblk->luns[i];
> -               ppa = rlun->bppa;
> -               pos = pblk_ppa_to_pos(geo, ppa);
> -               chunk = &line->chks[pos];
> +static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
> +                                     struct pblk_line *line)
> +{
> +       struct pblk_line_meta *lm = &pblk->lm;
> +       int blk_in_line = lm->blk_per_line;
> +       struct nvm_chk_meta *chunk;
> +       u64 max_wp, min_wp;
> +       int i;
>
> -               if (chunk->state & NVM_CHK_ST_OFFLINE)
> -                       continue;
> +       i = find_first_zero_bit(line->blk_bitmap, blk_in_line);
> +
> +       /* If there is one or zero good chunks in the line,
> +        * the write pointers can't be unbalanced.
> +        */
> +       if (i >= (blk_in_line - 1))
> +               return 0;
>
> -               if (chunk->wp > line_wp)
> +       chunk = pblk_get_stripe_chunk(pblk, line, i);
> +       max_wp = chunk->wp;
> +       if (max_wp > pblk->max_write_pgs)
> +               min_wp = max_wp - pblk->max_write_pgs;
> +       else
> +               min_wp = 0;
> +
> +       i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
> +       while (i < blk_in_line) {
> +               chunk = pblk_get_stripe_chunk(pblk, line, i);
> +               if (chunk->wp > max_wp || chunk->wp < min_wp)
>                         return 1;
> -               else if (chunk->wp < line_wp)
> -                       line_wp = chunk->wp;
> +
> +               i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
>         }
>
>         return 0;
> @@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>         int ret;
>         u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
>
> -       if (pblk_line_wp_is_unbalanced(pblk, line))
> +       if (pblk_line_wps_are_unbalanced(pblk, line))
>                 pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
>
>         ppa_list = p.ppa_list;
> --
> 2.17.1
>
