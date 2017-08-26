Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbdHZIna (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Aug 2017 04:43:30 -0400
Date: Sat, 26 Aug 2017 16:43:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 02/20] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20170826084315.GA28380@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-3-ming.lei@redhat.com>
 <1503426533.2508.6.camel@wdc.com>
 <20170824035743.GA12966@ming.t460p>
 <1503696985.2680.33.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503696985.2680.33.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 25, 2017 at 09:36:26PM +0000, Bart Van Assche wrote:
> On Thu, 2017-08-24 at 11:57 +0800, Ming Lei wrote:
> > On Tue, Aug 22, 2017 at 06:28:54PM +0000, Bart Van Assche wrote:
> > > * Whether or not index >= sb->map_nr. I propose to start iterating from the
> > >   start of @sb in this case.
> > 
> > It has been checked at the end of the loop.
> 
> That's not sufficient to avoid an out-of-bounds access if the start index is
> large. If __sbitmap_for_each_set() would accept values for the start index
> argument that result in index >= sb->map_nr then that will simplify code that
> accesses an sbitmap in a round-robin fashion.

Given the only user of this helper is blk_mq_dispatch_rq_from_ctx(), the
start index won't be out of bounds.

> 
> > > 	}
> > > 
> > > 	while (true) {
> > > 		struct sbitmap_word *word = &sb->map[i];
> > > 		unsigned int off;
> > 
> > Looks you removed the check on 'word->word'.
> 
> Yes, and I did that on purpose. If the start index refers to a word that is
> zero then the "if (word->word) continue;" code will cause the end-of-loop
> check to be skipped and hence will cause an infinite loop.

Got it, but it removes the optimization too, :-)

-- 
Ming
