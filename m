Return-Path: <viro@ftp.linux.org.uk>
Date: Thu, 19 Jul 2018 12:08:41 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to fill
 up the bio
Message-ID: <20180719110840.GZ30522@ZenIV.linux.org.uk>
References: <20180718075440.GA15254@ming.t460p>
 <20180719093918.28876-1-mwilck@suse.com>
 <20180719093918.28876-3-mwilck@suse.com>
 <20180719102122.GA20700@ming.t460p>
 <20180719103713.tfuqzagme7zze6md@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719103713.tfuqzagme7zze6md@quack2.suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 12:37:13PM +0200, Jan Kara wrote:
> On Thu 19-07-18 18:21:23, Ming Lei wrote:
> > On Thu, Jul 19, 2018 at 11:39:18AM +0200, Martin Wilck wrote:
> > > bio_iov_iter_get_pages() returns only pages for a single non-empty
> > > segment of the input iov_iter's iovec. This may be much less than the number
> > > of pages __blkdev_direct_IO_simple() is supposed to process. Call
> > 
> > In bio_iov_iter_get_pages(), iov_iter_get_pages() supposes to retrieve
> > as many as possible pages since both 'maxsize' and 'maxpages' are provided
> > to cover all.

Huh?  Why does having a way to say "I (the caller) don't want more than <amount>"
implies anything of that sort?  It never had been promised, explicitly or not...

> > So the question is why iov_iter_get_pages() doesn't work as expected?
>
> Well, there has never been a promise that it will grab *all* pages in the
> iter AFAIK. Practically, I think that it was just too hairy to implement in
> the macro magic that iter processing is... Al might know more (added to
> CC).

Not really - it's more that VM has every right to refuse letting you pin
an arbitrary amount of pages anyway.
