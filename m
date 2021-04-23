Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC6C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A703261468
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhDWVze (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhDWVze (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 17:55:34 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E80C061574
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 14:54:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a25so43925322ljm.11
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FG9jm8Vl8hDDPcDZaNQFgKm8YQhw26g/ixs7PbJyNJk=;
        b=gO+/GbqR9swcdR9BqChbdUglNpk4p7AZ6x83FZHTliRKgXwVNzZIqeRb+OJC0h3VIz
         H4aGtBWrWUst0YMjs6qdfoxtf3l6MI1ZQRy/3Cf8QefbyjG2E5WE+IzbFKAR1oYdvIQl
         8ObEkfQhHexViaez1BK3O2agQ1S5aKi82dSBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FG9jm8Vl8hDDPcDZaNQFgKm8YQhw26g/ixs7PbJyNJk=;
        b=XllCrYlSXqNBcJlVz6GlYswy3PAmtWipfa4b+WJDz/6CdjvZQVXLitqLsvk5pmKJX+
         TxE0o+difJVax7/+yAqA/W3lkOTc+XtxuARGYqRXTevthxUL7F+cmfB6+30ad8OJp3yD
         ieUiECHGuE3Pi15vVMuB/SUsB1K8usEIz9PnDZTh4JEWYAFNF3jEb7Xs3bAjcA888wzR
         FFZ/uaGILFxMLCOSuvEgNSjwCnUQnwJ17WPaS4WEhCHac7ETdiMa+xLKl17NDIpe8KoM
         hao+ZDcCAKS4zosqSfxTCcfzNrolGgs1aapacRnIIjDiT5AFwniavUAjDoCgM9Imbh7/
         Lrcw==
X-Gm-Message-State: AOAM532I9/pQodNmc9Zk5viTwTnrPSYBM6urJL+KPm5kdHWBThgscjKg
        DOuyLTc1JOrd4zAqBCWEqYi0nV5uFzsSgaJe
X-Google-Smtp-Source: ABdhPJwzpFy9VpL1T9eSKTdWT4dQpHOHzFbP+yEEnLM7xsJwrByaDsmY2alJV4aU1G0rdOYSQU4aig==
X-Received: by 2002:a2e:3611:: with SMTP id d17mr4029584lja.392.1619214893305;
        Fri, 23 Apr 2021 14:54:53 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l12sm652170lji.122.2021.04.23.14.54.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 14:54:52 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 12so79335246lfq.13
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 14:54:52 -0700 (PDT)
X-Received: by 2002:a19:f018:: with SMTP id p24mr3967617lfc.421.1619214892612;
 Fri, 23 Apr 2021 14:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk>
In-Reply-To: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Apr 2021 14:54:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5otGvBvWGx-XC=es88Xghe1TNFEYg_ZwoiZBzRvGeRA@mail.gmail.com>
Message-ID: <CAHk-=wi5otGvBvWGx-XC=es88Xghe1TNFEYg_ZwoiZBzRvGeRA@mail.gmail.com>
Subject: Re: [GIT PULL] Block fix for 5.12 final
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 2:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> A single fix for a behavioral regression in this series, when re-reading
> the partition table with partitions open.

Hmm. The fact that it's no longer calling blk_drop_partitions() didn't
just mean that the check for "bdev->bd_part_count" was lost (now
re-instated).

It also seems to mean that blkdev_reread_part() no longer does the

        sync_blockdev(bdev);
        invalidate_bdev(bdev);

to write back and invalidate any caches.

Are we sure cache writeback/invalidate isn't needed? Or does it get
done some other place?

            Linus
