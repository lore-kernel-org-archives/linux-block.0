Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D77AC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047C52184A
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 15:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfB0Pu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:50:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0Pu4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 10:50:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFC6B769F4;
        Wed, 27 Feb 2019 15:50:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6112619A4;
        Wed, 27 Feb 2019 15:50:49 +0000 (UTC)
Date:   Wed, 27 Feb 2019 23:50:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mmc: align max segment size with logical block size
Message-ID: <20190227155044.GB10141@ming.t460p>
References: <20190227130237.7725-1-ming.lei@redhat.com>
 <CAPDyKFqMz3M8SzupEHP_k=r=r8wJ_dKYQRP=LMoRFUbq60E3Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqMz3M8SzupEHP_k=r=r8wJ_dKYQRP=LMoRFUbq60E3Sg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 27 Feb 2019 15:50:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 27, 2019 at 02:57:04PM +0100, Ulf Hansson wrote:
> + Christoph
> 
> On Wed, 27 Feb 2019 at 14:02, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Logical block size is the lowest possible block size that the storage
> > device can address. Max segment size is often related with controller's
> > DMA capability. And it is reasonable to align max segment size with
> > logical block size.
> >
> > SDHCI sets un-aligned max segment size, and causes ADMA error, so
> > fix it by aligning max segment size with logical block size.
> 
> Seems reasonable. However, is this specific to MMC or should it be
> managed in block layer?

So far, only see such broken max segment size on MMC, so suggest to
fix in MMC, otherwise we may have to align the limit in fast path.

> 
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Faiz Abbas <faiz_abbas@ti.com>
> > Cc: linux-block@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/mmc/core/block.c | 6 ------
> >  drivers/mmc/core/queue.c | 9 ++++++++-
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 14f3fdb8c6bb..9ce8eb51a60f 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2380,12 +2380,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
> >         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> >                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> >
> > -       if (mmc_card_mmc(card))
> > -               blk_queue_logical_block_size(md->queue.queue,
> > -                                            card->ext_csd.data_sector_size);
> > -       else
> > -               blk_queue_logical_block_size(md->queue.queue, 512);
> > -
> >         set_capacity(md->disk, size);
> >
> >         if (mmc_host_cmd23(card->host)) {
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index cc19e71c71d4..891bdbe14192 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -355,6 +355,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
> >  {
> >         struct mmc_host *host = card->host;
> >         u64 limit = BLK_BOUNCE_HIGH;
> > +       unsigned block_size = 512;
> >
> >         if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
> >                 limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> > @@ -368,7 +369,13 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
> >         blk_queue_max_hw_sectors(mq->queue,
> >                 min(host->max_blk_count, host->max_req_size / 512));
> >         blk_queue_max_segments(mq->queue, host->max_segs);
> > -       blk_queue_max_segment_size(mq->queue, host->max_seg_size);
> > +
> > +       if (mmc_card_mmc(card))
> > +               block_size = card->ext_csd.data_sector_size;
> > +
> > +       blk_queue_logical_block_size(mq->queue, block_size);
> > +       blk_queue_max_segment_size(mq->queue, host->max_seg_size &
> > +                       ~(block_size - 1));
> 
> Can't we use round_down() instead? No?

Sure, use round_down() in V2.

thanks,
Ming
