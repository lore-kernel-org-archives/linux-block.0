Return-Path: <jack@suse.cz>
Date: Thu, 19 Jul 2018 12:37:13 +0200
From: Jan Kara <jack@suse.cz>
To: Ming Lei <ming.lei@redhat.com>
Cc: Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to fill
 up the bio
Message-ID: <20180719103713.tfuqzagme7zze6md@quack2.suse.cz>
References: <20180718075440.GA15254@ming.t460p>
 <20180719093918.28876-1-mwilck@suse.com>
 <20180719093918.28876-3-mwilck@suse.com>
 <20180719102122.GA20700@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719102122.GA20700@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Thu 19-07-18 18:21:23, Ming Lei wrote:
> On Thu, Jul 19, 2018 at 11:39:18AM +0200, Martin Wilck wrote:
> > bio_iov_iter_get_pages() returns only pages for a single non-empty
> > segment of the input iov_iter's iovec. This may be much less than the number
> > of pages __blkdev_direct_IO_simple() is supposed to process. Call
> 
> In bio_iov_iter_get_pages(), iov_iter_get_pages() supposes to retrieve
> as many as possible pages since both 'maxsize' and 'maxpages' are provided
> to cover all.
> 
> So the question is why iov_iter_get_pages() doesn't work as expected?

Well, there has never been a promise that it will grab *all* pages in the
iter AFAIK. Practically, I think that it was just too hairy to implement in
the macro magic that iter processing is... Al might know more (added to
CC).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
