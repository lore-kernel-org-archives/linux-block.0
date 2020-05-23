Return-Path: <SRS0=SpOq=7F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6E2C433DF
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B4A2073B
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 07:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L14BLNKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgEWHqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 May 2020 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgEWHqX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 May 2020 03:46:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C6C061A0E
        for <linux-block@vger.kernel.org>; Sat, 23 May 2020 00:46:22 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x22so7818299lfd.4
        for <linux-block@vger.kernel.org>; Sat, 23 May 2020 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrivRHaV0EYW9yCB4SkPi2X/Wga8CUn0A9+dhuceNIY=;
        b=L14BLNKIpakDUIX3xE/egAKjU0I12UkuqxAoGoR35CSCKrkfugNy+AHdwYoIAGpfKj
         RUqVtaGqeBAdwadS9f7/zW8PS6czYvCSt/k9qAkhxtmVK08W2Rsm/DO3SCxaUr9tvUiD
         kwzdEH8ZVl4TlMUZ5hirdUOoJrvXpTtDrT3JkVVwTD2k+3Bk5lPkva7+CkHlz9WSbq3Z
         rbpUqFBt4Mo6NxQJ7vOrZQOvNrnLjqevHXbun9Gay0h1WWsvXUKTnK5Yd7uQ0b7/IvI9
         12lVx8/bOLqM98XgkGkeo1ZSlp5TWPW2IlnAyHe8W2dEn0o867QuJOmIUBkTxOtRRZEp
         qyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrivRHaV0EYW9yCB4SkPi2X/Wga8CUn0A9+dhuceNIY=;
        b=njup5+8z3w90l5TtmYhrkj7W03woz+Ogg5NdzVXy6UyY+9MtfQ45e4/WKWiETpVDjZ
         Wn6jh5jeKB2CHEPSu6uByYnwJbJalhTLnJXgbtj3ZelonBavmJJAQkUgrVQpyRWYVOMb
         3W4UnzUnOr5nb+WxuqNxH4iMny+k3XdK0yrHHRyXxlF1eYm6d4bcepUKNm/kRNkJvQfR
         Fi0KHv+MvZM2GMYOQIVKQ/SNbXc2JXomN5DzTCXYBAiIOaffiW8qWZ4161CKWVX7Sdyg
         sJWGkAziHrW4wDMhvxKP5iFjz+e9HGtjoeDKCicBbfrBdTRZ1k2mz/wN8mC3NyOn1yz0
         Iurw==
X-Gm-Message-State: AOAM531NOoJH/Tn8gP9EhBg2i3O/A5PqvRI6icmRzNhU/7lPG3v2M8ey
        jBrBqxhrVlgMmqBFcSmgnZh/oQTGuGXFZx3O7VOxs6DK
X-Google-Smtp-Source: ABdhPJzmxPg2qFVR9zsNqWI9D0KnTDQHcHX2xd0tOEdsa5CTLFAVIi4y8esScXNtLtQJ+YeJ9rYMxQAt8nBXn52DeAQ=
X-Received: by 2002:a19:6a10:: with SMTP id u16mr9421774lfu.105.1590219981201;
 Sat, 23 May 2020 00:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200513095443.2038859-1-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-1-ming.lei@redhat.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sat, 23 May 2020 15:45:55 +0800
Message-ID: <CADBw62o9eTQDJ9RvNgEqSpXmg6Xcq=2TxH0Hfxhp29uF2W=TXA@mail.gmail.com>
Subject: Re: [PATCH 0/9] blk-mq: support batching dispatch from scheduler
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Wed, May 13, 2020 at 5:55 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hi Guys,
>
> More and more drivers want to get batching requests queued from
> block layer, such as mmc[1], and tcp based storage drivers[2]. Also
> current in-tree users have virtio-scsi, virtio-blk and nvme.
>
> For none, we already support batching dispatch.
>
> But for io scheduler, every time we just take one request from scheduler
> and pass the single request to blk_mq_dispatch_rq_list(). This way makes
> batching dispatch not possible when io scheduler is applied. One reason
> is that we don't want to hurt sequential IO performance, becasue IO
> merge chance is reduced if more requests are dequeued from scheduler
> queue.
>
> Tries to start the support by dequeuing more requests from scheduler
> if budget is enough and device isn't busy.
>
> Simple fio test over virtio-scsi shows IO can get improved by 5~10%.
>
> Patches can be found from the following tree too:
>
>         https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-batching-submission
>
> Patch 1 ~ 7 are improvement and cleanup, which can't applied without
> supporting batching dispatch.
>
> Patch 8 ~ 9 starts to support batching dispatch from scheduler.

Sorry for late reply. I've tested your patch set and got some better
performance. Thanks.
Tested-by: Baolin Wang <baolin.wang7@gmail.com>

> Please review and comment!
>
>
> [1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
> [2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/
>
>
> Ming Lei (9):
>   blk-mq: pass request queue into get/put budget callback
>   blk-mq: pass hctx to blk_mq_dispatch_rq_list
>   blk-mq: don't predicate last flag in blk_mq_dispatch_rq_list
>   blk-mq: move getting driver tag and bugget into one helper
>   blk-mq: move .queue_rq code into one helper
>   blk-mq: move code for handling partial dispatch into one helper
>   blk-mq: remove dead check from blk_mq_dispatch_rq_list
>   blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
>   blk-mq: support batching dispatch in case of io scheduler
>
>  block/blk-mq-sched.c    |  96 ++++++++++++++--
>  block/blk-mq.c          | 248 +++++++++++++++++++++-------------------
>  block/blk-mq.h          |  15 +--
>  drivers/scsi/scsi_lib.c |   8 +-
>  include/linux/blk-mq.h  |   4 +-
>  5 files changed, 226 insertions(+), 145 deletions(-)
>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
>
> --
> 2.25.2
>


-- 
Baolin Wang
