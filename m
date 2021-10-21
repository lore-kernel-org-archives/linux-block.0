Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74027C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 03:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D66561183
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 03:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhJUDnr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJUDnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 23:43:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A7C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 20:41:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t16so542835eds.9
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McvdtKIiqbJKho9tX4x87O/fd2EXpjSgFzXvW6u0Imc=;
        b=DMtGEjuhV5m6n2YMBOXwrOkGqgqFrOZCW9dqXDwK9rwlr8fxcR//1xWg1sanyHoU0n
         rXgszI8g49Br9or2aGYe/BdvLdL/7bUNkIDBYSQ3vSAl3Rtf9X87npwugqj45YX3PKrB
         W6sRs5MSeFGvPY2SqcPveMSVWSTYmv3AS/Axx9M7fuS1YYbRAj7WbO2CJ/P0Ce4OSGMe
         x98vWiux0ToM7D+bq+fDOoc3qgfmIC/GJG+nr/I/SXGmId/MdX5MnGhYGmMbQLvNVbGF
         /iCKFVs+83YZB3+XH2Dj3Q3t93ld+Xhi9+VknhTEBMwwq426TBbj0ZZr8Wu7+U3tLaAg
         qoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McvdtKIiqbJKho9tX4x87O/fd2EXpjSgFzXvW6u0Imc=;
        b=u//A/8i1CNw43b1GCCO9DcifrNneZW6LSWG5Ie65hk2A9DRDishInaf0Sjmc+hFfTC
         OtS2c2LeOZklBfzytwZ5mUliCxTXnpQGpgXEM2oSVrcU4WfBXgogv421hLWdW0TgrtpK
         NRqp4m9MlGyuoKM0mX70/ivpG/ScoPxjYXReTbS9aaI6ONwLIFiSj4j70ikzb/qkd9Gi
         2/fa94QpDOrvb212hPEcM5JeX2AqUqoGSMzOYaFirqgzeGnkKryWNLlDd6CyWLzmtJZa
         f5jNgGszH5dtztzoysYzBsBHMZPpiFXtLZjlBOFOLZn9UJSKPHVsaXIzWZ6lkgrfoLS+
         wMxA==
X-Gm-Message-State: AOAM5306GbM6AXa5dOrLTM5iGtcmcisUZlS2Qz/3futkRMASbTXvxuAs
        ulVqFJueQPEklPZTpf9kqhOpqI9r+yx/h3F2/6YH
X-Google-Smtp-Source: ABdhPJwwycD3BOlgLRwtbfdeQIFF8lCnZ3zK2U2WgdBwXKurxRrTdhXlcGLLGO9LX//giL1PYizPX0wbHcMe8ukay9s=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr4241359edd.231.1634787689973;
 Wed, 20 Oct 2021 20:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210922123711.187-1-xieyongji@bytedance.com>
In-Reply-To: <20210922123711.187-1-xieyongji@bytedance.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 21 Oct 2021 11:41:19 +0800
Message-ID: <CACycT3u3gr2+4AZGbuTEmH1hDkQArCFLgJ38XzJR-dWXy3ddUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add invalidate_disk() helper for drivers to
 invalidate the gendisk
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping

On Wed, Sep 22, 2021 at 8:37 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This series comes from Christoph Hellwig's suggestion [1]. Some block
> device drivers such as loop driver and nbd driver need to invalidate
> the gendisk when the backend is detached so that the gendisk can be
> reused by the new backend. Now the invalidation is done in device
> driver with their own ways. To avoid code duplication and hide
> some internals of the implementation, this series adds a block layer
> helper and makes both loop driver and nbd driver use it.
>
> [1] https://lore.kernel.org/all/YTmqJHd7YWAQ2lZ7@infradead.org/
>
> V1 to V2:
> - Rename invalidate_gendisk() to invalidate_disk()
> - Add a cleanup patch to remove bdev checks and bdev variable in __loop_clr_fd()
>
> Xie Yongji (4):
>   block: Add invalidate_disk() helper to invalidate the gendisk
>   loop: Use invalidate_disk() helper to invalidate gendisk
>   loop: Remove the unnecessary bdev checks and unused bdev variable
>   nbd: Use invalidate_disk() helper on disconnect
>
>  block/genhd.c         | 20 ++++++++++++++++++++
>  drivers/block/loop.c  | 15 ++++-----------
>  drivers/block/nbd.c   | 12 +++---------
>  include/linux/genhd.h |  2 ++
>  4 files changed, 29 insertions(+), 20 deletions(-)
>
> --
> 2.11.0
>
