Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33781 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbdDESiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 14:38:54 -0400
Received: by mail-pg0-f46.google.com with SMTP id x125so12404628pgb.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 11:38:54 -0700 (PDT)
Date: Wed, 5 Apr 2017 11:37:58 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 8/8] blk-mq: clean up direct issue blk_mq_queue_data
 initialization
Message-ID: <20170405183758.GA22645@vader.DHCP.thefacebook.com>
References: <cover.1491416593.git.osandov@fb.com>
 <e0eac74e541e9f85403fd4cf887a7f288768f00e.1491416593.git.osandov@fb.com>
 <1491417357.2787.13.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491417357.2787.13.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 05, 2017 at 06:35:58PM +0000, Bart Van Assche wrote:
> On Wed, 2017-04-05 at 11:28 -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Trivial cleanup.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  block/blk-mq.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 71dc8608f3a8..779249a5999b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1451,8 +1451,7 @@ static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
> >  	struct request_queue *q = rq->q;
> >  	struct blk_mq_queue_data bd = {
> >  		.rq = rq,
> > -		.list = NULL,
> > -		.last = 1
> > +		.last = true,
> >  	};
> >  	struct blk_mq_hw_ctx *hctx;
> >  	blk_qc_t new_cookie;
> 
> Hello Omar,
> 
> Although this patch looks fine to me I'm afraid that since this morning
> it no longer applies to Jens' for-next branch.
> 
> Bart.

Oh, I forgot to rebase. Thanks, Bart, I'll send out an updated version.
