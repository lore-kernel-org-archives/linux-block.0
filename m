Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9607DC433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 13:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DE6619EE
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 13:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhCYNKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhCYNKW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 09:10:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03EC06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 06:10:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b7so2831835ejv.1
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxzcvSpuW5BzO5KFJl2Jtm9u8hATZIardWi4yi/tUdw=;
        b=dhpkGEz7F7VPrF8qt11YAdUTNN38LDOuNBbwCKRx2c85T7s4WhMdIbYl94FrwIJ4/4
         xcNrf+3rO8Y2AdkQago6LnTWOk+7BYbz9kXaVU1QUL+3dK19s0KpfORr+a/TcQJz0SQk
         2laK69ap1j96hgTefznUvFGAUInNLKiCdgVVicYTwiyva5nYgqQTJoY3gr+EeqVe1nVw
         FaIvqAqf6+CzlYR5cvkR4Juf9AXHo92HOZhumHRmHVK8tu2VVOP+7CeZdzdAQzj4tkUg
         lj0MxLolDyCuuxH3vOdmAHHChDeUOoDeMrlN6udNiA33yLoq+yc/9lw7OXRTiSPjE111
         LkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxzcvSpuW5BzO5KFJl2Jtm9u8hATZIardWi4yi/tUdw=;
        b=EcZhyulBjJXZh7eixgrhsRhSwf1lReNOK6XHy0joVJvATaW/BLYcxaDGnCr2moS6Iy
         XLomPmFUja/U89ySIElg3CFSKX9OVWIFNqqIvMEZvHQ+YAEdv7pAflbybESkMRrVTQJU
         qMel4PGTV0gyngYMirPah24xVjHOxgT9gZL6aHqx6/+UpKp3x5wn0yZqw7O57BspJZf9
         8MdARSX26rN7Wkbj0FJqappR25Ha7GEb73niJIUqUkrrdrwJAyVYWGejWAWgjimu2zvq
         wGwwdBJ7vP7qnwBimYk/1CTQsNddCK50Ul7j4K7BGTuQi+C7+pflTaLWEhtqK68yLn4+
         Im/A==
X-Gm-Message-State: AOAM531T36harkcvzuxNIRgZlUnfECeY0Ne4XyB3cRsrZp18PIBXfiGc
        ScqAhCqBM/Nxw6R7QJZMDfpq2HKpsmZUQglA6QkBCQ==
X-Google-Smtp-Source: ABdhPJxmOrGZbR5jfPwo23eClqK/B4EIJuvV/F2TH8vBmojVqBN7770nnzNKZZa+b3hqNNvrrPmTHy0HqErHFzSFD2w=
X-Received: by 2002:a17:906:3409:: with SMTP id c9mr9284256ejb.314.1616677815208;
 Thu, 25 Mar 2021 06:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210325092203.10251-1-qiang.zhang@windriver.com>
In-Reply-To: <20210325092203.10251-1-qiang.zhang@windriver.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 25 Mar 2021 09:09:39 -0400
Message-ID: <CA+CK2bCS9Ab+F9gzGEJejW6J3R26j1JNBOV3tvcR6+fz2uRfpw@mail.gmail.com>
Subject: Re: [PATCH] loop: Fix use of unsafe lo->lo_mutex locks
To:     qiang.zhang@windriver.com
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Qiang,

Thank you for root causing this issue. Did you encounter this issue or
found by inspection?

I would change the title to what actually being changed, something like:

loop: call __loop_clr_fd() with lo_mutex locked to avoid autoclear race


>   ......                                       kfree(lo)
>        UAF
>
> When different tasks on two CPUs perform the above operations on the same
> lo device, UAF may occur.

Please also explain the fix:

Do not drop lo->lo_mutex before calling __loop_clr_fd(), so refcnt and
LO_FLAGS_AUTOCLEAR check in lo_release stay in sync.

>
> Fixes: 6cc8e7430801 ("loop: scale loop device by introducing per device lock")
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  drivers/block/loop.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d58d68f3c7cd..5712f1698a66 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1201,7 +1201,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>         bool partscan = false;
>         int lo_number;
>
> -       mutex_lock(&lo->lo_mutex);
>         if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
>                 err = -ENXIO;
>                 goto out_unlock;
> @@ -1257,7 +1256,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>         lo_number = lo->lo_number;
>         loop_unprepare_queue(lo);
>  out_unlock:
> -       mutex_unlock(&lo->lo_mutex);
>         if (partscan) {
>                 /*
>                  * bd_mutex has been held already in release path, so don't
> @@ -1288,12 +1286,11 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>          * protects us from all the other places trying to change the 'lo'
>          * device.
>          */
> -       mutex_lock(&lo->lo_mutex);
> +
>         lo->lo_flags = 0;
>         if (!part_shift)
>                 lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
>         lo->lo_state = Lo_unbound;
> -       mutex_unlock(&lo->lo_mutex);
>
>         /*
>          * Need not hold lo_mutex to fput backing file. Calling fput holding
> @@ -1332,9 +1329,10 @@ static int loop_clr_fd(struct loop_device *lo)
>                 return 0;
>         }
>         lo->lo_state = Lo_rundown;
> +       err = __loop_clr_fd(lo, false);
>         mutex_unlock(&lo->lo_mutex);
>
> -       return __loop_clr_fd(lo, false);
> +       return err;
>  }
>
>  static int
> @@ -1916,13 +1914,12 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>                 if (lo->lo_state != Lo_bound)
>                         goto out_unlock;
>                 lo->lo_state = Lo_rundown;
> -               mutex_unlock(&lo->lo_mutex);
>                 /*
>                  * In autoclear mode, stop the loop thread
>                  * and remove configuration after last close.
>                  */
>                 __loop_clr_fd(lo, true);
> -               return;
> +               goto out_unlock;
>         } else if (lo->lo_state == Lo_bound) {
>                 /*
>                  * Otherwise keep thread (if running) and config,
> --
> 2.17.1
>

LGTM
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
