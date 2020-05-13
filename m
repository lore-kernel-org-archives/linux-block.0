Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2DDC2D0F6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B248B20714
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppLa+IH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgEMDOr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 23:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725967AbgEMDOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:14:46 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF3C061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 20:14:46 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v4so12151516qte.3
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q6GGJktVYmihF1QRM2ZyJaorzh5uaXfYCfx3VREzUI=;
        b=ppLa+IH+hd/26idHUGbO2DS+DcIBqIBmtTV8gVdyOdZ4UK7b60gnNx9/PWwZuOkWrC
         tWDWf/fQiWqUqWCt08LkGMRsXRdAot8qRtQ4K/0mz98OBns9IkkNKnDcXkvaDlcofpRX
         MftMYlRvDHYw1PvrnHf9rILSKFx05oZcFu26INUb6DW0UmjsblviXr3QnIqlAJNZapKW
         oDKWdTFXvTPC6OhPIdVE/WH8sqNAWsyngcMywxXs4iwZN/8h9GbM+tnOX7QZ1L6NSMSC
         TO3ogrZkrDE4CroOv7RNxhG8G1B9w8yqMspfQc5J/F8MCAY1pq1odeZOUdPbRYf9nbMB
         qZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q6GGJktVYmihF1QRM2ZyJaorzh5uaXfYCfx3VREzUI=;
        b=qvriUHlbl0m07IX18jD7MUFXFfrhtRW/w49KuuKYAVxpDMHobnJ+V6fHydFcdt4Wny
         UQrnWu+8yMdAYFVHXhRcTQsZ8OBNeM6xeLyxMGvUEOyFoPXjDGmsp76rrgwRr3t96PhH
         ZdY6UUKhsVU6VQCgpc05O4iOhLRM6cte5Ny8Ur9c3PhEb6Gs9NpfzTvVIo2aefdqvo8U
         wVz4SGof1qWmg4Ln9Pk2sk/x4sZR5VJLQX0HDZm16Ni4BMdRO7uTGhJPnyQc8yfbqrGB
         Ua2JtMKisCFYPkJ8x0M0gTR1B24RTVmBIRw1Ju/hOxoH9TPETzBGWodq+oBzA1uzyPmM
         vGIQ==
X-Gm-Message-State: AGi0PuaE1inD6k/dRtKF2sFg/DDTEvXm0NOt9O+WCdn0bdzWinm7rdk2
        3PxO51/V54ZiMdV+BdU1EMx+6YZf+323l9BeVUwPjg==
X-Google-Smtp-Source: APiQypJqtkci7zcwIrlCXl4Wm5tDBS8nkeWfDl2iZ9cby+qnd56CTBBVB392d1joYsClYQDLo2wXzu84WRtfeqJuoPY=
X-Received: by 2002:ac8:3879:: with SMTP id r54mr12266182qtb.106.1589339685770;
 Tue, 12 May 2020 20:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200513004345.GA28465@192.168.3.9> <585b0389-aa83-59b8-a155-f23621155bcd@kernel.dk>
In-Reply-To: <585b0389-aa83-59b8-a155-f23621155bcd@kernel.dk>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 13 May 2020 11:14:08 +0800
Message-ID: <CAA70yB6SLv4g+Vihnf5M24J_ibTsEh5VLZzwoXJb0GZMhp+jZg@mail.gmail.com>
Subject: Re: [PATCH] block: reset mapping if failed to update hardware queue count
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, tom.leiming@gmail.com,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 10:22 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/12/20 6:44 PM, Weiping Zhang wrote:
> > When we increase hardware queue count, blk_mq_update_queue_map will
> > reset the mapping between cpu and hardware queue base on the hardware
> > queue count(set->nr_hw_queues). The mapping cannot be reset if it
> > encounters error in blk_mq_realloc_hw_ctxs, but the fallback flow will
> > continue using it, then blk_mq_map_swqueue will touch a invalid memory,
> > because the mapping points to a wrong hctx.
> >
> > blktest block/030:
> >
> > null_blk: module loaded
> > Increasing nr_hw_queues to 8 fails, fallback to 1
> > ==================================================================
> > BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x2f2/0x830
> > Read of size 8 at addr 0000000000000128 by task nproc/8541
> >
> > CPU: 5 PID: 8541 Comm: nproc Not tainted 5.7.0-rc4-dbg+ #3
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> > Call Trace:
> > dump_stack+0xa5/0xe6
> > __kasan_report.cold+0x65/0xbb
> > kasan_report+0x45/0x60
> > check_memory_region+0x15e/0x1c0
> > __kasan_check_read+0x15/0x20
> > blk_mq_map_swqueue+0x2f2/0x830
> > __blk_mq_update_nr_hw_queues+0x3df/0x690
> > blk_mq_update_nr_hw_queues+0x32/0x50
> > nullb_device_submit_queues_store+0xde/0x160 [null_blk]
> > configfs_write_file+0x1c4/0x250 [configfs]
> > __vfs_write+0x4c/0x90
> > vfs_write+0x14b/0x2d0
> > ksys_write+0xdd/0x180
> > __x64_sys_write+0x47/0x50
> > do_syscall_64+0x6f/0x310
> > entry_SYSCALL_64_after_hwframe+0x49/0xb3
>
> Applied, thanks. Please do run blktests on your series in the future.
>
No problem, thanks a lot.
> --
> Jens Axboe
>
