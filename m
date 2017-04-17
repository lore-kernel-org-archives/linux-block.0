Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34602 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753914AbdDQRbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2017 13:31:46 -0400
Received: by mail-pf0-f177.google.com with SMTP id c198so68659579pfc.1
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2017 10:31:46 -0700 (PDT)
Date: Mon, 17 Apr 2017 10:30:46 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170417173046.GA27028@vader.DHCP.thefacebook.com>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <20170416160352.GA6349@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170416160352.GA6349@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 17, 2017 at 12:03:53AM +0800, Ming Lei wrote:
> On Sat, Apr 15, 2017 at 08:38:21PM +0800, Ming Lei wrote:
> > The 1st patch enhances BLK_MQ_F_NO_SCHED so that we can't change/
> > show available io schedulers on devices which don't support io
> > scheduler.
> > 
> > The 2nd patch passes BLK_MQ_F_NO_SCHED for avoiding one regression
> > on mtip32xx, which is introduced by blk-mq io scheduler.
> > 
> > The last two patches introduce BLK_MQ_F_SCHED_USE_HW_TAG so that
> > we can allow to use hardware tag for scheduler, then mq-deadline
> > can work well on mtip32xx. Even though other devices with enough
> > hardware tag space can benefit from this feature too.
> > 
> > The 1st two patches aims on v4.11, and the last two are for
> > v4.12.
> 
> Please ignore this patchset, and I will post another serial for
> mtip32xx fix.
> 
> thanks,
> Ming

Regardless of the mtip32xx fix, I actually wanted to skip the scheduler
tags when possible just for performance reasons. I don't think that
should be a device-specific setting. We can let the I/O scheduler decide
how many tags it wants, and if the device has at least that many tags,
just use the hardware tags directly. I'll probably look at doing that
for 4.13, we'll see if it actually makes a performance difference.
