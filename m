Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbdHaEDo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 00:03:44 -0400
Date: Thu, 31 Aug 2017 12:03:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 13/14] blk-mq-sched: refactor blk_mq_sched_try_merge()
Message-ID: <20170831040326.GF12246@ming.t460p>
References: <20170826163332.28971-1-ming.lei@redhat.com>
 <20170826163332.28971-14-ming.lei@redhat.com>
 <1504113417.2526.57.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504113417.2526.57.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 30, 2017 at 05:17:05PM +0000, Bart Van Assche wrote:
> On Sun, 2017-08-27 at 00:33 +0800, Ming Lei wrote:
> > -bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> > -			    struct request **merged_request)
> > +static bool __blk_mq_try_merge(struct request_queue *q,
> > +		struct bio *bio, struct request **merged_request,
> > +		struct request *candidate, enum elv_merge type)
> >  {
> > -	struct request *rq;
> > +	struct request *rq = candidate;
> 
> It seems weird to me that the argument 'candidate' is not used other than to
> copy its value into the local variable 'rq'? How about removing that local

OK, will simply use 'rq' as parameter.

> variable and renaming the 'candidate' argument into 'rq'? Anyway, with or
> without that change:
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

OK, thanks!

-- 
Ming
