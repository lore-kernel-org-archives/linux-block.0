Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0748C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181D820870
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PugUgMGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgLARos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 12:44:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389020AbgLARos (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 12:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606844601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZGhKypd6JdyTYRhn0b8NIkt9xhU4Eeu0l38PBqCdSE=;
        b=PugUgMGOU7VY9uuTBPoOLNKpqyVpfjXR1ctiRvEFOlC4KGwf9Fb8B/N3M9n/gdT2ZxQ1Vy
        Pc9RSHGXs42wJgJQhl1PKnMFmkqCQYY/a1VAtBE523YkGeWjW83ifXFA3qNh67TbnHYTMw
        i7WUvZifBXXEjTbLLCD5dUmzR1l2O5M=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-AOhWlmrbOw6kmg9OwB4DWw-1; Tue, 01 Dec 2020 12:43:19 -0500
X-MC-Unique: AOhWlmrbOw6kmg9OwB4DWw-1
Received: by mail-vs1-f72.google.com with SMTP id n14so635168vsm.23
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 09:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZGhKypd6JdyTYRhn0b8NIkt9xhU4Eeu0l38PBqCdSE=;
        b=BY3wr0Bxo5Y7AQq/ZnXnPZ96HmHtOQsDVzlRweD/d2BaZcCZzdyBJfb12T1ZiNjelQ
         jWi8hblJlZsyYuT/YLunv2eR4UvdtE+fthyx2Y/qIc5LHQp12lrwYZ3LbG5GQcO3q5SK
         eMryV0TShIqQk8OqGjQo8iv2/9NNKzFH8E+IuFJ2AtQF7Kdv2q9Iy7t7d6OYnVHgclDj
         uXk7XgucWiODCk3xO97SnCeJG5H7qMpksl/7RRhLVb/X7NZiPCC0kLVmbT0uqmD2h8xw
         dFKiDV/plD1eekgWHslbqFx70vFZLKAUwBjzU6svnaoP3Unj9kGF54k+88VCIHcg6pBx
         FRLQ==
X-Gm-Message-State: AOAM531GpcLJM7OzMBRJEF0GyoNUFm7j8yESsP05owrbKhgs6PKpXr+8
        Rm0OyBFAXIt0bNkGFpciIdrtzM1o4RylAwZLTbEetpZ4CAtzlJmIYIqm7ANYBXz61iPXuqveStw
        ypBfBAB8lkisv2iFfzvejJak9zeIiV0DtPzJ8h2Y=
X-Received: by 2002:a1f:1d50:: with SMTP id d77mr3576791vkd.18.1606844598892;
        Tue, 01 Dec 2020 09:43:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnkpGmhM9X2tcCMDc+Bsf0RYjwAyyMjh73nNDrRnmtU3BRg77ZC6gtKZdSWoW2mS780qIV2q6VRprf71ohd4g=
X-Received: by 2002:a1f:1d50:: with SMTP id d77mr3576751vkd.18.1606844598652;
 Tue, 01 Dec 2020 09:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20201130171805.77712-1-snitzer@redhat.com> <20201201160709.31748-1-snitzer@redhat.com>
In-Reply-To: <20201201160709.31748-1-snitzer@redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Tue, 1 Dec 2020 12:43:07 -0500
Message-ID: <CAMeeMh-dt91dJuwt+EpXPYbR-7Kfr6otBH+C7tBMqEF4toxS8w@mail.gmail.com>
Subject: Re: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Bruce Johnston <bjohnsto@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 1, 2020 at 11:07 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
> chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
> reflect the most limited of all devices in the IO stack.
>
> Otherwise malformed IO may result. E.g.: prior to this fix,
> ->chunk_sectors = lcm_not_zero(8, 128) would result in
> blk_max_size_offset() splitting IO at 128 sectors rather than the
> required more restrictive 8 sectors.
>
> And since commit 07d098e6bbad ("block: allow 'chunk_sectors' to be
> non-power-of-2") care must be taken to properly stack chunk_sectors to
> be compatible with the possibility that a non-power-of-2 chunk_sectors
> may be stacked. This is why gcd() is used instead of reverting back
> to using min_not_zero().
>
> Fixes: 22ada802ede8 ("block: use lcm_not_zero() when stacking chunk_sectors")
> Fixes: 07d098e6bbad ("block: allow 'chunk_sectors' to be non-power-of-2")
> Cc: stable@vger.kernel.org
> Reported-by: John Dorminy <jdorminy@redhat.com>
> Reported-by: Bruce Johnston <bjohnsto@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  block/blk-settings.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> v2: use gcd(), instead of min_not_zero(), as suggested by John Dorminy
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 9741d1d83e98..659cdb8a07fe 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>
>         t->io_min = max(t->io_min, b->io_min);
>         t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> -       t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
> +
> +       /* Set non-power-of-2 compatible chunk_sectors boundary */
> +       if (b->chunk_sectors)
> +               t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
>
>         /* Physical block size a multiple of the logical block size? */
>         if (t->physical_block_size & (t->logical_block_size - 1)) {
> --
> 2.15.0
>

Reviewed-by: John Dorminy <jdorminy@redhat.com>

Thanks!

