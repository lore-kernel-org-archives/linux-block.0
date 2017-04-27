Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033823AbdD0GcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 02:32:05 -0400
Date: Wed, 26 Apr 2017 23:32:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170427063203.GA2964@infradead.org>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p>
 <20170420045408.GB2235@infradead.org>
 <20170420083041.GA1637@ming.t460p>
 <20170426104842.GB28062@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170426104842.GB28062@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 26, 2017 at 06:48:43PM +0800, Ming Lei wrote:
> Looks there are some choices for this issue:
> 
> 1) if internal ops uses independent tag space
> - we need to clean up the mtip32xx driver
> 
> 2) if internal ops shares tag space with normal request
> - export blk_mq_get_driver_tag() for mtip32xx
> 
> or
> 
> - use private way to send internal ops, and the drawback
> is that we still need to reserve tag and the reserved tag
> can't be used at all.

The fundamental problem in mtip is that it uses the block layer to
allocate requests, but not to issue them.  Either it needs to switch to
use blk_execute_rq(_nowait) to issue the command, or it needs to stop
using blk_mq_alloc_request to allocatate the internal commands.
Everything else is a layering violation just asking for more problems
down the road.

> 
> >From mtip32xx source code, I can see both share same tag space.
> When I try to search hw manual via google, not succeed yet.
> 
> Christoph, could you share us your findings about if internal ops
> uses independent tag space or not?

As said earlier in the thread - mtip32xx is a beefed up AHCI design,
and the internal commands issued are bog standard ATA commands.  So
I would be very surprised if the hardware requires a specific tag.
The way the driver is written it might very well expect a tag to be
set aside, though.
