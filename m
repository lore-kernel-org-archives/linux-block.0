Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D9BC63777
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 20:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AD22073C
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 20:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3P9ANJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgK3Uxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgK3Uxd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 15:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606769526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+b2Pp0coGV9j/d9ySwXiIZFcFYYUG+hnak08L/oevVY=;
        b=K3P9ANJQRuv9b4LkAXrjQ7mesyhUIS8A11XTQVeHmU47B75ZITDQMvDhSGL+9EPHVVGRrW
        EyhkwOhl19F2jRGF7pAahZpSJ3/Zfz0oj673INN+bFhd9Xu5p4MVqxxRGcLGpBB5M/yitM
        1olifTtHXD4M8fOnlrmxxaFKyBdiPHw=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-4Wt6wcLTMt-85y5BJMnkGw-1; Mon, 30 Nov 2020 15:52:03 -0500
X-MC-Unique: 4Wt6wcLTMt-85y5BJMnkGw-1
Received: by mail-vk1-f198.google.com with SMTP id r192so4471047vkf.21
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 12:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+b2Pp0coGV9j/d9ySwXiIZFcFYYUG+hnak08L/oevVY=;
        b=jxy9Io+8L6/mSuU1J3jqoeiivDUJYSD2mUxFXESZn+jR+jQvbA3QP9D2RZwE91Hiro
         8Ezw+LV/gYW1tJPr5/780TGtLnV3fKjFchWK70ubiCVf+Rw0szzCkhsTBDbeAq7Ewxzf
         OnwEha79CvugbFUHFa5zmoGkuyYdhcZd+p6DZH8UzzYqKF2FXuKWvaML5tkkznWmwbQ/
         xFOIKvrQPMZ/SiRtnK7jhluv0I7Sam5YBd3yXFVXkzBbx0KroCg4yVOflZHsjTd7X7fv
         SbMCxCGEUs8SDINxF0gz5rz/N2QK2wgH9rN2Yd6rJWCDT0BEs61ZLJccqwZK5dQ7agvl
         D87A==
X-Gm-Message-State: AOAM530ZlGBaJ1G4ITpDvO/9Ttgx4ZDvydgABKopgbBsqAFl0s5STtWe
        eUY2FVJLON3BuXty+qq0En7b8Gkg776Jl0rLL9KJAznROWhN7NuOADjbC9MVkOwkMBlY0OjEtVZ
        ZDpeIeH80V+UlU/gO81w3Tju8FGYv3zdrZcuNvAY=
X-Received: by 2002:ab0:74d1:: with SMTP id f17mr17280796uaq.30.1606769521906;
        Mon, 30 Nov 2020 12:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzubma8STl3HCa0vJRhZbqsCE0aoJSMnrUX0e2pI7+Gruh20CEhyGGJL2n7aZ3aL+d5VLu/RCaAHOpASP6gnDQ=
X-Received: by 2002:ab0:74d1:: with SMTP id f17mr17280758uaq.30.1606769521581;
 Mon, 30 Nov 2020 12:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20201130171805.77712-1-snitzer@redhat.com>
In-Reply-To: <20201130171805.77712-1-snitzer@redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Mon, 30 Nov 2020 15:51:50 -0500
Message-ID: <CAMeeMh8fb2JEBmuSuTP8ys6Xr+GpFqcUr5Py73W4wCQb1MCuAw@mail.gmail.com>
Subject: Re: [PATCH] block: revert to using min_not_zero() when stacking chunk_sectors
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Bruce Johnston <bjohnsto@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I don't think this suffices, as it allows IOs that span max(a,b) chunk
boundaries.

Chunk sectors is defined as "if set, it will prevent merging across
chunk boundaries". Pulling the example from the last change:
It is possible, albeit more unlikely, for a block device to have a non
power-of-2 for chunk_sectors (e.g. 10+2 RAID6 with 128K chunk_sectors,
which results in a full-stripe size of 1280K. This causes the RAID6's
io_opt to be advertised as 1280K, and a stacked device _could_ then be
made to use a blocksize, aka chunk_sectors, that matches non power-of-2
io_opt of underlying RAID6 -- resulting in stacked device's
chunk_sectors being a non power-of-2).

Suppose the stacked device had a block size/chunk_sectors of 256k.
Then, with this change, some IOs issued by the stacked device to the
RAID beneath could span 1280k sector boundaries, and require further
splitting still. I think combining as the GCD is better, since any IO
of size gcd(a,b) definitely spans neither a a-chunk nor a b-chunk
boundary.

But it's possible I'm misunderstanding the purpose of chunk_sectors,
or there should be a check that the one of the two devices' chunk
sizes divides the other.

Thanks.

-John

On Mon, Nov 30, 2020 at 12:18 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> chunk_sectors must reflect the most limited of all devices in the IO
> stack.
>
> Otherwise malformed IO may result. E.g.: prior to this fix,
> ->chunk_sectors = lcm_not_zero(8, 128) would result in
> blk_max_size_offset() splitting IO at 128 sectors rather than the
> required more restrictive 8 sectors.
>
> Fixes: 22ada802ede8 ("block: use lcm_not_zero() when stacking chunk_sectors")
> Cc: stable@vger.kernel.org
> Reported-by: John Dorminy <jdorminy@redhat.com>
> Reported-by: Bruce Johnston <bjohnsto@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  block/blk-settings.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 9741d1d83e98..1d9decd4646e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>
>         t->io_min = max(t->io_min, b->io_min);
>         t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> -       t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
> +
> +       if (b->chunk_sectors)
> +               t->chunk_sectors = min_not_zero(t->chunk_sectors,
> +                                               b->chunk_sectors);
>
>         /* Physical block size a multiple of the logical block size? */
>         if (t->physical_block_size & (t->logical_block_size - 1)) {
> --
> 2.15.0
>

