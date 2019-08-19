Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35DC3A59B
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6F0205F4
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 09:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="UWaHk5oE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfHSJGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:06:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46625 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfHSJGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 05:06:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id f9so1013217ljc.13
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=go6Fia+2oUYQIymod2azs8D08VfJ/HmbYRyQmFxd89A=;
        b=UWaHk5oEerHfLKS2cmpeDCb3YNnTl9A8bKmqgSH7efWz9q53FNMXuzRnaeKO+ydNdw
         wo8FWZXd9/UFnUKOg2uDtbJkvdqzqPfr4Kz+AUk3Nwno3GaWfpNOLpgZdzCPoOHC3FPF
         +268WiGdzDOGSb14MjnwrlZ/vziwSQU3B4vxMXWaIUZF4cTw7a36iyLusBHI9EnlCSup
         t8P+iT0HhgGWvE/vj/X+2d9hR82TDvjtbvNBlOtgyCbMkGFLW3T0ruzP+mhs7qY77wjP
         QhAKuuo9kMCP8alNtVj34LY7HEAVt/s0aD8cQHwVTNsey8jme1viz8Wvs8+Irj0Tp6nG
         xXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=go6Fia+2oUYQIymod2azs8D08VfJ/HmbYRyQmFxd89A=;
        b=M74Q8x/AKNRnpWst5h55RLw/KrAUOTZQpgnz8LhgUuaIHObYFahEWiRjOmxf3giWU0
         lohlDejmjqZuIT/aJjkERngNsb4KqVgXcIbQDsgVSvFFs1nvtBPoGrZVyWk4a7b/1SAE
         +77kRqGXK7QBgRi67zQZXznlfkg/0GmsKtMT9kF1xHlimIA4WAIi1o+CcQsh2sQYZ8Ur
         u4ixqybxewl1P3Dr328rp95JiwAeZwNtYEIE7DDH2CzokF99TOZu0BsXNOsa2XB6pi27
         7h35iHjDNNhWOFYlNpj8BuqMfsTOzTRJ4zryA9icPrVWHtGift6YsLFLVkRSqU8bDQQB
         vtWQ==
X-Gm-Message-State: APjAAAXZf5dNEAqqBuNH11d/WKnFECbXn5PNZXJ8/3znrOFBAR2/CiLN
        ++z6wFvhlERVV3ufMfcYCXK/BvAEaDoAZKTHakT5iQ==
X-Google-Smtp-Source: APXvYqzHfH2e05Zqc2osyVo+KtOEUYoxk9EXt9fxGHWlfCkmBrUFmllOuebgrzndF2yz2wS2Q08N4RmmSgUM3w+pa/c=
X-Received: by 2002:a2e:9903:: with SMTP id v3mr10537275lji.37.1566205589781;
 Mon, 19 Aug 2019 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
In-Reply-To: <20190814113348.GA525@ming.t460p>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 19 Aug 2019 11:06:18 +0200
Message-ID: <CAB0TPYFzgm7pJvXfYYER6qqHM3J8dU7WXWv8ct51e2CGctydzw@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
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

I was thinking about this more; our current sequence is:

1) LOOP_SET_FD
2) LOOP_SET_STATUS64 // for lo_offset/lo_sizelimit
3) LOOP_SET_BLOCK_SIZE // to make sure block size is correct for DIO
4) LOOP_SET_DIRECT_IO // to enable DIO

I noticed that LOOP_SET_FD already tries to configure DIO if the
underlying file is opened with O_DIRECT; but in this case, it will
still fail, because the logical block size of the loop queue must
exceed the logical I/O size of the backing device. But the default
logical block size of mq is 512.

One idea to fix is to call blk_queue_logical_block_size() as part of
LOOP_SET_FD, to match the block size of the backing fs in case the
backing file is opened with O_DIRECT; you could argue that if the
backing file is opened with O_DIRECT, this is what the user wanted
anyway. This would allow us to get rid of the latter two ioctl's and
already save quite some time.

Thanks,
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
