Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFA8C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6308920825
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6308920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeKOTKH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:10:07 -0500
Received: from verein.lst.de ([213.95.11.211]:40651 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbeKOTKH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 14:10:07 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B977D68D43; Thu, 15 Nov 2018 10:03:10 +0100 (CET)
Date:   Thu, 15 Nov 2018 10:03:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        drbd-dev@lists.linbit.com
Subject: Re: [PATCH 14/16] mmc: stop abusing the request queue_lock pointer
Message-ID: <20181115090310.GB14284@lst.de>
References: <20181114160219.28328-1-hch@lst.de> <20181114160219.28328-15-hch@lst.de> <CAPDyKFrEWQdOKHu2FeyzPvLCDrRa+QouG6OjEzf=JF1yxoTRgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrEWQdOKHu2FeyzPvLCDrRa+QouG6OjEzf=JF1yxoTRgw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 06:56:41PM +0100, Ulf Hansson wrote:
> >         } else {
> > @@ -397,6 +397,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> >         int ret;
> >
> >         mq->card = card;
> > +       mq->lock = lock;
> 
> Unless I am mistaken, it seems like the "lock" can also be removed as
> an in-parameter to mmc_init_queue() - and instead do the
> spin_lock_init() in here.
> 
> Moreover, that means we should drop the "lock" from the struct
> mmc_blk_data and instead move it to struct mmc_queue (rather than
> having a pointer to it.)

Which sounds like a sensible idead indeed, I'll look into it.
