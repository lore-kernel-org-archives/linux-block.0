Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967A0C606AF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA992086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXb+Q80f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfGHLq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:46:27 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:47103 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfGHLq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 07:46:27 -0400
Received: by mail-ua1-f68.google.com with SMTP id o19so4808851uap.13
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flSipI0xpnq86C8I/rrm9xZYmUfxRgobFckLUfbaRC8=;
        b=XXb+Q80fYNPiOi+n2vBpTR7ILscbEfWMSgFLUGGBp0WIXyrchBmIU+NDlQakm7jnM8
         tMOGGlXLa6lhxN8Ra5giF5vusg5FAGcyYjayn4957m4SVC5MJ6sWMYf/OxIiDdEXGjyl
         t0iUctAF15Luy9UaHIMu7DeLX/vVTxmDkPCj5Sd3ctiKIAbE6unYRJZiySlXBWUfp3Qt
         wSm5DjC32317VN9BrP1dS0bGuEjxebRetq6Ln0vcwZpEzFLSO9tqdk3raraxZko69lN0
         02Xs/0veoLx/lL8aN++HqWTdEhSnkt6acjQytnwnnYv3k8Q3yxAL+Dnno9K+Jo/jxapZ
         ShmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flSipI0xpnq86C8I/rrm9xZYmUfxRgobFckLUfbaRC8=;
        b=gnagHvN5I4f0CjJkyub3SepuAyiTqTSZSakHeS28cO13C0SAzDMx3mGuZHoQt++TIt
         /iL+bLXjvtV6uf4wrJEMLv2VggL+7KH5/UWw/C6a1ucculIzms/qVqUzyD6aGZMvEFkA
         qk8QkQz8rs1Tb4+PSZo5O9AsU4Pql2JANbLz1jbxPDpbeAFK12YbmvdsgNt+ZMZ653Wn
         DW3J6iiBnk4tM2m+xP9lYQ2ACuf4Vwhev1Yq+/h9+DhR2AeAjbcsNrVwnnLko8KecHwL
         ZpKrqLM1N7LdEvI1bStHyH5WL9kRqR3aO0J9LwUNh94MEfp9oeiNl5Bi1/RowSxKgPrn
         3crg==
X-Gm-Message-State: APjAAAUjCWM04L0wobE1JziHJJCl7USiBtyit20n8YLiKGKp7M+fM+sj
        4DirdsvyRp4OFJSMg90PY0DhYnJwXR8ZZqneA3kZVw==
X-Google-Smtp-Source: APXvYqyFEUscJD5GsIV+BS++o/YX8MWQdCWyg9O7X6Nb/wsuAeld8qTTFnYvdC785Otd3OEmiYJn0ixqzjixmeBiM0Q=
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr9491120uam.129.1562586386291;
 Mon, 08 Jul 2019 04:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1561020610-953-6-git-send-email-yoshihiro.shimoda.uh@renesas.com> <20190624062414.GD2989@lst.de>
In-Reply-To: <20190624062414.GD2989@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:45:50 +0200
Message-ID: <CAPDyKFpuRzmZUK730FMnh0hf3WRFb9aA=o9ciNt2ei8n803vsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/5] mmc: queue: Use bigger segments if DMA MAP
 layer can merge the segments
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Jun 2019 at 08:24, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jun 20, 2019 at 05:50:10PM +0900, Yoshihiro Shimoda wrote:
> > When the max_segs of a mmc host is smaller than 512, the mmc
> > subsystem tries to use 512 segments if DMA MAP layer can merge
> > the segments, and then the mmc subsystem exposes such information
> > to the block layer by using blk_queue_can_use_dma_map_merging().
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/mmc/core/queue.c | 35 ++++++++++++++++++++++++++++++++---
> >  include/linux/mmc/host.h |  1 +
> >  2 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index 92900a0..ab0ecc6 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -24,6 +24,8 @@
> >  #include "card.h"
> >  #include "host.h"
> >
> > +#define MMC_DMA_MAP_MERGE_SEGMENTS   512
> > +
> >  static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
> >  {
> >       /* Allow only 1 DCMD at a time */
> > @@ -196,6 +198,12 @@ static void mmc_queue_setup_discard(struct request_queue *q,
> >               blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
> >  }
> >
> > +static unsigned int mmc_get_max_segments(struct mmc_host *host)
> > +{
> > +     return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
> > +                                      host->max_segs;
>
> I personally don't like superflous use of ? : if an if would be more
> obvious:
>
>         if (host->can_dma_map_merge)
>                 return MMC_DMA_MAP_MERGE_SEGMENTS;
>         return host->max_segs;
>
> but that is really just a nitpick and for the mmc maintainer to decide.

I have no strong opinions, both formats are used in mmc code, so I am
fine as is.

>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
