Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33074 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdCOXle (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 19:41:34 -0400
Date: Thu, 16 Mar 2017 07:41:28 +0800
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
Message-ID: <20170315234110.GA19908@ming.t460p>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
 <1489536441.2676.21.camel@sandisk.com>
 <20170315121851.GA15807@ming.t460p>
 <1489613676.2660.8.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489613676.2660.8.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 15, 2017 at 09:34:50PM +0000, Bart Van Assche wrote:
> On Wed, 2017-03-15 at 20:18 +0800, Ming Lei wrote:
> > On Wed, Mar 15, 2017 at 12:07:37AM +0000, Bart Van Assche wrote:
> > > Both the old and the new check look racy to me. The REQ_ATOM_STARTED bit can
> > > be changed concurrently by blk_mq_start_request(), __blk_mq_finish_request()
> > 
> > blk_mq_start_request() and __blk_mq_finish_request() won't be run concurrently.
> > 
> > From view of __blk_mq_finish_request():
> > 
> > 	- if it is run from merge queue io path(blk_mq_merge_queue_io()),
> > 	blk_mq_start_request() can't be run at all, and the COMPLETE flag
> > 	is kept as previous value(zero)
> > 
> > 	- if it is run from normal complete path, COMPLETE flag is cleared
> > 	before the req/tag is released to tag set.
> > 
> > so there isn't race in blk_mq_start_request() vs. __blk_mq_finish_request()
> > wrt. timeout.
> > 
> > > or __blk_mq_requeue_request(). Another issue with this function is that the
> > 
> > __blk_mq_requeue_request() can be run from two pathes:
> > 
> > 	- dispatch failure, in which case the req/tag isn't released to tag set
> > 	
> > 	- IO completion path, in which COMPLETE flag is cleared before requeue.
> > 	
> > so I can't see races with timeout in case of start rq vs. requeue rq. 
> > 
> > > request passed to this function can be reinitialized concurrently.
> 
> Hello Ming,
> 
> You misinterpret what I wrote. I was referring to manipulation of
> REQ_ATOM_STARTED from different contexts and not to what you explained.

This patch addresses one race between timeout and pre-queuing I/O in block layer
(before .queue_rq), please focus on this patch. And that is definitely correct.

Also I am happy to discuss this kind of races, but maybe we can do that in
another thread if you can describe the issue clearly.


-- 
Ming
