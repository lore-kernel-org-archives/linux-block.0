Return-Path: <ming.lei@redhat.com>
Date: Thu, 4 May 2017 00:21:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
Message-ID: <20170503162102.GA9706@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
 <20170503040303.GA20187@ming.t460p>
 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
 <20170503150351.GA7927@ming.t460p>
 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
 <20170503153808.GB7927@ming.t460p>
 <20170503160627.GA9967@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503160627.GA9967@vader>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 03, 2017 at 09:06:27AM -0700, Omar Sandoval wrote:
> On Wed, May 03, 2017 at 11:38:09PM +0800, Ming Lei wrote:
> > On Wed, May 03, 2017 at 09:08:34AM -0600, Jens Axboe wrote:
> > > Sounds good. I just wanted to check the numbers here, with the series
> > > applied on top of for-linus crashes when switching to kyber. A few hunks
> > 
> > Yeah, I saw that too, it has been fixed in my local tree, :-)
> 
> I'm guessing that was this?
> 
> static unsigned int kyber_sched_tags_shift(struct kyber_queue_data *kqd)
> {
> 	/*
> 	 * All of the hardware queues have the same depth, so we can just grab
> 	 * the shift of the first one.
> 	 */
> 	return kqd->q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
> }

Yes, that is it, :-)

Now we need to check .sched_tags here.

Thanks,
Ming
