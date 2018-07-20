Return-Path: <hch@lst.de>
Date: Fri, 20 Jul 2018 17:09:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v4 2/4] blkdev: __blkdev_direct_IO_simple: fix leak in
	error case
Message-ID: <20180720150901.GA17322@lst.de>
References: <20180720130552.21432-1-mwilck@suse.com> <20180720130552.21432-3-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720130552.21432-3-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 20, 2018 at 03:05:50PM +0200, Martin Wilck wrote:
> Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for
>  simplified bdev direct-io")
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
