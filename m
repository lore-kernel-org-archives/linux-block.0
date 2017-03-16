Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34695 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdCPAH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 20:07:58 -0400
Date: Thu, 16 Mar 2017 08:07:51 +0800
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
Message-ID: <20170316000747.GA19948@ming.t460p>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
 <1489536441.2676.21.camel@sandisk.com>
 <20170315121851.GA15807@ming.t460p>
 <20170315124024.GA16549@ming.t460p>
 <1489592177.2660.1.camel@sandisk.com>
 <20170315162158.GA18768@ming.t460p>
 <1489613678.2660.9.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1489613678.2660.9.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 15, 2017 at 09:35:03PM +0000, Bart Van Assche wrote:
> On Thu, 2017-03-16 at 00:22 +0800, Ming Lei wrote:
> > On Wed, Mar 15, 2017 at 03:36:31PM +0000, Bart Van Assche wrote:
> > > Please have another look at __blk_mq_requeue_request(). In that function
> > > the following code occurs: if (test_and_clear_bit(REQ_ATOM_STARTED,
> > > &rq->atomic_flags)) { ... }
> > > 
> > > I think the�REQ_ATOM_STARTED check in blk_mq_check_expired() races with the
> > > test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags) call in
> > > __blk_mq_requeue_request().
> > 
> > OK, this race should only exist in case that the requeue happens after dispatch
> > busy, because COMPLETE flag isn't set. And if the requeue is from io completion,
> > no such race because COMPLETE flag is set.
> > 
> > One solution I thought of is to call blk_mark_rq_complete() before requeuing
> > when dispatch busy happened, but that looks a bit silly. Another way is to
> > set STARTED flag just after .queue_rq returns BLK_MQ_RQ_QUEUE_OK, which looks
> > reasonable too. Any comments on the 2nd solution?
> 
> Sorry but I don't think that would be sufficient. There are several other
> scenarios that have not been mentioned above, e.g. that a tag gets freed and
> reused after the blk_mq_check_expired() call started and before that function
> has had the chance to examine any members of struct request. What is needed in
> blk_mq_check_expired() is the following as a single atomic operation:

We have dealt with this by checking COMPLETE & rq->deadline together in
blk_mq_check_expired() already:

- if new rq->deadline(set in reuse path) has been observed in the later
checking rq of blk_mq_check_expired(), it won't be timeouted because of the timing.

- if new rq->deadline(set in reuse path) hasn't been observed in the
later checking rq of blk_mq_check_expired(), that means COMPLETE flag isn't set
yet in reuse path because we have a barrier to enhance the order in
blk_mq_start_request(), so it won't be timeouted too.

So let me know what is the real race between free/reusing vs. timeout.

> * Check whether REQ_ATOM_STARTED has been set.
> * Check whether REQ_ATOM_COMPLETE has not yet been set.
> * If both conditions have been met, set REQ_ATOM_COMPLETE.
> 
> I don't think there is another solution than using a single state variable to
> represent the REQ_ATOM_STARTED and REQ_ATOM_COMPLETE states instead of two
> independent bits. How about the patch below?

I would review it if you can confirm me that it is a real issue, :-)

Thanks,
Ming
