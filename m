Return-Path: <hch@lst.de>
Date: Thu, 26 Jul 2018 11:20:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/3] blkdev: __blkdev_direct_IO_simple: fix leak in
	error case
Message-ID: <20180726092012.GB24335@lst.de>
References: <20180725211509.13592-1-mwilck@suse.com> <20180725211509.13592-3-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725211509.13592-3-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 11:15:08PM +0200, Martin Wilck wrote:
> Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for
>  simplified bdev direct-io")
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Martin Wilck <mwilck@suse.com>

I'm pretty sure I already ACKed this last time, but here we go
again:

Reviewed-by: Christoph Hellwig <hch@lst.de>
