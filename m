Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772DFC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5716D61214
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhIOIuk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:50:40 -0400
Received: from verein.lst.de ([213.95.11.211]:35504 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhIOIuj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:50:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B324A67373; Wed, 15 Sep 2021 10:49:18 +0200 (CEST)
Date:   Wed, 15 Sep 2021 10:49:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Message-ID: <20210915084918.GA25090@lst.de>
References: <20210915064044.950534-1-hch@lst.de> <20210915064044.950534-2-hch@lst.de> <PH0PR04MB74162E70080738578747F6439BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74162E70080738578747F6439BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 08:45:56AM +0000, Johannes Thumshirn wrote:
> > index 5259edacde380..066a9118c3748 100644
> > --- a/drivers/gpu/drm/i915/i915_utils.h
> > +++ b/drivers/gpu/drm/i915/i915_utils.h
> > @@ -30,6 +30,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/types.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/sched/clock.h>
> >  
> >  struct drm_i915_private;
> >  struct timer_list;
> 
> This one
> 
> > diff --git a/lib/random32.c b/lib/random32.c
> > index 4d0e05e471d72..a57a0e18819d0 100644
> > --- a/lib/random32.c
> > +++ b/lib/random32.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/random.h>
> >  #include <linux/sched.h>
> >  #include <linux/bitops.h>
> > +#include <linux/slab.h>
> >  #include <asm/unaligned.h>
> >  #include <trace/events/random.h>
> >  
> > 
> 
> and this one look unrelated.

.. but they aren't.  All these headers indirectl pulled these headers
in before and now don't.

random32.c pulls in writeback.h through trace/events/random.h, which
pulls in blk-cgroup.h, which pull in blkdev.h, which pulls in slab.h
through some other weird twist of fate.

The drm code also somehow manages to pull in writeback.h
