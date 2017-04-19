Return-Path: <hch@lst.de>
Date: Wed, 19 Apr 2017 08:18:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	Adam Manzanares <adam.manzanares@wdc.com>
Subject: Re: [PATCH 2/5] null_blk: Use blk_init_request_from_bio() instead
	of open-coding it
Message-ID: <20170419061857.GB6412@lst.de>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com> <20170418231037.3968-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418231037.3968-3-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I wonder why the nvme lighnvm support cares about
a NULL-bio the null_blk one does not?
