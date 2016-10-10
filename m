Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62656 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbcJJUjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2016 16:39:16 -0400
Date: Mon, 10 Oct 2016 13:37:05 -0700
From: Adam Manzanares <adam.manzanares@hgst.com>
To: Jeff Moyer <jmoyer@redhat.com>
CC: <axboe@kernel.dk>, <tj@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] block: Add iocontext priority to request
Message-ID: <20161010203705.GA22612@hgst.com>
References: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
 <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
 <x49d1jdi7lz.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <x49d1jdi7lz.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jeff,

The 10/06/2016 15:46, Jeff Moyer wrote:
> Hi, Adam,
> 
> Adam Manzanares <adam.manzanares@hgst.com> writes:
> 
> > Patch adds an association between iocontext ioprio and the ioprio of
> > a request. This feature is only enabled if a queue flag is set to
> > indicate that requests should have ioprio associated with them. The
> > queue flag is exposed as the req_prio queue sysfs entry.
> >
> > Signed-off-by: Adam Mananzanares <adam.manzanares@hgst.com>
> 
> I like the idea of the patch, but I have a few comments.
> 
> First, don't add a tunable, there's no need for it.  (And in the future,
> if you do add tunables, document them.)  That should make your patch
> much smaller.
> 

I have a strong preference for making this a tunable for the following 
reason. I am concerned that this could negatively impact performance if this 
feature is not properly implemented on a device. In addition, this feature 
can make a dramatic difference in the performance of prioritized vs 
non-prioritized IO. Priority IO is improved, but it comes at the cost of 
non-prioritized IO. If someone has tuned a system in such a way that things 
work well as is, I do not want to cause any surprises.

I can see the argument for not having the tunable in the block layer, but 
then we need to add a tunable to all request based drivers that may leverage
the iopriority information. This has the potential to generate a lot more 
code and documentation.  I also would like to use the tunable when the 
iopriority is set on the request so we can preserve the default behavior. 
This can be a concern when we have drivers that use request iopriority 
information, such as the fusion mptsas driver.

I will also document the tunable :) if we agree that it is necessary.

> > @@ -1648,6 +1649,7 @@ out:
> >  
> >  void init_request_from_bio(struct request *req, struct bio *bio)
> >  {
> > +	struct io_context *ioc = rq_ioc(bio);
> 
> That can return NULL, and you blindly dereference it later.
>

Ouch, this will be cleaned up in the next revision.

> > @@ -1656,7 +1658,11 @@ void init_request_from_bio(struct request *req, struct bio *bio)
> >  
> >  	req->errors = 0;
> >  	req->__sector = bio->bi_iter.bi_sector;
> > -	req->ioprio = bio_prio(bio);
> > +	if (blk_queue_req_prio(req->q))
> > +		req->ioprio = ioprio_best(bio_prio(bio), ioc->ioprio);
> > +	else
> > +		req->ioprio = bio_prio(bio);
> > +
> 
> If the bio actually has an ioprio (only happens for bcache at this
> point), you should use it.  Something like this:
> 
>         req->ioprio = bio_prio(bio);
>         if (!req->ioprio && ioc)
> 		req->ioprio = ioc->ioprio;
>

I caught this in the explanation of the first patch I sent out. I am still
assuming that this will be a tunable, but I will have the bio_prio take 
precedence in the next patch.

> Finally, please re-order your series as Hannes suggested.

Will do. 

> 
> Thanks!
> Jeff

Take care,
Adam
