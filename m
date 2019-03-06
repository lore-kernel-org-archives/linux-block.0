Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A5FC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7711120675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="upIV8UpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCFOVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:21:02 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35935 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCFOVC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 09:21:02 -0500
Received: by mail-ua1-f65.google.com with SMTP id e15so9001519uam.3
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 06:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7jLWqv41sW6VygRlAS2mK+BkYj//dBILLC4X6uavvp0=;
        b=upIV8UpJmglxj3fLKQWjTKfnwOA4QtKwoPsbjjYJIIgJlFHwWUxz4dQDqzQTGwDc5J
         H70wy1TNLhupbzEdyiTh0dXdZIKDgbo6eEi90o+aq4ITL5ThaWItrn8DBRVN0XhCZ/Xx
         SDswpBq3diq/tpciLrJsXxriAwmZOMwjdMJdsk1v0tdXz24U4pz6AH6Gv2UaX9NFtmjg
         VvXliPfSaDJYsWIrG1wZffTA+ULzEm7RZAoQACOY8qD7lFhUE2KHyRMKfF0GGjokxhrL
         tovUoOho+oSGBptSE1L6SBc4tZqFHEuewiX8iezgwYrg5DkKp3gQEcd+fX/igsfZDQqz
         18eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jLWqv41sW6VygRlAS2mK+BkYj//dBILLC4X6uavvp0=;
        b=ObRVN8aqpcNOvqFChTllKNYMyQ/83GKB9rHSoY2YUV6uJGvmz8VOC+8AxuMhkw3hUR
         8w0uu3FEUz3cP6DxTgCS+qQwd8iG7hf1Wc2w3MZIGD+ot/LRo1/lcBcqoXk5NSF23F1C
         +R19xirMQP6GeoXifDbXlaJxhzxRrb/TfblFl4b2U6dtxsUlVUeG7jSD0Tt8p2GTpD6d
         khsEq+DG2usjKMjJirtGEUJN5qIoTuH9uAUHtbaxCGRijrbrXRT2onT5uy/TntYW5HUz
         JvhD1p9rFspvaxDc/ESFuFzvV5IQz/RREUamIVZprV8FhRYp97GmF9RLl+b//g++W9ke
         ENHg==
X-Gm-Message-State: APjAAAXTlIikCOnh36M2AU3wFXBeIZQQ24276HKHoC5zbp/X/vmaoi+s
        +5v0z959Fg2QehBgiQ4kzyVs5m2UjafgPzeqfRUSng==
X-Google-Smtp-Source: APXvYqxy0DCq/VVmdaS7Cz0FZoW/PY/E200PzFumN1/1b9LjNqp7vMYL0kZucRdzmcR49Bsqjisu/zoMYSr+R9NqPcw=
X-Received: by 2002:ab0:e03:: with SMTP id g3mr3936481uak.68.1551882061450;
 Wed, 06 Mar 2019 06:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20190305135120.29284-1-igor.j.konopko@intel.com> <20190305135120.29284-6-igor.j.konopko@intel.com>
In-Reply-To: <20190305135120.29284-6-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 6 Mar 2019 15:20:50 +0100
Message-ID: <CANr-nt1qBVjKfxm4VuUwOkbESSr+Y0v=4KUvGHt23G+atb2rGw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] lightnvm: pblk: Cleanly fail when there is not
 enough memory
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Tue, Mar 5, 2019 at 2:54 PM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
> L2P table can be huge in many cases, since it typically requires 1GB
> of DRAM for 1TB of drive. When there is not enough memory available,
> OOM killer turns on and kills random processes, which can be very
> annoying for users.
>
> This patch changes the flag for L2P table allocation on order to handle
> this situation in more user friendly way.
>
> GFP_KERNEL and __GPF_HIGHMEM are default flags used in parameterless
> vmalloc() calls, so they are also keeped in that patch. Additionally
> __GFP_NOWARN flag is added in order to hide very long dmesg warn in
> case of the allocation failures. The most important flag introduced
> in that patch is __GFP_RETRY_MAYFAIL, which would cause allocator
> to try use free memory and if not available to drop caches, but not
> to run OOM killer.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
> ---
>  drivers/lightnvm/pblk-init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index f4b6d8f2..97b4c6e 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -164,9 +164,14 @@ static int pblk_l2p_init(struct pblk *pblk, bool fac=
tory_init)
>         int ret =3D 0;
>
>         map_size =3D pblk_trans_map_size(pblk);
> -       pblk->trans_map =3D vmalloc(map_size);
> -       if (!pblk->trans_map)
> +       pblk->trans_map =3D __vmalloc(map_size, GFP_KERNEL | __GFP_NOWARN
> +                                       | __GFP_RETRY_MAYFAIL | __GFP_HIG=
HMEM,
> +                                       PAGE_KERNEL);
> +       if (!pblk->trans_map) {
> +               pblk_err(pblk, "failed to allocate L2P (need %ld of memor=
y)\n",
> +                               map_size);
>                 return -ENOMEM;
> +       }
>
>         pblk_ppa_set_empty(&ppa);
>
> --
> 2.9.5
>
