Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35180 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755116AbdCWMOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2017 08:14:06 -0400
Date: Thu, 23 Mar 2017 20:14:02 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Yi Zhang <yizhan@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] blk-mq: don't complete un-started request in timeout
 handler
Message-ID: <20170323121401.GA17152@ming.t460p>
References: <20170322021443.26397-1-tom.leiming@gmail.com>
 <2bc8118b-4a11-f28e-50eb-22019184756b@fb.com>
 <20170322155817.GA18960@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170322155817.GA18960@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 22, 2017 at 11:58:17AM -0400, Keith Busch wrote:
> On Tue, Mar 21, 2017 at 11:03:59PM -0400, Jens Axboe wrote:
> > On 03/21/2017 10:14 PM, Ming Lei wrote:
> > > When iterating busy requests in timeout handler,
> > > if the STARTED flag of one request isn't set, that means
> > > the request is being processed in block layer or driver, and
> > > isn't submitted to hardware yet.
> > > 
> > > In current implementation of blk_mq_check_expired(),
> > > if the request queue becomes dying, un-started requests are
> > > handled as being completed/freed immediately. This way is
> > > wrong, and can cause rq corruption or double allocation[1][2],
> > > when doing I/O and removing&resetting NVMe device at the sametime.
> > 
> > I agree, completing it looks bogus. If the request is in a scheduler or
> > on a software queue, this won't end well at all. Looks like it was
> > introduced by this patch:
> > 
> > commit eb130dbfc40eabcd4e10797310bda6b9f6dd7e76
> > Author: Keith Busch <keith.busch@intel.com>
> > Date:   Thu Jan 8 08:59:53 2015 -0700
> > 
> >     blk-mq: End unstarted requests on a dying queue
> > 
> > Before that, we just ignored it. Keith?
> 
> The above was intended for a stopped hctx on a dying queue such that
> there's nothing in flight to the driver. Nvme had been relying on this
> to end unstarted requests so we may progress when a controller dies.

So the brokenness started just from the begining.

> 
> We've since obviated the need: we restart the hw queues to flush entered
> requests to failure, so we don't need that brokenness.

Looks the following commit need to be backported too if we port this patch.

commit 69d9a99c258eb1d6478fd9608a2070890797eed7
Author: Keith Busch <keith.busch@intel.com>
Date:   Wed Feb 24 09:15:56 2016 -0700

    NVMe: Move error handling to failed reset handler
 

Thanks,
Ming
