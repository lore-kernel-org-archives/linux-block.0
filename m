Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76232C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 03:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1C320823
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 03:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4Y4Khhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGWDNK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:13:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46075 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfGWDNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 23:13:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so4095796otq.12
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRk0XCUOOeLhkURXIsrcmBZYRHclzXxoMPAdT26EhIw=;
        b=x4Y4KhhmBcGhMNRZHlH8uiKQqB7vPuwd9a3vzI/zUfipkeumIIxotuiLo/omBUZo1V
         I4yEENG2NJUeqgWbP1S7e+ALHfprLJHn0HSpbkd3gTfSAJAhc7mDQvXrKA9zm1A2m786
         /cvOT/9UgYlY1auQIn+F0rRuWUy1Qdqd5ONcxYNl502flymtImq5ZwDi9EUAlsslM6FR
         +L5kCSnrHL8qYuXoSb8ERiW3n5QlIqnThtyaAS1MAm7K+zC/omTtboVBCT/izDVm35/7
         6cdpMss5uZ4caCUgvGkE+eHNrp1Kki6vY7MNrEXIPrHCfePxLgKg+ccP5BOClq03YZiN
         odIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRk0XCUOOeLhkURXIsrcmBZYRHclzXxoMPAdT26EhIw=;
        b=VQiKn+W6NpPE4UKlLAHnDbOY8OPrDLmK0mVJy1XksCSuI/PSHjUk8FoN2eXwJDwdOX
         4MP4CjKuwqrUcosFW5fjKKehiZkViQ5993vU/XzlQg07jWeCqgk2O+bwlYDhuvNApfDV
         WuuF5WGzgvA/L2u5NUQ/YbyggpOcqJfLIIBu6R4dTUyK+am+0tFJEyU9xFg2ABnl49Sc
         FSA+c28gC4QghNuOlrNgldKNyKN4hgVc5nNAyQyt0YaDNogjafEMQ76DW3XDssa+SLwI
         Xjuchch0uQtJKIxSfs13MAxSZGpDeQYFFmmePrli9GMfQnp4urqZrfxD+4gmnhD0sUrZ
         mh1w==
X-Gm-Message-State: APjAAAXqqrbiqU18fMz1fw79LTskQDxpqSpRQ610kw/Lxyf+Sa6u4k62
        9u4LPNc9/lOAtgvmuDwB74lXisBZd2GUgNdw3ld/MA==
X-Google-Smtp-Source: APXvYqy1vfQdOXDImruQOKc6WqzDViO9H0BO7gpFE3uIOrbEzPmKXH6lGJp5FeQx/o3OtwHJ/PUcvdKi5AteHgD6TkQ=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr38048922oth.281.1563851589136;
 Mon, 22 Jul 2019 20:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563782844.git.baolin.wang@linaro.org> <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
 <20190722141940.GA26528@ming.t460p>
In-Reply-To: <20190722141940.GA26528@ming.t460p>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 23 Jul 2019 11:12:57 +0800
Message-ID: <CAMz4ku+R8OdAQ2S91Xe=V-nZL1Nu5g=_xpHqQCzNF6JeBHY3rw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Mon, 22 Jul 2019 at 22:19, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jul 22, 2019 at 09:09:36PM +0800, Baolin Wang wrote:
> > Some SD/MMC host controllers can support packed command or packed request,
> > that means we can package several requests to host controller at one time
> > to improve performence. And this patch set will introduce MMC packed function
> > to support this feature by following patches.
> >
> > To support MMC packed function, the MMC layer need to know if there are
> > requests are pending now in hardware queue to help to combine requests
> > as much as possible. If we know there are requests pending in hardware
> > queue, then we should not package requests to host controller immediately,
> > instead we should collect more requests into MMC packed queue to be packed
> > to host controller with packed condition.
> >
> > Thus export this function for MMC packed function.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  block/blk-mq.c         |    3 ++-
> >  include/linux/blk-mq.h |    1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index b038ec6..5bd4ef9 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
> >   * Check if any of the ctx, dispatch list or elevator
> >   * have pending work in this hardware queue.
> >   */
> > -static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> > +bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> >  {
> >       return !list_empty_careful(&hctx->dispatch) ||
> >               sbitmap_any_bit_set(&hctx->ctx_map) ||
> >                       blk_mq_sched_has_work(hctx);
> >  }
> > +EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
>
> Just wondering why you don't use the 'last' field of 'struct blk_mq_queue_data',
> which is passed to .queue_rq(), and supposed for implementing batch submission.

The 'last' field of 'struct blk_mq_queue_data' does not indicate the
last request in the hardware queue, since we want to collect more
requests from block layer as much as possible to be packed later.

And from blk_mq_do_dispatch_sched()--->blk_mq_dispatch_rq_list()--->
queue_rq(), I always get 'bd.last = true', which is not useful to
combine requests for MMC packed queue. Maybe I missed anything?

Thanks for your comments.

-- 
Baolin Wang
Best Regards
