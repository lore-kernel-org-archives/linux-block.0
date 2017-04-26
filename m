Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1956362AbdDZKsu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2017 06:48:50 -0400
Date: Wed, 26 Apr 2017 18:48:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170426104842.GB28062@ming.t460p>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p>
 <20170420045408.GB2235@infradead.org>
 <20170420083041.GA1637@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170420083041.GA1637@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Christoph,

On Thu, Apr 20, 2017 at 04:30:42PM +0800, Ming Lei wrote:
> Hi Christoph,
> 
> On Wed, Apr 19, 2017 at 09:54:08PM -0700, Christoph Hellwig wrote:
> > On Thu, Apr 20, 2017 at 09:03:47AM +0800, Ming Lei wrote:
> > > If we don't need to reserve tag for internal command, I am happy
> > > to fix it in the interim. However, the mtip32xx driver has to
> > > ask blk-mq to reserve the tag zero for internal command. Then
> > > if we can't allow the driver to use that reserved tag, it looks
> > > quite awkward, doesn't it?
> > 
> > It doesn't.  Just offset the hardware tags by 1 from the blk-mq tags.
> > 
> > But I'm pretty sure the hardware wouldn't require a specific tag
> > for the internal ops.
> 
> From mtip32xx code, the tag 0 is used to send internal command only, and
> not used for submitting normal request.
> 
> From code of mtip_issue_non_ncq_command() and mtip_issue_ncq_command(),
> even same hardware address is writen to when issuing non-ncq and ncq
> commands. So I think the internal ops and normal requests share one same
> tag space on mtip32xx.
> 
> Could you explain it a bit why you think the hw doesn't need the tag
> for internal ops in this case?

Gentle ping...

Looks there are some choices for this issue:

1) if internal ops uses independent tag space
- we need to clean up the mtip32xx driver

2) if internal ops shares tag space with normal request
- export blk_mq_get_driver_tag() for mtip32xx

or

- use private way to send internal ops, and the drawback
is that we still need to reserve tag and the reserved tag
can't be used at all.

>From mtip32xx source code, I can see both share same tag space.
When I try to search hw manual via google, not succeed yet.

Christoph, could you share us your findings about if internal ops
uses independent tag space or not?

Thanks,
Ming
