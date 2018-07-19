Return-Path: <hch@lst.de>
Date: Thu, 19 Jul 2018 16:53:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
	Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to
	fill up the bio
Message-ID: <20180719145351.GD21000@lst.de>
References: <20180718075440.GA15254@ming.t460p> <20180719093918.28876-1-mwilck@suse.com> <20180719093918.28876-3-mwilck@suse.com> <20180719102122.GA20700@ming.t460p> <20180719103713.tfuqzagme7zze6md@quack2.suse.cz> <20180719110840.GZ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719110840.GZ30522@ZenIV.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 12:08:41PM +0100, Al Viro wrote:
> > Well, there has never been a promise that it will grab *all* pages in the
> > iter AFAIK. Practically, I think that it was just too hairy to implement in
> > the macro magic that iter processing is... Al might know more (added to
> > CC).
> 
> Not really - it's more that VM has every right to refuse letting you pin
> an arbitrary amount of pages anyway.

In which case the code after this patch isn't going to help either, because
it still tries to pin it all, just in multiple calls to get_user_pages().
