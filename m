Return-Path: <hch@lst.de>
Date: Tue, 29 Aug 2017 14:49:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH] block: Make blk_dequeue_request() static
Message-ID: <20170829124959.GA27877@lst.de>
References: <20170829025437.26726-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829025437.26726-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 29, 2017 at 11:54:37AM +0900, Damien Le Moal wrote:
> The only caller of this function is blk_start_request() in the same
> file. Fix blk_start_request() description accordingly.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
