Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DDC433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDD9206C2
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 11:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="jbPsuqGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHNLii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:38:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34944 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNLih (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 07:38:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so79041151lfa.2
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2019 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tl4lHPgUKyjZ4PA5frXihhV1cgSueNxdkLcdZsBaY4I=;
        b=jbPsuqGC/o2ZqbZIV5mCeR3UJ7x6ztoAqdeOaM7bCjV7XeQ2b2f5KSNZRWcy5T2J1F
         nhf36FHFqaSyVDvmlGFM3VfNnoGwd6y14WLITLKeO607r5sFOoZY2t9WNLsEX++muVKG
         FvIB2nYIXiTZ5DBylglUMRIypMmbVkAjleOlU8tGJpKD1PYbLOZVNMVnixtiI4DAP3lz
         jikVx7bcSI8WeTCcfEHqLoa2EwRwtE4bIj/HjAWX9k0U78xbi4AlhNCTfiIwbTD3WmDU
         j78kMNCxdbgOggwf8Z5c3Ckm88BxzvbfnG516bYC+LKJru+dvuDZcGYad6olsS+OaK6h
         G7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl4lHPgUKyjZ4PA5frXihhV1cgSueNxdkLcdZsBaY4I=;
        b=H/dBLr0mN9VmYEJW5bis8+/asCexOUlqV7TtVCoAQeZFZOi5GYJO4xBgHJm5oAle2u
         Pcwz6WHhMMZepJ1snqP4soQQPOXlSBCNv8/I4LFEV1v5HrCa7ptUX9QMJyZQPU81xFU+
         sEf608Ro/2tTpxplhMgmDa0yGb+BAQ1b8v7Mqr9mzIOJS5bzrKQWw/6tuVJ6QbAhU62I
         30L6OguTuX/RvR4uGqsKIOUavZav1ahEb/EQk2dj677dd5nQcRU97GeOh+iQwURsgmjU
         YgDvKBD9/l4qboSgG4ewsfSRTlEAS9cm/XoFN/CzxniiYQLZ/rkaK6/Lw9ce4zlX6OUR
         PQbw==
X-Gm-Message-State: APjAAAUiuX+F3jYzliCcIE6mTupbZf5RT436atFXzuT4DCUYZnYedrP7
        P1LdXYOddDBvgJyevxrmY4vgYnez+7oEpF2FLzYYXA==
X-Google-Smtp-Source: APXvYqwdp0z7dISVyQdXlhFPeViRhkBkT7bHEq6kyIgkUCGOt5rMfFVE/QcTv/yI+SBrUgZYYqu3wwbwFOkJT3h5PoY=
X-Received: by 2002:ac2:4ac4:: with SMTP id m4mr24826096lfp.172.1565782716019;
 Wed, 14 Aug 2019 04:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
In-Reply-To: <20190814113348.GA525@ming.t460p>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 14 Aug 2019 13:38:25 +0200
Message-ID: <CAB0TPYHdaOTUKf5ix-oU7cXsV12ZW6YDYBsG+VKr6zk=RCW2NA@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 14, 2019 at 1:34 PM Ming Lei <ming.lei@redhat.com> wrote:
> Another candidate is to not switch to q_usage_counter's percpu mode
> until loop becomes Lo_bound, and this way may be more clean.

Thanks! I had considered this too, but thought it a bit risky to mess
with the init flag from the loop driver. Maybe we could delay
switching q_usage_counter to per-cpu mode in the block layer in
general, until the first request comes in?

This would also address our issues, and potentially be an even smaller change.

Martijn
>
> Something like the following patch:
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a7461f482467..8791f9242583 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1015,6 +1015,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>          */
>         bdgrab(bdev);
>         mutex_unlock(&loop_ctl_mutex);
> +
> +       percpu_ref_switch_to_percpu(&lo->lo_queue->q_usage_counter);
> +
>         if (partscan)
>                 loop_reread_partitions(lo, bdev);
>         if (claimed_bdev)
> @@ -1171,6 +1174,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>         lo->lo_state = Lo_unbound;
>         mutex_unlock(&loop_ctl_mutex);
>
> +       percpu_ref_switch_to_atomic(&lo->lo_queue->q_usage_counter, NULL);
> +
>         /*
>          * Need not hold loop_ctl_mutex to fput backing file.
>          * Calling fput holding loop_ctl_mutex triggers a circular
> @@ -2003,6 +2008,12 @@ static int loop_add(struct loop_device **l, int i)
>         }
>         lo->lo_queue->queuedata = lo;
>
> +       /*
> +        * cheat block layer for not switching to q_usage_counter's
> +        * percpu mode before loop becomes Lo_bound
> +        */
> +       blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, lo->lo_queue);
> +
>         blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
>
>         /*
>
>
> thanks,
> Ming
