Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34631 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbdCOQWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 12:22:11 -0400
Date: Thu, 16 Mar 2017 00:22:03 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in timeout
 handler
Message-ID: <20170315162158.GA18768@ming.t460p>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
 <1489536441.2676.21.camel@sandisk.com>
 <20170315121851.GA15807@ming.t460p>
 <20170315124024.GA16549@ming.t460p>
 <1489592177.2660.1.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1489592177.2660.1.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 15, 2017 at 03:36:31PM +0000, Bart Van Assche wrote:
> On Wed, 2017-03-15 at 20:40 +0800, Ming Lei wrote:
> > On Wed, Mar 15, 2017 at 08:18:53PM +0800, Ming Lei wrote:
> > > On Wed, Mar 15, 2017 at 12:07:37AM +0000, Bart Van Assche wrote:
> > > 
> > > > or __blk_mq_requeue_request(). Another issue with this function is that the
> > > 
> > > __blk_mq_requeue_request() can be run from two pathes:
> > > 
> > > 	- dispatch failure, in which case the req/tag isn't released to tag set
> > > 	
> > > 	- IO completion path, in which COMPLETE flag is cleared before requeue.
> > > 	
> > > so I can't see races with timeout in case of start rq vs. requeue rq. 
> > 
> > Actually rq/tag won't be released to tag set if it will be requeued, so
> > the timeout race is nothing to do with requeue.
> 
> Hello Ming,
> 
> Please have another look at __blk_mq_requeue_request(). In that function
> the following code occurs: if (test_and_clear_bit(REQ_ATOM_STARTED,
> &rq->atomic_flags)) { ... }
> 
> I think the�REQ_ATOM_STARTED check in blk_mq_check_expired() races with the
> test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags) call in
> __blk_mq_requeue_request().

OK, this race should only exist in case that the requeue happens after dispatch
busy, because COMPLETE flag isn't set. And if the requeue is from io completion,
no such race because COMPLETE flag is set.

One solution I thought of is to call blk_mark_rq_complete() before requeuing
when dispatch busy happened, but that looks a bit silly. Another way is to
set STARTED flag just after .queue_rq returns BLK_MQ_RQ_QUEUE_OK, which looks
reasonable too. Any comments on the 2nd solution?


Thanks,
Ming
