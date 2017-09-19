Return-Path: <BATV+de86e71b538cb4077339+5140+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 19 Sep 2017 07:38:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v6 1/2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170919143811.GB15944@infradead.org>
References: <1505760831-7747-1-git-send-email-longman@redhat.com>
 <1505760831-7747-2-git-send-email-longman@redhat.com>
 <20170919000155.GA30806@infradead.org>
 <aaa854ce-3e87-2a71-5f12-08db9bfbe837@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aaa854ce-3e87-2a71-5f12-08db9bfbe837@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 19, 2017 at 08:49:12AM -0400, Waiman Long wrote:
> On 09/18/2017 08:01 PM, Christoph Hellwig wrote:
> > Taking a look at this it seems like using a lock in struct block_device
> > isn't the right thing to do anyway - all the action is on fields in
> > struct blk_trace, so having a lock inside that would make a lot more
> > sense.
> >
> > It would also help to document what exactly we're actually protecting.
> 
> I think I documented in the patch that the lock has to protect changes
> in the blktrace structure as well as the allocation and destruction of
> it. Because of that, it can't be put inside the blktrace structure. The
> original code use the bd_mutex of the block_device structure. I just
> change the code to use another bd_fsfreeze_mutex in the same structure.

Either way it has absolutely nothing to do with struct block_device,
given that struct blk_trace hangs off the request_queue.

Reusing a mutex just because it happens to live in a structure also
generally is a bad idea if the protected data is in no way related.
