Return-Path: <hch@lst.de>
Date: Wed, 19 Apr 2017 08:16:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	Adam Manzanares <adam.manzanares@wdc.com>
Subject: Re: [PATCH 1/5] block: Export blk_init_request_from_bio()
Message-ID: <20170419061651.GA6412@lst.de>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com> <20170418231037.3968-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418231037.3968-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

> +EXPORT_SYMBOL(blk_init_request_from_bio);

EXPORT_SYMBOL_GPL for block layer internals, please.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
