Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC3C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 21:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D38619F9
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 21:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhCZVmA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCZVlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 17:41:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085ECC0613AA
        for <linux-block@vger.kernel.org>; Fri, 26 Mar 2021 14:41:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so10496346ejj.7
        for <linux-block@vger.kernel.org>; Fri, 26 Mar 2021 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WV7WEOwlzxCsF73+pI7k12EgmOoMiHqyTVgC0XnzDUM=;
        b=ecstEGFfBqs91yppIM+HaNt8s4h4q+ZO5S3+/XFI0UuJvwNLMSWwuUOprfEF59aLlz
         u4SK3abvmWXSsdyDHCJHy36n6byqXsYuAP9VeejcjjK61FDk+mMMliL++TtAovpAGpZy
         HjEiN2eXkaYItfs7tHfWO9/2HKHmvRjoLWk331UbJ8sRL8r0WamBXwFrBgD4IVua7UlE
         rgBhFq+nP2tGK55C/wl0iSHQ0MA2tTRurDaII6kXXOuAgNC3fQ23ch72261RT3GVuJ4y
         TSZTNni+7G/lGONUh2Z1fxFKJolQilZOCkA4hLZh0zvLUUXUShkpRK47nevseIX6qo6M
         dfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WV7WEOwlzxCsF73+pI7k12EgmOoMiHqyTVgC0XnzDUM=;
        b=JWlBlRSWfCndtuls1Eebo46Xzy+aDCrguu0V8XrNfOc2eUYZ4sq0Pl00hnKDSRFffX
         kBVU0MuxuuBXKzpQxeLTqLpIzFo72GqrXab6SsSV4nBSn/l0UtKcBZNWE+eTHBDTNXXR
         +dmQ24GF4LysuwAJmkCGE7vliy8m43qfQdX5P50i6AKcVxz/ZvkDCt6IpsUiB1ATFCXv
         P7mAyKtb1qiEgHyTzXGVdtU8YMGvj3QnNoljR+8uggtabnjmqcTRaAdQkxsuT3rdqHLb
         4awk7xkH2nmQS1mOMCT9MClSNABK9Tdo7u0MlQWJdE3yKL1jv0/konB1+cPg01THflnw
         ncwg==
X-Gm-Message-State: AOAM5328VvuMi5gSwEg3jQ/DFHDhF2FT+8Z7up+aFuDK6YYJli+Hg7B2
        g90FtV6Jh8n5agcivL/e7ZDTeuzM2fMQs2fU0zEPBQ==
X-Google-Smtp-Source: ABdhPJwyo7W0HT2r9p3wOC9IW5hOPQv6e730/N1Nx6z6ALymJ15Nwl83Xd++RfcdTLtckA4tUKqBYytDRnWmAgKLg0E=
X-Received: by 2002:a17:906:3c50:: with SMTP id i16mr17752791ejg.175.1616794897749;
 Fri, 26 Mar 2021 14:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210326090057.30499-1-qiang.zhang@windriver.com>
In-Reply-To: <20210326090057.30499-1-qiang.zhang@windriver.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 26 Mar 2021 17:41:01 -0400
Message-ID: <CA+CK2bADeLiFChUxx6jvUe7rb_hNZ_oz_1cFmLwqPCmhgxOTYA@mail.gmail.com>
Subject: Re: [PATCH v2] loop: call __loop_clr_fd() with lo_mutex locked to
 avoid autoclear race
To:     qiang.zhang@windriver.com
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 26, 2021 at 5:00 AM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> lo->lo_refcnt = 0
>
>             CPU0                                 CPU1
> lo_open()                                    lo_open()
>  mutex_lock(&lo->lo_mutex)
>  atomic_inc(&lo->lo_refcnt)
>  lo_refcnt == 1
>  mutex_unlock(&lo->lo_mutex)
>                                              mutex_lock(&lo->lo_mutex)
>                                              atomic_inc(&lo->lo_refcnt)
>                                              lo_refcnt == 2
>                                              mutex_unlock(&lo->lo_mutex)
> loop_clr_fd()
>  mutex_lock(&lo->lo_mutex)
>  atomic_read(&lo->lo_refcnt) > 1
>  lo->lo_flags |= LO_FLAGS_AUTOCLEAR        lo_release()
>  mutex_unlock(&lo->lo_mutex)
>  return                                      mutex_lock(&lo->lo_mutex)
>                                            atomic_dec_return(&lo->lo_refcnt)
>                                              lo_refcnt == 1
>                                              mutex_unlock(&lo->lo_mutex)
>                                              return
>
> lo_release()
>  mutex_lock(&lo->lo_mutex)
>  atomic_dec_return(&lo->lo_refcnt)
>  lo_refcnt == 0
>  lo->lo_flags & LO_FLAGS_AUTOCLEAR
>   == true
>  mutex_unlock(&lo->lo_mutex)              loop_control_ioctl()
>                                            case LOOP_CTL_REMOVE:
>                                             mutex_lock(&lo->lo_mutex)
>                                             atomic_read(&lo->lo_refcnt)==0
>   __loop_clr_fd(lo, true)                   mutex_unlock(&lo->lo_mutex)
>     mutex_lock(&lo->lo_mutex)                loop_remove(lo)
>                                                mutex_destroy(&lo->lo_mutex)
>   ......                                       kfree(lo)
>        data race
>
> When different tasks on two CPUs perform the above operations on the same
> lo device, data race may be occur, Do not drop lo->lo_mutex before calling
>  __loop_clr_fd(), so refcnt and LO_FLAGS_AUTOCLEAR check in lo_release
> stay in sync.

There is a race with autoclear logic where use after free may occur as
shown in the above scenario. Do not drop lo->lo_mutex before calling
__loop_clr_fd(), so refcnt and LO_FLAGS_AUTOCLEAR check in lo_release
stay in sync.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

>
> Fixes: 6cc8e7430801 ("loop: scale loop device by introducing per device lock")
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  v1->v2:
>  Modify the title and commit message.
>
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
