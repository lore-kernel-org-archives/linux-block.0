Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14875C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 08:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C833921855
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 08:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="kp3Ng6Da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfAYIr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:47:28 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41622 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYIr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 03:47:28 -0500
Received: by mail-ua1-f66.google.com with SMTP id z24so2974843ual.8
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 00:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKmDBjYBvS0GyLxiY7/dEaWXQULBJfFCLjAUtl27dhc=;
        b=kp3Ng6DaclxgsEV99cSy9sF/9zus5V28Fhnu3482e/FSZdwrQk66ed5qgzhp5befuT
         shmbTtEU6FUsRrPLrqAqh4FciX7l4iq85jGv5BwzgfQbT5qfhXorKlVHijp/YJAYCWbt
         IaD4ikbi8lPwerLPvghOw2uPi3ZWqmTtJVgaJci6LXTx1EJVoed2s1p3VWFJPsnpG5au
         r8sA9wlr/4er85ciFxw+ry4dtV4qFWFBEA8rDBEY2IIFbGnBOn6mWfGIOpcO7zIxOdNb
         f07eMHTxcNZrG/5Ipd4sfNO9/8ztSf1ua8eVeYrrT9F3YOYMzzVbZDNOlZT5ImV5GoEq
         Qh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKmDBjYBvS0GyLxiY7/dEaWXQULBJfFCLjAUtl27dhc=;
        b=VbZXWRqCC50RqyTEuz1a7cztFVP3XfBQ4qYtgpAI+w8E+CFKOMfJZV40bcxkU0mWtk
         xK/uMyx1BdlBrQjBBcf5tuibLpEBP52BWJhrnAUcN/kwW/OLxhyXnLvXbjiiODSLmON+
         wClpML3GH0oyFSbfhmwprSsbB8mGD3ZRQrftDSiQyUj6+2nQEU+Z5PiP8NjvmticjTIc
         BEeiQNwutvLgL2GXCQg8rh74eZRvmZ2Sfu8SsZcUQy1S0Cbvox+JaXgWXI2U4aLuxTQp
         8FuKoZPOg4cUxeNhn9Ru2x3+DAt3wUg+wGlK9a6NeTCDgmoZjF4bytO+zKeYB2w3Q/1C
         EBYw==
X-Gm-Message-State: AJcUukffGvUsFo2tZDSxIOXnHglSHpdmpzxCm11iZEZCl9spndAxSu3w
        li4Zv3UlZ3JucMfPOn/18uYg+kYpbx7RHsNqhxUa9Q==
X-Google-Smtp-Source: ALg8bN4A2lSIrtBR+iXBlYRGMVAHCEvoi/Gpnedm9X5TdAqHq6SWoTU97WxsYr3TlmYc/lTtOemWgA748MC0it973YM=
X-Received: by 2002:ab0:49ee:: with SMTP id f43mr3943324uad.29.1548406046277;
 Fri, 25 Jan 2019 00:47:26 -0800 (PST)
MIME-Version: 1.0
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
In-Reply-To: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 25 Jan 2019 09:47:15 +0100
Message-ID: <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
To:     Zhoujie Wu <zjwu@marvell.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        hongd@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wrote:
>
> The write pointer of the bad block could be 0 or undefined, ignore
> the checking of the bad block wp for pblk_line_wp_is_unbalanced to
> avoid fake warning.

fake -> spurious?

>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> ---
> v3: return in case bit >= lm->blk_per_line.
> v2: changed according to Javier's comments.
>
>  drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 6761d2a..02d466e 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
>         struct nvm_chk_meta *chunk;
>         struct ppa_addr ppa;
>         u64 line_wp;
> -       int pos, i;
> +       int pos, i, bit;

We don't need both bit and i, one of them is enough.

>
> -       rlun = &pblk->luns[0];
> +       bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
> +       if (bit >= lm->blk_per_line)
> +               return 0;

If there is only one non-offline chunk in the line, the wp can't be unbalanced,
so it should be safe to return 0 here if bit >= lm->blk_per_line - 1

If you change this please document why using a comment, as it might
not be obvious

> +       rlun = &pblk->luns[bit];
>         ppa = rlun->bppa;
>         pos = pblk_ppa_to_pos(geo, ppa);
>         chunk = &line->chks[pos];
>

>         line_wp = chunk->wp;
>
> -       for (i = 1; i < lm->blk_per_line; i++) {
> +       for (i = bit + 1; i < lm->blk_per_line; i++) {

>                 rlun = &pblk->luns[i];
>                 ppa = rlun->bppa;
>                 pos = pblk_ppa_to_pos(geo, ppa);
>                 chunk = &line->chks[pos];

This code is a copy of the code above, it'd be nice to refactor it
into a helper function or just do the chunk lookups in one place.

>
> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
> +                       continue;
> +

Since we rely on the block bitmap anyway, we might as well just
iterate over the zeroes in the block bitmap using find_next_zero_bit
instead.
We do this in lots of other places, see: git grep -n
find_next_zero_bit -- drivers/lightnvm

Apart from these nitpicks, the change looks good to me. Great to have
this fixed.

>                 if (chunk->wp > line_wp)
>                         return 1;
>                 else if (chunk->wp < line_wp)
> --
> 1.9.1
>
