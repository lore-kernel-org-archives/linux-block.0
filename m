Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Make blk_dequeue_request() static
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20170829025437.26726-1-damien.lemoal@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9a34aec4-8bcf-e133-f82f-8d31454abba1@kernel.dk>
Date: Tue, 29 Aug 2017 09:49:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170829025437.26726-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/28/2017 08:54 PM, Damien Le Moal wrote:
> The only caller of this function is blk_start_request() in the same
> file. Fix blk_start_request() description accordingly.

Applied, thanks.

-- 
Jens Axboe
