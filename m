Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40616 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeHKCD2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 22:03:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so5044322pgp.7
        for <linux-block@vger.kernel.org>; Fri, 10 Aug 2018 16:31:28 -0700 (PDT)
Date: Fri, 10 Aug 2018 16:31:26 -0700
From: Omar Sandoval <osandov@osandov.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH 1/5] block: move call of scheduler's
 ->completed_request() hook
Message-ID: <20180810233126.GB9835@vader>
References: <cover.1533846185.git.osandov@fb.com>
 <dc018874d79575db91e3ec44c09511720e2b0ab0.1533846185.git.osandov@fb.com>
 <97b406d3-ae02-9f27-6855-59e5b13d665b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97b406d3-ae02-9f27-6855-59e5b13d665b@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 10, 2018 at 10:59:37AM +0800, jianchao.wang wrote:
> Hi Omar
> 
> On 08/10/2018 04:26 AM, Omar Sandoval wrote:
> > @@ -524,6 +524,9 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
> >  		blk_stat_add(rq, now);
> >  	}
> >  
> > +	if (rq->internal_tag != -1)
> > +		blk_mq_sched_completed_request(rq, now);
> > +
> 
> Is it OK to move the io scheduler completed callback into __blk_mq_end_request ?

It's ok in the sense that only Kyber uses it.

> There is a relatively long distance between the __blk_mq_complete_request and __blk_mq_end_request,
> especially the driver's mq_ops.complete and the bio_endio.

That's a fair point. We could maybe consolidate all of the I/O time
measurements to __blk_mq_complete_request() and have a separate callback
for the total time measurement in __blk_mq_end_request(), but I'm not
sure it's worth adding another hook for that.
