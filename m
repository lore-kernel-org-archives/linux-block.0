Return-Path: <hch@lst.de>
Date: Thu, 19 Jul 2018 17:11:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>,
	Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to
	fill up the bio
Message-ID: <20180719151149.GA22445@lst.de>
References: <20180718075440.GA15254@ming.t460p> <20180719093918.28876-1-mwilck@suse.com> <20180719093918.28876-3-mwilck@suse.com> <20180719102122.GA20700@ming.t460p> <20180719103713.tfuqzagme7zze6md@quack2.suse.cz> <20180719110840.GZ30522@ZenIV.linux.org.uk> <20180719145351.GD21000@lst.de> <20180719150642.ppvxbapasfl2kqai@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719150642.ppvxbapasfl2kqai@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 05:06:42PM +0200, Jan Kara wrote:
> Yeah. Actually previous version of the fix (not posted publicly) submitted
> partial bio and then reused the bio to submit more. This is also the way
> __blkdev_direct_IO operates. Martin optimized this to fill the bio
> completely (as we know we have enough bvecs) before submitting which has
> chances to perform better. I'm fine with either approach, just we have to
> decide which way to go.

I think this first version is going to be less fragile, so I we should
aim for that.
