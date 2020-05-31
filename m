Return-Path: <SRS0=tY2F=7N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E4C433E0
	for <linux-block@archiver.kernel.org>; Sun, 31 May 2020 04:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2FB206B6
	for <linux-block@archiver.kernel.org>; Sun, 31 May 2020 04:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kew9nIK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgEaEJu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 May 2020 00:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgEaEJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 May 2020 00:09:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDCC05BD43
        for <linux-block@vger.kernel.org>; Sat, 30 May 2020 21:09:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so4066371ljj.1
        for <linux-block@vger.kernel.org>; Sat, 30 May 2020 21:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Dvo7g92Ll82Uwjs4Po60oTTNqHm0eVJCPATokIzRtE=;
        b=Kew9nIK8jMwvnQFN3/WT+s6X1nSGW74i+CPNbTuxLkNIb1l8PVVzOh6TCMRb3GvpcU
         otSiiUf1VXO7NseOAy1QITT1tN6pX9bxsgWyVJVmb+r+nTJnHhGQsNpbCmHabFj5xsM1
         NBTEUMVAZ1EcMQLvbVHJQrKku1VFiXDfnCVwcGfZH/jVRdQYCeuWaVb1cL1iBFl91dlq
         T/Apv2f2YM9rbF+ELniIrlIokuIxP/Z9lIyG3fSDPGNSnikUNqYQiTvJWVZh5s79KXbF
         gnz20JhHejFBq+VuE/BpISSs86XKwQWZfIclyunGCQG5ebq5LDcczI5SfVV90uyVe8Ey
         1RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Dvo7g92Ll82Uwjs4Po60oTTNqHm0eVJCPATokIzRtE=;
        b=Ytctbgi7Rp4kI3A0xEQrsat+8Qi3Gz2+5WfDvMi+U+GVEs8SaR5Fd4hW5y7fzZM84H
         P72vkXalSHEpgwpcJQEcKW2fYqDPwnkXSePV126hOkARhBtLZDf7cCflWk7DMeOFjCeH
         WDXprK3KyKMW4iTeih5LoVZp/Fsr6r7ulUkTgNV1WCyoePNzEq6/lv+F8bl/Holtz72h
         eytLifv4XJxN4Ihv1AXO9Hg9ZA9lkZ/8w4dBEjxnjDpfJ2wg2EGaQyTlDBj3SD751nVI
         FFIgb/6SCw9U1zj8zVerZB2ADuWjhLu0WcW3ObZ+nf/8iJtwQb12zUJtmn9jXSP9uQuO
         YMDg==
X-Gm-Message-State: AOAM533ILwOTFNXTx5kLkyA4EY/31yhTVhhiH/5nOGquWTxMK42GT8To
        wWW/1rEBeUAYZ1ar8ET48sJfcn+DfQAXQxQLe1pWsdbH
X-Google-Smtp-Source: ABdhPJwftcyrtC1T5n4w1bQli9cvXY4xYpZdvDO+MtB0Cw1NAHytlYYABZNBjictSFGWzllSX2r7MfRfNRaGnDzPZGE=
X-Received: by 2002:a2e:3202:: with SMTP id y2mr7991061ljy.155.1590898186951;
 Sat, 30 May 2020 21:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200528080053.1062653-1-ming.lei@redhat.com>
In-Reply-To: <20200528080053.1062653-1-ming.lei@redhat.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sun, 31 May 2020 12:09:07 +0800
Message-ID: <CADBw62rjYzTF=yZrZ3HHjd1J0qRm0hV5yFgxCLqyhaQfWFs+0w@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] blk-mq: support batching dispatch from scheduler
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

On Thu, May 28, 2020 at 4:01 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hi Jens,
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
> Baolin has tested V1 and found performance on MMC can be improved.
>
> Patches can be found from the following tree too:
>
>         https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-batching-submission
>
> Patch 1 ~ 4 are improvement and cleanup, which can't applied without
> supporting batching dispatch.
>
> Patch 5 ~ 6 starts to support batching dispatch from scheduler.
>
>
> [1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
> [2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/
>
> V3:
>         - add reviewed-by tag
>         - fix one typo
>         - fix one budget leak issue in case that .queue_rq returned *_RESOURCE in 5/6
>
> V2:
>         - remove 'got_budget' from blk_mq_dispatch_rq_list
>         - drop patch for getting driver tag & handling partial dispatch
>
> Ming Lei (6):
>   blk-mq: pass request queue into get/put budget callback
>   blk-mq: pass hctx to blk_mq_dispatch_rq_list
>   blk-mq: move getting driver tag and budget into one helper
>   blk-mq: remove dead check from blk_mq_dispatch_rq_list
>   blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
>   blk-mq: support batching dispatch in case of io scheduler
>
>  block/blk-mq-sched.c    |  95 ++++++++++++++++++++++++++++-----
>  block/blk-mq.c          | 115 ++++++++++++++++++++++++++--------------
>  block/blk-mq.h          |  15 +++---
>  drivers/scsi/scsi_lib.c |   8 ++-
>  include/linux/blk-mq.h  |   4 +-
>  5 files changed, 168 insertions(+), 69 deletions(-)
>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>

Works well for me again. So for the whole patch set:
Tested-by: Baolin Wang <baolin.wang7@gmail.com>

-- 
Baolin Wang
