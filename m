Return-Path: <mwilck@suse.com>
Message-ID: <09e8a0ba5ca156b83ca932e57afc68d698259902.camel@suse.com>
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to
 fill up the bio
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Ming Lei <ming.lei@redhat.com>, Jens
 Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>, Hannes Reinecke
 <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>, Kent Overstreet
 <kent.overstreet@gmail.com>,  linux-block@vger.kernel.org
Date: Thu, 19 Jul 2018 21:21:47 +0200
In-Reply-To: <20180719151149.GA22445@lst.de>
References: <20180718075440.GA15254@ming.t460p>
	 <20180719093918.28876-1-mwilck@suse.com>
	 <20180719093918.28876-3-mwilck@suse.com>
	 <20180719102122.GA20700@ming.t460p>
	 <20180719103713.tfuqzagme7zze6md@quack2.suse.cz>
	 <20180719110840.GZ30522@ZenIV.linux.org.uk> <20180719145351.GD21000@lst.de>
	 <20180719150642.ppvxbapasfl2kqai@quack2.suse.cz>
	 <20180719151149.GA22445@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-19 at 17:11 +0200, Christoph Hellwig wrote:
> On Thu, Jul 19, 2018 at 05:06:42PM +0200, Jan Kara wrote:
> > Yeah. Actually previous version of the fix (not posted publicly)
> > submitted
> > partial bio and then reused the bio to submit more. This is also
> > the way
> > __blkdev_direct_IO operates. Martin optimized this to fill the
> > bio
> > completely (as we know we have enough bvecs) before submitting
> > which has
> > chances to perform better. I'm fine with either approach, just we
> > have to
> > decide which way to go.
> 
> I think this first version is going to be less fragile, so I we
> should
> aim for that.

Wait a second. We changed the approach for a reason. By submitting
partial bios synchronously and sequentially, we loose a lot of
performance, so much that this "fast path" quickly falls behind the
regular __blkkdev_direct_IO() path as the number of input IO segments
increases. The patch I submitted avoids that. The whole point of this
fast path is to submit a single bio, and return as quickly as possible.

It's not an error condition if bio_iov_iter_get_pages() returns less
data than possible. The function just takes one iteration step at a
time, and thus iterating over it until the desired number of pages is
obtained, and collecting the resulting pages in a single bio, isn't
"fragile", it's just the natural thing to do.

Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
