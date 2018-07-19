Return-Path: <mwilck@suse.com>
Message-ID: <57fb12883b9ff68b2cfeeabc2a825b87b3636baa.camel@suse.com>
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to
 fill up the bio
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>, Jens Axboe
 <axboe@kernel.dk>, Jan Kara <jack@suse.com>, Hannes Reinecke
 <hare@suse.de>,  Johannes Thumshirn <jthumshirn@suse.de>, Kent Overstreet
 <kent.overstreet@gmail.com>,  linux-block@vger.kernel.org
Date: Thu, 19 Jul 2018 21:34:59 +0200
In-Reply-To: <20180719145351.GD21000@lst.de>
References: <20180718075440.GA15254@ming.t460p>
	 <20180719093918.28876-1-mwilck@suse.com>
	 <20180719093918.28876-3-mwilck@suse.com>
	 <20180719102122.GA20700@ming.t460p>
	 <20180719103713.tfuqzagme7zze6md@quack2.suse.cz>
	 <20180719110840.GZ30522@ZenIV.linux.org.uk> <20180719145351.GD21000@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-19 at 16:53 +0200, Christoph Hellwig wrote:
> On Thu, Jul 19, 2018 at 12:08:41PM +0100, Al Viro wrote:
> > > Well, there has never been a promise that it will grab *all*
> > > pages in the
> > > iter AFAIK. Practically, I think that it was just too hairy to
> > > implement in
> > > the macro magic that iter processing is... Al might know more
> > > (added to
> > > CC).
> > 
> > Not really - it's more that VM has every right to refuse letting
> > you pin
> > an arbitrary amount of pages anyway.
> 
> In which case the code after this patch isn't going to help either,
> because
> it still tries to pin it all, just in multiple calls to
> get_user_pages().

That was not the point of the patch. It's not about a situation in
which MM refuses to pin more pages.

The patch is about the "iterator::next()" nature of
bio_iov_iter_get_pages().

If it can't pin the pages, bio_iov_iter_get_pages() returns an error
code (elsewhere in this thread we discussed how to treat that right).
Otherwise, it always adds _some_ data to the bio, but the amount added
depends on the segment structure of the input iov_iter. If the input
iovec has just a single segment, it fills the bio in a single call.
With multiple segments, it just returns the page(s) of the first
segment. The point of my patch is to make no difference between single-
segment and multi-segment IOs.

Regards
Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
