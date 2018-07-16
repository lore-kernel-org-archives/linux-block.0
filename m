Return-Path: <mwilck@suse.com>
Message-ID: <607e800a52055e4ce7c95d2ed23702ee3c218648.camel@suse.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, Jan Kara
	 <jack@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>
Date: Mon, 16 Jul 2018 21:05:56 +0200
In-Reply-To: <d7baebbd-1cd5-e6f1-c170-15e6dde67797@kernel.dk>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
	 <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
	 <a1679897-ed41-1ceb-f94f-bd1be537ce4e@suse.de>
	 <57a2b121-9805-8337-fb97-67943670f250@kernel.dk>
	 <a0b0e59b-60cd-9933-6752-4c21a7a975fe@kernel.dk>
	 <2311947c2f0f368bd10474edb0f0f5b51dde6b7d.camel@suse.com>
	 <b85c5eff-d6dc-e43c-8e2c-608249ae81a2@kernel.dk>
	 <d14f5d9d08742fba54ee97e51ab0eafbf9d9088f.camel@suse.com>
	 <d7baebbd-1cd5-e6f1-c170-15e6dde67797@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-13 at 14:52 -0600, Jens Axboe wrote:
> On 7/13/18 2:48 PM, Martin Wilck wrote:
> > > 
> > > > However, so far I've only identified a minor problem, see below
> > > > -
> > > > it
> > > > doesn't explain the data corruption we're seeing.
> > > 
> > > What would help is trying to boil down a test case. So far it's a
> > > lot
> > > of hand waving, and nothing that can really help narrow down what
> > > is
> > > going on here.
> > 
> > It's not that we didn't try. We've run fio with verification on
> > block
> > devices with varying io sizes, block sizes, and alignments, but so
> > far
> > we haven't hit the issue. We've also tried to reproduce it by
> > approximating the customer's VM setup, with no success up to now.
> 
> I ran some testing yesterday as well, but didn't trigger anything.
> Didn't expect to either, as all the basic functionality was verified
> when the patch was done. It's not really a path with a lot of corner
> cases, so it's really weird that we're seeing anything at all. Which
> is
> why I'm suspecting it's something else entirely, but it's really hard
> to
> guesstimate on that with no clues at all.
> 
> > However, we're now much closer than we used to be, so I'm confident
> > that we'll be able to present more concrete facts soon.
> 
> OK, sounds good.

Jan Kara has provided very convincing analysis and provided a patch
which we are going to have to the customer test. 

By calling bio_iov_iter_get_pages() only once,
__blkdev_direct_IO_simple() may not transfer all requested bytes,
because bio_iov_iter_get_pages() doesn't necessarily exhaust all data
in the iov_iter. Thus a short write may occur, and
__generic_file_write_iter() falls back to buffered IO. We've actually
observed these "short direct writes" in the error case with an
instrumented kernel (in a trace I got, ~13000/800000 direct write ops
on a block device transferred less data than requested).

We suspect that this concurrency of direct and buffered writes may
cause the corruption the customer observes.

Does that make sense to you?

Regards,
Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
