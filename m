Return-Path: <mwilck@suse.com>
Message-ID: <69a408d71cd99e50858805c5f51f9e1ee4ecd3d0.camel@suse.com>
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to
 fill up the bio
From: Martin Wilck <mwilck@suse.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, Jan Kara
 <jack@suse.com>, Hannes Reinecke <hare@suse.de>, Johannes Thumshirn
 <jthumshirn@suse.de>, Kent Overstreet <kent.overstreet@gmail.com>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Date: Thu, 19 Jul 2018 22:01:55 +0200
In-Reply-To: <20180719151521.7ysnjr4ahj5wg4x2@quack2.suse.cz>
References: <20180718075440.GA15254@ming.t460p>
	 <20180719093918.28876-1-mwilck@suse.com>
	 <20180719093918.28876-3-mwilck@suse.com>
	 <20180719104551.jqndys6uxgglsbfh@quack2.suse.cz>
	 <f0945524222b06bee92e969b9d36f00d5b1a0800.camel@suse.com>
	 <20180719151521.7ysnjr4ahj5wg4x2@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-19 at 17:15 +0200, Jan Kara wrote:
> On Thu 19-07-18 14:23:53, Martin Wilck wrote:
> > On Thu, 2018-07-19 at 12:45 +0200, Jan Kara wrote:
> > > Secondly, I don't think it is good to discard error from
> > > bio_iov_iter_get_pages() here and just submit partial IO. It will
> > > again
> > > lead to part of IO being done as direct and part attempted to be
> > > done
> > > as
> > > buffered. Also the "slow" direct IO path in __blkdev_direct_IO()
> > > behaves
> > > differently - it aborts and returns error if
> > > bio_iov_iter_get_pages()
> > > ever
> > > returned error. IMO we should do the same here.
> > 
> > Well, it aborts the loop, but then (in the sync case) it still
> > waits
> > for the already submitted IOs to finish. Here, too, I'd find it
> > more
> > logical to return the number of successfully transmitted bytes
> > rather
> > than an error code. In the async case, the submitted bios are left
> > in
> > place, and will probably sooner or later finish, changing iocb-
> > >ki_pos.
> 
> Well, both these behaviors make sense, just traditionally (defined by
> our
> implementation) DIO returns error even if part of IO has actually
> been
> successfully submitted. Making a userspace visible change like you
> suggest
> thus has to be very carefully analyzed and frankly I don't think it's
> worth
> the bother.

OK, maybe not.
I'll rework the treatment of the error case.

Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
