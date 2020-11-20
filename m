Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6351C388F9
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6740822255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCh7ag1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKTB1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:27:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgKTB1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605835667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYquISkn3nZV5YB0okA6VfbOmAn2onUZzzDzkWZvjkE=;
        b=FCh7ag1kd2NMfAcWb5f7QaH822S8ODzpXzrUK4nSsXbRvb9aN68S35eTkJtUrnJux1uclF
        Z3489P2hzL+m1bApTKcGQXnq7uVLadub9KJBvimCelGKmXLyrKHnMX3z6dhYW03ZTntnac
        5JFvKnKCexBzP/wHcNrM0MeCaDT0zmo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-uAJpxo4LPj6entF9S0el4Q-1; Thu, 19 Nov 2020 20:27:43 -0500
X-MC-Unique: uAJpxo4LPj6entF9S0el4Q-1
Received: by mail-vk1-f197.google.com with SMTP id w63so3388567vka.3
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 17:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYquISkn3nZV5YB0okA6VfbOmAn2onUZzzDzkWZvjkE=;
        b=nkFxJL6SImvhSEfLSpCgGYmfoynEKqx4q50VpcKP40D5feB8MIX5pYeiRPTDOTGvXa
         fKL/JJPgF97vSGxpOKTsXxe8UkQQ3ueLwBD3sJIwdMKzhsWYgScZMHe0qek82ubhnWj0
         SAZmPlrTvYJ/LTI0gRMuopZ8ULmNPHzJfv+9uMzrR7+nwEgKDkfD5ktHXZFIcyACNbHf
         e+D172WnElZMjhOU9qi3rROXoO2Hm930ka/1gkmHgJBcNyXHlaGghAzdogHg94mX/aOU
         LjmOQCncpjsrY5dxnZNE8XOcpr1ADZB80FP4XWARyO8aGr+RADdqc+nPjBJ/q0Nroo8d
         fxJw==
X-Gm-Message-State: AOAM5338I7OIGNT9vU2sxJ668qyh5NEpfxrz+BCAWxgaasc4gqRR/F/c
        Bh1+q9YlcqiY7Y8BXxw3NL1sMScVxg3VUy2KII1fsKooNZiPpnSxunTeOvuJT4zlJQgYwF7KF7e
        HJx/MABAEeoXI+eVpKUlm5LUWS9qXquH5HU/MFyI=
X-Received: by 2002:ab0:224b:: with SMTP id z11mr13378388uan.103.1605835663207;
        Thu, 19 Nov 2020 17:27:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzE8trd4VpMwa8E8M6LiMEVo96dOkpqmDZ8DGxXQs4TM+71O6XXrABn/oUZi7Sf+whezhrwuz2dhE2fWIxvft0=
X-Received: by 2002:ab0:224b:: with SMTP id z11mr13378372uan.103.1605835663000;
 Thu, 19 Nov 2020 17:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118203127.GA30066@redhat.com> <20201118203408.GB30066@redhat.com>
 <fc7c4efd-0bb3-f023-19c6-54359d279ca8@redhat.com> <alpine.LRH.2.02.2011190810001.32672@file01.intranet.prod.int.rdu2.redhat.com>
 <20201119172807.GC1879@redhat.com> <alpine.LRH.2.02.2011191337180.588@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2011191517360.10231@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2011191517360.10231@file01.intranet.prod.int.rdu2.redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 19 Nov 2020 20:27:32 -0500
Message-ID: <CAMeeMh8uaZkOHGUsvfaM7Fyqov5wKNfCp_FfBy7S39EG3Ktc7w@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH] blk-settings: make sure that max_sectors is
 aligned on "logical_block_size" boundary.
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     David Teigland <teigland@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Marian Csontos <mcsontos@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greetings;

Might I suggest using SECTOR_SIZE instead of 512? Or, perhaps, >>
SECTOR_SHIFT instead of / 512.

I don't understand the three conditionals. I believe max_sectors is
supposed to be <= min(max_dev_sectors, max_hw_sectors), but I don't
understand why max_sectors being small should adjust max_hw_sectors
and max_dev_sectors. Are the conditions perhaps supposed to be
different, adjusting each max_*sectors up to at least PAGE_SIZE /
SECTOR_SIZE? Perhaps, like e.g. blk_queue_max_hw_sectors(), the
conditionals should log if they are adjusting max_*sectors up to the
minimum.

Thanks!

John Dorminy

On Thu, Nov 19, 2020 at 3:37 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> We get these I/O errors when we run md-raid1 on the top of dm-integrity on
> the top of ramdisk:
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8048, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8147, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8246, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8345, 0xbb
>
> The ramdisk device has logical_block_size 512 and max_sectors 255. The
> dm-integrity device uses logical_block_size 4096 and it doesn't affect the
> "max_sectors" value - thus, it inherits 255 from the ramdisk. So, we have
> a device with max_sectors not aligned on logical_block_size.
>
> The md-raid device sees that the underlying leg has max_sectors 255 and it
> will split the bios on 255-sector boundary, making the bios unaligned on
> logical_block_size.
>
> In order to fix the bug, we round down max_sectors to logical_block_size.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>
> ---
>  block/blk-settings.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> Index: linux-2.6/block/blk-settings.c
> ===================================================================
> --- linux-2.6.orig/block/blk-settings.c 2020-10-29 12:20:46.000000000 +0100
> +++ linux-2.6/block/blk-settings.c      2020-11-19 21:20:18.000000000 +0100
> @@ -591,6 +591,16 @@ int blk_stack_limits(struct queue_limits
>                 ret = -1;
>         }
>
> +       t->max_sectors = round_down(t->max_sectors, t->logical_block_size / 512);
> +       if (t->max_sectors < PAGE_SIZE / 512)
> +               t->max_sectors = PAGE_SIZE / 512;
> +       t->max_hw_sectors = round_down(t->max_hw_sectors, t->logical_block_size / 512);
> +       if (t->max_sectors < PAGE_SIZE / 512)
> +               t->max_hw_sectors = PAGE_SIZE / 512;
> +       t->max_dev_sectors = round_down(t->max_dev_sectors, t->logical_block_size / 512);
> +       if (t->max_sectors < PAGE_SIZE / 512)
> +               t->max_dev_sectors = PAGE_SIZE / 512;
> +
>         /* Discard alignment and granularity */
>         if (b->discard_granularity) {
>                 alignment = queue_limit_discard_alignment(b, start);
>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
>

